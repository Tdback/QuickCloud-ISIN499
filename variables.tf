variable "public_subnet" {
  type    = list(string)
  default = []
}

variable "private_server" {
  type    = list(string)
  default = []
}

variable "private_db" {
  type    = list(string)
  default = []
}

variable "server_name" {
  type    = list(string)
  default = []
}
