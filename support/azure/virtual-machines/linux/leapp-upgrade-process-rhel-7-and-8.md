---
title: Upgrade RHEL PAYG virtual machines using Leapp
description: Provides steps to upgrade virtual machines that use RHEL pay-as-you-go images from RHEL 7 to RHEL 8 or RHEL 8 to RHEL 9.
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.date: 09/14/2024
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.topic: how-to
---
# How to perform an upgrade for RHEL PAYG virtual machines using Leapp

> [!CAUTION]
> Following the process in this article will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure features such as [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [automatic operating system (OS) image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [hotpatching](/windows-server/get-started/hotpatch#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, we recommend creating a new VM using your preferred OS instead of performing an in-place upgrade.

**Applies to:** :heavy_check_mark: Linux VMs

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. This article introduces how to use the Leapp utility to upgrade Linux virtual machines (VMs) that use RHEL pay-as-you-go (PAYG) images from RHEL 7 to RHEL 8 or RHEL 8 to RHEL 9.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for PAYG images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you must attach the system to Red Hat Subscription Manager (RHSM) or Satellite to receive updates. For more information, see [How to register and subscribe a RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing a Leapp upgrade on custom, golden, or PAYG images provided by Red Hat, see the following articles:

- [Upgrading from RHEL 7 to RHEL 8](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index)

- [Upgrading from RHEL 8 to RHEL 9](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index)

## Prerequisites

- Make a backup of the Linux VM or a snapshot of the OS disk.
- Clear enough space in `/var/lib/leapp` to accommodate the upgrade. A best practice is to have at least 2-5 GB of free space.
- Set up access to the Serial Console.
- Run the commands in this article with root privileges.

## Prepare the VM for the Leapp pre-upgrade and upgrade process

This section outlines the necessary steps before performing an in-place upgrade to RHEL 8 or RHEL 9 using the Leapp utility.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

You can perform an in-place upgrade from RHEL 7 to the following RHEL 8 minor versions.

| Source OS version| Target version     | End of support      |
|------------------|--------------------|---------------------|
| RHEL 7.9         | RHEL 8.8           | May 31, 2025 (Extended Update Support (EUS))|
| RHEL 7.9         | RHEL 8.10 (default) | Jun 30, 2028        |

> [!NOTE]  
>  If you locked the VM to a minor release, remove the version lock. For more information, see [Switch a RHEL 7.x VM back to non-EUS](/azure/virtual-machines/workloads/redhat/redhat-rhui#switch-a-rhel-server-to-non-eus-repositories).

1. If you restricted packages to a specific version using the `yum-plugin-versionlock` command, remove the restriction:

    ```bash
    sudo yum versionlock clear
    ```

2. Enable required RHUI repositories and install required RHUI packages to ensure your system is ready for the upgrade:

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

4. Update all packages to the latest RHEL 7 version:

    ```bash
    sudo yum update
    ```

5. Reboot the VM:

    ```bash
    sudo reboot
    ```

6. To prevent upgrade failures, temporarily disable your antivirus software.

7. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).


### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

You can perform an in-place upgrade from RHEL 8 to the following RHEL 9 minor versions.


| Source OS version| Target version  | End of support      |
|------------------|-----------------|---------------------|
| RHEL 8.8         | RHEL 9.2        | May 31, 2025 (EUS)  |
| RHEL 8.10        | RHEL 9.4        | May 31, 2026 (EUS)  |
| RHEL 8.10        | RHEL 9.5        | May 31, 2026        |


> [!NOTE]  
> If you locked the VM to a minor release, remove the version lock. For more information, see [Switch a RHEL 8.x VM back to non-EUS](/azure/virtual-machines/workloads/redhat/redhat-rhui?tabs=rhel8#switch-a-rhel-server-to-non-eus-repositories).

1. If you restricted packages to a specific version using the `yum-plugin-versionlock` command, remove the restriction:

    ```bash
    sudo dnf versionlock clear
    ```

2. To ensure your system is ready for the upgrade, enable required RHUI repositories and install required RHUI packages:

    ```bash
    sudo dnf config-manager --set-enabled rhui-microsoft-azure-rhel8
    sudo dnf -y install rhui-azure-rhel8 leapp-rhui-azure
    ```
3. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```
4. Update all packages to the latest RHEL 8 version:

    ```bash
    sudo dnf update
    ```
5. Reboot the VM:

    ```bash
    sudo reboot
    ```
6. To prevent upgrade failures, temporarily disable your antivirus software.

7. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

8. RHEL 9 no longer supports the legacy network-scripts package, which was deprecated in RHEL 8. Before upgrading, migrate your custom network scripts and create a NetworkManager dispatcher script to run your existing custom scripts. For more information, see [Migrating custom network scripts to NetworkManager dispatcher scripts](https://access.redhat.com/solutions/6900331).

---

## Leapp pre-upgrade process

The Leapp pre-upgrade report highlights possible issues, provides recommended solutions, and helps determine whether it's feasible or advisable to proceed with the upgrade.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

Run the following `leapp preupgrade` command:

```bash
sudo leapp preupgrade --target <target_os_version> --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example, `8.10`. 

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

Run the following `leapp preupgrade` command:

```bash
sudo leapp preupgrade --target <target_os_version> --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example, `9.4` or `9.5`. 

---

Check the report located in the `/var/log/leapp/leapp-report.txt` file and resolve any identified issues manually. Some problems come with recommended fixes. Inhibitor issues must be resolved before you can proceed with the upgrade. For detailed information about the various issues that might appear in the report, see [Troubleshooting Red Hat OS upgrade issues](troubleshoot-red-hat-os-upgrade-issues.md).

## Leapp upgrade process

Continue the Leapp upgrade process after the Leapp pre-upgrade report shows no errors or inhibitors and everything is marked as resolved. The output is typically green or yellow, indicating that it's safe to proceed with the Leapp upgrade.

> [!IMPORTANT]  
> Make sure to run the `leapp upgrade` command through the Serial Console to avoid any network interruptions that could affect your secure shell (SSH) terminal and disrupt the upgrade process.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

1. Run the following `leapp preupgrade` command:

    ```bash
    sudo leapp upgrade --target <target_os_version> --no-rhsm
    ```

    > [!NOTE]
    > - Replace `<target_os_version>` with the target OS version, for example, `8.10`. 
    > - If you want to perform an automatic reboot, which is needed during the upgrade process, add the `--reboot` option to the `leapp upgrade` command.

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue the process, as shown in the following output, manually reboot the VM:


    ```output
    ====> * add_upgrade_boot_entry
            Add new boot entry for Leapp provided initramfs.
    A reboot is required to continue. Please reboot your system.
    ```

    ```bash
    sudo reboot
    ```

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

1. Run the following `leapp upgrade` command:

    ```bash
    sudo leapp upgrade --target <target_os_version> --no-rhsm
    ```
    
    > [!NOTE]
    > - Replace `<target_os_version>` with the target OS version, for example, `9.4` or `9.5`. 
    > - If you want to perform an automatic reboot, which is needed during the upgrade process, add the `--reboot` option to the `leapp upgrade` command.

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process shows that a reboot is required to continue the process as follows, manually reboot the VM:


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

## Verify the Leapp upgrade process

This section outlines the recommended verification steps after completing an in-place upgrade.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

1. Verify that the current OS version belongs to RHEL 8:

    ```bash
    sudo cat /etc/redhat-release
    ```

2. Check the kernel version:

    ```bash
    uname -r
    ```

3. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

1. Verify that the current OS version belongs to RHEL 9:

    ```bash
    sudo cat /etc/redhat-release
    ```

2. Check the kernel version:

    ```bash
    uname -r
    ```

3. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```

---

## Post-upgrade tasks

Once the VM is successfully upgraded, perform the following tasks:

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

1. Delete all remaining Leapp packages, including the *`snactor`* package, from the exclude list in the */etc/dnf/dnf.conf* configuration file. These Leapp packages are installed during the in-place upgrade.

    ```bash
    sudo dnf config-manager --save --setopt exclude=''
    ```

2. Remove all remaining RHEL 7 packages, including any remaining Leapp packages.

   1. Locate remaining RHEL 7 packages:

       ```bash
       sudo rpm -qa | grep -e '\.el[67]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
       ```      

   2. Remove the old packages for RHEL 7:

       ```bash
       sudo dnf remove $(rpm -qa | grep \.el[67] | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
       ```

3. Remove remaining RHEL 7 weak modules from the old kernel.

   1. Determine old kernel versions:

       ```bash
       sudo cd /lib/modules && sudo ls -d *.el7*
       ```
    
       ```output
       3.10.0-1160.119.1.el7.x86_64  3.10.0-1160.el7.x86_64
       3.10.0-1160.59.1.el7.x86_64
       ```

   2. Remove weak modules from the old kernel. If you have multiple old kernels, run the following command for each kernel:

       ```bash
       sudo [ -x /usr/sbin/weak-modules ] && sudo /usr/sbin/weak-modules --remove-kernel <kernel version>
       ```

        > [!NOTE]  
        > Ignore the following error message, which is generated if the kernel package was previously removed:
        >
        > > /usr/sbin/weak-modules: line \<line number\>: cd: /lib/modules/\<kernel version\>/weak-updates: No such file or directory

4. Remove the old kernel from the boot loader entry. If you have multiple old kernels, run the following command for each kernel:

    ```bash
    sudo /bin/kernel-install remove <kernel version> /lib/modules/<kernel version>/vmlinuz
    ```

5. Remove remaining RHEL 7 packages, including old kernel packages and the *kernel-workaround* package, from your RHEL 8 VM. To maintain RPM dependencies, use `yum` or `dnf` when performing these actions.

   1. Remove the *kernel-workaround* package:

       ```bash
       sudo yum remove kernel-workaround $(rpm -qa | grep \.el7 | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
       ```

   1. Remove remaining Leapp dependency packages:

       ```bash
       sudo yum remove leapp-deps-el8 leapp-repository-deps-el8 leapp-rhui-azure
       ```

   1. Remove any remaining empty directories:

       ```bash
       sudo rm -r /lib/modules/*el7*
       ```

   1. (Optional) Remove all remaining upgrade-related data from the system:

       ```bash
       sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
       ```

        > [!IMPORTANT]  
        > Removing this data might limit Microsoft and Red Hat Support's ability to investigate and troubleshoot post-upgrade problems.

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

1. Delete all remaining Leapp packages, including the *`snactor`* package, from the exclude list in the */etc/dnf/dnf.conf* configuration file. These Leapp packages are installed during the in-place upgrade.

    ```bash
    sudo dnf config-manager --save --setopt exclude=''
    ```

2. Remove all remaining RHEL 8 packages, including any remaining Leapp packages.

   1. Locate remaining RHEL 8 packages.

       ```bash
       sudo rpm -qa | grep -e '\.el[78]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
       ```

   2. Remove remaining RHEL 8 packages from your RHEL 9 VM:

       ```bash
       sudo dnf remove $(rpm -qa | grep \.el[78] | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
       ```

   3. Remove remaining Leapp dependency packages:

       ```bash
       sudo dnf remove leapp-deps-el9 leapp-repository-deps-el9
       ```

   4. (Optional) Remove all remaining upgrade-related data from the system:

       ```bash
       sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
       ```

        > [!IMPORTANT]  
        > Removing this data might limit Microsoft and Red Hat Support's ability to investigate and troubleshoot post-upgrade problems.

---

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
