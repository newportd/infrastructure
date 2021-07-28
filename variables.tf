variable "linode_api_token" {
  description = "Linode V4 API Token"
  sensitive = true
  type = string
}

variable "ssh_public_key" {
  description = "Public SSH Key for the root user"
  type = string
}
