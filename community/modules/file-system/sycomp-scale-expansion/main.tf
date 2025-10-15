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
  labels = merge(var.labels, { ghpc_module = "sycomp-scale-expansion", ghpc_role = "file-system" })
}

locals {
  name_prefix = coalesce(var.name_prefix, var.deployment_name)
}

module "sycomp_scale_expansion" {
  source           = "git::https://gitlab.com/sycomp/cluster-toolkit.git//sycomp-scale-expansion?ref=v1.0.0"
  add_afm_nodes    = var.add_afm_nodes
  add_ces_nodes    = var.add_ces_nodes
  add_client_nodes = var.add_client_nodes
  add_disks        = var.add_disks
  add_kmgr_nodes   = var.add_kmgr_nodes
  add_scale_nodes  = var.add_scale_nodes
  afm_config       = var.afm_config
  cloud            = { region = var.region, zone = var.zone, project = var.project_id }
  ces_config       = var.ces_config
  client_config    = var.client_config
  kmgr_config      = var.kmgr_config
  labels           = local.labels
  name_prefix      = local.name_prefix
  scale_config     = var.scale_config
}
