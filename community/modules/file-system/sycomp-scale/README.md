<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Copyright 2025 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sycomp_scale"></a> [sycomp\_scale](#module\_sycomp\_scale) | git::https://gitlab.com/sycomp/cluster-toolkit.git//sycomp-scale | v1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin"></a> [admin](#input\_admin) | Administrative configuration for cluster | <pre>object({<br/>    expandable_cluster = optional(bool, true)<br/>    service_account_id = optional(string, "")<br/>    collector = optional(object({<br/>      host       = optional(string, "collector.sycomp.com")<br/>      tls_verify = optional(bool, true)<br/>      }), {<br/>      host       = "collector.sycomp.com"<br/>      tls_verify = true<br/>    })<br/>  })</pre> | `{}` | no |
| <a name="input_afm_config"></a> [afm\_config](#input\_afm\_config) | Base configuration for afm nodes | <pre>object({<br/>    afm_node_count   = number<br/>    afm_image        = string<br/>    afm_machine_type = string<br/>  })</pre> | <pre>{<br/>  "afm_image": "",<br/>  "afm_machine_type": "n2-standard-4",<br/>  "afm_node_count": 0<br/>}</pre> | no |
| <a name="input_afm_mounts"></a> [afm\_mounts](#input\_afm\_mounts) | AFM mounts | <pre>object({<br/>    object_mounts = optional(list(object({<br/>      endpoint_uri = string<br/>      filesystem   = string<br/>      fileset      = optional(string, "")<br/>      junction     = optional(string, "")<br/>      bucket       = string<br/>      access_key   = string<br/>      secret_key   = string<br/>      key_source   = string<br/>      mode         = optional(string, "iw")<br/>    })), [])<br/>    nfs_mounts = optional(list(object({<br/>      endpoint_uri = string<br/>      filesystem   = string<br/>      fileset      = optional(string, "")<br/>      junction     = optional(string, "")<br/>      mode         = optional(string, "iw")<br/>    })), [])<br/>  })</pre> | <pre>{<br/>  "nfs_mounts": [],<br/>  "object_mounts": []<br/>}</pre> | no |
| <a name="input_ces_config"></a> [ces\_config](#input\_ces\_config) | Ces configuration data | <pre>object({<br/>    enabled          = optional(bool, false)<br/>    use_ces_node     = optional(bool, false)<br/>    ces_node_count   = optional(number, 0)<br/>    ces_machine_type = optional(string, "n2-standard-4")<br/>    create_dns       = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Base configuration for client nodes | <pre>object({<br/>    client_node_count   = number<br/>    client_image        = string<br/>    client_machine_type = string<br/>  })</pre> | <pre>{<br/>  "client_image": "",<br/>  "client_machine_type": "n2-standard-4",<br/>  "client_node_count": 0<br/>}</pre> | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | deployment name | `string` | n/a | yes |
| <a name="input_ece"></a> [ece](#input\_ece) | Parameters for erasure coding | <pre>object({<br/>    use_ece          = bool<br/>    ece_nodes_per_rg = optional(number, 16)<br/>    ece_raid_code    = optional(string, "8+3p")<br/>    ece_block_size   = optional(string, "16m")<br/>  })</pre> | <pre>{<br/>  "use_ece": false<br/>}</pre> | no |
| <a name="input_external_storage_clusters"></a> [external\_storage\_clusters](#input\_external\_storage\_clusters) | External storage clusters this cluster connects to if used as an application cluster | <pre>list(object({<br/>    server_ip    = string<br/>    api_key      = string<br/>    key_source   = string<br/>    network_tags = optional(list(string), [])<br/>    mounts = optional(list(object({<br/>      file_system = string<br/>      mount_point = optional(string, "")<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_feature_branch"></a> [feature\_branch](#input\_feature\_branch) | Sycomp 'edge' feature branch name used to enable the feature branch repo | `string` | `""` | no |
| <a name="input_kmgr_config"></a> [kmgr\_config](#input\_kmgr\_config) | Base configuration for key manager nodes | <pre>object({<br/>    kmgr_node_count   = number<br/>    kmgr_image        = string<br/>    kmgr_machine_type = string<br/>    kmgr_public_ip    = optional(bool, false)<br/>    https_source_ips  = optional(list(string), [])<br/>    certificate = optional(object({<br/>      organizational_unit_name = optional(string)<br/>      organization_name        = optional(string)<br/>      locality_name            = optional(string)<br/>      state                    = optional(string)<br/>      country_name             = optional(string)<br/>      validity_days            = optional(string, "1095")<br/>    }))<br/>  })</pre> | <pre>{<br/>  "certificate": {},<br/>  "https_source_ips": [],<br/>  "kmgr_image": "",<br/>  "kmgr_machine_type": "n2-standard-4",<br/>  "kmgr_node_count": 0,<br/>  "kmgr_public_ip": false<br/>}</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to add to resources | `map(string)` | `{}` | no |
| <a name="input_mgmt_config"></a> [mgmt\_config](#input\_mgmt\_config) | Base configuration for mgmt nodes | <pre>object({<br/>    mgmt_node_count   = optional(number, 1)<br/>    mgmt_machine_type = optional(string, "n2-standard-4")<br/>    mgmt_image        = optional(string, "")<br/>    mgmt_public_ip    = optional(bool, true)<br/>    https_source_ips  = optional(list(string), ["0.0.0.0/0"])<br/>    ssh_source_ips    = optional(list(string), ["0.0.0.0/0"])<br/>  })</pre> | `{}` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | Scale cluster monitoring and alerts | <pre>object({<br/>    log_based_alerts  = optional(bool, false)<br/>    synthetic_monitor = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "log_based_alerts": false,<br/>  "synthetic_monitoring": false<br/>}</pre> | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | This string will be used as the prefix for every name. Use only alphanumeric characters. | `string` | `""` | no |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | Network configuration | <pre>object({<br/>    create_firewall_rules = optional(bool, true)<br/>    primary_network = object({<br/>      create_network  = optional(bool, false)<br/>      network_name    = string<br/>      create_nat      = optional(bool, false)<br/>      shared_vpc_host = optional(string)<br/>      create_subnet   = optional(bool, false)<br/>      subnet_name     = string<br/>      address_prefix  = optional(string, "")<br/>    })<br/>    secondary_networks = optional(list(object({<br/>      create_network  = optional(bool, true)<br/>      network_name    = string<br/>      shared_vpc_host = optional(string)<br/>      create_subnet   = optional(bool, true)<br/>      subnet_name     = string<br/>      address_prefix  = string<br/>    })), [])<br/>    ces_networks = optional(list(object({<br/>      create_network  = optional(bool, true)<br/>      network_name    = string<br/>      shared_vpc_host = optional(string)<br/>      create_subnet   = optional(bool, true)<br/>      subnet_name     = string<br/>      address_prefix  = string<br/>    })), [])<br/><br/>  })</pre> | <pre>{<br/>  "primary_network": {<br/>    "network_name": "",<br/>    "subnet_name": ""<br/>  }<br/>}</pre> | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the existing VPC network | `string` | n/a | yes |
| <a name="input_nfs_exports"></a> [nfs\_exports](#input\_nfs\_exports) | NFS exports | <pre>list(object({<br/>    path        = string<br/>    pseudo_path = optional(string, "")<br/>    clients = optional(list(object({<br/>      anonymous_uid  = optional(string, "65534")<br/>      anonymous_gid  = optional(string, "65534")<br/>      protocols      = optional(string, "3:4")<br/>      no_root_squash = optional(bool, false)<br/>      rw_clients     = optional(list(string), ["0.0.0.0/0"])<br/>      ro_clients     = optional(list(string), [])<br/>    })), [{}])<br/>  }))</pre> | `[]` | no |
| <a name="input_post_script"></a> [post\_script](#input\_post\_script) | Full path name of post script which will be executed after cluster is deployed. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | region string | `string` | n/a | yes |
| <a name="input_scale_config"></a> [scale\_config](#input\_scale\_config) | Scale node and disk configuration | <pre>object({<br/>    scale_node_count       = optional(number, 0)<br/>    scale_machine_type     = optional(string, "n2-standard-4")<br/>    scale_min_cpu_platform = optional(string)<br/>    scale_image            = optional(string, "")<br/>    local_ssd_count        = optional(number, 0)<br/>    scale_volumes = optional(object({<br/>      metadata-storage = optional(object({<br/>        count                  = optional(number, 0)<br/>        size_in_gb             = optional(number, 0)<br/>        type                   = optional(string, "pd-ssd")<br/>        provisioned_iops       = optional(number, 0)<br/>        provisioned_throughput = optional(number, 0)<br/>      }), {})<br/>      data-storage = optional(object({<br/>        count                  = optional(number, 0)<br/>        size_in_gb             = optional(number, 0)<br/>        type                   = optional(string, "pd-ssd")<br/>        provisioned_iops       = optional(number, 0)<br/>        provisioned_throughput = optional(number, 0)<br/>      }), {})<br/>    }), {})<br/>  })</pre> | `{}` | no |
| <a name="input_scalesetup_args"></a> [scalesetup\_args](#input\_scalesetup\_args) | Additional arguments to be used when running scalesetup | `string` | `""` | no |
| <a name="input_security"></a> [security](#input\_security) | SSH configuration for administrator | <pre>object({<br/>    ssh = optional(object({<br/>      ssh_user_name = optional(string, "sycompacct")<br/>      key_source    = optional(string, "localFile")<br/>      private_key   = optional(string, "~/.ssh/id_rsa")<br/>      public_key    = optional(string, "~/.ssh/id_rsa.pub")<br/>    }), {})<br/>    api_key = optional(object({<br/>      nm_server_key  = optional(string, "")<br/>      mcm_server_key = optional(string, "")<br/>      key_source     = optional(string, "inline")<br/>      }), {<br/>      nm_server_key  = ""<br/>      mcm_server_key = ""<br/>      key_source     = "inline"<br/>    })<br/>    customer_token = object({<br/>      token        = optional(string, "")<br/>      token_source = optional(string, "inline")<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_subnetwork_address"></a> [subnetwork\_address](#input\_subnetwork\_address) | The IP range of internal addresses for the subnetwork. | `string` | n/a | yes |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | Name of the existing VPC subnetwork | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | zone string | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deployment_summary"></a> [deployment\_summary](#output\_deployment\_summary) | Summary output of sycomp-scale module |
| <a name="output_nfs_server"></a> [nfs\_server](#output\_nfs\_server) | NFS Server IP and DNS name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
