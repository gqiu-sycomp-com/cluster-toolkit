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

locals {
  # This label allows for billing report tracking based on module.
  labels = merge(var.labels, { ghpc_module = "sycomp-scale", ghpc_role = "file-system" })
}

locals {
  name_prefix = coalesce(var.name_prefix, var.deployment_name)

  network_config = {
    create_firewall_rules = var.network_config.create_firewall_rules
    primary_network = {
      create_network = var.network_config.primary_network.create_network
      network_name   = coalesce(var.network_config.primary_network.network_name, var.network_name)
      create_subnet  = var.network_config.primary_network.create_subnet
      subnet_name    = coalesce(var.network_config.primary_network.subnet_name, var.subnetwork_name)
      create_nat     = var.network_config.primary_network.create_nat
      address_prefix = coalesce(var.network_config.primary_network.address_prefix, var.subnetwork_address)
    }
    secondary_networks = var.network_config.secondary_networks
    ces_networks       = var.network_config.ces_networks
  }
}

module "sycomp_scale" {
  source                    = "git::https://gitlab.com/sycomp/cluster-toolkit.git//sycomp-scale?ref=v1.0.0"
  admin                     = var.admin
  afm_config                = var.afm_config
  afm_mounts                = var.afm_mounts
  ces_config                = var.ces_config
  client_config             = var.client_config
  cloud                     = { region = var.region, zone = var.zone, project = var.project_id }
  ece                       = var.ece
  external_storage_clusters = var.external_storage_clusters
  feature_branch            = var.feature_branch
  kmgr_config               = var.kmgr_config
  labels                    = local.labels
  mgmt_config               = var.mgmt_config
  monitoring                = var.monitoring
  name_prefix               = local.name_prefix
  network_config            = local.network_config
  nfs_exports               = var.nfs_exports
  post_script               = var.post_script
  scale_config              = var.scale_config
  scalesetup_args           = var.scalesetup_args
  security                  = var.security
}
