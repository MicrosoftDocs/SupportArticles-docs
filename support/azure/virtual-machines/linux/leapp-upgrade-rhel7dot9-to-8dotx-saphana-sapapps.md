---
title: Leapp upgrade from RHEL 7.9 to RHEL 8.x on SAP-HANA and SAP-APPS pay-as-you-go VMs
description: Describes how to perform a upgrade from RHEL 7.9 to RHEL 8.x on SAP-HANA and SAP-APPS pay-as-you-go virtual machines by using the Leapp tool.
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.date: 09/14/2024
ms.service: azure-virtual-machines
ms.topic: how-to
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to upgrade SAP-HANA and SAP-APPS PAYG virtual machines from RHEL 7.9 to RHEL 8.x using Leapp

**Applies to:** :heavy_check_mark: Linux VMs

> [!CAUTION]
> Following the process in this article will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure features such as [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [automatic operating system (OS) image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, we recommend creating a new VM using your preferred OS instead of performing an in-place upgrade.

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. This article introduces how to use the Leapp utility to upgrade Linux virtual machines (VMs) that use SAP-HANA or SAP-APPS pay-as-you-go (PAYG) images from RHEL 7.9 to RHEL 8.*x*.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for PAYG images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you have to attach the system to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing a Leapp upgrade on custom, golden or PAYG images provided by Red Hat, see [Upgrading SAP environments from RHEL 7 to 8](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html/upgrading_sap_environments_from_rhel_7_to_rhel_8/index).

## Prerequisites

- Make a backup of the Linux VM or a snapshot of the OS disk.
- Clear enough space in `/var/lib/leapp` to accommodate the upgrade. A best practice is to have at least 2-5 GB of free space.
- Stop SAP processes during the OS update process.
- Set up access to the Serial Console.
- Run the commands in this article with root privileges.
- Before upgrading production systems to 8.10, verify that 8.10 is compatible with the required SAP software. For more information, see [SAP Software on Linux: General information - SAP note 2369910](https://launchpad.support.sap.com/#/notes/2369910).

## Prepare the VM for the Leapp pre-upgrade and upgrade process

You can perform an in-place upgrade from RHEL 7.9 to the following RHEL 8.8 or 8.10 minor versions.

System configuration   | Source OS version| Target version     |
|----------------------|------------------|--------------------|
|SAP HANA              | RHEL 7.9         | RHEL 8.8 (default)  | 
|SAP HANA              |   RHEL 7.9       | RHEL 8.10          | 
|SAP NetWeaver and other SAP Applications | RHEL 7.9         | RHEL 8.8           |      
|SAP NetWeaver and other SAP Applications |  RHEL 7.9         | RHEL 8.10 (default) |

> [!NOTE]  
> For more information, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361)

> [!NOTE]  
> To update an SAP-HANA PAYG VM running on RHEL 7.7 or an earlier version, you must first upgrade it to RHEL 7.9. For detailed instructions, see [How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 7.x to 7.9](upgrade-rhel-7dotx-to-7dot9-sap-hana-apps.md).

According to the [Upgrading SAP HANA System](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html/upgrading_sap_environments_from_rhel_7_to_rhel_8/asmb_upgrading-hana-system_asmb_planning-upgrade) documentation, SAP validates SAP HANA for RHEL minor versions that receive package updates for longer than six months. Therefore, for SAP HANA hosts, the upgrade paths include only Extended Update Support (EUS)/Update Services for SAP Solutions (E4S) releases and the last minor release for a given major release.

According to the [Upgrading from RHEL 7 to RHEL 8](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index#con_supported-upgrade-paths-rhel-7-to-rhel-8_upgrading-from-rhel-7-to-rhel-8) documentation, SAP validates SAP NetWeaver for each major RHEL version. The supported in-place upgrade path for SAP NetWeaver is from RHEL 7.9 to the RHEL 8.*x* minor version, which the Leapp tool supports for non-HANA systems. For more information about supported upgrade paths, see [Supported in-place upgrade paths for Red Hat Enterprise Linux](https://access.redhat.com/articles/4263361). *Exceptionally for cloud providers*, the two latest EUS/E4S releases support the upgrade of SAP NetWeaver systems. Certain deviations from the default upgrade procedure are described in [Upgrading SAP NetWeaver System](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html/upgrading_sap_environments_from_rhel_7_to_rhel_8/asmb_upgrading_netweaver_asmb_upgrading-hana-system#proc_upgrading_cloud_asmb_upgrading_netweaver). For systems where both SAP HANA and SAP NetWeaver are installed, the SAP HANA restrictions apply.


### [RHEL 7.9 to RHEL 8.*x* - SAP-HANA PAYG VMs](#tab/rhel8saphana)

This section outlines the necessary steps before performing an in-place upgrade from 7.9 to 8.8 or 8.10 using the Leapp utility on SAP-HANA PAYG VMs.

> [!IMPORTANT]  
> Upgrading cluster nodes in place or through rolling upgrades isn't supported for major RHEL releases. For more information, see [Leapp upgrade from RHEL 7 to RHEL 8 fails for pacemaker cluster](https://access.redhat.com/solutions/7049940). In this case, if you run SAP HANA in a High-availability (HA) cluster, to perform an in-place upgrade, you must destroy the existing cluster and re-create it after the upgrade is complete.

1. To ensure your system is ready for upgrade, enable required Red Hat Update Infrastructure repositories and install required Red Hat Update Infrastructure packages:

    ```bash
    sudo yum-config-manager --enable rhui-rhel-7-server-rhui-extras-rpms
    sudo yum install leapp-rhui-azure-sap
    ```
2. Stop the SAP HANA systems and terminate all SAP processes.

    > [!IMPORTANT]  
    > - Don't unmount the SAP HANA file systems, as they're necessary for detecting the presence and version of the installed SAP HANA system.
    > - If your VM is configured to start SAP processes automatically at boot time, disable the automatic start of SAP processes.
    
3. Configure RHEL settings for SAP HANA:

   1. The SAP HANA installer in `SAP HANA version 2.0 SPS 05` configures kernel settings in the */etc/sysctl.conf* file. Keep these settings unchanged.

   2. According to the SAP notes [2382421](https://launchpad.support.sap.com/#/notes/2382421) and [2292690](https://launchpad.support.sap.com/#/notes/2292690), other settings recommended for SAP HANA are configured in the files */etc/sysctl.d/sap.conf* and */etc/sysctl.d/sap_hana.conf*. The settings in */etc/sysctl.d/sap_hana.conf* are applicable to both RHEL 7 and RHEL 8. However, the `kernel.sem` value in */etc/sysctl.d/sap.conf* for RHEL 7 is lower than the default value for RHEL 8. Therefore, remove the line that sets `kernel.sem` to `1250 256000 100 1024` from */etc/sysctl.d/sap.conf*. The `vm.max_map_count` setting is valid for both RHEL 7 and RHEL 8, so keep this setting unchanged.

4. To make sure your RHEL 7.9 system is up-to-date, update all packages:

    ```bash
    sudo yum update
    ```

5. Reboot the VM:

    ```bash
    sudo reboot
    ```

    After the VM is started and running, make sure that the SAP HANA systems and SAP processes are stopped on your VM. Also make sure the SAP HANA file systems are mounted.

6. Temporarily disable antivirus software to prevent the upgrade from failing.

7. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

8. Install the Leapp utility:

    ```bash
    sudo yum install leapp-upgrade
    ```

### [RHEL 7.9 to RHEL 8.*x* - SAP-APPS PAYG VMs](#tab/rhel8sapapps)

This section outlines the necessary steps before performing an in-place upgrade to RHEL 7 or RHEL 8 using the Leapp utility on SAP-APPS PAYG VMs.

1. To ensure your system is ready for upgrade, enable required Red Hat Update Infrastructure repositories and install required Red Hat Update Infrastructure packages:

    ```bash
    sudo yum-config-manager --enable rhui-rhel-7-server-rhui-extras-rpms
    sudo yum install leapp-rhui-azure-sap
    ```

2. Stop all SAP processes.

    > [!NOTE]
    > If your VM is configured to start SAP processes automatically at boot time, disable this configuration.

3. To make sure your RHEL 7.9 system is up-to-date, update all packages:

    ```bash
    sudo yum update
    ```

4. Reboot the VM:

    ```bash
    sudo reboot
    ```

   After the VM is started and running, make sure that the SAP processes are stopped on the VM.

5. Temporarily disable antivirus software to prevent the upgrade from failing.

6. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture (such as Puppet, Salt, or Chef) or an agentless architecture (such as Ansible).

7. Install the Leapp utility:

    ```bash
    sudo yum install leapp-upgrade
    ```
---

## Leapp pre-upgrade process

The pre-upgrade report highlights possible issues and provides recommended solutions, and helps determine whether it's feasible or advisable to proceed with the upgrade.

### [RHEL 7.9 to RHEL 8.*x* - SAP-HANA PAYG VMs](#tab/preupgraderhel8saphana)

Run the `leapp preupgrade` command, replacing `<target_os_version>` with the target OS version and `e4s` with the appropriate channel:

```bash
sudo leapp preupgrade --target <target_os_version> --channel e4s --no-rhsm
```

For example, pre-upgrading to 8.8 requires E4S repo, so the `leapp preupgrade` command should be like:

```bash
sudo leapp preupgrade  --target 8.8 --channel e4s --no-rhsm
```

Pre-upgrading to 8.10 requires specifying the target OS without any channel, as 8.10 is the final minor release of RHEL 8. It's not an E4S/EUS release, and its support cycle differs. For more information, see [Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata). So the `leapp preupgrade` command should be like:

```bash
sudo leapp preupgrade  --target 8.10  --no-rhsm
```

> [!IMPORTANT]  
> RHEL 8.10 isn't certified for running SAP HANA currently. This certification is in process. For more information, see [Overview Product Availability Matrix for SAP on Red Hat](https://access.redhat.com/articles/6966927#support-matrix-for-sap-hana-on-intel-64-rhel-5).

### [RHEL 7.9 to 8.*x* - SAP-APPS PAYG VMs](#tab/preupgraderhel8sapapps)

Run the `leapp preupgrade` command, replacing `<target_os_version>` with the target OS version and `eus` with the appropriate channel:

```bash
sudo leapp preupgrade --target <target_os_version> --channel eus --no-rhsm
```

For example, pre-upgrading to 8.8 requires EUS repo, so the `leapp preupgrade` command should be like:

```bash
sudo leapp preupgrade  --target 8.8 --channel eus --no-rhsm
```

Pre-upgrading to 8.10 requires specifying the target OS without any channel, as 8.10 is the final minor release of RHEL 8. It's not an E4S/EUS release, and its support cycle differs. For more information, see [ Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata). So the `leapp preupgrade` command should be like:

```bash
sudo leapp preupgrade  --target 8.10  --no-rhsm
```

> [!IMPORTANT]  
> RHEL 8.10 isn't certified for running SAP HANA currently. This certification is in process. For more information, see [Overview Product Availability Matrix for SAP on Red Hat](https://access.redhat.com/articles/6966927#support-matrix-for-sap-hana-on-intel-64-rhel-5).

--- 

Review the report located in the `/var/log/leapp/leapp-report.txt` file and manually address all identified issues. Some problems come with recommended fixes. Inhibitor issues must be resolved before you can proceed with the upgrade. For detailed information about the various issues that might appear in the report, see [Troubleshooting Red Hat OS upgrade issues](troubleshoot-red-hat-os-upgrade-issues.md).


## Leapp upgrade process

Continue the Leapp upgrade process after the Leapp pre-upgrade report shows no errors or inhibitors and everything is marked as resolved. The output is typically green or yellow, indicating that it's safe to proceed with the Leapp upgrade.

> [!IMPORTANT]  
> - Make sure to run the `leapp upgrade` command through the Serial Console to avoid any network interruptions that could affect your secure shell (SSH) terminal and disrupt the upgrade process.
> - Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process.

### [RHEL 7.9 to 8.*x* - SAP-HANA PAYG VMs](#tab/upgraderhel8saphana)

1. Run the `leapp upgrade` command, replacing `<target_os_version>` with the target OS version and `e4s` with the appropriate channel.

    ```bash
    sudo leapp upgrade --target <target_os_version> --channel e4s --no-rhsm
    ```
    
    For example, upgrading to 8.8 requires E4S repo, so the `leapp upgrade` command should be like:
    
    ```bash
    sudo leapp upgrade  --target 8.8 --channel e4s --no-rhsm
    ```
    
    Upgrading to 8.10 requires specifying the target OS without any channel, as 8.10 is the final minor release of RHEL 8. It isn't an E4S/EUS release, and its support cycle differs. For more information, see [Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata).
    
    ```bash
    sudo leapp upgrade  --target 8.10  --no-rhsm
    ```
    
    > [!IMPORTANT]  
    > RHEL 8.10 isn't certified for running SAP HANA currently. This certification is in process. For more information, see [Overview Product Availability Matrix for SAP on Red Hat](https://access.redhat.com/articles/6966927#support-matrix-for-sap-hana-on-intel-64-rhel-5).
    
2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue with the process, as shown in the following output, manually reboot the VM. 

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

### [RHEL 7.9 to RHEL 8.*x* - SAP-APPS PAYG VMs](#tab/upgraderhel8sapapps)

1. Run the `leapp upgrade` command, replacing `<target_os_version>` with the target OS version and `eus` with the appropriate channel:


    ```bash
    sudo leapp upgrade --target <target_os_version> --channel eus --no-rhsm
    ```

    For example, upgrading to 8.8 requires EUS repo, so the `leapp upgrade` command should be like:
    
    ```bash
    sudo leapp upgrade  --target 8.8 --channel eus --no-rhsm
    ```

    Upgrading to 8.10 requires specifying the target OS without any channel, as 8.10 is the final minor release of RHEL 8. It isn't an E4S/EUS release, and its support cycle differs. For more information, see [ Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata).
    
    ```bash
    sudo leapp upgrade  --target 8.10  --no-rhsm
    ```

    > [!IMPORTANT]  
    > RHEL 8.10 isn't certified for running SAP HANA currently. This certification is in process. For more information, see [Overview Product Availability Matrix for SAP on Red Hat](https://access.redhat.com/articles/6966927#support-matrix-for-sap-hana-on-intel-64-rhel-5).

2. If the `--reboot` option wasn't included in the previous command, monitor the Serial Console. Once the upgrade process confirms that a reboot is required to continue with the process, as shown in the following output, manually reboot the VM. 

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


## Verify the Leapp upgrade process

This section outlines the recommended verification steps after completing an in-place upgrade.

### [RHEL 7.9 to RHEL 8.*x* - SAP-HANA PAYG VMs](#tab/verifyrhel8saphana)

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

    The output from the RHEL 8.8 (E4S) upgrade should contain the following lines:
    
    ```output
    ansible-2-for-rhel-8-x86_64-rhui-rpms            Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
    rhel-8-for-x86_64-appstream-e4s-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - AppStream - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-8-for-x86_64-baseos-e4s-rhui-rpms           Red Hat Enterprise Linux 8 for x86_64 - BaseOS - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-8-for-x86_64-highavailability-e4s-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - High Availability - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-8-for-x86_64-sap-netweaver-e4s-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver - Update Services for SAP Solutions from RHUI (RPMs)
    rhel-8-for-x86_64-sap-solutions-e4s-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP Solutions - Update Services for SAP Solutions from RHUI (RPMs)
    rhui-microsoft-azure-rhel8-sap-ha                Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-sap-ha)
    ```

    The output from the RHEL 8.10 upgrade should contain the following lines:
    
    ```output
    ansible-2-for-rhel-8-x86_64-rhui-rpms        Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
    packages-microsoft-com-prod                  packages-microsoft-com-prod
    rhel-8-for-x86_64-appstream-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - AppStream from RHUI (RPMs)
    rhel-8-for-x86_64-baseos-rhui-rpms           Red Hat Enterprise Linux 8 for x86_64 - BaseOS from RHUI (RPMs)
    rhel-8-for-x86_64-highavailability-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - High Availability (RPMs) from RHUI
    rhel-8-for-x86_64-sap-netweaver-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver (RPMs) from RHUI
    rhel-8-for-x86_64-sap-solutions-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP Solutions (RPMs) from RHUI
    rhui-microsoft-azure-rhel8-base-sap-ha       Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-ha)
    ```

### [RHEL 7.9 to RHEL 8.*x* - SAP-APPS PAYG VMs](#tab/verifyrhel8sapapps)

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

    The output from the RHEL 8.8 (EUS) upgrade should contain the following lines:
    
    ```output
    ansible-2-for-rhel-8-x86_64-rhui-rpms         Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
    rhel-8-for-x86_64-appstream-eus-rhui-rpms     Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support from RHUI (RPMs)
    rhel-8-for-x86_64-baseos-eus-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - BaseOS - Extended Update Support from RHUI (RPMs)
    rhel-8-for-x86_64-sap-netweaver-eus-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver - Extended Update Support from RHUI (RPMs)
    rhui-microsoft-azure-rhel8-sapapps            Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-sapapps)
    ```

    The output from the RHEL 8.10 upgrade should contain the following lines:
    
    ```output
    ansible-2-for-rhel-8-x86_64-rhui-rpms     Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
    rhel-8-for-x86_64-appstream-rhui-rpms     Red Hat Enterprise Linux 8 for x86_64 - AppStream from RHUI (RPMs)
    rhel-8-for-x86_64-baseos-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - BaseOS from RHUI (RPMs)
    rhel-8-for-x86_64-sap-netweaver-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver (RPMs) from RHUI
    rhui-microsoft-azure-rhel8-base-sap-apps  Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-apps)
    ```

---


## Post-upgrade tasks

Once the upgrade is complete, perform [post-upgrade tasks](leapp-upgrade-process-rhel-7-and-8.md?tabs=rhel7-rhel8#post-upgrade-tasks).

## Post-configuration for SAP-HANA PAYG VMs

After you verify that the upgrade is successful, you must configure the system for SAP HANA according to the applicable SAP notes for RHEL 8. For more information, see [Configuring the system for SAP HANA](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html-single/upgrading_sap_environments_from_rhel_7_to_rhel_8/index#proc_configuring-system-sap-hana_asmb_upgrading-hana-system).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
