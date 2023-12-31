public_subnet     = ["10.0.1.0/24", "10.0.2.0/24"]
private_server    = ["10.0.3.0/24", "10.0.4.0/24"]
private_db        = ["10.0.5.0/24", "10.0.6.0/24"]
server_name       = ["s1", "s2"]
private_ips       = ["10.0.3.100", "10.0.4.100"]
eips              = ["10.0.1.10", "10.0.2.10"]
type              = "t2.micro"
db_username       = "admin"
db_engine         = "mariadb"
db_engine_version = "10.5"
db_instance_class = "db.t3.micro"
db_port           = 3306
ssh_port          = 22
bastion_ssh_port  = 2222
http_port         = 80
https_port        = 443
