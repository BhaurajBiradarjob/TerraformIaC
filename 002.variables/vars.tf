variable "sample" {
  default = "Sample Value"
}

output "sample_output" {
  value = var.sample
}

variable "sample1" {
    default = "Sample Terraform Value"
}

output "sample1_output" {
  value = "Value of sample is ${var.sample1}"
}