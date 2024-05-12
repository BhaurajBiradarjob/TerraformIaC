variable "sample_city" {
  
}

output "sample_city_output" {
  value = "My city is ${var.sample_city}"
}

# run and pass -> terraform plan -var sample_city=Bangalore  
