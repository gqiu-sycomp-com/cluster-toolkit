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


output "cluster_info" {
  description = "Summary output of sycomp-scale-expansion module"
  value       = module.sycomp_scale_expansion.cluster_info
}

output "management_node" {
  description = "Summary output of management node information"
  value       = module.sycomp_scale_expansion.management_node
}

output "key_manager_node" {
  description = "Summary output of key manager node information"
  value       = module.sycomp_scale_expansion.key_manager_node
}
