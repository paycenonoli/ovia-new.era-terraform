# Define input variables
variable "instance_type" {
  type        = string
  description = "The instance capacity"
  sensitive   = false
  default     = "t2.micro"

}