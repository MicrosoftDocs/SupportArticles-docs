---
title: How to do a leapp Upgrade from RHEL 7 to 8 and from 8 to 9 on PAYGO images.
description: Guide with step by step procedure to do a leapp upgrade..
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 07/30/2024
ms.service: virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to do a `Leapp` Upgrade from RHEL 7 to 8 and from 8 to 9 on PAYGO images.

**Applies to:** :heavy_check_mark: Linux VMs

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. In this article, we guide you through upgrading from RHEL 7 to RHEL 8 or from RHEL 8 to RHEL 9 using a PAYGO (Pay-As-You-Go) image for Red Hat.

> [!IMPORTANT]
> RHUI is intended for only pay-as-you-go images. Are you using custom or golden images (also known as "bring-your-own-subscription (BYOS)") instead? In that case, the system has to be attached to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information on performing a `Leapp upgrade` process on custom or golden images, and pay-as-you-go (PAYG) images provided by Red Hat, refer to:

[Upgrading from RHEL 7 to 8](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index)

[Upgrading from RHEL 8 to 9](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index)


## Prerequisites

- Make a backup of the virtual machine or a snapshot of the OS disk.
- Clear enough space in /var/lib/leapp. Having at least 2-5 GB of free space is a safe practice
- Set up access to the serial console
- Root privileges.


## Preparing the Virtual Machine for the `Leapp` `pre-upgrade` and upgrade process

This procedure outlines the necessary steps to complete before performing an in-place upgrade to RHEL 8 or RHEL 9 using the Leapp utility.

#### [RHEL 7.9 to RHEL 8.X](#tab/rhel7-rhel8)

Now, you can conduct an in-place upgrade from RHEL 7 to the following RHEL 8 minor versions.


| Source OS version| Target Version     | End of support      |
|------------------|--------------------|---------------------|
| RHEL 7.9         | RHEL 8.8           | May 31, 2025 (EUS)  |
| RHEL 7.9         | RHEL 8.10(default) | Jun 30, 2028        |

> [!NOTE]  
> If you locked the Virtual Machine to a minor release, remove the version lock. For more information, see, [Switch a RHEL 7.x VM back to non-EUS](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/redhat/redhat-rhui?tabs=rhel7#switch-a-rhel-7x-vm-back-to-non-eus-remove-a-version-lock).

1. If you use the `yum-plugin-versionlock` to restrict packages to a certain version, remove the restriction by running

```bash
sudo yum versionlock clear
```
2. Enable required `RHUI` repositories and install required RHUI packages to ensure your system is ready for upgrade.

```bash
sudo yum-config-manager --enable rhui-microsoft-azure-rhel7
sudo yum -y install rhui-azure-rhel7
sudo yum-config-manager --enable rhui-rhel-7-server-rhui-extras-rpms
sudo yum -y install leapp-rhui-azure
```
3. Install the Leapp utility:

```bash
sudo yum install leapp-upgrade
```
4. Update all packages to the latest RHEL 7 version.

```bash
sudo yum update
```
5. Reboot the VM

```bash
sudo reboot
```
6. Temporarily disable antivirus software to prevent the upgrade from failing.

7. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture)


#### [RHEL 8.X to RHEL 9.X](#tab/rhel8-rhel9)

Now, you can conduct an in-place upgrade from RHEL 8 to the following RHEL 9 minor versions.


| Source OS version| Target Version  | End of support      |
|------------------|-----------------|---------------------|
| RHEL 8.8         | RHEL 9.2        | May 31, 2025 (EUS)  |
| RHEL 8.10        | RHEL 9.4        | May 31, 2026        |


> [!NOTE]  
> If you locked the Virtual Machine to a minor release, remove the version lock. For more information, see [Switch a RHEL 8.x VM back to non-EUS](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/redhat/redhat-rhui?tabs=rhel8#switch-a-rhel-7x-vm-back-to-non-eus-remove-a-version-lock).

1. If you use the `yum-plugin-versionlock` to restrict packages to a certain version, remove the restriction by running

```bash
sudo dnf versionlock clear
```

2. Enable required RHUI repositories and install required RHUI packages to ensure your system is ready for upgrade.

```bash
sudo dnf config-manager --set-enabled rhui-microsoft-azure-rhel8
sudo dnf -y install rhui-azure-rhel8 leapp-rhui-azure
```
3. Install the Leapp utility:

```bash
sudo dnf install leapp-upgrade
```
4. Update all packages to the latest RHEL 8 version.

```bash
sudo dnf update
```
5. Reboot the VM

```bash
sudo reboot
```
6. Temporarily disable antivirus software to prevent the upgrade from failing.

7. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture)

8. RHEL 9 no longer supports the legacy network-scripts package, which was deprecated in RHEL 8. Before upgrading, migrate your custom network scripts and create a NetworkManager dispatcher script to run your existing custom scripts. For more informartion, see to [Migrating custom network scripts to NetworkManager dispatcher scripts.](https://access.redhat.com/solutions/6900331)

---

## `Leapp pre-upgrade` and upgrade process for RHEL 7 and 8

#### `Leapp pre-upgrade` process

The `pre-upgrade`report highlights possible issues and provides recommended solutions. It also helps in determining whether it's feasible or advisable to proceed with the upgrade.

#### [RHEL 7.9 to RHEL 8.X](#tab/rhel7-rhel8)


1. Run the `leapp preupgrade` command. Replace <target_os_version> with the target OS version, for example 9.4. 


```bash
sudo leapp preupgrade --target <target_os_version> --no-rhsm
```


#### [RHEL 8.X to RHEL 9.X](#tab/rhel8-rhel9)


1. Run the `leapp preupgrade` command. Replace <target_os_version> with the target OS version, for example 8.10. 


```bash
sudo leapp preupgrade --target <target_os_version> --no-rhsm
```
---

Review the report located in the `/var/log/leapp/leapp-report.txt` file and manually address all identified issues. Some problems come with suggested fixes. Inhibitor issues must be resolved before you can proceed with the upgrade. For detailed information on the various issues that may appear in the report, for more information see, [Troubleshoot-red-hat-os-upgrade-issues.](https://learn.microsoft.com/en-us/troubleshoot/azure/virtual-machines/linux/troubleshoot-red-hat-os-upgrade-issues)


#### `Leapp` upgrade process

Continue to the leapp upgrade process after the `pre-upgrade` report shows no errors or inhibitors and everything is marked as resolved. The output is typically in green or yellow, indicating that it's safe to proceed with the leapp upgrade.

> [!IMPORTANT]  
> Make sure to run the `leapp upgrade` command through the serial console to avoid any network interruptions that could affect your SSH terminal and disrupt the upgrade process.


#### [RHEL 7.9 to RHEL 8.X](#tab/rhel7-rhel8)

1. Run the `leapp preupgrade` command. Replace <target_os_version> with the target OS version, for example 8.10. 

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --no-rhsm
```
2. If the `--reboot` option wasn't included in the previous command, monitor the serial console and manually reboot the VM once the upgrade process confirms that a reboot is required to continue with the process. 


```output
====> * add_upgrade_boot_entry
        Add new boot entry for Leapp provided initramfs.
A reboot is required to continue. Please reboot your system.
```

```bash
sudo reboot
```

#### [RHEL 8.X to RHEL 9.X](#tab/rhel8-rhel9)


1. Run the `leapp preupgrade` command. Replace <target_os_version> with the target OS version, for example 9.4. 

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --no-rhsm
```

2. If the `--reboot` option wasn't included in the previous command, monitor the serial console and manually reboot the VM once the upgrade process confirms that a reboot is required to continue with the process. 


```output
====> * add_upgrade_boot_entry
        Add new boot entry for Leapp provided initramfs.
A reboot is required to continue. Please reboot your system.
```

```bash
sudo reboot
```
---

Once the upgrade is finished, check if the system is in the desired state.


## Verification upgrade process

This procedure outlines the recommended verification steps to take after completing an in-place upgrade

#### [RHEL 7.9 to RHEL 8.X](#tab/rhel7-rhel8)

1. Verify that the current OS version belongs tp Red Hat Enterprice Linux 8

```bash
sudo cat /etc/redhat-release
```

2. Check the kernel version

```bash
uname -r
```

3. Verify the new repositories

```bash
sudo dnf repolist
```

#### [RHEL 8.X to RHEL 9.X](#tab/rhel8-rhel9)


1. Verify that the current OS version belongs tp Red Hat Enterprice Linux 9

```bash
sudo cat /etc/redhat-release
```

2. Check the kernel version

```bash
uname -r
```

3. Verify the new repositories

```bash
sudo dnf repolist
```

---

## Post-Upgrade Tasks

Once the VM is successfully upgraded, complete the following tasks:

#### [RHEL 7.9 to RHEL 8.X](#tab/rhel7-rhel8)

1. Delete any leftover `Leapp` packages from the exclude list in the /etc/dnf/dnf.conf configuration file, including the snactor package. These Leapp packages were installed during the in-place upgrade

```bash
sudo dnf config-manager --save --setopt exclude=''
```
2. Remove any remaining RHEL 7 packages, including any leftover `Leapp` packages

a. Locate remaining RHEL 7 packages

```bash
sudo rpm -qa | grep -e '\.el[67]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
```

b. Remove old packages for RHEL 7

```bash
sudo dnf remove $(rpm -qa | grep \.el[67] | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
```
3. Remove remaining RHEL 7 packages, including remaining `Leapp` packages

a. Determine old kernel versions

```bash
cd /lib/modules && ls -d *.el7*
```
```output
3.10.0-1160.119.1.el7.x86_64  3.10.0-1160.el7.x86_64
3.10.0-1160.59.1.el7.x86_64
```

b. Remove weak modules from the old kernel. If you have multiple old kernels, repeat the following step for each kernel:

```bash
[ -x /usr/sbin/weak-modules ] && /usr/sbin/weak-modules --remove-kernel <version>
```

```bash
[ -x /usr/sbin/weak-modules ] && /usr/sbin/weak-modules --remove-kernel 3.10.0-1160.119.1.el7.x86_64
```

> [!NOTE]  
>Disregard the following error message if the kernel package was previously removed: `/usr/sbin/weak-modules: line 1087: cd: /lib/modules/3.10.0-1160.119.1.el7.x86_64/weak-updates: No such file or directory`



4. Remove the old kernel from the boot loader entry. If you have multiple old kernels, repeat this step for each kernel

```bash
sudo /bin/kernel-install remove <version> /lib/modules/<version>/vmlinuz
```

```bash
sudo /bin/kernel-install remove 3.10.0-1160.119.1.el7.x86_64 /lib/modules/3.10.0-1160.119.1.el7.x86_64/vmlinuz
```

5. Remove remaining RHEL 7 packages, including old kernel packages, and the kernel-workaround package from your RHEL 8 VM. To ensure that RPM dependencies are maintained.

a. Remove kernel-workaround

```bash
sudo yum remove kernel-workaround $(rpm -qa | grep \.el7 | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
```

b. Remove remaining `Leapp` dependency packages

```bash
 sudo yum remove leapp-deps-el8 leapp-repository-deps-el8 leapp-rhui-azure
```

c. Remove any remaining empty directories

```bash
sudo rm -r /lib/modules/*el7*
```

d. **Optional*** Remove all remaining upgrade-related data from the system

```bash
sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
```

> [!IMPORTANT]  
>Removing `leapp` data might limit Microsoft and Red Hat Support’s ability to investigate and troubleshoot post-upgrade problems.


#### [RHEL 8.X to RHEL 9.X](#tab/rhel8-rhel9)

1. Delete any leftover `Leapp` packages from the exclude list in the /etc/dnf/dnf.conf configuration file, including the snactor package. These Leapp packages were installed during the in-place upgrade

```bash
sudo dnf config-manager --save --setopt exclude=''
```

2. Remove any remaining RHEL 8 packages, including any leftover `Leapp` packages

a. Locate remaining RHEL 8 packages

```bash
sudo rpm -qa | grep -e '\.el[78]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
```

b. Remove remaining RHEL 8 packages from your RHEL 9 vm.

```bash
sudo dnf remove $(rpm -qa | grep \.el[78] | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
```

c. Remove remaining `Leapp` dependency packages

```bash
sudo dnf remove leapp-deps-el9 leapp-repository-deps-el9
```

d. **Optional*** Remove all remaining upgrade-related data from the system

```bash
sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
```

> [!IMPORTANT]  
>Removing `leapp` data might limit Microsoft and Red Hat Support’s ability to investigate and troubleshoot post-upgrade problems.


---

