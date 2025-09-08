---
title: Leapp upgrade from RHEL 8.x to RHEL 9.x on SAP-HANA and SAP-APPS pay-as-you-go VMs
description: Provides steps to help you upgrade SAP-HANA and SAP-APPS pay-as-you-go virtual machines from RHEL 8.x to RHEL 9.x by using the Leapp utility.
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.date: 06/27/2025
ms.service: azure-virtual-machines
ms.topic: how-to
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to upgrade SAP-HANA and SAP-APPS PAYG virtual machines from RHEL 8.x to RHEL 9.x using Leapp

**Applies to:** :heavy_check_mark: Linux VMs

> [!CAUTION]
> Following the process in this article will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure features such as [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [automatic operating system (OS) image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, we recommend creating a new VM using your preferred OS instead of performing an in-place upgrade.

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. This article introduces how to use the Leapp utility to upgrade Linux virtual machines (VMs) that use SAP-HANA or SAP-APPS pay-as-you-go (PAYG) images from RHEL 8.*x* to RHEL 9.*x*.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for PAYG images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you have to attach the system to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing a Leapp upgrade on custom, golden or PAYG images provided by Red Hat, see [Upgrading SAP environments from RHEL 8 to 9](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html/upgrading_sap_environments_from_rhel_8_to_rhel_9/index).

## Prerequisites

- Make a backup of the Linux VM or a snapshot of the OS disk.
- Clear enough space in `/var/lib/leapp` to accommodate the upgrade. A best practice is to have at least 2-5 GB of free space.
- Set up access to the Serial Console.
- Run the commands in this article with root privileges.

## Prepare the VM for the Leapp pre-upgrade and upgrade process

You can perform an in-place upgrade from RHEL 8 to the following RHEL 9 minor versions.

|System configuration   | Source OS version| Target version    |
|----------------------|------------------|-------------------|
|SAP HANA              | RHEL 8.10         | RHEL 9.4          | 
|SAP HANA              | RHEL 8.10        | RHEL 9.6          | 
|SAP NetWeaver and other SAP Applications   | RHEL 8.10         | RHEL 9.4          |      
|SAP NetWeaver and other SAP Applications | RHEL 8.10        | RHEL 9.6          |

> [!NOTE]  
> For more information, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361).

According to the [Upgrading SAP environments from RHEL 8 to RHEL 9 - Supported upgrade paths](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html/upgrading_sap_environments_from_rhel_8_to_rhel_9/asmb_supported-upgrade-paths_how-to-in-place-upgrade-sap-environments-from-rhel8-to-rhel9#asmb_supported-upgrade-paths_how-to-in-place-upgrade-sap-environments-from-rhel8-to-rhel9) documentation, SAP validates SAP HANA for the RHEL minor versions that receive package updates for more than six months. Currently, the supported in-place upgrade paths for an SAP HANA system are from RHEL 8.10 to RHEL 9.4 and from RHEL 8.10 to RHEL 9.6. This documentation also describes restrictions and detailed steps for upgrading an SAP HANA system.

SAP validates SAP NetWeaver for each major RHEL version. The supported in-place upgrade paths for an SAP NetWeaver system are the two latest Extended Update Support (EUS)/Update Services for SAP Solutions (E4S) releases that the Leapp utility supports for non-HANA systems. For more information, see [Upgrading from RHEL 8 to RHEL 9 - Supported upgrade paths](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9). Certain deviations from the default upgrade procedure are described in [Upgrading an SAP NetWeaver system](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html/upgrading_sap_environments_from_rhel_8_to_rhel_9/asmb_upgrading_netweaver_asmb_upgrading-hana-system). For systems where both SAP HANA and SAP NetWeaver are installed, the SAP HANA restrictions apply.

### [RHEL 8.10 to RHEL 9.4 - SAP-HANA PAYG VMs](#tab/rhel94saphana)

This section outlines the necessary steps before you perform an in-place upgrade from RHEL 8.10 to RHEL 9.4 by using the Leapp utility on SAP-HANA PAYG VMs.

> [!NOTE]
> If your VM is part of a Hight Availability cluster, the upgrade is possible if the cluster nodes do *not* use any packages that are part of [Resilient Storage](https://access.redhat.com/articles/3130101). For more information, see [Procedure to upgrade a RHEL 8 High Availability cluster to RHEL 9](https://access.redhat.com/articles/7012677).

> [!NOTE] 
> To update an SAP-HANA system from RHEL 8.10 to RHEL 9.4, you must first upgrade the system to RHEL 8.10 if it isn't already upgaded. For more information, see [How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 8.x to 8.10](upgrade-rhel-8-dot-x-to-8-dot-10-on-sap-hana-apps.md).

1. Make sure that your current Red Hat release is 8.10:

    ```bash
    sudo cat /etc/redhat-release 
    ```
    
    ```bash
    sudo cat /etc/yum/vars/releasever
    ```

2. To  make sure your system is ready for upgrade, install required RHUI packages:

    ```bash
    sudo dnf install leapp-rhui-azure-sap
    ```

3. Stop the SAP HANA systems and terminate all SAP processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP HANA file systems, as they're necessary for detecting the presence and version of the installed SAP HANA system.
    > - If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

4. Configure RHEL settings for SAP HANA:

   According to [SAP Note 2772999](https://launchpad.support.sap.com/#/notes/2772999), the following parameters are necessary for SAP Applications, including SAP HANA. They're configured in the */etc/sysctl.d/sap.conf* file.

   ```output
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```
   
    All other settings configured in the files */etc/sysctl.conf* and */etc/sysctl.d/sap_hana.conf* are the same for both RHEL 8 and RHEL 9 and should remain unchanged. For more information, see the [SAP Notes 2382421](https://launchpad.support.sap.com/#/notes/2382421).


5. To make sure that your RHEL 8.10 system is up to date, update all packages:

    ```bash
    sudo dnf update
    ```

6. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM is started and running, make sure that the SAP HANA systems and all SAP processes are stopped on it. Also make sure the SAP HANA file systems are mounted.

7. Temporarily disable antivirus software to prevent the upgrade from failing.

8. Before you run the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

9. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```

### [RHEL 8.10 to RHEL 9.6 - SAP-HANA PAYG VMs](#tab/rhel96saphana)

This section outlines the necessary steps before performing an in-place upgrade from RHEL 8.10 to RHEL 9.6 using the Leapp utility on SAP-HANA PAYG VMs.

> [!NOTE]  
> If your VM is part of a Hight Availability cluster, the upgrade is possible if the cluster nodes do *not* use any packages that are part of [Resilient Storage](https://access.redhat.com/articles/3130101). For more information, see [Procedure to upgrade a RHEL 8 High Availability cluster to RHEL 9](https://access.redhat.com/articles/7012677).

> [!NOTE] 
> To update an SAP-HANA system from RHEL 8.10 to RHEL 9.6, you must first upgrade the system to RHEL 8.10 if it isn't. For more information, see [How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 8.x to 8.10](upgrade-rhel-8-dot-x-to-8-dot-10-on-sap-hana-apps.md).

1. Make sure your current Red Hat release is 8.10:

    ```bash
    sudo cat /etc/redhat-release 
    ```

2. To ensure your system is ready for upgrade, install required RHUI package:

    ```bash
    sudo dnf install leapp-rhui-azure-sap
    ```

3. Stop the SAP HANA systems and terminate all SAP processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP HANA file systems, as they're necessary for detecting the presence and version of the installed SAP HANA systems.
    > - If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

4. Configure RHEL settings for SAP HANA:

   According to [SAP Note 2772999](https://launchpad.support.sap.com/#/notes/27729990), the following parameters are necessary for SAP applications, including SAP HANA, and they're configured in the file */etc/sysctl.d/sap.conf*.

   ```output
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```
   
   All other settings for SAP HANA, configured in the files */etc/sysctl.conf* and */etc/sysctl.d/sap_hana.conf*, are the same for both RHEL 8 and RHEL 9 and should remain unchanged. For more information, see the [SAP Notes 2382421](https://launchpad.support.sap.com/#/notes/2382421).

5. To make sure that your RHEL 8.10 system is up to date, update all packages:

    ```bash
    sudo dnf update
    ```

6. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM is started and running, make sure the SAP HANA systems and all SAP processes are stopped on it. Also make sure the SAP HANA file systems are mounted.

7. Temporarily disable antivirus software to prevent the upgrade from failing.

8. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

9. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```

### [RHEL 8.10 to RHEL 9.4 - SAP-APPS PAYG VMs](#tab/rhel94sapapps)

This section outlines the necessary steps before performing an in-place upgrade from RHEL 8.10 to RHEL 9.4 using the Leapp utility on SAP-APPS PAYG VMs.

> [!NOTE] 
> To update an SAP-APPS system from RHEL 8.10 to RHEL 9.4, you must first upgrade the system to RHEL 8.10 if it isn't. For more information, see [How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 8.x to 8.10](upgrade-rhel-8-dot-x-to-8-dot-10-on-sap-hana-apps.md).

1. Make sure your current Red Hat release is 8.10:

    ```bash
    sudo cat /etc/redhat-release 
    ```

    ```bash
    sudo cat /etc/yum/vars/releasever
    ```

2. To ensure your system is ready for upgrade, install required RHUI packages:

    ```bash
    sudo dnf install leapp-rhui-azure-sap
    ```

3. Stop all SAP or application processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP file systems, as they're necessary for detecting the presence and version of the installed SAP systems.
    > - If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

4. Configure RHEL settings for SAPAPPS:

   According to [SAP Note 2772999](https://launchpad.support.sap.com/#/notes/2772999), the following parameters are necessary for SAP Applications, and they're configured in the file */etc/sysctl.d/sap.conf*.

   ```output
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```

   All other settings for SAP, configured in the file */etc/sysctl.conf*, are the same for both RHEL 8 and RHEL 9 and should remain unchanged. For more information, see the [SAP Notes 2382421](https://launchpad.support.sap.com/#/notes/2382421).


5. To make sure that your RHEL 8.10 system is up to date, update all packages:

    ```bash
    sudo dnf update
    ```

6. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM is started and running, make sure that the SAP-APPS systems or SAP processes are stopped. Also Make sure the SAP file systems are mounted.

7. Temporarily disable antivirus software to prevent the upgrade from failing.

8. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

9. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```

### [RHEL 8.10 to RHEL 9.6 - SAP-APPS PAYG VMs](#tab/rhel96sapapps)

This section outlines the necessary steps before performing an in-place upgrade from RHEL 8.10 to RHEL 9.6 using the Leapp utility on SAP-APPS PAYG VMs.

> [!NOTE] 
> To update an SAP-APPS system from RHEL 8.10 to RHEL 9.6, you must first upgrade the system to RHEL 8.10 if it isn't. For more information, see [How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 8.x to 8.10](upgrade-rhel-8-dot-x-to-8-dot-10-on-sap-hana-apps.md).

1. Make sure your current Red Hat release is 8.10:

    ```bash
    sudo cat /etc/redhat-release 
    ```

2. To ensure your system is ready for upgrade, install required RHUI packages:

    ```bash
    sudo dnf install leapp-rhui-azure-sap
    ```

3. Stop the SAP systems and terminate all SAP processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP file systems, as they're necessary for detecting the presence and version of the installed SAP systems.
    > - If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

4. Configure RHEL settings for SAP:

   According to [SAP Note 2772999](https://launchpad.support.sap.com/#/notes/2772999), the following parameters are necessary for SAP applications, and they're configured in the file */etc/sysctl.d/sap.conf*.

   ```output
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```

   All other settings for SAP, configured in the file */etc/sysctl.conf*, are the same for both RHEL 8 and RHEL 9 and should remain unchanged. For more information, see [SAP Notes 2382421](https://launchpad.support.sap.com/#/notes/2382421).


4. To make sure that your RHEL 8.10 system is up to date, update all packages:

    ```bash
    sudo dnf update
    ```

6. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM is started and running, make sure that the SAP-APPS system or SAP processes are stopped. Also make sure the SAP file systems are mounted.

7. Temporarily disable antivirus software to prevent the upgrade from failing.

8. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

9. Install the Leapp utility:

    ```bash
    sudo dnf install leapp-upgrade
    ```

---

## Leapp pre-upgrade process

The Leapp pre-upgrade report highlights possible issues, provides recommended solutions, and helps determine whether it's feasible or advisable to proceed with the upgrade.

### [RHEL 8.10 to RHEL 9.4 - SAP-HANA PAYG VMs](#tab/rhel94saphana)

Run the `leapp preupgrade` command with the `e4s` channel:

```bash
sudo leapp preupgrade --target <target_os_version> --channel e4s --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example, `9.4`. 


### [RHEL 8.10 to RHEL 9.6 - SAP-HANA PAYG VMs](#tab/rhel96saphana)

Run the `leapp preupgrade` command with the `e4s` channel:

```bash
sudo leapp preupgrade --target <target_os_version> --channel e4s --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example, `9.6`.


### [RHEL 8.10 to RHEL 9.4 - SAP-APPS PAYG VMs](#tab/rhel94sapapps)

Run the `leapp preupgrade` command with the `eus` channel:

```bash
sudo leapp preupgrade --target <target_os_version> --channel eus --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example, `9.4`.

### [RHEL 8.10 to RHEL 9.6 - SAP-APPS PAYG VMs](#tab/rhel96sapapps)

Run the `leapp preupgrade` command with the `eus` channel:

```bash
sudo leapp preupgrade --target <target_os_version> --channel eus --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example, `9.6`. 

--- 

Review the report located in the `/var/log/leapp/leapp-report.txt` file and resolve any identified issues manually. Some problems come with recommended fixes. Inhibitor issues must be resolved before you can proceed with the upgrade. For detailed information about the various issues that might appear in the report, see [Troubleshooting Red Hat OS upgrade issues](troubleshoot-red-hat-os-upgrade-issues.md).

## Leapp upgrade process

Continue the Leapp upgrade process after the Leapp pre-upgrade report shows no errors or inhibitors and everything is marked as resolved. The output is typically green or yellow, indicating that it's safe to proceed with the Leapp upgrade.

> [!IMPORTANT]  
> - Make sure to run the `leapp upgrade` command through the Serial Console to avoid any network interruptions that could affect your secure shell (SSH) terminal and disrupt the upgrade process.
> - If you want to perform an automatic reboot, which is needed during the upgrade process, add the `--reboot` option to the `leapp upgrade` command.

### [RHEL 8.10 to RHEL 9.4 - SAP-HANA PAYG VMs](#tab/rhel94saphana)

1. Run the `leapp upgrade` command with the `e4s` channel:
    
    ```bash
    sudo leapp upgrade --target <target_os_version> --channel e4s --no-rhsm
    ```
    
    Replace `<target_os_version>` with the target OS version, for example, `9.4`. 

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue the process, as shown in the following output, manually reboot the VM:

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

### [RHEL 8.10 to RHEL 9.6 - SAP-HANA PAYG VMs](#tab/rhel96saphana)

1. Run the `leapp upgrade` command with the `e4s` channel.
    
    ```bash
    sudo leapp upgrade --target <target_os_version> --channel e4s --no-rhsm
    ```

   Replace `<target_os_version>` with the target OS version, for example, `9.6`.

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue the process, as shown in the following output, manually reboot the VM:

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

### [RHEL 8.10 to RHEL 9.4 - SAP-APPS PAYG VMs](#tab/rhel94sapapps)

1. Run the `leapp upgrade` command with the `eus` channel.
    
    ```bash
    sudo leapp upgrade --target <target_os_version> --channel eus --no-rhsm
    ```

   Replace `<target_os_version>` with the target OS version, for example, `9.4`. 

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue the process, as shown in the following output, manually reboot the VM:

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


### [RHEL 8.10 to RHEL 9.6 - SAP-APPS PAYG VMs](#tab/rhel96sapapps)

1. Run the `leapp upgrade` command with the `eus` channel.
    
    ```bash
    sudo leapp upgrade --target <target_os_version> --channel eus --no-rhsm
    ```
   
   Replace `<target_os_version>` with the target OS version, for example, `9.6`. 

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue the process, as shown in the following output, manually reboot the VM:

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

Once the upgrade is finished, check if the system is in the desired state.

## Verify the upgrade process

This section outlines the recommended verification steps after completing an in-place upgrade.

### [RHEL 9.4 or RHEL 9.6 - SAP-HANA PAYG VMs](#tab/rhel9496saphana)

1. Verify that the current OS version belongs to RHEL 9:

    ```bash
    sudo cat /etc/redhat-release
    ```

2. Verify the version lock file:

    ```bash
    sudo cat /etc/yum/vars/releasever 
    ```

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
    rhel-9-for-x86_64-appstream-e4s-rhui-rpms        Red Hat Enterprise Linux 9 for x86_64 - AppStream - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-9-for-x86_64-baseos-e4s-rhui-rpms           Red Hat Enterprise Linux 9 for x86_64 - BaseOS - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-9-for-x86_64-highavailability-e4s-rhui-rpms Red Hat Enterprise Linux 9 for x86_64 - High Availability - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-9-for-x86_64-sap-netweaver-e4s-rhui-rpms    Red Hat Enterprise Linux 9 for x86_64 - SAP NetWeaver - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-9-for-x86_64-sap-solutions-e4s-rhui-rpms    Red Hat Enterprise Linux 9 for x86_64 - SAP Solutions - Update Services for SAP Solutions from RHUI (RPMs)
    ```

### [RHEL 9.4 or RHEL 9.6 - SAP-APPS PAYG VMs](#tab/rhel9496sapapps)


1. Verify that the current OS version belongs to RHEL 9:

    ```bash
    sudo cat /etc/redhat-release
    ```

2. Verify the version lock file:

    ```bash
    sudo cat /etc/yum/vars/releasever 
    ```

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
    repo id                                       repo name
    rhel-9-for-x86_64-appstream-eus-rhui-rpms     Red Hat Enterprise Linux 9 for x86_64 - AppStream - Extended Update Support from RHUI (RPMs)
    rhel-9-for-x86_64-baseos-eus-rhui-rpms        Red Hat Enterprise Linux 9 for x86_64 - BaseOS - Extended Update Support from RHUI (RPMs)
    rhel-9-for-x86_64-sap-netweaver-eus-rhui-rpms Red Hat Enterprise Linux 9 for x86_64 - SAP NetWeaver - Extended Update Support from RHUI (RPMs)
    rhui-microsoft-azure-rhel9-sapapps            Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9-sapapps)
    ```

---

## Post-upgrade tasks

Once you verify the upgrade is successful, perform the [post-upgrade tasks](leapp-upgrade-process-rhel-7-and-8.md?tabs=rhel8-rhel9#post-upgrade-tasks).

## Post-configuration for SAP-HANA PAYG VMs

After you verify that the upgrade is successful, you must configure the upgraded system for SAP HANA according to the applicable SAP notes for RHEL 9. For more information, see [Configuring the system for SAP HANA](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html-single/upgrading_sap_environments_from_rhel_8_to_rhel_9/index#proc_configuring-system-sap-hana_asmb_upgrading-hana-system).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
