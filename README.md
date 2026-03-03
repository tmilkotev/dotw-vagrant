# Vagrant Repo

This repository contains reusable Vagrant environments for home lab solutions using the VirtualBox provider.

The goal is to provide consistent, reproducible virtual machine environments with minimal setup effort.

---

## Requirements

* Vagrant 2.x
* VirtualBox 6.x or 7.x
* Host system with sufficient RAM and CPU resources

Verify installation:

```bash
vagrant --version
VBoxManage --version
```

---

## Repository Structure

```powershell
vagrant-repo/
│
├── labs/
│   └── <lab-name>/
│       ├── Vagrantfile
│       ├── system-setting/
|       |   ├ <vagrant_box>.sh
|       |   └ hosts.entries
│       └── README.md
│
└── templates/
    ├── vm/
    │   └── Vagrantfile
    │
    └── provision/
        └── <vagrant_box>.sh
```

---

## Templates

### vm/

Contains the base Vagrantfile template defining:

* VM box
* VirtualBox provider configuration
* CPU and memory allocation
* Provisioning integration

### provision/

Contains provisioning scripts used to bootstrap the VM.

Provisioning runs automatically during:

```bash
vagrant up
```

or manually:

```bash
vagrant provision
```

---

## Creating a New Lab

1. Create a new lab directory:

```bash
mkdir labs/my-lab
```

1. Copy templates:

```bash
cp templates/vm/Vagrantfile labs/my-lab/
```

1. Modify files as required.

---

## Running a Lab

Start VM:

```bash
cd labs/my-lab
vagrant up
```

Access VM:

```bash
vagrant ssh
```

Stop VM:

```bash
vagrant halt
```

Destroy VM:

```bash
vagrant destroy -f
```

---

## Notes

* Each lab is independent.
* Virtual machines are managed by VirtualBox.
* Configuration is defined in the Vagrantfile.
* Provisioning logic is auto-copied from templates/provision/<vagrant_box>.sh to labs/my-lab/system-setting/<vagrant_box>.sh

---

## Purpose

This repository serves as a centralized, version-controlled collection of reproducible virtual lab environments.
