variable "cidr_vpc" {
  type      = string
  default   = "10.0.0.0/16"
}

variable "azs" {
  type      = list(string)
  default   = [ "us-east-1b", "us-east-1d"  ]
}

variable "pub-subnets" {
  type      = list(string)
  default   = [ 
      "10.0.1.0/24",
      "10.0.2.0/24"
   ] 
}

variable "priv-subnets" {
  type      = list(string)
  default   = [ 
      "10.0.8.0/24",
      "10.0.9.0/24"
   ] 
}