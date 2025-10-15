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
| <a name="module_sycomp_scale_expansion"></a> [sycomp\_scale\_expansion](#module\_sycomp\_scale\_expansion) | git::https://gitlab.com/sycomp/cluster-toolkit.git//sycomp-scale-expansion | v1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_afm_nodes"></a> [add\_afm\_nodes](#input\_add\_afm\_nodes) | Number of afm nodes to add | `number` | `0` | no |
| <a name="input_add_ces_nodes"></a> [add\_ces\_nodes](#input\_add\_ces\_nodes) | Number of CES nodes to add | `number` | `0` | no |
| <a name="input_add_client_nodes"></a> [add\_client\_nodes](#input\_add\_client\_nodes) | Number of client nodes to add | `number` | `0` | no |
| <a name="input_add_disks"></a> [add\_disks](#input\_add\_disks) | Disks to add | <pre>object({<br/>    metadata-storage = optional(object({<br/>      count                  = number<br/>      size_in_gb             = number<br/>      type                   = string<br/>      provisioned_iops       = optional(number, 0)<br/>      provisioned_throughput = optional(number, 0)<br/>      }), {<br/>      count                  = 0<br/>      size_in_gb             = 0<br/>      type                   = ""<br/>      provisioned_iops       = 0<br/>      provisioned_throughput = 0<br/>    })<br/>    data-storage = optional(object({<br/>      count                  = number<br/>      size_in_gb             = number<br/>      type                   = string<br/>      provisioned_iops       = optional(number, 0)<br/>      provisioned_throughput = optional(number, 0)<br/>      }), {<br/>      count                  = 0<br/>      size_in_gb             = 0<br/>      type                   = ""<br/>      provisioned_iops       = 0<br/>      provisioned_throughput = 0<br/>    })<br/>  })</pre> | <pre>{<br/>  "data-storage": {<br/>    "count": 0,<br/>    "provisioned_iops": 0,<br/>    "provisioned_throughput": 0,<br/>    "size_in_gb": 0,<br/>    "type": ""<br/>  },<br/>  "metadata-storage": {<br/>    "count": 0,<br/>    "provisioned_iops": 0,<br/>    "provisioned_throughput": 0,<br/>    "size_in_gb": 0,<br/>    "type": ""<br/>  }<br/>}</pre> | no |
| <a name="input_add_kmgr_nodes"></a> [add\_kmgr\_nodes](#input\_add\_kmgr\_nodes) | Number of key manager nodes to add | `number` | `0` | no |
| <a name="input_add_scale_nodes"></a> [add\_scale\_nodes](#input\_add\_scale\_nodes) | Number of scale nodes to add | `number` | `0` | no |
| <a name="input_afm_config"></a> [afm\_config](#input\_afm\_config) | Base configuration for afm nodes | <pre>object({<br/>    afm_image        = string<br/>    afm_machine_type = string<br/>    boot_disk_type   = string<br/>  })</pre> | <pre>{<br/>  "afm_image": "",<br/>  "afm_machine_type": "",<br/>  "boot_disk_type": ""<br/>}</pre> | no |
| <a name="input_ces_config"></a> [ces\_config](#input\_ces\_config) | Ces configuration data | <pre>object({<br/>    ces_image        = string<br/>    ces_machine_type = string<br/>    boot_disk_type   = string<br/>  })</pre> | <pre>{<br/>  "boot_disk_type": "",<br/>  "ces_image": "",<br/>  "ces_machine_type": ""<br/>}</pre> | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Base configuration for client nodes | <pre>object({<br/>    client_image        = string<br/>    client_machine_type = string<br/>    boot_disk_type      = string<br/>  })</pre> | <pre>{<br/>  "boot_disk_type": "",<br/>  "client_image": "",<br/>  "client_machine_type": ""<br/>}</pre> | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | deployment name | `string` | n/a | yes |
| <a name="input_kmgr_config"></a> [kmgr\_config](#input\_kmgr\_config) | Base configuration for key manager nodes | <pre>object({<br/>    kmgr_image        = string<br/>    kmgr_machine_type = string<br/>    boot_disk_type    = string<br/>    kmgr_public_ip    = optional(bool, false)<br/>    https_source_ips  = optional(list(string), [])<br/>    certificate = optional(object({<br/>      organizational_unit_name = optional(string)<br/>      organization_name        = optional(string)<br/>      locality_name            = optional(string)<br/>      state                    = optional(string)<br/>      country_name             = optional(string)<br/>      validity_days            = optional(string, "1095")<br/>    }))<br/>  })</pre> | <pre>{<br/>  "boot_disk_type": "",<br/>  "certificate": {},<br/>  "https_source_ips": [],<br/>  "kmgr_image": "",<br/>  "kmgr_machine_type": "",<br/>  "kmgr_public_ip": false<br/>}</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Additional tags that should be added | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | This string will be used as the prefix for every name. Use only alphanumeric characters. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | region string | `string` | n/a | yes |
| <a name="input_scale_config"></a> [scale\_config](#input\_scale\_config) | Scale node and disk configuration | <pre>object({<br/>    scale_machine_type     = string<br/>    scale_min_cpu_platform = optional(string)<br/>    scale_image            = string<br/>    local_ssd_count        = optional(number, 0)<br/>    boot_disk_type         = string<br/>  })</pre> | <pre>{<br/>  "boot_disk_type": "",<br/>  "local_ssd_count": 0,<br/>  "scale_image": "",<br/>  "scale_machine_type": "",<br/>  "scale_min_cpu_platform": null<br/>}</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | zone string | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_info"></a> [cluster\_info](#output\_cluster\_info) | Summary output of sycomp-scale-expansion module |
| <a name="output_key_manager_node"></a> [key\_manager\_node](#output\_key\_manager\_node) | Summary output of key manager node information |
| <a name="output_management_node"></a> [management\_node](#output\_management\_node) | Summary output of management node information |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
