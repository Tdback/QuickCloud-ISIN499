variable "public_subnet" {
  type    = list(string)
  default = []
}

variable "private_subnet" {
  type    = list(string)
  default = []
}

variable "server" {
  type    = list(string)
  default = []
}
