terraform {  
  backend "s3" {  
    bucket       = "terraform-backend-56528776824"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true  
    use_lockfile = true
  }  
}
