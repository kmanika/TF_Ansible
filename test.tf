provider "aws" {
  alias = "a"
}

variable "users" {
  type = list(object({
    name = string
    location = string
  }))
  default = [{
    name = "Mani"
    location = "India"
  },
    {
      name = "Nayak"
      location = "USA"
    },
    {
      name = "Manikanta"
      location = "US"
    }]
}

output "names" {
  value = [for names in var.users: names.name]
}