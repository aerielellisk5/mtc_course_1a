#  ---- compute/outputs.tf -----

output "instance" {
    value = aws_instance.mtc_node_id[*]
    sensitive = true
}

output "port" {
    value = aws_lb_target_group_attachment.mtc_tg_attach[0].port
}