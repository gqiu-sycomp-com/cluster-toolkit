# Sycomp Scale Storage Cluster Blueprint

This document provides instructions on how to use the example
blueprint to deploy/expand `Sycomp Scale storage cluster` and enable `SLURM` cluster to use `Sycomp Scale Storage` via `NFS` on Google Cloud Platform (GCP)
using the HPC Toolkit.

The directories contains 4 example blueprints for deploying/expanding `Sycomp Scale Storage`:

- sycomp-scale.yaml

  Blueprint for deploying a `Sycomp Scale cluster` consisting of 3 storage servers.

- sycomp-scale-expansion.yaml

  Blueprint for expand above created cluster to 4 storage servers.

- sycomp-scale-ece.yaml

  Blueprint for deploying a `Sycomp Scale cluster` consisting of 7 storage servers with `ECE`(Erasure Code Edition) mode.

- sycomp-scale-slurm.yaml

  Blueprint for deploying a `SLURM` cluster and `Sycomp Scale storage` with 4 servers. The `SLURM` compute nodes are configured as `NFS` clients and have the ability to use the Sycomp Scale filesystem.

## Prerequisites

1. Google Cloud SDK is installed and configured.
2. The HPC Toolkit is installed.
3. You have a Google Cloud project with the required permissions to create VPCs, and Compute Engine instances.
4. The following APIs must be enabled in your project:
   - Compute Engine API (`compute.googleapis.com`)
5. You have an SSH key pair (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub` or similar). If you don't have one, you can generate it using `ssh-keygen -t rsa`.
6. You have a valid **Customer Token** provided by Sycomp.
7. **Project access token** provided by Sycomp.
8. To avoid repeatedly entering passwords, set `credential.helper` is recommended:

```shell
git config credential.helper cache
```

## Configuration

Before deploying the blueprint, you must edit blueprint files and fill in the placeholder values.

1. **`vars` block:**
   - `project_id`: Your Google Cloud project ID.
   - `deployment_name`: A unique name for this deployment (e.g., `mystorage1`).

      **Note**: By default, the value of `deployment_name` is set by `sycomp-scale-gcp` module to its `name_prefix` variable, and `name_prefix` only accepts letters and numbers. If you want `deployment_name` to contain other characters, you need to set `name_prefix` separately for `sycomp-scale-gcp`.

2. **`network1` module settings:**
   - `network_name`: A name for the new VPC network (e.g., `sycomp-net`).
   - `subnetwork_name`: A name for the new subnetwork (e.g., `sycomp-subnet`).
   - `allowed_ssh_ip_ranges`: A list of IP address ranges in CIDR format that
     are allowed to connect via SSH. **You must include the IP address of the
     machine you are running the deployment from.** For example: `["1.2.3.0/24"]`.

3. **`sycomp-scale-gcp` module settings:**
   - `name_prefix`: The prefix of cluster. Default value is the value of `var.deployment_name`. Only letters and numbers are accepted.
   - `security.ssh.ssh_user_name`: The username for SSH access to the management node (e.g., `sycompacct`).
   - `security.ssh.private_key`: The file path to your SSH private key (e.g., `~/.ssh/id_rsa`).
   - `security.ssh.public_key`: The file path to your SSH public key (e.g., `~/.ssh/id_rsa.pub`).
   - `security.customer_token.token`: Your Sycomp Customer Token. Contact `Sycomp` for it.

4. **(Optional) `scale_config` settings:**
   - `scale_node_count`: The number of nodes in the Sycomp Scale cluster. Defaults to `3`.
   - `scale_volumes`: Configuration for the data disks. Defaults to 4 disks of 250GB each per node.

## Deployment

Once the blueprint file(e.g., `sycomp-scale.yaml`) is configured, you can deploy the cluster by following these steps from your terminal.

1. **Create the deployment directory:**

   ```bash
   gcluster create community/examples/sycomp/sycomp-scale.yaml
   ```

   This command will create a new directory named after your `deployment_name` (e.g., `mystorage1`).

2. **Deploy the resources:**

   ```bash
   # terraform will prompt you to enter the username and password.
   # You can enter any username and use the project access token obtained from Sycomp as the password.
   terraform -chdir=<deployment_name>/primary init # e.g., mystorage1
   gcluster deploy <deployment_name>
   ```

   This process will take several minutes as it provisions the network and the Sycomp Scale cluster nodes.

## Cleanup

To remove all resources created by this blueprint, run the following command from
within the deployment directory:

```bash
gcluster destroy <deployment_name>
```
