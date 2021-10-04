# infrastructure

## Required Tools
Both `terraform` and `ansible-playbook` are required to be on your $PATH to work with this project.

## Variables
The following variables are required. It is recommended that they be placed in a `*.auto.tfvars` file in the root of this project so they are automatically applied.

| Variable | Description |
| -------- | ----------- |
| admin_email | The admin e-mail address. |
| linode_api_token | The Linode V4 API Token. |
| ssh_public_key | The public SSH key used to authenticate. |
