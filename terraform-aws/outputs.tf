#  ------ root/outputs.tf ------

output "load_balancer_endpont" {
  value = module.loadbalancing.lb_endpoint
}

output "instances" {
  value     = { for i in module.compute.instance : i.tags.Name => "${i.public_ip}:${module.compute.port}" }
  sensitive = true
}