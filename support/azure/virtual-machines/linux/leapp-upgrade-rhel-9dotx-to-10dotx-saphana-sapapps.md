---
title: Leapp upgrade from RHEL 9.x to RHEL 10.x on SAP-HANA and SAP-APPS pay-as-you-go VMs
description: Learn how to perform a Leapp upgrade from RHEL 9.6 to RHEL 10.0 on SAP HANA and SAP applications pay-as-you-go VMs, and verify the result.
author: kaushika-msft
ms.author: kaushika
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.date: 08/21/2026
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.custom: sap:Kernel Upgrades, Package Management issue (Yum, Zypper, RPM, DPKG, APT)
ai-usage: ai-assisted
---

# Perform a Leapp upgrade from RHEL 9 to RHEL 10 on SAP-HANA and SAP-APPS pay-as-you-go VMs

**Applies to:** :heavy_check_mark: Linux VMs

> [!CAUTION]
> If you follow the process in this article, the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM) disconnect. Azure features such as [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [automatic operating system (OS) image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) aren't available. To use these features, create a new VM with your preferred OS instead of performing an in-place upgrade.

## Summary

A Leapp upgrade from RHEL 9.6 to RHEL 10.0 helps SAP-HANA and SAP-APPS pay-as-you-go VMs receive current features, security updates, and support. This article explains how to prepare, run, and verify the in-place upgrade.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for pay-as-you-go images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you must attach the system to Red Hat Subscription Manager (RHSM) or Satellite to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing a Leapp upgrade on custom, golden, or pay-as-you-go images provided by Red Hat, see [Upgrading SAP environments from RHEL 9 to RHEL 10](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/10/html/upgrading_sap_environments_from_rhel_9_to_rhel_10/index).

## Prerequisites

- Back up the Linux VM or take a snapshot of the OS disk.
- Clear enough space in `/var/lib/leapp` to accommodate the upgrade. A best practice is to have at least 2-5 GB of free space.
- Set up access to the Serial Console.
- Run the commands in this article with root privileges.
- Plan for three reboots: one before the upgrade process and two during it.

## Prepare the VM for the Leapp pre-upgrade and upgrade process

You can perform an in-place upgrade from RHEL 9 to the following RHEL 10 minor versions.

|System configuration   | Source OS version| Target version    |
|----------------------|------------------|------------------|
|SAP HANA              | RHEL 9.6         | RHEL 10.0         |
|SAP NetWeaver and other SAP Applications | RHEL 9.6        | RHEL 10.0  |

> [!NOTE]  
> For more information, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361).

According to the [Upgrading SAP environments from RHEL 9 to RHEL 10 - Supported upgrade paths](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/10/html/upgrading_sap_environments_from_rhel_9_to_rhel_10/asmb_supported-upgrade-paths_upgrading-sap-environment-10) documentation, the only in-place upgrade path currently supported on VMs that use RHUI is from RHEL 9.6 to RHEL 10.0, for both SAP HANA and SAP NetWeaver / S/4HANA systems. For systems where both SAP HANA and SAP NetWeaver are installed, the SAP HANA restrictions apply.

If the installed SAP HANA version isn't on the minimum revision that's supported on both the source and target RHEL minor versions, upgrade the SAP HANA instance first. For more information, see [Planning an upgrade](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/10/html/upgrading_sap_environments_from_rhel_9_to_rhel_10/asmb_planning-upgrade_upgrading-sap-environment-10).

### [RHEL 9.6 to RHEL 10.0 - SAP-HANA PAYG VMs](#tab/rhel10saphana)

This section outlines the necessary steps before performing an in-place upgrade from RHEL 9.6 to RHEL 10.0 by using the Leapp utility on SAP-HANA pay-as-you-go VMs.

> [!NOTE]  
> If your VM is part of a high availability cluster, follow the guidelines in [Procedure to upgrade a RHEL 9 High Availability cluster to RHEL 10](https://access.redhat.com/articles/7012677). To minimize downtime, upgrade the cluster nodes that run the less important SAP instances (for example, the secondary SAP HANA instance) first.

> [!NOTE] 
> To update an SAP-HANA system from RHEL 9.6 to RHEL 10.0, you must first upgrade the system to RHEL 9.6 if it isn't. Also, if the VM was previously upgraded from RHEL 8 to RHEL 9, ensure that you complete all required post-upgrade tasks. For more information, see [Performing post-upgrade tasks on the RHEL 9 system](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html-single/upgrading_from_rhel_8_to_rhel_9/index#performing-post-upgrade-tasks-on-the-rhel-9-system_upgrading-from-rhel-8-to-rhel-9).

1. Make sure your current Red Hat release is 9.6:

    ```bash
    sudo cat /etc/redhat-release 
    ```

1. To ensure your system is ready for upgrade, install the required RHUI package:

    ```bash
    sudo dnf install leapp-rhui-azure-sap
    ```

    > [!NOTE]  
    > If the package can't be found, enable the RHUI client configuration repository first:
    >
    > ```bash
    > sudo dnf config-manager --set-enabled rhui-microsoft-azure-rhel9-sap-ha
    > ```

1. Clean the DNF cache so that the VM picks up the metadata for the release that you pin in the next step:

    ```bash
    sudo dnf clean all
    ```

1. Set the expected system release version to the source OS version:

    ```bash
    sudo rhui-set-release --set 9.6
    ```

    > [!IMPORTANT]  
    > Don't delete the */etc/dnf/vars/releasever* file on this path. RHEL 9.6 isn't the latest RHEL 9 minor release, so without the lock the `dnf update` command in a later step would move the VM to a newer minor release and away from the only source version that Leapp accepts for the upgrade to RHEL 10.0.

    > [!NOTE]  
    > If the `rhui-set-release` command isn't available on the VM, set the expected release version by updating the */etc/dnf/vars/releasever* file instead:
    >
    > ```bash
    > echo "9.6" | sudo tee /etc/dnf/vars/releasever
    > ```

1. Clear pins if you used the `dnf versionlock` plug-in to pin individual packages to a specific version:

    ```bash
    sudo dnf versionlock clear
    ```

    > [!NOTE]  
    > This step has nothing to do with the release lock from the previous step. The `dnf versionlock` plug-in pins individual packages, such as a specific kernel build, and keeps its list in */etc/dnf/plugins/versionlock.list*. Any pin left in place blocks the Leapp utility from replacing that package during the upgrade. The release lock stays at 9.6.

1. Stop the SAP HANA systems and terminate all SAP processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP HANA file systems, as they're necessary for detecting the presence and version of the installed SAP HANA systems.
    > - If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

1. Configure RHEL settings for SAP HANA:

   According to [SAP Note 3562909](https://me.sap.com/notes/3562909), the following parameter is necessary for SAP applications, including SAP HANA, and it's configured in the file */etc/sysctl.d/sap.conf*.

   ```output
   vm.max_map_count = 2147483647
   ```
   
   All other settings for SAP HANA, configured in the files */etc/sysctl.conf* and */etc/sysctl.d/sap_hana.conf*, are the same for both RHEL 9 and RHEL 10 and should remain unchanged. For more information, see [SAP Note 2382421](https://launchpad.support.sap.com/#/notes/2382421).

1. To ensure that your RHEL 9.6 system is up to date, update all packages:

    ```bash
    sudo dnf update
    ```

1. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM starts and runs, ensure the SAP HANA systems and all SAP processes are stopped on it. Also, ensure the SAP HANA file systems are mounted.

1. Temporarily disable antivirus software to prevent the upgrade from failing.

1. (Optional) Look for the *.rpmnew* and *.rpmsave* files that earlier updates left on the VM, merge back any setting you still need, and then delete the files.

1. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

1. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```

### [RHEL 9.6 to RHEL 10.0 - SAP-APPS PAYG VMs](#tab/rhel10sapapps)

This section outlines the necessary steps before performing an in-place upgrade from RHEL 9.6 to RHEL 10.0 by using the Leapp utility on SAP-APPS pay-as-you-go (PAYG) VMs.

> [!NOTE] 
> To update an SAP-APPS system from RHEL 9.6 to RHEL 10.0, you must first upgrade the system to RHEL 9.6 if it isn't. Also, if the VM was previously upgraded from RHEL 8 to RHEL 9, ensure that you complete all required post-upgrade tasks. For more information, see [Performing post-upgrade tasks on the RHEL 9 system](https://docs.redhat.com/documentation/red_hat_enterprise_linux/9/html-single/upgrading_from_rhel_8_to_rhel_9/index#performing-post-upgrade-tasks-on-the-rhel-9-system_upgrading-from-rhel-8-to-rhel-9).

1. Make sure your current Red Hat release is 9.6:

    ```bash
    sudo cat /etc/redhat-release 
    ```

1. Install required RHUI packages to ensure your system is ready for upgrade:

    ```bash
    sudo dnf install leapp-rhui-azure-sap
    ```

    > [!NOTE]  
    > If the package can't be found, enable the RHUI client configuration repository first:
    >
    > ```bash
    > sudo dnf config-manager --set-enabled rhui-microsoft-azure-rhel9-sapapps
    > ```

3. Clean the DNF cache so that the VM picks up the metadata for the release that you pin in the next step:

    ```bash
    sudo dnf clean all
    ```

4. Set the expected system release version to the source OS version:

    ```bash
    sudo rhui-set-release --set 9.6
    ```

    > [!IMPORTANT]  
    > Don't delete the */etc/dnf/vars/releasever* file on this path. RHEL 9.6 isn't the latest RHEL 9 minor release, so without the lock the `dnf update` command in a later step would move the VM to a newer minor release and away from the only source version that Leapp accepts for the upgrade to RHEL 10.0.

    > [!NOTE]  
    > If the `rhui-set-release` command isn't available on the VM, set the expected release version by updating the */etc/dnf/vars/releasever* file instead:
    >
    > ```bash
    > echo "9.6" | sudo tee /etc/dnf/vars/releasever
    > ```

5. Clear pins if you used the `dnf versionlock` plug-in to pin individual packages to a specific version:

    ```bash
    sudo dnf versionlock clear
    ```

    > [!NOTE]  
    > This step has nothing to do with the release lock from the previous step. The `dnf versionlock` plug-in pins individual packages, such as a specific kernel build, and keeps its list in */etc/dnf/plugins/versionlock.list*. Any pin left in place blocks the Leapp utility from replacing that package during the upgrade. The release lock stays at 9.6.

1. Stop the SAP systems and terminate all SAP processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP file systems, as they're necessary for detecting the presence and version of the installed SAP systems.
    > - If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

1. Configure RHEL settings for SAP:

   According to [SAP Note 3562909](https://me.sap.com/notes/3562909), the following parameter is necessary for SAP applications, and it's configured in the file */etc/sysctl.d/sap.conf*.

   ```output
   vm.max_map_count = 2147483647
   ```

   All other settings for SAP, configured in the file */etc/sysctl.conf*, are the same for both RHEL 9 and RHEL 10 and should remain unchanged. For more information, see [SAP Note 2382421](https://launchpad.support.sap.com/#/notes/2382421).

8. To ensure that your RHEL 9.6 system is up to date, update all packages:

    ```bash
    sudo dnf update
    ```

9. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM is started and running, make sure that the SAP-APPS system or SAP processes are stopped. Also make sure the SAP file systems are mounted.

10. Temporarily disable antivirus software to prevent the upgrade from failing.

11. (Optional) Look for the *.rpmnew* and *.rpmsave* files that earlier updates left on the VM, merge back any setting you still need, and then delete the files.

12. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

13. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```

---

## Leapp pre-upgrade process

The Leapp pre-upgrade report highlights possible issues, provides recommended solutions, and helps you determine whether it's feasible or advisable to proceed with the upgrade.

### [RHEL 9.6 to RHEL 10.0 - SAP-HANA PAYG VMs](#tab/rhel10saphana)

Run the `leapp preupgrade` command with the `e4s` channel:

```bash
sudo -r unconfined_r -t unconfined_t leapp preupgrade --target <target_os_version> --channel e4s --no-rhsm
```

> [!NOTE]  
> - Replace `<target_os_version>` with the target OS version (for example, `10.0`).
> - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.

### [RHEL 9.6 to RHEL 10.0 - SAP-APPS PAYG VMs](#tab/rhel10sapapps)

Run the `leapp preupgrade` command with the `eus` channel:

```bash
sudo -r unconfined_r -t unconfined_t leapp preupgrade --target <target_os_version> --channel eus --no-rhsm
```

> [!NOTE]  
> - Replace `<target_os_version>` with the target OS version (for example, `10.0`).
> - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.

--- 

Review the report located in the `/var/log/leapp/leapp-report.txt` file and resolve any identified issues manually. Some problems come with recommended fixes. You must resolve inhibitor issues before you can proceed with the upgrade. For detailed information about the various issues that might appear in the report, see [Troubleshooting Red Hat OS upgrade issues](troubleshoot-red-hat-os-upgrade-issues.md).

## Leapp upgrade process

Continue the Leapp upgrade process after the Leapp pre-upgrade report shows no errors or inhibitors and everything is marked as resolved. The output is typically green or yellow, indicating that it's safe to proceed with the Leapp upgrade.

> [!IMPORTANT]  
> - Run the `leapp upgrade` command through the Serial Console to avoid any network interruptions that could affect your secure shell (SSH) terminal and disrupt the upgrade process.
> - Use the same value for the `--channel` option in both the `leapp preupgrade` and `leapp upgrade` commands.
> - Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process.

### [RHEL 9.6 to RHEL 10.0 - SAP-HANA PAYG VMs](#tab/rhel10saphana)

1. Run the `leapp upgrade` command with the `e4s` channel.
    
    ```bash
    sudo -r unconfined_r -t unconfined_t leapp upgrade --target <target_os_version> --channel e4s --no-rhsm
    ```

   > [!NOTE]  
   > - Replace `<target_os_version>` with the target OS version (for example, `10.0`).
   > - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.

1. If you didn't include the `--reboot` option in the previous command, monitor the Serial Console. When the upgrade process confirms that a reboot is required to continue, as shown in the following output, manually reboot the VM:

    ```output
    Complete!
    ====> * add_upgrade_boot_entry
            Add new boot entry for Leapp provided initramfs.
    A reboot is required to continue. Please reboot your system.
    Debug output written to /var/log/leapp/leapp-upgrade.log
    ```
    
    ```bash
    sudo reboot
    ```

### [RHEL 9.6 to RHEL 10.0 - SAP-APPS PAYG VMs](#tab/rhel10sapapps)

1. Run the `leapp upgrade` command with the `eus` channel.
    
    ```bash
    sudo -r unconfined_r -t unconfined_t leapp upgrade --target <target_os_version> --channel eus --no-rhsm
    ```
   
   > [!NOTE]  
   > - Replace `<target_os_version>` with the target OS version (for example, `10.0`).
   > - Omit the `-r unconfined_r -t unconfined_t` options if SELinux is disabled on the VM.

2. If you didn't include the `--reboot` option in the previous command, monitor the Serial Console. When the upgrade process confirms that a reboot is required to continue, as shown in the following output, manually reboot the VM:

    ```output
    Complete!
    ====> * add_upgrade_boot_entry
            Add new boot entry for Leapp provided initramfs.
    A reboot is required to continue. Please reboot your system.
    Debug output written to /var/log/leapp/leapp-upgrade.log
    ```
    
    ```bash
    sudo reboot
    ```

---

When the upgrade finishes, check if the system is in the desired state.

## Verify the upgrade process

This section outlines the recommended verification steps after completing an in-place upgrade.

### [RHEL 10.0 - SAP-HANA PAYG VMs](#tab/rhel10saphana)

1. Verify that the current OS version belongs to RHEL 10:

    ```bash
    sudo cat /etc/redhat-release
    ```

1. Verify that the version lock now points to the target version. The Leapp utility rewrites this file during the upgrade, and the lock is what keeps the VM on the E4S content that SAP certifies:

    ```bash
    sudo cat /etc/dnf/vars/releasever 
    ```

    ```output
    10.0
    ```

    > [!IMPORTANT]  
    > If the file is missing or holds a different value, restore the lock before you run any update. Otherwise, the next `dnf update` moves the VM to a newer RHEL 10 minor release and off the certified E4S content:
    >
    > ```bash
    > sudo rhui-set-release --set 10.0
    > ```
    >
    > If the `rhui-set-release` command isn't available on the VM, write the value directly:
    >
    > ```bash
    > echo "10.0" | sudo tee /etc/dnf/vars/releasever
    > ```

1. Check the kernel version:

    ```bash
    uname -r
    ```

1. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```

    Here's an example output:
    
    ```output
    rhel-10-for-x86_64-appstream-e4s-rhui-rpms        Red Hat Enterprise Linux 10 for x86_64 - AppStream - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-10-for-x86_64-baseos-e4s-rhui-rpms           Red Hat Enterprise Linux 10 for x86_64 - BaseOS - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-10-for-x86_64-highavailability-e4s-rhui-rpms Red Hat Enterprise Linux 10 for x86_64 - High Availability - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-10-for-x86_64-sap-netweaver-e4s-rhui-rpms    Red Hat Enterprise Linux 10 for x86_64 - SAP NetWeaver - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-10-for-x86_64-sap-solutions-e4s-rhui-rpms    Red Hat Enterprise Linux 10 for x86_64 - SAP Solutions - Update Services for SAP Solutions from RHUI (RPMs)
    rhui-microsoft-azure-rhel10-sap-ha                Microsoft Azure RPMs for Red Hat Enterprise Linux 10 (rhel10-sap-ha)
    ```

1. Verify that network services are operational, for example, by connecting to the VM through SSH.

### [RHEL 10.0 - SAP-APPS PAYG VMs](#tab/rhel10sapapps)

1. Verify that the current OS version belongs to RHEL 10:

    ```bash
    sudo cat /etc/redhat-release
    ```

1. Verify that the version lock now points to the target version. The Leapp utility rewrites this file during the upgrade, and the lock is what keeps the VM on the EUS content for that minor release:

    ```bash
    sudo cat /etc/dnf/vars/releasever 
    ```

    ```output
    10.0
    ```

    > [!IMPORTANT]  
    > If the file is missing or holds a different value, restore the lock before you run any update. Otherwise, the next `dnf update` moves the VM to a newer RHEL 10 minor release and off the certified EUS content:
    >
    > ```bash
    > sudo rhui-set-release --set 10.0
    > ```
    >
    > If the `rhui-set-release` command isn't available on the VM, write the value directly:
    >
    > ```bash
    > echo "10.0" | sudo tee /etc/dnf/vars/releasever
    > ```

3. Check the kernel version:

    ```bash
    uname -r
    ```

4. Verify the new repositories:

    ```bash
    sudo dnf repolist
    ```

    Here's an example output:
    
    ```output
    repo id                                        repo name
    rhel-10-for-x86_64-appstream-eus-rhui-rpms     Red Hat Enterprise Linux 10 for x86_64 - AppStream - Extended Update Support from RHUI (RPMs)
    rhel-10-for-x86_64-baseos-eus-rhui-rpms        Red Hat Enterprise Linux 10 for x86_64 - BaseOS - Extended Update Support from RHUI (RPMs)
    rhel-10-for-x86_64-sap-netweaver-eus-rhui-rpms Red Hat Enterprise Linux 10 for x86_64 - SAP NetWeaver - Extended Update Support from RHUI (RPMs)
    rhui-microsoft-azure-rhel10-sapapps            Microsoft Azure RPMs for Red Hat Enterprise Linux 10 (rhel10-sapapps)
    ```

5. Verify that network services are operational, for example, by connecting to the VM through SSH.

---

## Post-upgrade tasks

After you verify the upgrade is successful, perform the [post-upgrade tasks](leapp-upgrade-process-rhel-7-and-8.md?tabs=rhel9-rhel10#post-upgrade-tasks). These tasks include removing the remaining RHEL 9 packages, restoring the rescue kernel, and returning SELinux to the mode that the VM used before the upgrade.

## Post-configuration for SAP-HANA PAYG VMs

After you verify that the upgrade is successful, configure the upgraded system for SAP HANA according to the applicable SAP notes for RHEL 10. For more information, see [Configuring the system for SAP HANA](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/10/html-single/upgrading_sap_environments_from_rhel_9_to_rhel_10/index#proc_configuring-system-sap-hana_asmb_upgrading-hana-system), [SAP Note 3562919](https://me.sap.com/notes/3562919), and [SAP Note 2382421](https://me.sap.com/notes/2382421).

Then, start your SAP HANA system and run the functional and performance verification steps for your most important business transactions to ensure that the system is fully operational again.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [AI-generated content attribution](../../../includes/ai-generated-attribution.md)]
