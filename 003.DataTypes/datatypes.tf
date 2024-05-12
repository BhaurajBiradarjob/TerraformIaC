# Terraform supports 3 data types - Strings, Numbers and Boolean

#string data type
variable "sample_string" {
  default = "Hello Terraform!"
}

#number data type
variable "sample_number" {
    default = 100
}

#boolean data type
variable "sample_boolean" {
    default = true
}

output "sample_output" {
  value = "${var.sample_string} and Number is ${var.sample_number} and Boolean is ${var.sample_boolean}"
}
