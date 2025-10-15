/**
  * Copyright 2025 Google LLC
  *
  * Licensed under the Apache License, Version 2.0 (the "License");
  * you may not use this file except in compliance with the License.
  * You may obtain a copy of the License at
  *
  *      http://www.apache.org/licenses/LICENSE-2.0
  *
  * Unless required by applicable law or agreed to in writing, software
  * distributed under the License is distributed on an "AS IS" BASIS,
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  */

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
variable "region" {
  description = "region string"
  type        = string
}
variable "zone" {
  description = "zone string"
  type        = string
}

variable "deployment_name" {
  description = "deployment name"
  type        = string
}


variable "name_prefix" {
  type        = string
  description = "This string will be used as the prefix for every name. Use only alphanumeric characters."
  default     = ""
}


variable "labels" {
  description = "Additional tags that should be added"
  type        = map(string)
  default     = {}
}

variable "add_scale_nodes" {
  description = "Number of scale nodes to add"
  type        = number
  default     = 0
}

variable "add_client_nodes" {
  description = "Number of client nodes to add"
  type        = number
  default     = 0
}

variable "add_afm_nodes" {
  description = "Number of afm nodes to add"
  type        = number
  default     = 0
}

variable "add_ces_nodes" {
  description = "Number of CES nodes to add"
  type        = number
  default     = 0
}

variable "add_kmgr_nodes" {
  description = "Number of key manager nodes to add"
  type        = number
  default     = 0
}

variable "add_disks" {
  description = "Disks to add"
  type = object({
    metadata-storage = optional(object({
      count                  = number
      size_in_gb             = number
      type                   = string
      provisioned_iops       = optional(number, 0)
      provisioned_throughput = optional(number, 0)
      }), {
      count                  = 0
      size_in_gb             = 0
      type                   = ""
      provisioned_iops       = 0
      provisioned_throughput = 0
    })
    data-storage = optional(object({
      count                  = number
      size_in_gb             = number
      type                   = string
      provisioned_iops       = optional(number, 0)
      provisioned_throughput = optional(number, 0)
      }), {
      count                  = 0
      size_in_gb             = 0
      type                   = ""
      provisioned_iops       = 0
      provisioned_throughput = 0
    })
  })
  default = {
    metadata-storage = {
      count                  = 0
      size_in_gb             = 0
      type                   = ""
      provisioned_iops       = 0
      provisioned_throughput = 0
    }
    data-storage = {
      count                  = 0
      size_in_gb             = 0
      type                   = ""
      provisioned_iops       = 0
      provisioned_throughput = 0
    }
  }
}

variable "kmgr_config" {
  description = "Base configuration for key manager nodes"
  type = object({
    kmgr_image        = string
    kmgr_machine_type = string
    boot_disk_type    = string
    kmgr_public_ip    = optional(bool, false)
    https_source_ips  = optional(list(string), [])
    certificate = optional(object({
      organizational_unit_name = optional(string)
      organization_name        = optional(string)
      locality_name            = optional(string)
      state                    = optional(string)
      country_name             = optional(string)
      validity_days            = optional(string, "1095")
    }))
  })
  default = {
    kmgr_image        = ""
    kmgr_machine_type = ""
    boot_disk_type    = ""
    kmgr_public_ip    = false
    https_source_ips  = []
    certificate       = {}
  }
}

variable "scale_config" {
  description = "Scale node and disk configuration"
  type = object({
    scale_machine_type     = string
    scale_min_cpu_platform = optional(string)
    scale_image            = string
    local_ssd_count        = optional(number, 0)
    boot_disk_type         = string
  })
  default = {
    scale_machine_type     = ""
    scale_min_cpu_platform = null
    scale_image            = ""
    local_ssd_count        = 0
    boot_disk_type         = ""
  }
}

variable "ces_config" {
  description = "Ces configuration data"
  type = object({
    ces_image        = string
    ces_machine_type = string
    boot_disk_type   = string
  })
  default = {
    ces_image        = ""
    ces_machine_type = ""
    boot_disk_type   = ""
  }
}

variable "client_config" {
  description = "Base configuration for client nodes"
  type = object({
    client_image        = string
    client_machine_type = string
    boot_disk_type      = string
  })
  default = {
    client_image        = ""
    client_machine_type = ""
    boot_disk_type      = ""
  }
}

variable "afm_config" {
  description = "Base configuration for afm nodes"
  type = object({
    afm_image        = string
    afm_machine_type = string
    boot_disk_type   = string
  })
  default = {
    afm_image        = ""
    afm_machine_type = ""
    boot_disk_type   = ""
  }
}
