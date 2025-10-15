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

variable "network_name" {
  description = "Name of the existing VPC network"
  type        = string
}

variable "subnetwork_name" {
  description = "Name of the existing VPC subnetwork"
  type        = string
}

variable "subnetwork_address" {
  description = "The IP range of internal addresses for the subnetwork."
  type        = string
}

variable "name_prefix" {
  type        = string
  description = "This string will be used as the prefix for every name. Use only alphanumeric characters."
  default     = ""
}

variable "post_script" {
  type        = string
  description = "Full path name of post script which will be executed after cluster is deployed."

  validation {
    condition     = can(var.post_script == "") || (startswith(var.post_script, "/") && can(regex("^/([^/]+/)*[^/]+$", var.post_script)))
    error_message = "post_script is not a valid full path file name."
  }
  default = ""
}

variable "scalesetup_args" {
  type        = string
  description = "Additional arguments to be used when running scalesetup"

  validation {
    condition     = length(regex("^(|[a-zA-Z0-9 _-]*)$", var.scalesetup_args)) > 0
    error_message = "The string can only contain dashes, spaces, underscores, or alphanumeric characters."
  }
  default = ""
}

variable "feature_branch" {
  type        = string
  description = "Sycomp 'edge' feature branch name used to enable the feature branch repo"

  validation {
    condition     = can(regex("^(|[a-zA-Z0-9-_]{1,50})$", var.feature_branch))
    error_message = "The string must be empty, or contain only letters, numbers, dashes, and underscores, and have a maximum length of 50 characters."
  }

  default = ""
}

variable "security" {
  description = "SSH configuration for administrator"
  type = object({
    ssh = optional(object({
      ssh_user_name = optional(string, "sycompacct")
      key_source    = optional(string, "localFile")
      private_key   = optional(string, "~/.ssh/id_rsa")
      public_key    = optional(string, "~/.ssh/id_rsa.pub")
    }), {})
    api_key = optional(object({
      nm_server_key  = optional(string, "")
      mcm_server_key = optional(string, "")
      key_source     = optional(string, "inline")
      }), {
      nm_server_key  = ""
      mcm_server_key = ""
      key_source     = "inline"
    })
    customer_token = object({
      token        = optional(string, "")
      token_source = optional(string, "inline")
    })
  })
  validation {
    condition     = contains(["inline", "localFile", "secretsManager"], var.security.ssh.key_source)
    error_message = "Specify a valid key source. Valid values are inline, localFile and secretsManager"
  }
  validation {
    condition     = contains(["inline", "localFile", "secretsManager"], var.security.api_key.key_source)
    error_message = "Specify a valid key source. Valid values are inline, localFile and secretsManager"
  }
  validation {
    condition     = contains(["inline", "localFile", "secretsManager"], var.security.customer_token.token_source)
    error_message = "Specify a valid key source. Valid values are inline, localFile and secretsManager"
  }
}

variable "admin" {
  description = "Administrative configuration for cluster"
  type = object({
    expandable_cluster = optional(bool, true)
    service_account_id = optional(string, "")
    collector = optional(object({
      host       = optional(string, "collector.sycomp.com")
      tls_verify = optional(bool, true)
      }), {
      host       = "collector.sycomp.com"
      tls_verify = true
    })
  })
  default = {}
}

variable "ece" {
  description = "Parameters for erasure coding"
  type = object({
    use_ece          = bool
    ece_nodes_per_rg = optional(number, 16)
    ece_raid_code    = optional(string, "8+3p")
    ece_block_size   = optional(string, "16m")
  })
  default = {
    use_ece = false
  }
  validation {
    condition     = contains(["3WayReplication", "4WayReplication", "4+2p", "4+3p", "8+2p", "8+3p", "16+2p", "16+3p"], var.ece.ece_raid_code)
    error_message = "Specify a valid raid code. Valid values are 3WayReplication, 4WayReplication, 4+2p, 4+3p, 8+2p, 8+3p, 16+2p and 16+3p"
  }

  validation {
    condition     = contains(["3WayReplication", "4WayReplication"], var.ece.ece_raid_code) ? contains(["256k", "512k", "1m", "2m"], var.ece.ece_block_size) : true
    error_message = "Specify a valid block size for the raid code. Valid values are 256k, 512k, 1m and 2m"
  }

  validation {
    condition     = contains(["4+2p", "4+3p"], var.ece.ece_raid_code) ? contains(["512k", "1m", "2m", "4m", "8m"], var.ece.ece_block_size) : true
    error_message = "Specify a valid block size for the raid code. Valid values are 512k, 1m, 2m, 4m and 8m"
  }

  validation {
    condition     = contains(["8+2p", "8+3p", "16+2p", "16+3p"], var.ece.ece_raid_code) ? contains(["512k", "1m", "2m", "4m", "8m", "16m"], var.ece.ece_block_size) : true
    error_message = "Specify a valid block size for the raid code. Valid values are 512k, 1m, 2m, 4m, 8m and 16m"
  }
}

variable "external_storage_clusters" {
  description = "External storage clusters this cluster connects to if used as an application cluster"
  type = list(object({
    server_ip    = string
    api_key      = string
    key_source   = string
    network_tags = optional(list(string), [])
    mounts = optional(list(object({
      file_system = string
      mount_point = optional(string, "")
    })), [])
  }))
  default = []
  validation {
    condition     = alltrue([for key in var.external_storage_clusters : contains(["inline", "localFile", "secretsManager"], key.key_source)])
    error_message = "Specify a valid key source. Valid values are inline, localFile and secretsManager"
  }
}

variable "nfs_exports" {
  description = "NFS exports"
  type = list(object({
    path        = string
    pseudo_path = optional(string, "")
    clients = optional(list(object({
      anonymous_uid  = optional(string, "65534")
      anonymous_gid  = optional(string, "65534")
      protocols      = optional(string, "3:4")
      no_root_squash = optional(bool, false)
      rw_clients     = optional(list(string), ["0.0.0.0/0"])
      ro_clients     = optional(list(string), [])
    })), [{}])
  }))
  default = []
}

variable "afm_mounts" {
  description = "AFM mounts"
  type = object({
    object_mounts = optional(list(object({
      endpoint_uri = string
      filesystem   = string
      fileset      = optional(string, "")
      junction     = optional(string, "")
      bucket       = string
      access_key   = string
      secret_key   = string
      key_source   = string
      mode         = optional(string, "iw")
    })), [])
    nfs_mounts = optional(list(object({
      endpoint_uri = string
      filesystem   = string
      fileset      = optional(string, "")
      junction     = optional(string, "")
      mode         = optional(string, "iw")
    })), [])
  })

  default = {
    object_mounts = []
    nfs_mounts    = []
  }

  validation {
    condition     = alltrue([for mnt in var.afm_mounts.object_mounts : contains(["inline", "localFile", "secretsManager"], mnt.key_source)])
    error_message = "Specify a valid key source. Valid values are inline, localFile and secretsManager"
  }

  validation {
    condition     = alltrue([for mnt in var.afm_mounts.object_mounts : contains(["sw", "ro", "lu", "mu", "iw"], mnt.mode)])
    error_message = "Specify a valid object mount mode. Valid values are sw, ro, lu, mu, and iw"
  }

  validation {
    condition     = alltrue([for mnt in var.afm_mounts.nfs_mounts : contains(["sw", "ro", "lu", "mu", "iw"], mnt.mode)])
    error_message = "Specify a valid nfs mount mode. Valid values are sw, ro, lu, mu, and iw"
  }
}

variable "monitoring" {
  description = "Scale cluster monitoring and alerts"
  type = object({
    log_based_alerts  = optional(bool, false)
    synthetic_monitor = optional(bool, false)
  })
  default = {
    log_based_alerts     = false
    synthetic_monitoring = false
  }
}

variable "labels" {
  description = "Labels to add to resources"
  type        = map(string)
  default     = {}
}

variable "network_config" {
  description = "Network configuration"
  type = object({
    create_firewall_rules = optional(bool, true)
    primary_network = object({
      create_network  = optional(bool, false)
      network_name    = string
      create_nat      = optional(bool, false)
      shared_vpc_host = optional(string)
      create_subnet   = optional(bool, false)
      subnet_name     = string
      address_prefix  = optional(string, "")
    })
    secondary_networks = optional(list(object({
      create_network  = optional(bool, true)
      network_name    = string
      shared_vpc_host = optional(string)
      create_subnet   = optional(bool, true)
      subnet_name     = string
      address_prefix  = string
    })), [])
    ces_networks = optional(list(object({
      create_network  = optional(bool, true)
      network_name    = string
      shared_vpc_host = optional(string)
      create_subnet   = optional(bool, true)
      subnet_name     = string
      address_prefix  = string
    })), [])

  })
  default = {
    primary_network = {
      network_name = ""
      subnet_name  = ""
    }
  }
}

variable "mgmt_config" {
  description = "Base configuration for mgmt nodes"
  type = object({
    mgmt_node_count   = optional(number, 1)
    mgmt_machine_type = optional(string, "n2-standard-4")
    mgmt_image        = optional(string, "")
    mgmt_public_ip    = optional(bool, true)
    https_source_ips  = optional(list(string), ["0.0.0.0/0"])
    ssh_source_ips    = optional(list(string), ["0.0.0.0/0"])
  })
  default = {}
}

variable "kmgr_config" {
  description = "Base configuration for key manager nodes"
  type = object({
    kmgr_node_count   = number
    kmgr_image        = string
    kmgr_machine_type = string
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
    kmgr_node_count   = 0
    kmgr_image        = ""
    kmgr_machine_type = "n2-standard-4"
    kmgr_public_ip    = false
    https_source_ips  = []
    certificate       = {}
  }
}

variable "scale_config" {
  description = "Scale node and disk configuration"
  type = object({
    scale_node_count       = optional(number, 0)
    scale_machine_type     = optional(string, "n2-standard-4")
    scale_min_cpu_platform = optional(string)
    scale_image            = optional(string, "")
    local_ssd_count        = optional(number, 0)
    scale_volumes = optional(object({
      metadata-storage = optional(object({
        count                  = optional(number, 0)
        size_in_gb             = optional(number, 0)
        type                   = optional(string, "pd-ssd")
        provisioned_iops       = optional(number, 0)
        provisioned_throughput = optional(number, 0)
      }), {})
      data-storage = optional(object({
        count                  = optional(number, 0)
        size_in_gb             = optional(number, 0)
        type                   = optional(string, "pd-ssd")
        provisioned_iops       = optional(number, 0)
        provisioned_throughput = optional(number, 0)
      }), {})
    }), {})
  })
  default = {}
}

variable "ces_config" {
  description = "Ces configuration data"
  type = object({
    enabled          = optional(bool, false)
    use_ces_node     = optional(bool, false)
    ces_node_count   = optional(number, 0)
    ces_machine_type = optional(string, "n2-standard-4")
    create_dns       = optional(bool, true)
  })
  default = {}
  validation {
    condition     = var.ces_config.ces_node_count <= 50
    error_message = "Exceeded limit of CES nodes that can be deployed. Maximum is 50"
  }
}

variable "client_config" {
  description = "Base configuration for client nodes"
  type = object({
    client_node_count   = number
    client_image        = string
    client_machine_type = string
  })
  default = {
    client_node_count   = 0
    client_image        = ""
    client_machine_type = "n2-standard-4"
  }
}

variable "afm_config" {
  description = "Base configuration for afm nodes"
  type = object({
    afm_node_count   = number
    afm_image        = string
    afm_machine_type = string
  })
  default = {
    afm_node_count   = 0
    afm_image        = ""
    afm_machine_type = "n2-standard-4"
  }
}
