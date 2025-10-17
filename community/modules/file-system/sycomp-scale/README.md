## Description

This module allows creating an instance of [Sycomp Scale Storage](https://app.gitbook.com/o/jgH2EAoj698kWnpbW4ZD/s/rmXON2iiGrh4NtJ22zLy/google-cloud) on Google Cloud Platform ([GCP](https://cloud.google.com/)).

> **_NOTE:_**
> Sycomp Scale Storage on GCP does not require an HPC Toolkit wrapper.
> Terraform modules are sourced directly from GitLib.
> It will not work as a [local or embedded module](../../../../modules/README.md#embedded-modules).

Terraform modules for Sycomp Scale Storage are located in the [Google Cloud Sycomp Scale Storage repo on GitLib](https://gitlab.com/sycomp/cluster-toolkit).

Sycomp Scale Storage Terraform module parameters can be found in the README.md files in each module directory.

- [Sycomp Scale module](https://gitlab.com/sycomp/cluster-toolkit/blob/main/sycomp-scale/README.md)
- [Sycomp Scale Expansion module](https://gitlab.com/sycomp/cluster-toolkit/blob/main/sycomp-scale-expansion/README.md)

For more information on this and other network storage options in the Cloud HPC Toolkit, see the extended [Network Storage documentation](../../../../docs/network_storage.md).
## Examples

The [community examples folder](../../../examples/sycomp/) contains 4 example blueprints for deploying/expanding Sycomp Scale Storage.

- [community/examples/sycomp/sycomp-scale.yaml](../../../examples/sycomp/sycomp-scale.yaml)
  Blueprint for deploying a Sycomp Scale cluster consisting of 3 storage servers.

- [community/examples/sycomp/sycomp-scale-expansion.yaml](../../../examples/sycomp/sycomp-scale-expansion.yaml)
  Blueprint for expand above created cluster to 4 storage servers.

- [community/examples/sycomp/sycomp-scale-ece.yaml](../../../examples/sycomp/sycomp-scale-ece.yaml)
  Blueprint for deploying a Sycomp Scale cluster consisting of 7 storage servers with ECE(Erasure Code Edition) mode.

- [community/examples/sycomp/sycomp-scale-slurm.yaml](../../../examples/sycomp/sycomp-scale-slurm.yaml)
  Blueprint for deploying a Slurm cluster and Sycomp Scale storage with 4 servers. The Slurm compute nodes are configured as NFS clients and have the ability to use the Sycomp Scale filesystem.
