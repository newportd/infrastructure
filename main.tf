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
