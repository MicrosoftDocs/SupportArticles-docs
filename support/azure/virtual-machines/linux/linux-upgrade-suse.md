---
title: Troubleshoot SLES migration issue
description: This article provides troubleshooting scneario with associated solution while performing SLES migrations
services: virtual-machines
documentationcenter: ''
author: rnirek
tags: virtual-machines
ms.custom: sap:Kernel Upgrades, Package Management issue (Yum, Zypper, RPM, DPKG, APT), linux-related-content
ms.service: azure-virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 10/15/2024
ms.reviewer: dvargas
---
 [**Tags**](/Tags): [Azure](/Tags/Azure) [Azure Linux Escalation](/Tags/Azure-Linux-Escalation) [Azure-Linux-SAP&Clustering](/Tags/Azure%2DLinux%2DSAP&Clustering) [Azure-Linux-SAP-Clustering-howto](/Tags/Azure%2DLinux%2DSAP%2DClustering%2Dhowto) [Linux](/Tags/Linux) [SUSE](/Tags/SUSE) [Virtual Machine](/Tags/Virtual-Machine) [suse-tsg](/Tags/suse%2Dtsg)                                                                                                                                              
# Scope of this article

This TSG covers different issues and their possible resolution during SLES migrations.

> [!CAUTION]
> Following the process in this article will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, it's recommended to create a new VM using your preferred operating system instead of performing an in-place upgrade.

# Pre-requisite 

- Plan the migration activity as per the approved downtime window. This is because the VM reboots during the migration.
- Prior to the migration activity, take a complete backup of the VM.
- If backup isn't configured, take a snapshot backup of the OS disk.
- [Check if the VM is generation V1 or generation V2](#check-the-generation-version-for-a-vm).


# 1. Successful Migration from SLES12 to SLES15, but SLES15 SP1 to SP2 Upgrade Fails with Error

While running `zypper migration`, the migration fails showing the following output which can also be seen in `/var/log/messages` or `/var/log/distro-migration.log` file:

**Error :**
```output
    Can't get available migrations from server: SUSE::Connect::ApiError: The requested products 'HPC Module 12 x86_64' are not activated on the system.
```
OR
```output
    Can't get available migrations from server: SUSE::Connect::ApiError: Invalid combination of  products registered.
```
**Cause :** 

One of the bigger changes between SLE12 and SLE15 was that HPC became a standalone product. As a result, the HPC module is no longer available to systems registered as SUSE Linux Enterprise Server (SLES). This brings with it that in some cases the process that calculates the migration target fails to find a target and the migration process fails. Therefore, it is recommended that prior to the migration, the HPC module components are removed.

**Resolution :**
```bash
     sudo zypper rm sle-module-hpc-release-POOL sle-module-hpc-release
```

**Workaround :**
Move `sle-module-hpc.prod` from `/etc/products.d/` to a temporary location and try the migration again.
             
 ```bash
    cd /etc/products.d
 ```
 ```bash
    sudo mv sle-module-hpc.prod /tmp/
 ```
 ```bash
   sudo zypper migration
 ```
**Reference :**

1. https://www.suse.com/c/major-distro-upgrade-in-the-public-cloud-made-easy/ 
2. https://www.suse.com/support/kb/doc/?id=000019232

# 2. Error while installing the `suse-migration-sles15-activation` package.

While installing the `suse-migration-sles15-activation` package, the migration fails showing the following output which can also be seen in `/var/log/messages` or `/var/log/distro-migration.log` file:

**Error :**
```output
    'suse-migration-sle15-activation' not found in package names. Trying capabilities. No provider of 'suse-migration-sle15-activation' found.
```
**Cause :**

You will notice that the SLES12 Public Cloud module isn't enabled by default.

**Resolution :**

1. Enable the following module and then try installing the package again.
   ```bash
         sudo SUSEConnect -p sle-module-public-cloud/12/x86_64
   ```
> [!NOTE]
> On SLES for SAP instances, the following two packages should never be present: `sle-ha-release` and `sle-ha-release-POOL`. If the instance is SLES for SAP, remove these packages before starting the distribution migration:
  
  ```bash 
      sudo zypper remove sle-ha-release sle-ha-release-POOL
  ```
2. Perform a cleanup and then re-register the system.
     ```bash
            sudo SUSEConnect --cleanup
     ```
     ```bash
          sudo rm /etc/zypp/{credentials,services,repos}.d/*
     ```
     ```bash
         sudo rm --force --recursive /var/cache/zypp/*
     ```
     ```bash
         sudo rm /var/lib/cloudregister/*
     ```
     ```bash
         sudo registercloudguest --force-new
     ```
3. Verify the VM registration status by running SUSEConnect again:
     ```bash
         sudo SUSEConnect --status
     ```
4. Then proceed with the migration.
     ```bash
            sudo zypper migration
     ```

**Reference :**
1. https://www.suse.com/c/major-distro-upgrade-in-the-public-cloud-made-easy/
2. https://www.suse.com/c/upgrading-suse-linux-enterprise-in-the-public-cloud/

# 3. Gen2 VMs Fail to Boot After SLE15SP1 to SP2 Upgrade When Stopped via Azure Portal or Shutdown(init 0 or shutdown -h) command.

After the VM is upgrade to SLES15SP1 to SP2, VM doesn't boot when stopped from Azure Portal. The `serialconsole.log` or `boot.log` will display the following output:

**Error :**
```output
    Loading Linux 5.3.18-24.49-default ...  
    error: symbol grub_file_filters' not found                                                 
    Loading initial ramdisk ...  
    error: symbol grub_file_filters' not found
    Press any key to continue.
```
OR
```output
    Loading Linux 5.3.18-24.49-default ...  
    error: symbol grub_verify string' not found                                                 
    Loading initial ramdisk ...  
    error: symbol grub_verify string' not found
    Press any key to continue...
```
**Cause :**
Hyper-V in the Azure environment doesn't preserve the Generation-2 VM (UEFI VM)'s Boot Entries after the VM is rebooted, stopped and deallocated. This causes SUSE Linux VM to fail to boot up. 

**Resolution :**
1. Setup chroot environment from the affected VM OS snapshot disk  on a rescue VM as described in [chroot-environment-linux](/azure/virtual-machines/chroot-environment-linux).
2. Re-install Grub boot loader executing:
     ```bash
          sudo /usr/sbin/shim-install --config-file=/boot/grub2/grub.cfg
     ```
3. Swap the snapshot disk back to the problematic VM as described in [chroot-environment-linux](/azure/virtual-machines/chroot-environment-linux).

**Reference :**
 https://www.suse.com/support/kb/doc/?id=000019919

# 4. Migration failure from SLES15 SP0 to SP3.

The migration fails from SLES15 SP0 to SP3 showing the following output which can also be seen in `/var/log/messages` or `/var/log/distro-migration.log` file:

**Error:**
```output
Can't get available migrations from server: SUSE::Connect::ApiError: The requested products 'SUSE Linux Enterprise High Availability Extension 15 SP1 x86_64, Basesystem Module 15 SP1 x86_64, SUSE Cloud Application Platform Tools Module 15 SP1 x86_64, Containers Module 15 SP1 x86_64, Desktop Applications Module 15 SP1 x86_64, Development Tools Module 15 SP1 x86_64, Legacy Module 15 SP1 x86_64, Public Cloud Module 15 SP1 x86_64, Python 2 Module 15 SP1 x86_64, SAP Applications Module 15 SP1 x86_64, Server Applications Module 15 SP1 x86_64, Web and Scripting Module 15 SP1 x86_64, Transactional Server Module 15 SP1 x86_64' are not activated on the system.
/usr/lib/zypper/commands/zypper-migration' exited with status 1
```  
**Cause :**
The  error occurs because SLES migration from SLE15SP0 to higher version was interrupted/stopped midway, or was accidentally terminated for some reason. This can leave some packages upddated while others will be left on original version

**Resolution:**
Roll back all the packages to the versions compatible with SLE15SP0 and perform the following steps:
  ```bash
       sudo zypper dup
  ```
  ```bash
      sudo zypper rollback
  ```
  ```bash 
       sudo zypper migration
  ```

# 5. Post Migration SUSE fails to boot to latest kernel followed by registration failure
Post migration customers might experience issues with kernel where the VM fails to boot  with the latest kernel. Also, repositories will not work on the VM with an error stating that the repositories are not defined on the VM.

**Cause:** 
The `credentials.d` directory had incorrect permission or the contents of a file inside `credentials.d` was incorrect or corrupted. 

**Resolution:**
1.  The registration was failing because the `credentials.d` directory had incorrect permission or the contents of a file inside `credentials.d` was triggering this error.
Clean up registration by following below steps:
     ```bash
            sudo rm /var/cache/cloudregister/
     ```
     ```bash
          sudo rm /etc/zypp/credentials.d/
     ```
     ```bash
         sudo rm /etc/zypp/credentials.d/
     ```
     ```bash
         sudo chmod 0755 /etc/zypp/credentials.d*
     ```
     ```bash
         sudo registercloudguest --force-new
     ```
2. After the registration is successfully completed, patch the VM and reboot: 
     ```bash
          sudo zypper update
     ```
     ```bash
         sudo reboot
    ```

# 6. Migration from SLES12SP5 to SLES15SP1 fails due to issue with `regionService` directory:
The migration fails from SLES12 SP5 to SLES15 SP1 showing the following output which can also be seen in `/var/log/messages` or `/var/log/distro-migration.log` file:

**Error:**
````output
Skipping repository 'SLE-Module-Containers12-Updates' because of the above error.
Error retrieving metadata for 'SLE-Module-HPC12-Pool':
Not ready to read within timeout.
Skipping repository 'SLE-Module-HPC12-Pool' because of the above error.
Error retrieving metadata for 'SLE-Module-HPC12-Updates' :
Not ready to read within timeout.
Skipping repository 'SLE-Module-HPC12-Updates' because of the above error.
Error retrieving metadata for 'SLE-Module-Legacy12-Pool' :
Not ready to read within timeout.
Skipping repository 'SLE-Module-Legacy12-Pool' because of the above err Error retrieving metadata for 'SLE-Module-Legacy12-Updates' :
Not ready to read within timeout.
Skipping repository 'SLE-Module-Legacy12-Updates' because of the above Error retrieving metadata for 'SLE-Module-Public-Cloud12-Pool' :
Not ready to read within timeout.
Skipping repository 'SLE-Module-Public-Cloud12-Pool' because of the abo Error retrieving metadata for 'SLE-Module-Public-Cloud12-Updates' :
Not ready to read within timeout.
Skipping repository 'SLE-Module-Public-Cloud12-Updates' because of the
````
**Cause**:
The  regionService directory has moved from `/var/lib` to `/usr/lib` and the DMS scripting is only looking for the certs directory under `/var/lib` when attempting to setup the bind mount into the ISO runtime environment.

**Resolution:**
1. Create the old/previously used directories: `/var/lib/regionService/certs`.
   ```bash
      sudo mkdir -p /var/lib/regionService/certs
   ```
2. Copy the cert files.
   ```bash 
    sudo cp -a /usr/lib/regionService/certs/* /var/lib/regionService/certs/
   ```
3. Modify `/etc/regionserverclnt.cfg` and set `certLocation` to the previously used path `/var/lib/regionService/certs`.
   ```bash
    sudo  vi /etc/regionserverclnt.cfg
   ```
4. The modified file will look like this:
   ```bash
     sudo cat /etc/regionserverclnt.cfg
   ```
   ``` output        
    [server]
     api = regionInfo
     #certLocation = /usr/lib/regionService/certs
     certLocation = /var/lib/regionService/certs
     regionsrv = 23.100.36.229,40.121.202.140,52.187.53.250,104.45.31.195,191.237.254.253
    [instance]
     dataProvider = /usr/bin/azuremetadata --api latest --subscriptionId --billingTag --attestedData --signature --xml
     instanceArgs = msftazure
     httpsOnly = true
   ```
5. Install the latest `SLES15-Migration` package.
   ``` bash
      sudo zypper in SLES15-Migration
   ```
6. Trigger the migration:
   ``` bash
        sudo zypper migration
   ```

**Reference:** https://www.suse.com/support/kb/doc/?id=000021338

# 7. Migration fails due to unknown folder in `/etc/pki/trust/anchors`.

Migration from SLES12SP5 to SLES15SP1 is failing, these errors can be seen in the `/var/log/distro_migration.log`

**Error:**
````output
Mar 11 13:39:15 localhost suse-migration-prepare[1510]: IsADirectoryError: [Errno 21] Is a directory: '/system-root/etc/pki/trust/anchors/temp'
Mar 11 13:39:15 localhost systemd[1]: suse-migration-prepare.service: Main process exited, code=exited, status=1/FAILURE
Mar 11 13:39:15 localhost systemd[1]: Failed to start Prepare For Migration.
Mar 11 13:39:15 localhost systemd[1]: suse-migration-prepare.service: Unit entered failed state.
Mar 11 13:39:15 localhost systemd[1]: suse-migration-prepare.service: Failed with result 'exit-code'.
````
**Resolution:**
1. Move the `/etc/pki/trust/anchors` to 1tmp` folder. 
   ```bash
     sudo mv /etc/pki/trust/anchors/temp /backuplocation/temp
   ```
2. Install the migration package.
   ```bash
     sudo zypper install suse-migration-sle15-activation
   ```
3. Perform the migration.
   ```bash
      sudo zypper migration
   ```

# 8. SUSE registration and repos fail to work after migration.
While performing OS migration, you have migrated from SLES15SP3 to SLES15SP4. Now, while performing migration from SLES15SP4 to SLES15SP5, migration and updates are not working as expected. 

**Error:** 
```output
         sle-module-desktop-applications/15.3/x86_64 Desktop Applications Module
         sle-module-development-tools/15.3/x86_64 Development Tools Module
         sle-ha/15.3/x86_64          SUSE Linux Enterprise High Availability Extension 15 SP3
         sle-module-sap-applications/15.3/x86 64  SAP Applications Module
         sle-module-live-patching/15.3/x86_64   SUSE Linux Enterprise Live Patching
         PackageHub/15.3/x86 64   SUSE Package Hub 15
         sle-module-certifications/15.3/x86_64   Certifications Module
 Unavailable migrations (product is not mirrored):
         SUSE Linux Enterprise Server for SAP Applications 15 SP6 x86_64 (not available) Basesystem Module 15 SP6 x86_64 (not available) Certifications Module 15 SP6 x86_64 (not available) Containers Module 15 SP6 x86_64 (not available)
         Desktop Applications Module 15 SP6 x86_64 (not available)
         Server Applications Module 15 SP6 x86_64 (not available)
         SUSE Linux Enterprise Live Patching 15 SP6 x86_64 (not available)
         SUSE Package Hub 15 SP6 x86_64 (not available)
         Development Tools Module 15 SP6 x86_64 (not available)
         Legacy Module 15 SP6 x86_64 (not available)
         Public Cloud Module 15 SP6 x86_64 (not available)
         SUSE Linux Enterprise High Availability Extension 15 SP6 x86 64 (not available) Web and Scripting Module 15 SP6 x86_64 (not available)
         SAP Applications Module 15 SP6 x86_64 (not available)

No migration available.

'/usr/lib/zypper/commands/zypper-migration' exited with status 1
```

**Resolution:**
1. Activate and Deactivate the following modules  prior to the migration.

 * Activate the following modules:
     ```bash
        SUSEConnect -p sle-module-web-scripting/15.3/x86_64
        SUSEConnect -p sle-module-public-cloud/15.3/x86_64
       SUSEConnect -p sle-module-containers/15.3/x86_64
       SUSEConnect -p sle-module-live-patching/15.3/x86_64
     ```
 * Deactivate the following modules:
     ```bash
        SUSEConnect -d -p sle-module-legacy/15.3/x86_64
        SUSEConnect -d -p sle-module-python2/15.3/x86_64
        SUSEConnect -d -p PackageHub/15.3/x86_64
     ```
2. Perform a cleanup and then re-register the system.
     ```bash
            sudo SUSEConnect --cleanup
     ```
     ```bash
          sudo rm /etc/zypp/{credentials,services,repos}.d/*
     ```
     ```bash
         sudo rm --force --recursive /var/cache/zypp/*
     ```
     ```bash
         sudo rm /var/lib/cloudregister/*
     ```
     ```bash
         sudo registercloudguest --force-new
     ```
3. Verify the VM registration status by running SUSEConnect again:
     ```bash
         sudo SUSEConnect --status
     ```

# 9. Migration fails from SLES15SP3 to SLES15SP4 with the error `No Migration available`.
The SLES15 Migration from SP3 to SP4 fails showing the following output which can also be seen in `/var/log/messages` or `/var/log/distro-migration.log` file:

**Error:** 
```output
      Node01:~# SUSEConnect -S
      Error: Invalid system credentials, probably because the registered system was deleted in SUSE Customer Center. Check https://scc.suse.co m whether your system appears there. If it does not, please call SUSEConnect --cleanup 
      and re-register this system.
      Node01:~# zypper migration

      Executing '/usr/bin/zypper patch-check-updatestack-only'
      Loading repository data...
      Warning: No repositories defined. Operating only with the installed resolvables. Nothing can be installed. Reading installed packages...

     O patches needed (0 security patches)


     Executing '/usr/bin/zypper ref'

     Warning: There are no enabled repositories defined.
     Use 'zypper addrepo' or 'zypper modifyrepo' commands to add or enable repositories.
     repository refresh failed, exiting
     '/usr/lib/zypper/commands/zypper-migration' exited with status 1
```

**Cause:** The `Certification Module` is present due to which the `zypper migration` fails.

**Resolution:**
Disable 'Certification Module' prior to the update and try again the migration:
```bash
    sudo SUSEConnect -d -p sle-module-certifications/15.3/x86_64
```

# 10. Migration fails due to third party modules and security tools.
Several issues have been encountered during VM migration, such as VM in hung state, boot failures, or prolonged processes at zypper module repositories. It is advisable to consult with the customer to ensure that any third-party repositories and security tools on the system are disabled before proceeding with the SUSE migration.Security tools can disrupt the migration by blocking operations or modifying system files, leading to instability. Additionally, third-party repositories may introduce packages that conflict with official SUSE packages, potentially causing further complications during the upgrade.Disabling them during the migration is crucial to prevent dependency conflicts, ensure system stability, maintain consistency with official packages, simplify troubleshooting, and provide a smoother upgrade process. 

# Contact & Feedback
::: template /.templates/Shared/Azure-Virtual-Machine-RDPSSH-Contact-Feedback-LTemplate
::: 

## Transcluded templates (1)
- Template: Azure-Virtual-Machine-RDPSSH-Contact-Feedback-LTemplate([View](https://supportability.visualstudio.com/AzureLinuxNinjas/_wiki/wikis/AzureLinuxNinjas?wikiVersion=GBmaster&pagePath=%2f.templates%2fShared%2fAzure-Virtual-Machine-RDPSSH-Contact-Feedback-LTemplate))
