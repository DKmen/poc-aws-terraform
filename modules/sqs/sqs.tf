# create an DLQ for the sqs queue
resource "aws_sqs_queue" "dlq" {
  name                        = var.is_fifo ? "${var.queue_name}-dlq.fifo" : "${var.queue_name}-dlq"
  message_retention_seconds   = var.message_retention_seconds
  delay_seconds               = var.message_delay_seconds
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  content_based_deduplication = var.is_content_based_deduplication_enabled && var.is_fifo
  fifo_queue                  = var.is_fifo
}

# create an fifo sqs queue
resource "aws_sqs_queue" "sqs_queue" {
  name                        = var.is_fifo ? "${var.queue_name}.fifo" : var.queue_name
  message_retention_seconds   = var.message_retention_seconds
  delay_seconds               = var.message_delay_seconds
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  fifo_queue                  = var.is_fifo
  content_based_deduplication = var.is_content_based_deduplication_enabled && var.is_fifo
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })
}

# create an sqs queue with a policy
resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "sqs-policy",
  "Statement": [
    {
      "Sid": "AllowAll",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SQS:*",    
      "Resource": "${aws_sqs_queue.sqs_queue.arn}"
    }
  ]
}
EOF
}
