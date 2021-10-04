terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.linode_api_token
}

resource "linode_sshkey" "root_authorized_key" {
  lifecycle {
    # do not force recreation of dependent objects when the ssh key changes
    ignore_changes = [ ssh_key ]
  }

  label   = "newport-solutions"
  ssh_key = var.ssh_public_key
}

resource "linode_domain" "newport_solutions" {
  description = "newport.solutions master domain"
  domain      = "newport.solutions"
  expire_sec  = 300
  refresh_sec = 300
  retry_sec   = 300
  ttl_sec     = 300
  soa_email   = var.admin_email
  status      = "active"
  type        = "master"
}

resource "linode_domain_record" "caa_issue" {
  domain_id   = linode_domain.newport_solutions.id
  record_type = "CAA"
  tag         = "issue"
  target      = "letsencrypt.org"
  ttl_sec     = 28800
}

resource "linode_domain_record" "caa_iodef" {
  domain_id   = linode_domain.newport_solutions.id
  record_type = "CAA"
  tag         = "iodef"
  target      = "mailto:${var.admin_email}"
  ttl_sec     = 28800
}

#
resource "linode_instance" "www" {
  label      = "www"
  private_ip = false
  region     = "us-southeast"
  tags       = [ "app:todo", "app:www" ]
  type       = "g6-standard-2"

  config {
    devices {
      sda {
        disk_label = "root"
      }
    }
    kernel      = "linode/grub2"
    label       = "boot_config"
    root_device = "/dev/sda"
  }

  disk {
    authorized_keys = [ var.ssh_public_key ]
    image           = "linode/arch"
    label           = "root"
    size            = 81920
  }
}

resource "linode_domain_record" "bare_ipv4" {
  domain_id   = linode_domain.newport_solutions.id
  name        = ""
  record_type = "A"
  target      = tolist(linode_instance.www.ipv4)[0]
  ttl_sec     = 300
}

resource "linode_domain_record" "bare_ipv6" {
  domain_id   = linode_domain.newport_solutions.id
  name        = ""
  record_type = "AAAA"
  target      = trimsuffix(linode_instance.www.ipv6, "/128")
  ttl_sec     = 300
}

resource "linode_domain_record" "www_ipv4" {
  domain_id   = linode_domain.newport_solutions.id
  name        = "www"
  record_type = "A"
  target      = tolist(linode_instance.www.ipv4)[0]
  ttl_sec     = 300
}

resource "linode_domain_record" "www_ipv6" {
  domain_id   = linode_domain.newport_solutions.id
  name        = "www"
  record_type = "AAAA"
  target      = trimsuffix(linode_instance.www.ipv6, "/128")
  ttl_sec     = 300
}

resource "linode_rdns" "www_ipv4" {
  address = tolist(linode_instance.www.ipv4)[0]
  rdns    = "www.newport.solutions"
}

resource "linode_rdns" "www_ipv6" {
  address = trimsuffix(linode_instance.www.ipv6, "/128")
  rdns    = "www.newport.solutions"
}

resource "null_resource" "configure" {
  depends_on = [
    linode_instance.www
  ]
  triggers = {
    playbook_sha256 = filebase64sha256("playbooks/site.yml")
  }
  provisioner "local-exec" {
    command     = "ansible-playbook playbooks/site.yml"
  }
}
