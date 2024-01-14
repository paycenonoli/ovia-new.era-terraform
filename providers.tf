# Define provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = "us-east-2"
  profile = "ovia-terraform"
}

# Create an alias for us-east-1 (N.Virginia)
provider "aws" {
  alias   = "us"
  region  = "us-east-1"
  profile = "ovia-terraform"
}