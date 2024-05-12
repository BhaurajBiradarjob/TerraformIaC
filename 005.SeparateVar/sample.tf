# Create a terraform.tfvars file for default values and terraform by default
# sees the values from terraform.tfvars file
# If you want to add new file than terraform.tfvars file then add file with 
# tfvars extension and run terraform plan --var-file=def.tfvars command


variable "city" {}
output "fav_city_name" {
  value = var.city
}

variable "state" {}
output "fav_state" {
  value = var.state
}

variable "District" {}
output "fav_district" {
  value = var.District
}

variable "Taluk" {}
output "fav_taluk" {
  value = var.Taluk
}

variable "Village" {}
output "fav_village" {
  value = var.Village
}

variable "PIN" {}
output "fav_pin" {
  value = var.PIN
}