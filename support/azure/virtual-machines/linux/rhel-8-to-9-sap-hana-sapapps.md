---
title:  Leapp upgrade from RHEL 8.X to 9.X on SAP-HANA and SAPAPPS (PAYG) virtual machines.
description: Guide with step by step procedure to do a leapp upgrade..
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 08/27/2024
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# Leapp upgrade from RHEL 8.X to 9.X on SAP-HANA and SAPAPPS (PAYG) virtual machines.

**Applies to:** :heavy_check_mark: Linux VMs

Upgrading your Red Hat Enterprise Linux (RHEL) system is a crucial task to ensure that you benefit from the latest features, security updates, and support. In this article, we guide you through upgrading SAP environments from `RHEL` 8.X to `RHEL` 9.X using a `PAYG` (Pay-As-You-Go) image for Red Hat in Azure.

> [!IMPORTANT]
> RHUI is intended for only pay-as-you-go images. Are you using custom or golden images (also known as "bring-your-own-subscription (BYOS)") instead? In that case, the system has to be attached to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information on performing a `leapp upgrade` process on custom or golden images, and pay-as-you-go (PAYG) images provided by Red Hat, see:

- [Upgrading SAP environments from RHEL 8 to 9](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html/upgrading_sap_environments_from_rhel_8_to_rhel_9/index)


## Prerequisites

- Make a backup of the virtual machine or a snapshot of the OS disk.
- Clear enough space in `/var/lib/leapp`. Having at least 2-5 GB of free space is a safe practice
- Set up access to the serial console
- Run the commands in this article with root privileges.

## Preparing the virtual machine for the `leapp` `pre-upgrade` and upgrade process

- You can conduct an in-place upgrade from **RHEL 8** to the following **RHEL 9** minor versions.

System Configuration   | Source OS version| Target Version    |
|----------------------|------------------|-------------------|
|SAP HANA              | RHEL 8.8         | RHEL 9.2          | 
|                      | RHEL 8.10        | RHEL 9.4          | 
|SAP NetWeaver and     | RHEL 8.8         | RHEL 9.2          |      
|Other SAP Applications| RHEL 8.10        | RHEL 9.4          |


- According to the Red Hat documentation, `SAP HANA` is validated by `SAP` for `RHEL` minor versions that receive package updates for more than six months. Currently, the supported in-place paths of an `SAP HANA` system are from `RHEL` 8.8 to `RHEL` 9.2 and from `RHEL` 8.10 to `RHEL` 9.4. The rest of this document describes restrictions and detailed steps for upgrading an `SAP HANA` system.

- `SAP NetWeaver` is validated by `SAP` for each major `RHEL` version. The supported `in-place` upgrade paths for this scenario are the two latest `EUS/E4S` releases that are supported by `Leapp `for `non-HANA` systems as per the [Upgrading from `RHEL` 8 to `RHEL` 9](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9) document. Certain deviations from the default upgrade procedure are described in [Section 4. Upgrading an SAP NetWeaver system.](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html/upgrading_sap_environments_from_rhel_8_to_rhel_9/asmb_upgrading_netweaver_asmb_upgrading-hana-system) For systems on which both `SAP HANA` and `SAP NetWeaver` are installed, the `SAP HANA` restrictions apply.

> [!IMPORTANT]  
> For RHEL designed for SAP HANA and SAP Applications, there is a known issue when upgrading from version 8.10 to 9.4 due to a difference in the RHUI client RPM name in 8.10 compared to earlier versions. As a result, the upgrade is currently not possible, and no workaround is available. However, **the upgrade from 8.8 to 9.2 is unaffected** by this issue." 


#### [RHEL 8.8 to 9.2 on SAP-HANA](#tab/rhel92saphana)

This procedure outlines the necessary steps to complete before performing an in-place upgrade to `RHEL` 8.8 to `RHEL` 9.2 using the `leapp` utility on `SAP-HANA PAYG` images on Azure.

> [!IMPORTANT]
> If your VM is part of a Hight Availability cluster, the upgrade is possible if the cluster nodes are **not** using any packages that are part of [Resilient Storage.](https://access.redhat.com/articles/3130101) For more information, see, [Procedure to upgrade a RHEL 8 High Availability cluster to RHEL 9.](https://access.redhat.com/articles/7012677)


1. Make sure your current Red Hat release is 8.8.

```bash
sudo cat /etc/redhat-release 
```

```bash
sudo cat /etc/yum/vars/releasever
```

2. Install required `RHUI` packages to ensure your system is ready for upgrade.

```bash
sudo dnf install leapp-rhui-azure-sap
```

3. Stop the SAP HANA system's and terminate all SAP processes.

> [!IMPORTANT]  
> Avoid unmounting the SAP HANA file systems, as they are necessary for detecting the presence and version of the installed SAP HANA system.

If your virtual machine is configured to start SAP processes automatically at boot time, disable the automatic start of SAP processes.

3. Configure RHEL settings for SAP HANA:

   a. Check that the RHEL settings for `SAP HANA` are in place by checking the following:

   According to SAP Note 2772999, the following parameter is necessary for SAP applications, including SAP HANA, and is usually configured in the file `/etc/sysctl.d/sap.conf`.

   ```bash
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```
   b. All other settings for `SAP HANA`, found in the files `/etc/sysctl.conf` and `/etc/sysctl.d/sap_hana.conf`, are the same for both `RHEL` 8 and `RHEL` 9 and should remain unchanged. For further information, please refer to the `SAP` Notes [2382421.](https://launchpad.support.sap.com/#/notes/2382421)


4. Upgrade your RHEL 8.8 system to the latest available RHEL 8.8 package versions.

```bash
sudo dnf update
```

5. Reboot the virtual machine.

```bash
sudo reboot
```

   a. After the virtual machine is up and running, make sure that no SAP HANA systems and no SAP processes are running on your virtual machine.

   b. Make sure the SAP HANA file systems are mounted.

   c. Temporarily disable antivirus software to prevent the upgrade from failing.

   d. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture).


6. Install the `leapp` utility.

```bash
sudo dnf install leapp-upgrade
```

#### [RHEL 8.10 to 9.4 on SAP-HANA](#tab/rhel94saphana)

This procedure outlines the necessary steps to complete before performing an in-place upgrade to `RHEL` 8.10 to `RHEL` 9.4 using the `Leapp` utility on `SAP-HANA PAYG` images on Azure.

> [!NOTE]  
> To update an `SAPAPPS` system running from `RHEL 8.10` to `RHEL 9.4`, you must first upgrade to `RHEL 8.10` for detailed instructions on upgrading from RHEL 8.8 or earlier to RHEL 8.10 on Azure for `PAYG` images, please refer to the guide [How to update RHEL from 8.x to 8.10 on Azure with RHEL for SAP with High Availability or SAP APPS on (PAYG) virtual machines.](https://review.learn.microsoft.com/troubleshoot/azure/virtual-machines/linux/rhel8xto810-on-saphana?branch=pr-en-us-7011&tabs=rhel8x-rhel810ha)" 

> [!IMPORTANT]  
> If your VM is part of a Hight Availability cluster, the upgrade is possible if the cluster nodes are **not** using any packages that are part of [Resilient Storage.](https://access.redhat.com/articles/3130101) For more information, see:  [Procedure to upgrade a RHEL 8 High Availability cluster to RHEL 9](https://access.redhat.com/articles/7012677)

> [!IMPORTANT]  
> `RHEL` for `SAP HANA` and for `SAPAPPS`, there is a known bug in upgrading from **8.10 to 9.4** due to a `RHUI` client rpm name difference in 8.10 compared to previous releases. The upgrade is not possible at the moment, and there is no workaround. The upgrade from **8.8 to 9.2 is not impacted**." 


1. Make sure your current Red Hat release is 8.10.

```bash
sudo cat /etc/redhat-release 
```

2. Install required `RHUI` packages to ensure your system is ready for upgrade.

```bash
sudo dnf install leapp-rhui-azure-sap
```

3. Stop the SAP HANA system's and terminate all SAP processes.

> [!IMPORTANT]  
> Avoid unmounting the SAP HANA file systems, as they are necessary for detecting the presence and version of the installed SAP HANA system

If your virtual machine is configured to start SAP processes automatically at boot time, disable the automatic start of SAP processes.

4. Configure RHEL settings for SAP HANA:

   a. Check that the RHEL settings for `SAP HANA` are in place by checking the following:

   According to SAP Note 2772999, the following parameter is necessary for SAP applications, including SAP HANA, and is configured in the file `/etc/sysctl.d/sap.conf`

   ```bash
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```
   b. All other settings for `SAP HANA`, found in the files `/etc/sysctl.conf` and `/etc/sysctl.d/sap_hana.conf`, are the same for both `RHEL` 8 and `RHEL` 9 and should remain unchanged. 
      For further information, refer to the `SAP` Notes [2382421.](https://launchpad.support.sap.com/#/notes/2382421)


4. Upgrade your RHEL 8.10 system to the latest available RHEL 8.10 package versions.

```bash
sudo dnf update
```

6. Reboot the virtual machine.

```bash
sudo reboot
```
   a. After the virtual machine is up and running, make sure that no SAP HANA systems and no SAP processes are running on your virtual machine.

   b. Make sure the SAP HANA file systems are mounted.

   c. Temporarily disable antivirus software to prevent the upgrade from failing.

   d. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless 
      architecture)


7. Install the `leapp` utility.

```bash
sudo dnf install leapp-upgrade
```

#### [RHEL 8.8 to 9.2 on SAPAPPS](#tab/rhel92sapapps)


This procedure outlines the necessary steps to complete before performing an in-place upgrade to `RHEL` 8.8 to `RHEL` 9.2 using the `leapp` utility on `SAPAPPS PAYG` images on Azure.


1. Make sure your current Red Hat release is 8.8.

```bash
sudo cat /etc/redhat-release 
```

```bash
sudo cat /etc/yum/vars/releasever
```

2. Install required `RHUI` packages to ensure your system is ready for upgrade.

```bash
sudo dnf install leapp-rhui-azure-sap
```

3. Stop all SAP or application processes.

> [!IMPORTANT]  
> Avoid unmounting the SAP file systems, as they are necessary for detecting the presence and version of the installed SAP system.

If your virtual machine is configured to start SAP processes automatically at boot time, disable the automatic start of SAP processes.

4. Configure RHEL settings for SAP HANA:

   a. Check that the RHEL settings for `SAP` are in place by checking the following:

   According to SAP Note 2772999, the following parameter is necessary for SAP applications, including SAP HANA, and is configured in the file `/etc/sysctl.d/sap.conf`.

   ```bash
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```

   b. All other settings for `SAP`, found in the files `/etc/sysctl.conf`, are the same for both `RHEL` 8 and `RHEL` 9 and should remain unchanged. For further information, refer to the `SAP` Notes [2382421.](https://launchpad.support.sap.com/#/notes/2382421)


4. Upgrade your RHEL 8.8 system to the latest available RHEL 8.8 package versions.

```bash
sudo dnf update
```

5. Reboot the virtual machine.

```bash
sudo reboot
```

   a. After the virtual machine is up and running, make sure that no SAP HANA systems and no SAP processes are running on your virtual machine.

   b. Make sure the SAP file systems are mounted.

   c. Temporarily disable antivirus software to prevent the upgrade from failing.

   d. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture).

6. Install the `leapp` utility.

```bash
sudo dnf install leapp-upgrade
```


#### [RHEL 8.10 to 9.4 on SAPAPPS](#tab/rhel94sapapps)

This procedure outlines the necessary steps to complete before performing an in-place upgrade to `RHEL` 8.10 to `RHEL` 9.4 using the `leapp` utility on `SAPAPPS PAYG` images on Azure.

> [!NOTE]  
> To update an `SAPAPPS` system running from `RHEL 8.10` to `RHEL 9.4`, you must first upgrade to `RHEL 8.10` for detailed instructions on upgrading from RHEL 8.8 or earlier to RHEL 8.10 on Azure for `PAYG` images, please refer to the guide. [How to update RHEL from 8.x to 8.10 on Azure with RHEL for SAP with High Availability or SAP APPS on (PAYG) virtual machines.](https://review.learn.microsoft.com/troubleshoot/azure/virtual-machines/linux/rhel8xto810-on-saphana?branch=pr-en-us-7011&tabs=rhel8x-rhel810ha)" 

> [!IMPORTANT]  
> `RHEL` for `SAP HANA` and for `SAPAPPS`, there is a known bug in upgrading from **8.10 to 9.4** due to a `RHUI` client rpm name difference in 8.10 compared to previous releases. The upgrade is not possible at the moment, and there is no workaround. The upgrade from **8.8 to 9.2 is not impacted**." 


1. Make sure your current Red Hat release is 8.10

```bash
sudo cat /etc/redhat-release 
```

2. Install required `RHUI` packages to ensure your system is ready for upgrade.

```bash
sudo dnf install leapp-rhui-azure-sap
```

3. Stop the SAP HANA system's and terminate all SAP processes.

> [!IMPORTANT]  
> Avoid unmounting the SAP file systems, as they are necessary for detecting the presence and version of the installed SAP system.

If your virtual machine is configured to start SAP processes automatically at boot time, disable the automatic start of SAP processes.

4. Configure RHEL settings for SAP:

   a. Check that the RHEL settings for `SAP` are in place by checking the following:

   According to SAP Note 2772999, the following parameter is necessary for SAP applications, including SAP HANA, and is configured in the file `/etc/sysctl.d/sap.conf`

   ```bash
   vm.max_map_count = 2147483647
   kernel.pid_max = 4194304
   ```
   
   b. All other settings for `SAP`, found in the files `/etc/sysctl.conf`, are the same for both `RHEL` 8 and `RHEL` 9 and should remain unchanged. For further information, refer to the 
     `SAP` Notes [2382421.](https://launchpad.support.sap.com/#/notes/2382421)


4. Upgrade your RHEL 8.10 system to the latest available RHEL 8.10 package versions.

```bash
sudo dnf update
```

6. Reboot the virtual machine.

```bash
sudo reboot
```

   a. After the virtual machine is up and running, make sure that no SAP processes are running on your virtual machine.

   b. Make sure the SAP file systems are mounted.

   c. Temporarily disable antivirus software to prevent the upgrade from failing.

   d. Before running the `leapp preupgrade` command, disable any configuration management systems with a client-server architecture, like Puppet, Salt, and Chef or Ansible (agentless architecture)


7. Install the `leapp` utility.

```bash
sudo dnf install leapp-upgrade
```

---


## `Leapp pre-upgrade` and upgrade process

#### `Leapp pre-upgrade` process

The `pre-upgrade`report highlights possible issues and provides recommended solutions. It also helps in determining whether it's feasible or advisable to proceed with the upgrade.

#### [RHEL 8.8 to 9.2 on SAP-HANA](#tab/rhel92saphana)


1. Run the `leapp preupgrade` command, replacing `<target_os_version>` with the target OS version and use the `e4s` channel.

```bash
sudo leapp preupgrade --target <target_os_version> --channel e4s --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.2`. 


#### [RHEL 8.10 to 9.4 on SAP-HANA](#tab/rhel94saphana)


1. Run the `leapp preupgrade` command, replacing `<target_os_version>` with the target OS version and use the `e4s` channel.

```bash
sudo leapp preupgrade --target <target_os_version> --channel e4s --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.4`. 


#### [RHEL 8.8 to 9.2 on SAPAPPS](#tab/rhel92sapapps)


1. Run the `leapp preupgrade` command, replacing `<target_os_version>` with the target OS version and use the `eus` channel.

```bash
sudo leapp preupgrade --target <target_os_version> --channel eus --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.2`. 



#### [RHEL 8.10 to 9.4 on SAPAPPS](#tab/rhel94sapapps)


1. Run the `leapp preupgrade` command, replacing `<target_os_version>` with the target OS version and use the `eus` channel.

```bash
sudo leapp preupgrade --target <target_os_version> --channel eus --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.4`. 


--- 

Review the report located in the `/var/log/leapp/leapp-report.txt` file and manually address all identified issues. Some problems come with suggested fixes. Inhibitor issues must be resolved before you can proceed with the upgrade. For detailed information on the various issues that might appear in the report, for more information, see: [Troubleshoot-red-hat-os-upgrade-issues.](troubleshoot-red-hat-os-upgrade-issues.md)


#### `Leapp` upgrade process

Continue to the `leapp upgrade` process after the `pre-upgrade` report shows no errors or inhibitors and everything is marked as resolved. The output is typically in green or yellow, indicating that it's safe to proceed with the `leapp` upgrade.

> [!IMPORTANT]  
> Make sure to run the `leapp upgrade` command through the serial console to avoid any network interruptions that could affect your SSH terminal and disrupt the upgrade process.


#### [RHEL 8.8 to 9.2 on SAP-HANA](#tab/rhel92saphana)


1. Run the `leapp upgrade` command, replacing `<target_os_version>` with the target OS version and use the `e4s` channel.

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --channel e4s --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.2`. 


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

#### [RHEL 8.10 to 9.4 on SAP-HANA](#tab/rhel94saphana)


1. Run the `leapp upgrade` command, replacing `<target_os_version>` with the target OS version and use the `e4s` channel.

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --channel e4s --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.4`. 


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


#### [RHEL 8.8 to 9.2 on SAPAPPS](#tab/rhel92sapapps)


1. Run the `leapp upgrade` command, replacing `<target_os_version>` with the target OS version and use the `eus` channel.

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --channel eus --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.2`. 


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


#### [RHEL 8.10 to 9.4 on SAPAPPS](#tab/rhel94sapapps)


1. Run the `leapp upgrade` command, replacing `<target_os_version>` with the target OS version and use the `eus` channel.

> [!NOTE]  
> Add the `--reboot` option to the `leapp upgrade` command if you want to perform an automatic reboot, which is needed during the upgrade process

```bash
sudo leapp upgrade --target <target_os_version> --channel eus --no-rhsm
```

Replace `<target_os_version>` with the target OS version, for example `9.4`. 


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

This procedure outlines the recommended verification steps to take after completing an in-place upgrade.

#### [RHEL 9.2 or 9.4 on SAP-HANA](#tab/rhel9294saphana)

1. Verify that the current OS version belongs to Red Hat Enterprise Linux 9

```bash
sudo cat /etc/redhat-release
```

2. Verify the version lock file.

```bash
sudo cat /etc/yum/vars/releasever 
```

3. Check the kernel version

```bash
uname -r
```

4. Verify the new repositories

```bash
sudo dnf repolist
```

The output should contain:

```output
arhel-9-for-x86_64-appstream-e4s-rhui-rpms        Red Hat Enterprise Linux 9 for x86_64 - AppStream - Update Services for SAP Solutions from RHUI (RPMs)
rhel-9-for-x86_64-baseos-e4s-rhui-rpms           Red Hat Enterprise Linux 9 for x86_64 - BaseOS - Update Services for SAP Solutions from RHUI (RPMs)
rhel-9-for-x86_64-highavailability-e4s-rhui-rpms Red Hat Enterprise Linux 9 for x86_64 - High Availability - Update Services for SAP Solutions from RHUI (RPMs)
rhel-9-for-x86_64-sap-netweaver-e4s-rhui-rpms    Red Hat Enterprise Linux 9 for x86_64 - SAP NetWeaver - Update Services for SAP Solutions from RHUI (RPMs)
rhel-9-for-x86_64-sap-solutions-e4s-rhui-rpms    Red Hat Enterprise Linux 9 for x86_64 - SAP Solutions - Update Services for SAP Solutions from RHUI (RPMs)
```

#### [RHEL 9.2 or 9.4 on SAPAPPS](#tab/rhel9294sapapps)


1. Verify that the current OS version belongs to Red Hat Enterprise Linux 9.

```bash
sudo cat /etc/redhat-release
```
2. Verify the version lock file.

```bash
sudo cat /etc/yum/vars/releasever 
```

3. Check the kernel version.

```bash
uname -r
```

4. Verify the new repositories

```bash
sudo dnf repolist
```

The output should contain:

```output
repo id                                       repo name
rhel-9-for-x86_64-appstream-eus-rhui-rpms     Red Hat Enterprise Linux 9 for x86_64 - AppStream - Extended Update Support from RHUI (RPMs)
rhel-9-for-x86_64-baseos-eus-rhui-rpms        Red Hat Enterprise Linux 9 for x86_64 - BaseOS - Extended Update Support from RHUI (RPMs)
rhel-9-for-x86_64-sap-netweaver-eus-rhui-rpms Red Hat Enterprise Linux 9 for x86_64 - SAP NetWeaver - Extended Update Support from RHUI (RPMs)
rhui-microsoft-azure-rhel9-sapapps            Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9-sapapps)
```

---


## Post-Upgrade Tasks

Take further steps once you confirm the upgrade. Adhere to the guidelines in, [Post_upgrade Tasks RHEL 7 to 8 and 8 to 9](/azure/linux/leapp-upgrade-process-rhel-7-and-8?tabs=rhel8-rhel9#post-upgrade-tasks)


## Post-configuration of the system for SAP HANA

After you verify that the upgrade was successful, you must configure the system for SAP HANA according to the applicable SAP notes for RHEL 8. More information, see: [Configuring the system for SAP HANA.](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_sap_solutions/9/html-single/upgrading_sap_environments_from_rhel_8_to_rhel_9/index#proc_configuring-system-sap-hana_asmb_upgrading-hana-system)
