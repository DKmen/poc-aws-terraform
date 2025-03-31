output "sqs_config" {
  value = {
    queue_name = aws_sqs_queue.sqs_queue.name
    queue_url  = aws_sqs_queue.sqs_queue.url
    queue_arn  = aws_sqs_queue.sqs_queue.arn
    queue_id   = aws_sqs_queue.sqs_queue.id

    dlq_name = aws_sqs_queue.dlq.name
    dlq_url  = aws_sqs_queue.dlq.url
    dlq_arn  = aws_sqs_queue.dlq.arn
    dlq_id   = aws_sqs_queue.dlq.id
  }
}