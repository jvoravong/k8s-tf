# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_version" {
  type        = string
  default     = "1.27"
}

variable "cluster_owner" {
  description = "AWS region"
  type        = string
  default     = "data-collection"
}
