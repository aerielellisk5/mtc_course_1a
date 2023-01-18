#  --- root/main.tf ---

module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  access_ip        = var.access_ip
  security_groups  = local.security_groups
  private_sn_count = 3
  public_sn_count  = 2
  max_subnets      = 20
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}

module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "5.7"
  db_instance_class      = "db.t3.micro"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_identifier          = "mtc-db"
  skip_db_snapshot       = true
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.db_security_group
}


module "loadbalancing" {
  source                 = "./loadbalancing"
  public_sg              = module.networking.public_sg
  public_subnets         = module.networking.public_subnets
  lb_healthy_threshold   = 2
  lb_unhealthy_threshold = 2
  lb_timeout             = 3
  lb_interval            = 30
  tg_port                = 8000
  tg_protocol            = "HTTP"
  vpc_id                 = module.networking.vpc_id
  listener_port          = 80
  listener_protocol      = "HTTP"
}

module "compute" {
  source              = "./compute"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
  instance_count      = 1
  instance_type       = "t3.micro"
  volume_size         = 10
  key_name            = "mtckey"
  public_key_path     = "/home/ubuntu/.ssh/mtckey.pub"
  user_data_path      = "${path.root}/userdata.tpl"
  db_name             = var.dbname
  db_user             = var.dbuser
  db_password         = var.dbpassword
  db_endpoint         = module.database.db_endpoint
  lb_target_group_arn = module.loadbalancing.lb_target_group_arn
  tg_port             = 8000
}