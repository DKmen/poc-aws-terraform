variable "queue_name" {
  type        = string
  description = "The name of the queue"
}

variable "is_fifo" {
  type        = bool
  description = "Whether the queue is a fifo queue"
  default     = false
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "The visibility timeout for the queue"
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "The message retention period for the queue"
  default     = 86400
}

variable "message_delay_seconds" {
  type        = number
  description = "The message delay for the queue"
  default     = 0
}

variable "max_receive_count" {
  type        = number
  description = "The maximum number of times a message can be received"
  default     = 5
}

variable "is_content_based_deduplication_enabled" {
  type        = bool
  description = "Whether the queue is a content based deduplication queue"
  default     = false

}