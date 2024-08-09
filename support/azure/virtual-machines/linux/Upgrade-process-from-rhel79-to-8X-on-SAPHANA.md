---
title:  How to Perform a `Leapp` upgrade from RHEL 7.9 to 8.X on SAPAPPS and SAP-HANA Pay-As-You-Go (PAYG) images.
description: Guide with step by step procedure to do a leapp upgrade..
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 07/30/2024
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to Perform a `Leapp` upgrade from RHEL 7.9 to 8.X on SAPAPPS and SAP-HANA Pay-As-You-Go (PAYG) images.

**Applies to:** :heavy_check_mark: Linux VMs

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. In this article, we guide you through upgrading SAP environments from RHEL 7.9 to RHEL 8 using a `PAYGO` (Pay-As-You-Go) image for Red Hat in Azure.

> [!IMPORTANT]
> RHUI is intended for only pay-as-you-go images. Are you using custom or golden images (also known as "bring-your-own-subscription (BYOS)") instead? In that case, the system has to be attached to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information on performing a `Leapp upgrade` process on custom or golden images, and pay-as-you-go (PAYGO) images provided by Red Hat, see:

[Upgrading SAP environments from RHEL 7 to 8](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html/upgrading_sap_environments_from_rhel_7_to_rhel_8/index)


## Prerequisites

- Make a backup of the virtual machine or a snapshot of the OS disk.
- Clear enough space in /var/lib/leapp. Having at least 2-5 GB of free space is a safe practice
- Set up access to the serial console
- Root privileges.

## Preparing the virtual machine for the `Leapp` `pre-upgrade` and upgrade process

You can conduct an in-place upgrade from **RHEL 7.9** to the following **RHEL 8.8 or 8.10** minor versions.

System Configuration   | Source OS version| Target Version     |
|----------------------|------------------|--------------------|
|SAP HANA              | RHEL 7.9         | RHEL 8.8(default)  | 
|                      |                  | RHEL 8.10          | 
|SAP NetWeaver and     | RHEL 7.9         | RHEL 8.8           |      
|Other SAP Applications|                  | RHEL 8.10(default) |

> [!NOTE]  
> To update an `SAP HANA` system running on `RHEL 7.7` or earlier, you must first upgrade to `RHEL 7.9` for detailed instructions on upgrading from RHEL 7.7 or earlier to RHEL 7.9 on Azure for `PAYGO` images, please refer to the guide [How to update RHEL from 7.7* to 7.9 on Azure with "RHEL for SAP with High Availability or SAP APPS on pay-as-you-go (PAYGO) images](/azure/virtual-machines/linux/rhel7x-to-79-sap-ha-apps?branch=pr-en-us-6941&tabs=rhel7x-rhel79ha)" 

- According to the Red Hat documentation, `SAP` validates `SAP HANA` for RHEL minor versions, which receive package updates for longer than six months. Therefore, for `SAP HANA` hosts, the upgrade paths include only `EUS/E4S` releases plus the last minor release for a given major release.[Upgrading SAP HANA System](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html/upgrading_sap_environments_from_rhel_7_to_rhel_8/asmb_upgrading-hana-system_asmb_planning-upgrade)

- `SAP NetWeaver` is validated by `SAP` for each major RHEL version. The supported in-place upgrade path for this scenario is from `RHEL 7.9` to the `RHEL 8.x` minor version, which is supported by `Leapp` for `non-HANA` systems as per the [Upgrading from RHEL 7 to RHEL 8](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index#con_supported-upgrade-paths-rhel-7-to-rhel-8_upgrading-from-rhel-7-to-rhel-8) document. **Exceptionally for Cloud Providers**, the upgrade of `SAP NetWaver` systems is supported by two latest `EUS/E4S` releases. [Upgrading SAP NetWeaver System](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html/upgrading_sap_environments_from_rhel_7_to_rhel_8/asmb_upgrading_netweaver_asmb_upgrading-hana-system#proc_upgrading_cloud_asmb_upgrading_netweaver) describes certain deviations from the default upgrade procedure. For systems on which both `SAP HANA` and `SAP NetWeaver` are installed, the `SAP HANA` restrictions apply. For more information about supported upgrade paths, see [Supported in-place upgrade paths for Red Hat Enterprise Linux.](https://access.redhat.com/articles/4263361)


#### [RHEL 7.9 to 8.X SAP-HA](#tab/rhel8saphana)

This procedure outlines the necessary steps to complete before performing an in-place upgrade from 7.9 to 8.8 or 8.10 using the `Leapp` utility on `SAP-HANA` `PAYGO` images on Azure.

Based on Red Hat documentation, upgrading cluster nodes in place or through rolling upgrades **is not supported** for major `RHEL` releases. For more information, see, [`Leapp` upgrade from RHEL 7 to RHEL 8 fails for pacemaker cluster](https://access.redhat.com/solutions/7049940).

In this case, if you're running `SAP HANA` in an `HA` cluster, to perform an `in-place` upgrade, you must destroy the existing cluster and recreate it after the upgrade is complete.

1. Enable required `RHUI` repositories and install required `RHUI` packages to ensure your system is ready for upgrade.

```bash
sudo yum-config-manager --enable rhui-rhel-7-server-rhui-extras-rpms
sudo yum install leapp-rhui-azure-sap
```
2. Stop the `SAP HANA`systems and terminate all SAP processes

> [!IMPORTANT]  
> Avoid unmounting the `SAP HANA` file systems, as they are necessary for detecting the presence and version of the installed `SAP HANA` system

If your virtual machine is configured to start `SAP` processes automatically at boot time, disable the automatic start of `SAP` processes.

3. Configure RHEL settings for `SAP HANA`:

a. The `SAP HANA` installer in `SAP HANA 2.0 SPS05` configures kernel settings in the `/etc/sysctl.conf` file. Keep these settings unchanged

b. Another settings recommended for `SAP HANA`, according to SAP notes [2382421](https://launchpad.support.sap.com/#/notes/2382421) and [2292690](https://me.sap.com/notes/2292690), are configured using the files `sap.conf` and s`ap_hana.conf` in the `/etc/sysctl.d` directory. The settings in `sap_hana.con` are applicable to both `RHEL 7` and `RHEL 8`. However, the kernel.sem value in `sap.conf` for `RHEL 7` is lower than the default value for `RHEL 8`. Therefore, remove the line that sets `kernel.sem` to 1250 256000 100 1024 from `/etc/sysctl.d/sap.conf`. The `vm.max_map_count` setting is valid for both `RHEL 7` and `RHEL 8`, so keep this setting unchanged

4. Upgrade your `RHEL` 7.9 system to the latest available `RHEL` 7 package versions.

```bash
sudo yum update
```

5. Reboot the virtual machine

```bash
sudo reboot
```

a. After the virtual machine is up and running, make sure that no `SAP HANA` systems and no `SAP` processes are running on your virtual machine.

b. Make sure the `SAP HANA` file systems are mounted.

c. Temporarily disable antivirus software to prevent the upgrade from failing.

d. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture)


6. Install the `leapp` utility.

```bash
yum install leapp-upgrade
```

#### [RHEL 7.9 to 8.X - SAPAPPS](#tab/rhel8sapapps)

This procedure outlines the necessary steps to complete before performing an in-place upgrade to `RHEL 7` or `RHEL 8` using the `Leapp` utility on `SAPAPPS PAYGO` images on Azure.


1.  Enable required `RHUI` repositories and install required `RHUI` packages to ensure your system is ready for upgrade.

```bash
sudo yum-config-manager --enable rhui-rhel-7-server-rhui-extras-rpms
sudo yum install leapp-rhui-azure-sap
```

2. Stop all SAP processes

If your virtual machine is configured to start an `SAP` processes automatically at boot time, disable the automatic start of any sap processes.

3. Upgrade your `RHEL 7.9` system to the latest available `RHEL 7` package versions.

```bash
sudo yum update
```

4. Reboot the virtual machine

```bash
sudo reboot
```
a. After the virtual machine is up and running, make sure that no `SAP` processes are running on your virtual machine.

c. Temporarily disable antivirus software to prevent the upgrade from failing.

d. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture)

5. Install the `leapp` utility.

```bash
yum install leapp-upgrade
```

---

## `Leapp pre-upgrade` and upgrade process for `RHEL` 7 and 8

#### `Leapp pre-upgrade` process

The `pre-upgrade`report highlights possible issues and provides recommended solutions. It also helps in determining whether it's feasible or advisable to proceed with the upgrade.

#### [RHEL 7.9 to 8.X SAP-HA](#tab/rhel8saphana)

1. Run the `leapp preupgrade` command, replacing <target_os_version> with the target OS version and `--channel` with the appropriate channel

```bash
sudo leapp preupgrade --target <target_os_version> --channel <e4s> --no-rhsm
```

**Example 1**: `Pre-upgrading` to 8.8 requires E4S repo.

```bash
sudo leapp preupgrade  --target 8.8 --channel e4s --no-rhsm
```

**Example 2**: `Pre-upgrading` to 8.10 requires specifying the target without any channel, as it's the final minor release of RHEL 8. It's not an `E4S/EUS` release, and its support cycle differs. For more information, see, [ Red Hat Enterprise Linux Life Cycle.](https://access.redhat.com/support/policy/updates/errata)

```bash
sudo leapp preupgrade  --target 8.10  --no-rhsm
```

#### [RHEL 7.9 to 8.X - SAPAPPS](#tab/rhel8sapapps)


1. Run the `leapp preupgrade` command, replacing <target_os_version> with the target OS version and `--channel` with the appropriate channel

```bash
sudo leapp preupgrade --target <target_os_version> --channel <eus> --no-rhsm
```

**Example 1**: `Pre-upgrading` to 8.8 requires `EUS` repo.

```bash
sudo leapp preupgrade  --target 8.8 --channel eus --no-rhsm
```

**Example 2**: `Pre-upgrading` to 8.10 requires specifying the target without any channel, as it's the final minor release of `RHEL` 8. It isn't an `E4S/EUS` release, and its support cycle differs. For more information, see, [ Red Hat Enterprise Linux Life Cycle.](https://access.redhat.com/support/policy/updates/errata)

```bash
sudo leapp preupgrade  --target 8.10  --no-rhsm
```

--- 


Review the report located in the `/var/log/leapp/leapp-report.txt` file and manually address all identified issues. Some problems come with suggested fixes. Inhibitor issues must be resolved before you can proceed with the upgrade. For detailed information on the various issues that might appear in the report, for more information, see, [Troubleshoot-red-hat-os-upgrade-issues.](azure/virtual-machines/linux/troubleshoot-red-hat-os-upgrade-issues)


#### `Leapp` upgrade process

Continue to the `leapp upgrade` process after the `pre-upgrade` report shows no errors or inhibitors and everything is marked as resolved. The output is typically in green or yellow, indicating that it's safe to proceed with the `leapp` upgrade.

> [!IMPORTANT]  
> Make sure to run the `leapp upgrade` command through the serial console to avoid any network interruptions that could affect your SSH terminal and disrupt the upgrade process.

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process.


#### [RHEL 7.9 to 8.X SAP-HA](#tab/rhel8saphana)


1. Run the `leapp upgrade` command, replacing <target_os_version> with the target OS version and --channel with the appropriate channel

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --channel <e4s/eus> --no-rhsm
```

**Example 1**: Upgrading to 8.8 requires E4S repo.

```bash
sudo leapp upgrade  --target 8.8 --channel e4s --no-rhsm
```

**Example 2**: Upgrading to 8.10 requires specifying the target without any channel, as it's the final minor release of `RHEL` 8. It isn't an `E4S/EUS` release, and its support cycle differs. For more information, see, [ Red Hat Enterprise Linux Life Cycle.](https://access.redhat.com/support/policy/updates/errata)

```bash
sudo leapp upgrade  --target 8.10  --no-rhsm
```

2. If the `--reboot` option wasn't included in the previous command, monitor the serial console and manually reboot the virtual machine once the upgrade process confirms that a reboot is required to continue with the process. 

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

#### [RHEL 7.9 to 8.X - SAPAPPS](#tab/rhel8sapapps)


1. Run the `leapp upgrade` command, replacing <target_os_version> with the target OS version and --channel <e4s/eus > with the appropriate channel

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --channel <eus> --no-rhsm
```

**Example 1**: Upgrading to 8.8 will require `EUS` repo.

```bash
sudo leapp upgrade  --target 8.8 --channel eus --no-rhsm
```

**Example 2**: Upgrading to 8.10 requires specifying the target without any channel, as it's the final minor release of RHEL 8. It isn't an `E4S/EUS` release, and its support cycle differs. For more information, see, [ Red Hat Enterprise Linux Life Cycle.](https://access.redhat.com/support/policy/updates/errata)

```bash
sudo leapp upgrade  --target 8.10  --no-rhsm
```

2. If the `--reboot` option wasn't included in the previous command, monitor the serial console and manually reboot the virtual machine once the upgrade process confirms that a reboot is required to continue with the process. 

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


## Verification upgrade process

This procedure outlines the recommended verification steps to take after completing an in-place upgrade

#### [RHEL 7.9 to 8.X SAP-HA](#tab/rhel8saphana)

1. Verify that the current OS version belongs to Red Hat Enterprise Linux 8

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

The output from 8.8 update should contain:

```output
ansible-2-for-rhel-8-x86_64-rhui-rpms            Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
rhel-8-for-x86_64-appstream-e4s-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - AppStream - Update Services for SAP Solutions from RHUI (RPMs)
rhel-8-for-x86_64-baseos-e4s-rhui-rpms           Red Hat Enterprise Linux 8 for x86_64 - BaseOS - Update Services for SAP Solutions from RHUI (RPMs)
rhel-8-for-x86_64-highavailability-e4s-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - High Availability - Update Services for SAP Solutions from RHUI (RPMs)
rhel-8-for-x86_64-sap-netweaver-e4s-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver - Update Services for SAP Solutions from RHUI (RPMs)
rhel-8-for-x86_64-sap-solutions-e4s-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP Solutions - Update Services for SAP Solutions from RHUI (RPMs)
rhui-microsoft-azure-rhel8-sap-ha                Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-sap-ha)
```
The output from 8.10 update should contain:

```bash
ansible-2-for-rhel-8-x86_64-rhui-rpms        Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
packages-microsoft-com-prod                  packages-microsoft-com-prod
rhel-8-for-x86_64-appstream-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - AppStream from RHUI (RPMs)
rhel-8-for-x86_64-baseos-rhui-rpms           Red Hat Enterprise Linux 8 for x86_64 - BaseOS from RHUI (RPMs)
rhel-8-for-x86_64-highavailability-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - High Availability (RPMs) from RHUI
rhel-8-for-x86_64-sap-netweaver-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver (RPMs) from RHUI
rhel-8-for-x86_64-sap-solutions-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP Solutions (RPMs) from RHUI
rhui-microsoft-azure-rhel8-base-sap-ha       Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-ha)
```
#### [RHEL 7.9 to 8.X on SAPAPPS](#tab/rhel8sapapps)


1. Verify that the current OS version belongs to Red Hat Enterprise Linux 9

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

The output from 8.8 should contain:

```output
ansible-2-for-rhel-8-x86_64-rhui-rpms         Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
rhel-8-for-x86_64-appstream-eus-rhui-rpms     Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support from RHUI (RPMs)
rhel-8-for-x86_64-baseos-eus-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - BaseOS - Extended Update Support from RHUI (RPMs)
rhel-8-for-x86_64-sap-netweaver-eus-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver - Extended Update Support from RHUI (RPMs)
rhui-microsoft-azure-rhel8-sapapps            Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-sapapps)
```
The output from 8.10 update should contain:

```output
ansible-2-for-rhel-8-x86_64-rhui-rpms     Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
rhel-8-for-x86_64-appstream-rhui-rpms     Red Hat Enterprise Linux 8 for x86_64 - AppStream from RHUI (RPMs)
rhel-8-for-x86_64-baseos-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - BaseOS from RHUI (RPMs)
rhel-8-for-x86_64-sap-netweaver-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver (RPMs) from RHUI
rhui-microsoft-azure-rhel8-base-sap-apps  Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-apps)
```

---

## Post-Upgrade Tasks

Take further steps once you confirm the upgrade. Adhere to the guidelines in, [Post_upgrade Tasks RHEL 7 to 8 and 8 to 9](https://review.learn.microsoft.com/troubleshoot/azure/virtual-machines/linux/leapp-upgrade-process-rhel-7-and-8?branch=pr-en-us-6901&tabs=rhel7-rhel8#post-upgrade-tasks)


## Post-configuration of the system for `SAP HANA`

"After you verify that the upgrade is successful, you must configure the system for `SAP HANA` according to the applicable `SAP` notes for `RHEL` 8. More information, see,[Configuring the system for SAP HANA.](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/8/html-single/upgrading_sap_environments_from_rhel_7_to_rhel_8/index#proc_configuring-system-sap-hana_asmb_upgrading-hana-system)

