# Terraform supports Dictionary, List and Map variables

#Dictionary - Normal default variable types which has key and value
# variable "sample_dictionary" {
#   default = "This is dictionary variable"
# }
output "sample_dictionary_output" {
  value = "${var.sample_dictionary} "
}

# List - contains key and list of values
# variable "sample_list" {
#   default = [
#     "Hello world", 500, true, "This is a list variable"
#   ]
# }
output "sample_list_output" {
  value = "Hi, ${var.sample_list[0]} "
}

# Map - contains key and value. value contains multiple key-value pairs
# variable "sample_map" {
#   default = {
#     "Name"="Bhauraj",
#     "Age"="25",
#     "Gender"="Male"
#   }
# }
output "sample_map_output" {
  value = "Hi, My name is ${var.sample_map["Name"]} and Age is ${var.sample_map["Age"]}"
}