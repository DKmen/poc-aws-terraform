output "vpc_config" {
  value = module.vpc.vpc_config
}

output "queue_config" {
  value = module.sqs.sqs_config
}