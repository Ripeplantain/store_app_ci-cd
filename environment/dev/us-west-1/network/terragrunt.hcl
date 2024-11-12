terraform {
  source = "../../../../modules/network"
  extra_arguments "custom_vars" {
    commands = ["apply", "plan", "import", "push"< "refresh"]
    required_var_files = ["../../configuration/dev/us-west-1/terraform.tfvars"]
  }
}
