# Terraform

# Terraform Commands

Help : terraform -help

Version : terraform -version

Format Your Terraform Code : terraform fmt, terraform fmt --recursive, terraform fmt --diff, terraform fmt --check

Download and Install Modules :

terraform init,

terraform get,

terraform get -update

Validate Your Terraform Code :

terraform validate

Plan Your Infrastructure :

    terraform plan -> with or without terraform.tfvars file,

    terraform plan -out=<path> -> with terraform.tfvars and other tfvar file,

    terraform plan -destroy

Deploy Your Infrastructure :

    terraform apply -> with or without terraform.tfvars file,

    terraform apply -auto-approve,

    terraform apply <planfilename>,

    terraform apply -lock=false,

    terraform apply -parallelism=<n>,

    terraform apply -var="environment=dev",

    terraform apply -var-file="varfile.tfvars" -> with terraform.tfvars and other tfvar file,

    terraform apply -target=”module.appgw.0"

Destroy Your Infrastructure :

terraform destroy

terraform destroy -target=”module.appgw.0"

terraform destroy --auto-approve

terraform destroy -target="module.appgw.resource[\"key\"]"
