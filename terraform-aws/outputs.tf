#  ------ root/outputs.tf ------

output "load_balancer_endpont" {
    value = module.loadbalancing.lb_endpoint
}