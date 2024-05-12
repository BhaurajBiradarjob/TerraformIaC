# Terraform supports Dictionary, List and Map variables
#Dictionary - Normal default variable types which has key and value
variable "sample_dictionary" {
  default = "This is dictionary variable"
}
# List - contains key and list of values
variable "sample_list" {
  default = [
    "Hello world", 500, true, "This is a list variable"
  ]
}
# Map - contains key and value. value contains multiple key-value pairs
variable "sample_map" {
  default = {
    "Name"="Bhauraj",
    "Age"="25",
    "Gender"="Male"
  }
}