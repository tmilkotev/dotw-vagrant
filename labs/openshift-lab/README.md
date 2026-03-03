# OpenShift-Compatible Lab (OpenStack Base)

This lab provisions the infrastructure layer for an OpenShift-compatible platform using Vagrant + VirtualBox on a single workstation.

It creates three AlmaLinux VMs:

- controller
- compute1
- compute2

These nodes are used as the OpenStack base. Kubernetes/OpenShift-compatible workloads will run inside instances created on the compute nodes.

---

## Requirements

- Windows / Linux / macOS host
- VirtualBox installed
- Vagrant installed
- Hardware virtualization enabled in BIOS/UEFI
- Minimum recommended host resources:
  - 12 CPU cores
  - 32 GB RAM
  - 100+ GB free disk

---

## Start the lab

From this directory:

```bash
cd vagrant/labs/openshift-lab
vagrant up
```

## Enable nested virtualization for compute nodes

From this directory:

```bash
cd vagrant/labs/openshift-lab
vagrant halt
```

Open powershell:

```powershell
VBoxManage modifyvm "openshift-lab-compute1" --nested-hw-virt on
VBoxManage modifyvm "openshift-lab-compute2" --nested-hw-virt on
