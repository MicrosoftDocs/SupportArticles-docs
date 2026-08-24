---
title: Upgrade RHEL pay-as-you-go virtual machines using Leapp
description: Learn how to upgrade RHEL pay-as-you-go virtual machines using Leapp from RHEL 7 to 8, RHEL 8 to 9, or RHEL 9 to 10, and verify the result.
author: kaushika-msft
ms.author: kaushika
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.date: 08/21/2026
ms.topic: troubleshooting
ms.service: azure-virtual-machines
ms.custom: sap:Kernel Upgrades, Package Management issue (Yum, Zypper, RPM, DPKG, APT)
ai-usage: ai-assisted
---
# How to perform an upgrade for RHEL pay-as-you-go virtual machines using Leapp

> [!CAUTION]
> Following the process in this article causes a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure features such as [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [automatic operating system (OS) image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [hotpatching](/windows-server/get-started/hotpatch#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) aren't available. To use these features, create a new VM by using your preferred OS instead of performing an in-place upgrade.

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. This article introduces how to use the Leapp utility to upgrade Linux virtual machines (VMs) that use RHEL pay-as-you-go images from RHEL 7 to RHEL 8, RHEL 8 to RHEL 9, or RHEL 9 to RHEL 10.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for pay-as-you-go images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you must attach the system to Red Hat Subscription Manager (RHSM) or Satellite to receive updates. For more information, see [How to register and subscribe a RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing a Leapp upgrade on custom, golden, or pay-as-you-go images provided by Red Hat, see the following articles:

- [Upgrading from RHEL 7 to RHEL 8](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index)

- [Upgrading from RHEL 8 to RHEL 9](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index)

- [Upgrading from RHEL 9 to RHEL 10](https://docs.redhat.com/documentation/red_hat_enterprise_linux/10/html/upgrading_from_rhel_9_to_rhel_10/index)

## Prerequisites

- Back up the Linux VM or take a snapshot of the OS disk.
- Clear enough space in `/var/lib/leapp` to accommodate the upgrade. A best practice is to have at least 2-5 GB of free space.
- Set up access to the Serial Console.
- Run the commands in this article with root privileges.

## Prepare the VM for the Leapp pre-upgrade and upgrade process

This section outlines the necessary steps before performing an in-place upgrade to RHEL 8, RHEL 9, or RHEL 10 by using the Leapp utility.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

RHEL 8.10 is the only valid target for an in-place upgrade from RHEL 7.

| Source OS version | Target version | Support type        |
|-------------------|----------------|---------------------|
| RHEL 7.9          | RHEL 8.10      | Maintenance Support |

> [!NOTE]  
> RHEL 8.10 is the final minor release of RHEL 8, so no Extended Update Support (EUS) repositories exist for it. Earlier RHEL 8 minor versions, such as RHEL 8.8, are no longer accepted as upgrade targets. To confirm the current list, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361).


> [!NOTE]  
>  If you locked the VM to a minor release, remove the version lock. For more information, see [Switch a RHEL 7.x VM back to non-EUS](/azure/virtual-machines/workloads/redhat/redhat-rhui#switch-a-rhel-server-to-non-eus-repositories).

1. If you pinned packages to a fixed version by using the `yum-plugin-versionlock` plug-in, drop the pins:

    ```bash
    sudo yum versionlock clear
    ```

1. Enable required RHUI repositories and install required RHUI packages to ensure your system is ready for the upgrade:

    ```bash
    sudo yum-config-manager --enable rhui-microsoft-azure-rhel7
    sudo yum -y install rhui-azure-rhel7
    sudo yum-config-manager --enable rhui-rhel-7-server-rhui-extras-rpms
    sudo yum -y install leapp-rhui-azure
    ```

1. Install the Leapp utility:

    ```bash
    sudo yum install leapp-upgrade
    ```

1. Update all packages to the latest RHEL 7 version:

    ```bash
    sudo yum update
    ```

1. Reboot the VM:

    ```bash
    sudo reboot
    ```

1. To prevent upgrade failures, temporarily disable your antivirus software and every configured health check, including Intelligent Platform Management Interface (IPMI) watchdogs. If one of these tools interrupts a critical phase of the upgrade, the VM can become unusable.

1. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

1. Make sure the VM doesn't rely on more than one network interface card (NIC) whose name uses the kernel `eth` prefix. If it does, switch to another naming scheme before you continue. For more information, see [How to perform an in-place upgrade to RHEL 8 when using kernel NIC names on RHEL 7](https://access.redhat.com/solutions/4067471).


### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

You can perform an in-place upgrade from RHEL 8 to the following RHEL 9 minor versions.


| Source OS version | Target version | Support type                  |
|-------------------|----------------|-------------------------------|
| RHEL 8.10         | RHEL 9.6       | Extended Update Support (EUS) |
| RHEL 8.10         | RHEL 9.8       | Latest RHEL 9 minor release   |

> [!IMPORTANT]  
> On pay-as-you-go VMs that use RHUI, only the most recent upgrade path is supported. This restriction doesn't apply to VMs that have SAP HANA installed. To upgrade an SAP-HANA or SAP-APPS pay-as-you-go VM, follow the SAP-specific procedure instead. For more information, see [Upgrading SAP environments from RHEL 8 to RHEL 9](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html-single/upgrading_sap_environments_from_rhel_8_to_rhel_9/index).

> [!NOTE]  
> Earlier RHEL 9 minor versions, such as RHEL 9.4, are no longer accepted as upgrade targets. To confirm the current list, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361).

> [!NOTE]  
> If you locked the VM to a minor release, remove the version lock. For more information, see [Switch a RHEL 8.x VM back to non-EUS](/azure/virtual-machines/workloads/redhat/redhat-rhui?tabs=rhel8#switch-a-rhel-server-to-non-eus-repositories).

1. If you pinned packages to a fixed version with the `dnf versionlock` plug-in, drop the pins:

    ```bash
    sudo dnf versionlock clear
    ```

1. To ensure your system is ready for the upgrade, enable required RHUI repositories and install required RHUI packages:

    ```bash
    sudo dnf config-manager --set-enabled rhui-microsoft-azure-rhel8
    sudo dnf -y install rhui-azure-rhel8 leapp-rhui-azure
    ```

1. Pin the VM to the source OS version so that the Leapp utility resolves the correct content:

    ```bash
    sudo rhui-set-release --set 8.10
    ```

    > [!NOTE]  
    > If the `rhui-set-release` command isn't available on the VM, write the value to the */etc/dnf/vars/releasever* file instead:
    >
    > ```bash
    > echo "8.10" | sudo tee /etc/dnf/vars/releasever
    > ```

1. If the VM was previously upgraded from RHEL 7 to RHEL 8, delete the files that upgrade left behind. Do this before you install any Leapp package, because those leftovers can break the RHEL 8 to RHEL 9 upgrade:

    ```bash
    sudo rm -rf /usr/share/leapp-repository/repositories
    ```

1. Install the Leapp utility.

    ```bash
    sudo dnf install leapp-upgrade
    ```

1. Update all packages to the latest RHEL 8 version:

    ```bash
    sudo dnf update
    ```

1. Reboot the VM.

    ```bash
    sudo reboot
    ```

1. To prevent upgrade failures, temporarily disable your antivirus software and every configured health check, including Intelligent Platform Management Interface (IPMI) watchdogs. If one of these tools interrupts a critical phase of the upgrade, the VM can become unusable.

1. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

1. RHEL 9 no longer supports the legacy network-scripts package, which was deprecated in RHEL 8. Before upgrading, migrate your custom network scripts and create a NetworkManager dispatcher script to run your existing custom scripts. For more information, see [Migrating custom network scripts to NetworkManager dispatcher scripts](https://access.redhat.com/solutions/6900331).

1. If your Network Security Services (NSS) database was created on RHEL 7 or earlier, convert it from the DBM format to SQLite before you upgrade. For more information, see [Updating NSS databases from DBM to SQLite](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html-single/upgrading_from_rhel_8_to_rhel_9/index#updating-nss-databases-from-dbm-to-sqlite_applying-security-policies).

### [RHEL 9.*x* to RHEL 10.*x*](#tab/rhel9-rhel10)

You can perform an in-place upgrade from RHEL 9 to the following RHEL 10 minor versions.

| Source OS version| Target version | Support type        |
|------------------|----------------|---------------------|
| RHEL 9.6         | RHEL 10.0      | Extended Update Support (EUS)|
| RHEL 9.8         | RHEL 10.2      | Latest RHEL 9 minor release|

> [!IMPORTANT]  
> On pay-as-you-go VMs that use RHUI, only the latest available upgrade path is supported. This restriction doesn't apply to VMs that have SAP HANA installed. To upgrade an SAP-HANA or SAP-APPS pay-as-you-go VM, see [How to upgrade SAP-HANA and SAP-APPS pay-as-you-go virtual machines from RHEL 9.x to RHEL 10.x using Leapp](leapp-upgrade-rhel-9dotx-to-10dotx-saphana-sapapps.md).

> [!NOTE]  
> For more information, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361).

1. If the VM was previously upgraded from RHEL 8 to RHEL 9, make sure that you completed all required post-upgrade tasks. For more information, see [Performing post-upgrade tasks on the RHEL 9 system](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html-single/upgrading_from_rhel_8_to_rhel_9/index#performing-post-upgrade-tasks-on-the-rhel-9-system_upgrading-from-rhel-8-to-rhel-9).

1. Set the expected system release version to the source OS version:

    ```bash
    sudo rhui-set-release --set <source_os_version>
    ```

Replace `<source_os_version>` with the source OS version (for example, `9.6`).

> [!IMPORTANT]  
> Keep this lock in place until the upgrade finishes. It pins the VM to the minor release that Leapp uses as the source, so the `dnf update` command in a later step can't move the VM to a different minor release and break the upgrade path.

> [!NOTE]  
> If the `rhui-set-release` command isn't available on the VM, set the expected release version by updating the */etc/dnf/vars/releasever* file instead:
> ```bash
> echo "<source_os_version>" | sudo tee /etc/dnf/vars/releasever
> ```

1. If you used the `dnf versionlock` plug-in to pin individual packages to a specific version, clear those pins:

    ```bash
    sudo dnf versionlock clear
    ```

> [!NOTE]  
> This step has nothing to do with the release lock from the previous step. The `dnf versionlock` plug-in pins individual packages, such as a specific kernel build, and keeps its list in */etc/dnf/plugins/versionlock.list*. Any pin left in place blocks the Leapp utility from replacing that package during the upgrade.

1. Enable required RHUI repositories and install required RHUI packages to ensure your system is ready for the upgrade.

    ```bash
    sudo dnf config-manager --set-enabled rhui-microsoft-azure-rhel9
    sudo dnf -y install rhui-azure-rhel9 leapp-rhui-azure
    ```

5. Install the Leapp utility.

    ```bash
    sudo dnf install leapp-upgrade
    ```

1. Update all packages so that the VM runs the latest content available for the pinned minor release.

    ```bash
    sudo dnf update
    ```

7. Reboot the VM.

    ```bash
    sudo reboot
    ```

1. (Optional) Look for the *.rpmnew* and *.rpmsave* files that earlier updates left on the VM, merge back any setting you still need, and then delete the files.

1. To prevent upgrade failures, temporarily disable your antivirus software and any configured health checks, including Intelligent Platform Management Interface (IPMI) watchdogs.

1. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

---

## Leapp pre-upgrade process

The Leapp pre-upgrade report highlights possible issues, provides recommended solutions, and helps you determine whether it's feasible or advisable to proceed with the upgrade.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

Run the following `leapp preupgrade` command:

```bash
sudo -r unconfined_r -t unconfined_t prlimit --nofile=16384 leapp preupgrade --target <target_os_version> --no-rhsm
```

If SELinux is disabled on the VM, run the following command instead:

```bash
sudo prlimit --nofile=16384 leapp preupgrade --target <target_os_version> --no-rhsm
```

> [!NOTE]  
> - Replace `<target_os_version>` with the target OS version (for example, `8.10`).
> - The `prlimit --nofile=16384` command raises the file descriptor limit that the Leapp utility needs. It runs as part of the same command because an unprivileged user can't raise the limit beforehand.

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

Run the following `leapp preupgrade` command:

```bash
sudo -r unconfined_r -t unconfined_t leapp preupgrade --target <target_os_version> --no-rhsm
```

> [!NOTE]  
> - Replace `<target_os_version>` with the target OS version (for example, `9.6` or `9.8`).
> - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.

### [RHEL 9.*x* to RHEL 10.*x*](#tab/rhel9-rhel10)

Run the following `leapp preupgrade` command:

```bash
sudo -r unconfined_r -t unconfined_t leapp preupgrade --target <target_os_version> --no-rhsm
```

> [!NOTE]  
> - Replace `<target_os_version>` with the target OS version (for example, `10.0` or `10.2`).
> - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.

---

Check the report in the `/var/log/leapp/leapp-report.txt` file and manually resolve any identified issues. Some problems include recommended fixes. You must resolve inhibitor issues before you can proceed with the upgrade. For detailed information about the various issues that might appear in the report, see [Troubleshooting Red Hat OS upgrade issues](troubleshoot-red-hat-os-upgrade-issues.md).

## Leapp upgrade process

Continue the Leapp upgrade process after the Leapp pre-upgrade report shows no errors or inhibitors and everything is marked as resolved. The output is typically green or yellow, indicating that it's safe to proceed with the Leapp upgrade.

> [!IMPORTANT]  
> Ensure you run the `leapp upgrade` command through the Serial Console to avoid any network interruptions that could affect your secure shell (SSH) terminal and disrupt the upgrade process.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

1. Run the following `leapp upgrade` command:

    ```bash
    sudo -r unconfined_r -t unconfined_t prlimit --nofile=16384 leapp upgrade --target <target_os_version> --no-rhsm
    ```

    If SELinux is disabled on the VM, run the following command instead:

    ```bash
    sudo prlimit --nofile=16384 leapp upgrade --target <target_os_version> --no-rhsm
    ```

    > [!NOTE]
    > - Replace `<target_os_version>` with the target OS version, for example, `8.10`. 
    > - The `prlimit --nofile=16384` command raises the file descriptor limit that the Leapp utility needs. It runs as part of the same command because an unprivileged user can't raise the limit beforehand.
    > - Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process.

2. If you didn't include the `--reboot` option in the previous command, monitor the Serial Console. When the upgrade process confirms that a reboot is required to continue, as shown in the following output, manually reboot the VM:


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
    sudo -r unconfined_r -t unconfined_t leapp upgrade --target <target_os_version> --no-rhsm
    ```
    
    > [!NOTE]
    > - Replace `<target_os_version>` with the target OS version, for example, `9.6` or `9.8`. 
    > - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.
    > - Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process.

1. If you didn't include the `--reboot` option in the previous command, monitor the Serial Console. When the upgrade process shows that a reboot is required to continue, manually reboot the VM.


    ```output
    ====> * add_upgrade_boot_entry
            Add new boot entry for Leapp provided initramfs.
    A reboot is required to continue. Please reboot your system.
    ```
    
    ```bash
    sudo reboot
    ```

### [RHEL 9.*x* to RHEL 10.*x*](#tab/rhel9-rhel10)


1. Run the following `leapp upgrade` command:

    ```bash
    sudo -r unconfined_r -t unconfined_t leapp upgrade --target <target_os_version> --no-rhsm
    ```
    
    > [!NOTE]
    > - Replace `<target_os_version>` with the target OS version, for example, `10.0` or `10.2`.
    > - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.
    > - Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process.

2. If you didn't include the `--reboot` option in the previous command, monitor the Serial Console. When the upgrade process shows that a reboot is required to continue, manually reboot the VM.


    ```output
    ====> * add_upgrade_boot_entry
            Add new boot entry for Leapp provided initramfs.
    A reboot is required to continue. Please reboot your system.
    ```
    
    ```bash
    sudo reboot
    ```


---

When the upgrade finishes, check if the system is in the desired state.

## Verify the Leapp upgrade process

This section outlines the recommended verification steps after completing an in-place upgrade.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

1. Verify that the current OS version belongs to RHEL 8:

    ```bash
    sudo cat /etc/redhat-release
    ```

1. Verify the version lock file:

    ```bash
    sudo cat /etc/dnf/vars/releasever
    ```

1. Check the kernel version:

    ```bash
    uname -r
    ```

1. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

1. Verify that the current OS version belongs to RHEL 9:

    ```bash
    sudo cat /etc/redhat-release
    ```

2. Verify the version lock file:

    ```bash
    sudo cat /etc/dnf/vars/releasever
    ```

3. Check the kernel version:

    ```bash
    uname -r
    ```

4. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```

### [RHEL 9.*x* to RHEL 10.*x*](#tab/rhel9-rhel10)

1. Verify that the current OS version belongs to RHEL 10:

    ```bash
    sudo cat /etc/redhat-release
    ```

2. Verify the version lock file:

    ```bash
    sudo cat /etc/dnf/vars/releasever
    ```

3. Check the kernel version:

    ```bash
    uname -r
    ```

4. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```
    
---

## Post-upgrade tasks

After the VM is upgraded, complete the following tasks.

### [RHEL 7.9 to RHEL 8.*x*](#tab/rhel7-rhel8)

1. Delete all remaining Leapp packages, including the *`snactor`* package, from the exclude list in the */etc/dnf/dnf.conf* configuration file. The in-place upgrade installs these Leapp packages.

    ```bash
    sudo dnf config-manager --save --setopt exclude=''
    ```

1. Detach the RHEL 7 kernels before you remove any package. Otherwise, stale module links and boot entries remain.

   1. List the old kernel versions:

       ```bash
       cd /lib/modules && ls -d *.el7*
       ```
    
       ```output
       3.10.0-1160.119.1.el7.x86_64  3.10.0-1160.el7.x86_64
       3.10.0-1160.59.1.el7.x86_64
       ```

   1. Drop the weak modules of each old kernel. Repeat the command for every version returned by the previous step:

       ```bash
       [ -x /usr/sbin/weak-modules ] && sudo /usr/sbin/weak-modules --remove-kernel <kernel version>
       ```

        > [!NOTE]  
        > Ignore the following error message, which is generated if the kernel package was previously removed:
        >
        > > /usr/sbin/weak-modules: line \<line number\>: cd: /lib/modules/\<kernel version\>/weak-updates: No such file or directory

   1. Delete the boot loader entry of each old kernel. Repeat the command for every version:

       ```bash
       sudo /bin/kernel-install remove <kernel version> /lib/modules/<kernel version>/vmlinuz
       ```

1. Remove everything that still belongs to RHEL 7, including the old kernel packages, the *kernel-workaround* package, and the leftover Leapp packages. Use `dnf` so that RPM dependencies stay consistent.

   1. Review what's still installed:

       ```bash
       rpm -qa | grep -e '\.el[67]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
       ```      

   1. Remove those packages:

       ```bash
       sudo dnf remove kernel-workaround $(rpm -qa | grep \.el7 | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
       ```

        > [!IMPORTANT]  
        > This step might also remove third-party packages. Review the transaction before you accept it to make sure that no packages are unintentionally removed.

   1. Remove remaining Leapp dependency packages:

       ```bash
       sudo dnf remove leapp-deps-el8 leapp-repository-deps-el8 leapp-rhui-azure
       ```

   1. Remove any remaining empty directories:

       ```bash
       sudo rm -r /lib/modules/*el7*
       ```

1. Disable every repository whose content isn't compatible with RHEL 8:

    ```bash
    sudo dnf config-manager --set-disabled <repository_id>
    ```

1. Verify that the rescue kernel is present on the VM:

    ```bash
    ls /boot/vmlinuz*rescue* 2>/dev/null || echo "No rescue kernel installed."
    ```

   If the rescue kernel is present, replace the old rescue kernel and initial RAM disk with the current ones:

    ```bash
    sudo dnf -y install dracut-config-rescue
    sudo rm /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*
    sudo /usr/lib/kernel/install.d/51-dracut-rescue.install add "$(uname -r)" /boot "/boot/vmlinuz-$(uname -r)"
    ```

1. Look for the *.rpmnew*, *.rpmsave*, and *.leappsave* files that the upgrade left on the VM, merge back any setting you still need, and then delete the files.

1. Reapply your security policies. The Leapp utility switches SELinux to permissive mode during the upgrade and doesn't switch it back. If the VM ran in enforcing mode before the upgrade, restore that mode. If the VM already ran in permissive mode and you want to keep it that way, skip this step.

   1. Check that there are no SELinux denials:

       ```bash
       sudo ausearch -m AVC,USER_AVC -ts boot
       ```

   1. Set `SELINUX=enforcing` in the */etc/selinux/config* file, and then reboot the VM.

   1. Confirm the new mode:

       ```bash
       getenforce
       ```

1. (Optional) Remove all remaining upgrade-related data from the system:

    ```bash
    sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
    ```

    > [!IMPORTANT]  
    > Removing this data might limit Microsoft and Red Hat Support's ability to investigate and troubleshoot post-upgrade problems.

### [RHEL 8.*x* to RHEL 9.*x*](#tab/rhel8-rhel9)

1. Delete all remaining Leapp packages, including the *`snactor`* package, from the exclude list in the */etc/dnf/dnf.conf* configuration file. The in-place upgrade installs these Leapp packages.

    ```bash
    sudo dnf config-manager --save --setopt exclude=''
    ```

1. Remove all remaining RHEL 8 packages, including any remaining Leapp packages.

   1. Locate remaining RHEL 8 packages.

       ```bash
       sudo rpm -qa | grep -e '\.el[78]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
       ```

   1. Remove remaining RHEL 8 packages from your RHEL 9 VM:

       ```bash
       sudo dnf remove $(rpm -qa | grep \.el[78] | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
       ```

        > [!IMPORTANT]  
        > This step might also remove third-party packages. Review the transaction before you accept it to make sure that no packages are unintentionally removed.

   3. Remove remaining Leapp dependency packages:

       ```bash
       sudo dnf remove leapp-deps-el9 leapp-repository-deps-el9
       ```

   1. (Optional) Remove all remaining upgrade-related data from the system:

       ```bash
       sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
       ```

        > [!IMPORTANT]  
        > Removing this data might limit Microsoft and Red Hat Support's ability to investigate and troubleshoot post-upgrade problems.

1. Disable every repository whose content isn't compatible with RHEL 9:

    ```bash
    sudo dnf config-manager --set-disabled <repository_id>
    ```

1. Verify that the rescue kernel is present on the VM:

    ```bash
    ls /boot/vmlinuz*rescue* 2>/dev/null || echo "No rescue kernel installed."
    ```

   If the rescue kernel is present, replace the old rescue kernel and initial RAM disk with the current ones:

    ```bash
    sudo dnf -y install dracut-config-rescue
    sudo rm /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*
    sudo /usr/lib/kernel/install.d/51-dracut-rescue.install add "$(uname -r)" /boot "/boot/vmlinuz-$(uname -r)"
    ```

1. Look for the *.rpmnew*, *.rpmsave*, and *.leappsave* files that the upgrade left on the VM, merge back any setting you still need, and then delete the files.

1. Reapply your security policies. The Leapp utility switches SELinux to permissive mode during the upgrade and doesn't switch it back. If the VM ran in enforcing mode before the upgrade, restore that mode. If the VM already ran in permissive mode and you want to keep it that way, skip this step.

   1. Check that there are no SELinux denials:

       ```bash
       sudo ausearch -m AVC,USER_AVC -ts boot
       ```

   2. Set `SELINUX=enforcing` in the */etc/selinux/config* file, and then reboot the VM.

   3. Confirm the new mode:

       ```bash
       getenforce
       ```


### [RHEL 9.*x* to RHEL 10.*x*](#tab/rhel9-rhel10)


1. Delete all remaining Leapp packages, including the *`snactor`* package, from the exclude list in the */etc/dnf/dnf.conf* configuration file. The in-place upgrade installs these Leapp packages.

    ```bash
    sudo dnf config-manager --save --setopt exclude=''
    ```

1. Remove all remaining RHEL 9 packages, including any remaining Leapp packages.

   1. Locate remaining RHEL 9 packages.

       ```bash
       sudo rpm -qa | grep -e '\.el[789]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort
       ```

   1. Remove remaining RHEL 9 packages from your RHEL 10 VM:

       ```bash
       sudo dnf remove $(rpm -qa | grep \.el[789] | grep -vE 'gpg-pubkey|libmodulemd|katello-ca-consumer')
       ```

        > [!IMPORTANT]  
        > This step might also remove third-party packages. Review the transaction before you accept it to make sure that no packages are unintentionally removed.

   3. Remove remaining Leapp dependency packages:

       ```bash
       sudo dnf remove leapp-deps-el10 leapp-repository-deps-el10
       ```

   4. (Optional) Remove all remaining upgrade-related data from the system:

       ```bash
       sudo rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp
       ```

        > [!IMPORTANT]  
        > Removing this data might limit Microsoft and Red Hat Support's ability to investigate and troubleshoot post-upgrade problems.

1. Disable every repository whose content isn't compatible with RHEL 10:

    ```bash
    sudo dnf config-manager --set-disabled <repository_id>
    ```

4. Verify that the rescue kernel is present on the VM:

    ```bash
    ls /boot/vmlinuz*rescue* 2>/dev/null || echo "No rescue kernel installed."
    ```

   If the rescue kernel is present, replace the old rescue kernel and initial RAM disk with the current ones:

    ```bash
    sudo dnf -y install dracut-config-rescue
    sudo rm /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*
    sudo /usr/lib/kernel/install.d/51-dracut-rescue.install add "$(uname -r)" /boot "/boot/vmlinuz-$(uname -r)"
    ```

1. Review the configuration files that the upgrade left behind:

   - Look for the *.rpmnew*, *.rpmsave*, and *.leappsave* files, merge back any setting you still need, and then delete the files.
   - Delete the RHEL 9 DNF module files that are no longer valid from the */etc/dnf/modules.d/* directory.

1. Reapply your security policies. The Leapp utility sets SELinux to permissive mode during the upgrade and doesn't set it back. If the VM ran in enforcing mode before the upgrade, restore that mode. If the VM already ran in permissive mode and you want to keep it that way, skip this step.

   1. Check that there are no SELinux denials:

       ```bash
       sudo ausearch -m AVC,USER_AVC -ts boot
       ```

   2. Set `SELINUX=enforcing` in the */etc/selinux/config* file, and then reboot the VM.

   3. Confirm the new mode:

       ```bash
       getenforce
       ```


---

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [AI-generated content attribution](../../../includes/ai-generated-attribution.md)]
