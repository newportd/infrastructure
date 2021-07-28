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
