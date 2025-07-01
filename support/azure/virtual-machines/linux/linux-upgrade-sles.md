---
title: Troubleshoot SLES migration issues 
description: Provides solutions to issues that occur while you perform SUSE Linux Enterprise server migrations.
ms.service: azure-virtual-machines
ms.date: 11/01/2024
ms.reviewer: divargas, rnirek, v-weizhu
ms.custom: sap:Issue with OS Upgrade
---                                                                                                                      
# Troubleshoot SLES migration issues in Azure Linux virtual machines

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses issues that occur during SUSE Linux Enterprise server (SLES) migrations and provides solutions to them.

> [!CAUTION]
> Following the process in this article will cause a disconnection between the data plane, and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, it's recommended to create a new VM using your preferred operating system instead of performing an in-place upgrade.

## Prerequisite

- This [Distribution Migration System (DMS)](https://documentation.suse.com/suse-distribution-migration-system/15/single-html/distribution-migration-system/index.html) guide provides general steps about how to upgrade SLES 12 to SLES 15 for an Azure VM. For more information, see [Upgrading SUSE Linux Enterprise in the Public Cloud](https://www.suse.com/c/upgrading-suse-linux-enterprise-in-the-public-cloud/) and [SUSE Product Lifecycle](https://www.suse.com/lifecycle).
- Because the migration requires the VM to reboot, plan the migration activity as per the approved downtime window. 
- Take a complete backup or snapshot of VM before performing the migration.
- [Check if the VM is generation V1 or generation V2](#check-the-generation-version-for-a-vm).

### Check the generation version for a VM

You can check the generation version by using one of the following methods:

- Run the following command in the SLES terminal:

    ```bash
    sudo dmidecode | grep -i hyper
    ```

    If it's a Generation 1 VM, no output is returned. 
    
    If it's a Generation 2 VM, you can see an output like the following text:
    
    ```output
    Version: Hyper-V UEFI Release v4.1
    Version: Hyper-V UEFI Release v4.1
    Version: Hyper-V UEFI Release v4.1
    Version: Hyper-V UEFI Release v4.1
    ```
 
- In the [Azure portal](https://portal.azure.com), go to the VM **Properties**, and then check the **VM generation** field as shown:

    :::image type="content" source="media/linux-upgrade-sles/vm-generation-property.png" alt-text="Screenshot that shows the 'VM generation' property.":::

## Scenario 1: Migration from SLES 12 to SLES 15 succeeds, but upgrade from SLES 15 SP1 to SP2 fails

While you execute the `sudo zypper migration` command, the migration fails and you get the following output:

```output
Can't get available migrations from server: SUSE::Connect::ApiError: The requested products 'HPC Module 12 x86_64' are not activated on the system.
```

Or

```output
Can't get available migrations from server: SUSE::Connect::ApiError: Invalid combination of  products registered.
```

You can also find the output in the `/var/log/messages` or `/var/log/distro-migration.log` file.

### Cause 

One major change between SLES 12 and SLES 15 is that High-Performance Computing (HPC) becomes a standalone product. Therefore, the HPC module is no longer available to systems registered as SLES. This change causes that the migration target fails to find a target and the migration process fails.

### Resolution

To resolve this issue, remove the HPC module before starting the migration by running the following command:

```bash
sudo zypper rm sle-module-hpc-release-POOL sle-module-hpc-release
```

### Workaround

To work around this issue, move `sle-module-hpc.prod` from the `/etc/products.d/` directory to a temporary location, and try the migration again. To do so, run the following commands:

```bash
cd /etc/products.d
```

```bash
sudo mv sle-module-hpc.prod /tmp/
```

```bash
sudo zypper migration
```

For more information, see [Major distros in the Public Cloud](https://www.suse.com/c/major-distro-upgrade-in-the-public-cloud-made-easy/) and [zypper migration fails in Azure](https://www.suse.com/support/kb/doc/?id=000019232).

## Scenario 2: Installing the "suse-migration-sles15-activation" package fails

While you install the `suse-migration-sles15-activation` package, the migration fails and you get the following output:

```output
'suse-migration-sle15-activation' not found in package names. Trying capabilities. No provider of 'suse-migration-sle15-activation' found.
```

You can also find this output in the `/var/log/messages` or `/var/log/distro-migration.log` file.

### Cause

The SLES 12 Public Cloud module isn't enabled by default.

### Resolution

To resolve this issue, follow these steps:

1. Enable the Public Cloud module and then try installing the package again:

    ```bash
    sudo SUSEConnect -p sle-module-public-cloud/12/x86_64
    ```

    > [!NOTE]
    > On SLES for SAP instances, two packages should never exist: `sle-ha-release` and `sle-ha-release-POOL`. In this case, before starting the distribution migration, remove these packages by running the `sudo zypper remove sle-ha-release sle-ha-release-POOL` command.

2. Perform a cleanup on the system, and then re-register it:

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
3. Verify the VM registration status:

    ```bash
    sudo SUSEConnect --status
    ```
4. Proceed with the migration:

    ```bash
    sudo zypper migration
    ```

For more information, see [Major Distros in the Public Cloud](https://www.suse.com/c/major-distro-upgrade-in-the-public-cloud-made-easy/) and [Upgrading SUSE Linux Enterprise in the Public Cloud](https://www.suse.com/c/upgrading-suse-linux-enterprise-in-the-public-cloud/).

## Scenario 3: After you upgrade from SLE 15 SP1 to SLE 15 SP2, Generation 2 VMs fail to boot after stopped

After the Generation 2 VM is upgraded from SLES 15 SP1 to SLES 15 SP2, the VM doesn't boot after it's stopped from the Azure portal or by running the `init 0` or `shutdown -h` command. The following output is displayed in the serial console log or `boot.log` under the `/var/log/` directory:

```output
Loading Linux 5.3.18-24.49-default ...  
error: symbol grub_file_filters' not found                                                 
Loading initial ramdisk ...  
error: symbol grub_file_filters' not found
Press any key to continue.
```
Or

```output
Loading Linux 5.3.18-24.49-default ...  
error: symbol grub_verify string' not found                                                 
Loading initial ramdisk ...  
error: symbol grub_verify string' not found
Press any key to continue...
```

### Cause

After the Generation 2 VM is rebooted, stopped, or deallocated, Hyper-V in the Azure environment doesn't preserve its boot entries. In this case, the SUSE Linux VM fails to boot.

### Resolution

To resolve this issue, follow these steps:

1. Set up the chroot environment from the affected VM OS snapshot disk on a rescue VM as described in [Chroot environment in a Linux rescue VM](chroot-environment-linux.md).

2. Reinstall the GRUB bootloader:

    ```bash
    sudo /usr/sbin/shim-install --config-file=/boot/grub2/grub.cfg
    ```
3. Swap the snapshot disk back to the problematic VM as described in [Chroot environment in a Linux rescue VM](chroot-environment-linux.md).

For more information, see [grub2 error: symbol 'grub_file_filters' not found](https://www.suse.com/support/kb/doc/?id=000019919).

## Scenario 4: Migration from SLES 15 to SLES 15 SP3 fails

The migration fails from SLES 15 to SLES 15 SP3, and you get the following output:

```output
Can't get available migrations from server: SUSE::Connect::ApiError: The requested products 'SUSE Linux Enterprise High Availability Extension 15 SP1 x86_64, Basesystem Module 15 SP1 x86_64, SUSE Cloud Application Platform Tools Module 15 SP1 x86_64, Containers Module 15 SP1 x86_64, Desktop Applications Module 15 SP1 x86_64, Development Tools Module 15 SP1 x86_64, Legacy Module 15 SP1 x86_64, Public Cloud Module 15 SP1 x86_64, Python 2 Module 15 SP1 x86_64, SAP Applications Module 15 SP1 x86_64, Server Applications Module 15 SP1 x86_64, Web and Scripting Module 15 SP1 x86_64, Transactional Server Module 15 SP1 x86_64' are not activated on the system.
/usr/lib/zypper/commands/zypper-migration' exited with status 1
```

You can also find it in the `/var/log/messages` or `/var/log/distro-migration.log` file.

### Cause

This error occurs because SLES migration from SLES 15 to a later version is interrupted, stopped, or accidentally terminated, resulting in the incomplete package updates in the system.

### Resolution

To resolve this issue, roll back all the packages to the versions compatible with SLES 15 and try the migration again:

1. Check duplicate packages in the system:

    ```bash
    sudo zypper dup
    ```
2. Roll back the changes:
    
    ```bash
    sudo zypper rollback
    ```
3. Perform the migration again:

    ```bash 
    sudo zypper migration
    ```

## Scenario 6: After migration, SUSE fails to boot with the latest kernel followed by a registration failure

After migration, the VM fails to boot with the latest kernel. Additionally, repositories don't work and you get an error stating that the repositories aren't defined.

### Cause

The `/etc/credentials.d` directory has incorrect permissions or the content of a file in this directory is incorrect or corrupted.

### Resolution

To resolve this issue, follow these steps:

1. Clean up the registration:

    ```bash
    sudo rm /var/cache/cloudregister/
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
2. After the registration is successfully completed, patch and reboot the VM: 

    ```bash
    sudo zypper update
    
    ```
    ```bash
    sudo reboot
    ```

## Scenario 7: Migration from SLES 12 SP5 to SLES 15 SP1 fails due to the regionService directory issue

The migration fails from SLES 12 SP5 to SLES 15 SP1, and you get the following output:

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

You can also find the output in the `/var/log/messages` or `/var/log/distro-migration.log` file.


### Cause

The `regionService` directory moves from `/var/lib` to `/usr/lib`, but the DMS scripting only looks for the `certs` directory under `/var/lib` when setting up the bind mount into the ISO runtime environment.

### Resolution

To resolve this issue, follow these steps:

1. Create the previously used directory `/var/lib/regionService/certs`:

    ```bash
    sudo mkdir -p /var/lib/regionService/certs
    ```
2. Copy the cert files to `/var/lib/regionService/certs`:

    ```bash 
    sudo cp -a /usr/lib/regionService/certs/* /var/lib/regionService/certs/
    ```
3. Modify the `/etc/regionserverclnt.cfg` file, and set the `certLocation` parameter to the previously used path `/var/lib/regionService/certs`:

    ```bash
    sudo vi /etc/regionserverclnt.cfg
    ```
4. Check the modified file:

    ```bash
    sudo cat /etc/regionserverclnt.cfg
    ```

    ```output        
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

4. Install the latest `SLES15-Migration` package:

    ``` bash
    sudo zypper in SLES15-Migration
    ```

5. Perform the migration again:

    ``` bash
    sudo zypper migration
    ```

For more information, see [SLES 12 SP5 Distribution Migration System (DMS) failed](https://www.suse.com/support/kb/doc/?id=000021338).

## Scenario 8: Migration fails due to an unknown folder in the /etc/pki/trust/anchors directory

Migration from SLES 12 SP5 to SLES 15 SP1 fails, and the following error messages are displayed in the `/var/log/distro_migration.log` file:

````output
Mar 11 13:39:15 localhost suse-migration-prepare[1510]: IsADirectoryError: [Errno 21] Is a directory: '/system-root/etc/pki/trust/anchors/temp'
Mar 11 13:39:15 localhost systemd[1]: suse-migration-prepare.service: Main process exited, code=exited, status=1/FAILURE
Mar 11 13:39:15 localhost systemd[1]: Failed to start Prepare For Migration.
Mar 11 13:39:15 localhost systemd[1]: suse-migration-prepare.service: Unit entered failed state.
Mar 11 13:39:15 localhost systemd[1]: suse-migration-prepare.service: Failed with result 'exit-code'.
````

### Resolution

To resolve this issue, follow these steps:

1. Move the `temp` folder in the `/etc/pki/trust/anchors` directory to the `/backuplocation/` directory:

    ```bash
    sudo mv /etc/pki/trust/anchors/temp /backuplocation/temp
    ```
2. Install the migration package:

    ```bash
    sudo zypper install suse-migration-sle15-activation
    ```
3. Perform the migration again:

    ```bash
    sudo zypper migration
    ```

## Scenario 9: SUSE registration and repositories don't work after migration

During the OS migration from SLES 15 SP3 to SLES 15 SP4, the process completes successfully. However, when you migrate from SLES 15 SP4 to SLES 15 SP5, the migration and updates don't work as expected, and you get the following output:

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

### Resolution

To resolve this issue, follow these steps:

1. Before the migration, activate and then deactivate the following modules.

   1. Activate the following modules:

       ```bash
       sudo SUSEConnect -p sle-module-web-scripting/15.3/x86_64
       sudo SUSEConnect -p sle-module-public-cloud/15.3/x86_64
       sudo SUSEConnect -p sle-module-containers/15.3/x86_64
       sudo SUSEConnect -p sle-module-live-patching/15.3/x86_64
       ```
   2. Deactivate the following modules:

       ```bash
       sudo SUSEConnect -d -p sle-module-legacy/15.3/x86_64
       sudo SUSEConnect -d -p sle-module-python2/15.3/x86_64
       sudo SUSEConnect -d -p PackageHub/15.3/x86_64
       ```

2. Perform a cleanup on the system, and then re-register it:

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

3. Verify the VM registration status:

    ```bash
    sudo SUSEConnect --status
    ```

## Scenario 10: SLES 15 migration fails from SP3 to SP4 with invalid credentials and repository errors

The SLES 15 migration from SP3 to SP4 fails, and you get the following output:

```bash
sudo SUSEConnect -S
```

```output
Error: Invalid system credentials, probably because the registered system was deleted in SUSE Customer Center. Check https://scc.suse.com whether your system appears there. If it does not, please call SUSEConnect --cleanup and re-register this system.
```

```bash
sudo zypper migration
```

```output
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

You can also find the outputs in the `/var/log/messages` or `/var/log/distro-migration.log` file.

### Cause

The migration fails because the certification module exists.

### Resolution

To resolve this issue, run the following command to disable the certification module before the update, and try the migration again:

```bash
sudo SUSEConnect -d -p sle-module-certifications/15.3/x86_64
```

## Scenario 11: Migration fails due to third-party modules and security tools

Some issues occur during VM migration, such as the VM entering a hung state, boot failures, or prolonged processes at zypper module repositories.

### Cause

- Security tools can disrupt the migration by blocking operations or modifying system files, leading to instability.
- Third-party repositories might introduce packages that conflict with official SUSE packages, potentially causing further complications during the upgrade.

### Resolution

We recommend disabling any third-party repositories and security tools on the system before proceeding with the SUSE migration. Disabling them during the migration is crucial to prevent dependency conflicts, ensure system stability, maintain consistency with official packages, simplify troubleshooting, and provide a smoother upgrade process.

## Scenario 12: Successful Migration from SLES12 SP5 to SLES15 SP3, but SLES15 SP3 to SP6 Upgrade Fails with Error

The migration succeeds from SLES 12 SP5 to SLES 15 SP3. While you execute the `sudo zypper migration -v` command on SLES 15 SP3, the migration fails and you get the following output:

```output
[SUSE_Linux_Enterprise_Server_x86_64:SLE-Product-SLES15-SP6-Updates|plugin:/susecloud?credentials=SUSE_Linux_Enterprise_Server_x86_64&amp;path=/repo/SUSE/Updates/SLE-Product-SLES/15-SP6/x86_64/update/] Valid metadata not found at specified URL
History:
- Signature verification failed for repomd.xml
- Can&apos;t provide /repodata/repomd.xml
      

</message>
<message type="warning">Skipping repository &apos;SLE-Product-SLES15-SP6-Updates&apos; because of the above error.</message>
<message type="error">Some of the repositories have not been refreshed because of an error.</message>
<message type="info">Loading repository data...</message>
<message type="info">Reading installed packages...</message>

<search-result version="0.0">
<solvable-list>
<solvable status="installed" name="sle-module-basesystem" kind="product" edition="15.3-0" arch="x86_64" repository="(System Packages)"/>
</solvable-list>
</search-result>
</stream>

**Migration failed.**

Performing repository rollback...
Starting to sync system product activations to the server. This can take some time...
Rollback successful.
'/usr/lib/zypper/commands/zypper-migration' exited with status 1

```

You can also find the output in the `/var/log/messages` or `/var/log/distro-migration.log` file.

### Cause 

Mid of 2023, SUSE has changed the GPG signing key for the SUSE Linux Enterprise 15 products, and products based on those (SUSE Enterprise Storage, SUSE Manager, SUSE CaaSP) to the RSA 4096 bit key as specified in SUSE article [https://www.suse.com/support/security/keys/](https://www.suse.com/support/security/keys).

### Resolution

1. Verify the existing keys.
```bash
sudo rpm -q gpg-pubkey
```
```output
gpg-pubkey-39db7c82-66c5d91a
gpg-pubkey-50a3dd1c-50f35137
```
2. Create a file named `repo-signing-key-sle-15.txt` using `vi` editor under your home directory.

```bash
sudo vi repo-signing-key-sle-15.txt
```
3. Add the following contents and save the file.
   
```bash
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.15 (GNU/Linux)

mQINBGPJSBwBEAC+sp2UJHVei0aAkvnEeeuRrIbzyWotRYuDgdWzS4V01alxFl97
ZPA6syyyZpITGP6fLP0AG0KipXABcYdaF7iFGKnhm6v5ExQ+Aft9SNaJmGqxwPng
2jHGoaovbcOrvpix1INwPlxyxAaKfCtdH6kE9ZBzZXKHhDwTuBAyIJmvz5P4djxs
RFxryZ2wq2IbhT/eu5b+3QRdeOHhbP/K2ZA+jd4Ct6uSyEAV0n9D5rVrtKhYqzp7
zXPYntFW9IgEC/HisQ3TcDhKqK0xfxsQAYjsrvrbhc2O1sHWfhDEqV7W8yPrEbH2
NTWmQxiSf4ZEJsKOZa6TI4fOS89OPRRIC0Ec+mFWHHSfhGaiK0g59TSuBECke7jV
hgwLKa0WGzxhYaZ/dPxjke9MfHPIlCrwfH4tKsEY5Cy+GQWwt8s7J9lK1gEGz0c2
nLA4PBDCPqKB/+GEHkF+hyN1GHlhoY78mJ+c/QHyTv/DYOvS3jr5RaJYwKkBHS+0
5pBUGW6PANT6yoDGOGLaq7hJLdeAwW+qLSfFSxBOnjBrtBV4Pqj1kbzCKFBGgazF
UPhWOSRms8erkr4ltGtUPDJxna16uoTZaYkjn7fZ/3iTqVgnSC/sOJM9KpA1kFrg
5R1OdTzymu7OwH7cmPSn0Yyg1BlU3K8EYFRFfhKptcNzuwERIAdcY39QnQARAQAB
tChTVVNFIFBhY2thZ2UgU2lnbmluZyBLZXkgPGJ1aWxkQHN1c2UuZGU+iQI+BBMB
AgAoBQJjyUgcAhsDBQkHhM4ABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3
Twm8P6HWzozMD/9xq1D3I+YWyrKJJRhyX8O1x3oYwayo1Si8VaqHUHMx5vL4VGub
cCGieg6+9cwbGVVqh4f0wozrrllTgwXuepzivvwlQnZ/cfdjYwV961MTl2/+0JD3
Hv39ef78DSU7iq8Pa22MPbXiliRvm3YJEsBnPRxDnGdGKDvLXlwugmHwHQXUTUvm
XpipD19xgJ+FUKxbsHudiFBHAfvzmvckn2wsz6pIasAH8PoWFyyoYbGbffDBx17v
YHhkZODadeD9N5lyo/mNkjFjTgHSTDYuhsor2AkSe4ptyY6EWONGg8ezqLLqJgWj
KcI3o0dOf1dpIIubkbrnshul/tT5DHQrKqqPDu6zuloKOSdKBWwh2zDPGYVGmii6
E/YKw8+lgTBs4Xuz4IxPhD/mSjLrADjuObhZhwQuM71SkQlScX4NhEeWoWfBg1k2
2V7zU6lGodEx5QtmeMe3yhMsTUBn9ls9VR+Zr6N1rhcubDwDu5JLbbUyNBOiqDc9
yQbIOD9bBG+XTxzs2VsAFkKWuW8opSJIDQ1LDg9pKF10IjrSyb+ln4OuRwQK5LHy
mGllHiz1Feivf6//Tb63qgd3k8HtwdjeK5YuXM1LwnisIhfZuhKWm2gdzKCvdGsn
Y0bH1r5E/rCFhRii/iyCxZN/2KIg/dHo8BXoh5zvzJ1XZ/bgiDnWSkQvdA==
=umXA
-----END PGP PUBLIC KEY BLOCK-----
```
4. Import the key from the file `repo-signing-key-sle-15.txt`.
```bash
sudo rpm --import repo-signing-key-sle-15.txt
```
5. Verify if the key is imported.
```bash
sudo rpm -q gpg-pubkey
```
```output
gpg-pubkey-39db7c82-66c5d91a
gpg-pubkey-50a3dd1c-50f35137
gpg-pubkey-3fa1d6ce-63c9481c
```
6. Initiate migration.

```bash
sudo zypper migration -v
```
```output
.
.                                                                                         
All repositories have been refreshed.
Installed products:
  SLES/15.3/x86_64          
  sle-module-containers/15.3/x86_64 
  sle-module-legacy/15.3/x86_64 
  sle-module-public-cloud/15.3/x86_64 
  sle-module-web-scripting/15.3/x86_64 
  sle-module-basesystem/15.3/x86_64 
  sle-module-server-applications/15.3/x86_64 
  sle-module-desktop-applications/15.3/x86_64 
  sle-module-development-tools/15.3/x86_64 

Available migrations:

    1 | SUSE Linux Enterprise Server 15 SP6 x86_64
        Basesystem Module 15 SP6 x86_64
        Containers Module 15 SP6 x86_64
        Desktop Applications Module 15 SP6 x86_64
        Server Applications Module 15 SP6 x86_64
        Development Tools Module 15 SP6 x86_64
        Legacy Module 15 SP6 x86_64
        Public Cloud Module 15 SP6 x86_64
        Web and Scripting Module 15 SP6 x86_64
       
    2 | SUSE Linux Enterprise Server 15 SP5 x86_64
        Basesystem Module 15 SP5 x86_64
        Containers Module 15 SP5 x86_64
        Desktop Applications Module 15 SP5 x86_64
        Server Applications Module 15 SP5 x86_64
        Development Tools Module 15 SP5 x86_64
        Legacy Module 15 SP5 x86_64
        Public Cloud Module 15 SP5 x86_64
        Web and Scripting Module 15 SP5 x86_64
       
    3 | SUSE Linux Enterprise Server 15 SP4 x86_64
        Basesystem Module 15 SP4 x86_64
        Containers Module 15 SP4 x86_64
        Desktop Applications Module 15 SP4 x86_64
        Server Applications Module 15 SP4 x86_64
        Development Tools Module 15 SP4 x86_64
        Legacy Module 15 SP4 x86_64
        Public Cloud Module 15 SP4 x86_64
        Web and Scripting Module 15 SP4 x86_64
       

[num/q]: 1
Upgrading product SUSE Linux Enterprise Server 15 SP6 x86_64.
Removing service SUSE_Linux_Enterprise_Server_x86_64.
Adding service SUSE_Linux_Enterprise_Server_x86_64.
Upgrading product Basesystem Module 15 SP6 x86_64.
Removing service Basesystem_Module_x86_64.
Adding service Basesystem_Module_x86_64.
Upgrading product Containers Module 15 SP6 x86_64.
Removing service Containers_Module_x86_64.
Adding service Containers_Module_x86_64.
Upgrading product Desktop Applications Module 15 SP6 x86_64.
Removing service Desktop_Applications_Module_x86_64.
Adding service Desktop_Applications_Module_x86_64.
Upgrading product Server Applications Module 15 SP6 x86_64.
Removing service Server_Applications_Module_x86_64.
Adding service Server_Applications_Module_x86_64.
Upgrading product Development Tools Module 15 SP6 x86_64.
Removing service Development_Tools_Module_x86_64.
Adding service Development_Tools_Module_x86_64.
Upgrading product Legacy Module 15 SP6 x86_64.
Removing service Legacy_Module_x86_64.
Adding service Legacy_Module_x86_64.
Upgrading product Public Cloud Module 15 SP6 x86_64.
Removing service Public_Cloud_Module_x86_64.
Adding service Public_Cloud_Module_x86_64.
Upgrading product Web and Scripting Module 15 SP6 x86_64.
Removing service Web_and_Scripting_Module_x86_64.
Adding service Web_and_Scripting_Module_x86_64.

Executing 'zypper --releasever 15.6 ref -f'

Warning: Enforced setting: $releasever=15.6
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Basesystem15-SP6-Pool' metadata ..................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Basesystem15-SP6-Pool' cache .......................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Basesystem15-SP6-Updates' metadata ...............................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Basesystem15-SP6-Updates' cache ....................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Containers15-SP6-Pool' metadata ..................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Containers15-SP6-Pool' cache .......................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Containers15-SP6-Updates' metadata ...............................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Containers15-SP6-Updates' cache ....................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Desktop-Applications15-SP6-Pool' metadata ........................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Desktop-Applications15-SP6-Pool' cache .............................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Desktop-Applications15-SP6-Updates' metadata .....................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Desktop-Applications15-SP6-Updates' cache ..........................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-DevTools15-SP6-Pool' metadata ....................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-DevTools15-SP6-Pool' cache .........................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-DevTools15-SP6-Updates' metadata .................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-DevTools15-SP6-Updates' cache ......................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Legacy15-SP6-Pool' metadata ......................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Legacy15-SP6-Pool' cache ...........................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Legacy15-SP6-Updates' metadata ...................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Legacy15-SP6-Updates' cache ........................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Public-Cloud15-SP6-Pool' metadata ................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Public-Cloud15-SP6-Pool' cache .....................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Public-Cloud15-SP6-Updates' metadata .............................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Public-Cloud15-SP6-Updates' cache ..................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Product-SLES15-SP6-Pool' metadata .......................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Product-SLES15-SP6-Pool' cache ............................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Product-SLES15-SP6-Updates' metadata ....................................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Product-SLES15-SP6-Updates' cache .........................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Server-Applications15-SP6-Pool' metadata .........................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Server-Applications15-SP6-Pool' cache ..............................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Server-Applications15-SP6-Updates' metadata ......................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Server-Applications15-SP6-Updates' cache ...........................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Web-Scripting15-SP6-Pool' metadata ...............................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Web-Scripting15-SP6-Pool' cache ....................................................................................................[done]
Forcing raw metadata refresh
Retrieving repository 'SLE-Module-Web-Scripting15-SP6-Updates' metadata ............................................................................................[done]
Forcing building of repository cache
Building repository 'SLE-Module-Web-Scripting15-SP6-Updates' cache .................................................................................................[done]
All repositories have been refreshed.

Executing 'zypper --releasever 15.6 --verbose  --no-refresh  dist-upgrade --no-allow-vendor-change '

Autorefresh disabled.
Verbosity: 2
Warning: Enforced setting: $releasever=15.6
Initializing Target
Loading repository data...
Reading installed packages...
Warning: You are about to do a distribution upgrade with all enabled repositories. Make sure these repositories are compatible before you continue. See 'man zypper' for more information about this command.
Computing distribution upgrade...
Force resolution: No
Computing upgrade...

Problem: nothing provides 'python311-isodate >= 0.6.0' needed by the to be installed python311-msrest-0.7.1-150400.14.3.1.noarch
 Solution 1: deinstallation of python3-vsts-cd-manager-1.0.2-150200.7.3.2.noarch
 Solution 2: keep obsolete python3-vsts-cd-manager-1.0.2-150200.7.3.2.noarch
 Solution 3: break python311-msrest-0.7.1-150400.14.3.1.noarch by ignoring some of its dependencies

Choose from above solutions by number or cancel [1/2/3/c/d/?] (c): 1
Applying solution 1
Resolving dependencies...
Computing distribution upgrade...
Force resolution: No
Computing upgrade...

The following 9 items are locked and will not be changed by any action:
 Available:
  plymouth plymouth-branding-SLE plymouth-devel plymouth-dracut plymouth-lang plymouth-plugin-label plymouth-plugin-label-ft plymouth-plugin-script plymouth-scripts

The following 674 packages are going to be upgraded:
.
.
The following 2 packages require a system reboot:
  kernel-azure    6.4.0-150600.8.37.1
  kernel-default  6.4.0-150600.23.50.1

674 packages to upgrade, 167 new, 40 to remove.
Overall download size: 1.14 GiB. Already cached: 0 B. After the operation, additional 218.8 MiB will be used.

    Note: System reboot required.
Continue? [y/n/v/...? shows all options] (y): y
.
.
.
.
File /usr/lib64/python3.6/zipapp.py
  from install of
     python3-base-3.6.15-150300.10.84.1.x86_64 (SLE-Module-Basesystem15-SP6-Updates)
  conflicts with file from package
     python36-base-3.6.15-73.1.x86_64 (@System)

File /usr/lib64/python3.6/zipfile.py
  from install of
     python3-base-3.6.15-150300.10.84.1.x86_64 (SLE-Module-Basesystem15-SP6-Updates)
  conflicts with file from package
     python36-base-3.6.15-73.1.x86_64 (@System)

File /usr/share/man/man1/python3.6.1.gz
  from install of
     python3-base-3.6.15-150300.10.84.1.x86_64 (SLE-Module-Basesystem15-SP6-Updates)
  conflicts with file from package
     python36-base-3.6.15-73.1.x86_64 (@System)


File conflicts happen when two packages attempt to install files with the same name but different contents. If you continue, conflicting files will be replaced losing the previous content.

Continue? [yes/no] (no): yes

(  1/865) Removing atk-lang-2.34.1-1.56.noarch .....................................................................................................................[done]
(  2/865) Installing: hicolor-icon-theme-0.17-150600.19.2.noarch ...................................................................................................[done]
.
.
dracut[I]: Module 'tpm2-tss' will not be installed, because command 'tpm2' could not be found!
dracut[I]: Module 'nvmf' will not be installed, because command 'nvme' could not be found!
dracut[I]: Module 'nvmf' will not be installed, because command 'jq' could not be found!
dracut[I]: Module 'biosdevname' will not be installed, because command 'biosdevname' could not be found!
dracut[I]: Module 'memstrack' will not be installed, because command 'memstrack' could not be found!
dracut[I]: memstrack is not available
dracut[I]: If you need to use rd.memdebug>=4, please install memstrack and procps-ng
dracut[I]: Module 'squash' will not be installed, because command 'mksquashfs' could not be found!
dracut[I]: Module 'squash' will not be installed, because command 'unsquashfs' could not be found!
dracut[I]: Module 'systemd-pcrphase' will not be installed, because command '/usr/lib/systemd/systemd-pcrphase' could not be found!
dracut[I]: Module 'systemd-portabled' will not be installed, because command 'portablectl' could not be found!
dracut[I]: Module 'systemd-portabled' will not be installed, because command '/usr/lib/systemd/systemd-portabled' could not be found!
dracut[I]: Module 'systemd-repart' will not be installed, because command 'systemd-repart' could not be found!
dracut[I]: Module 'systemd-resolved' will not be installed, because command 'resolvectl' could not be found!
dracut[I]: Module 'systemd-resolved' will not be installed, because command '/usr/lib/systemd/systemd-resolved' could not be found!
dracut[I]: Module 'dbus-broker' will not be installed, because command 'dbus-broker' could not be found!
dracut[I]: Module 'rngd' will not be installed, because command 'rngd' could not be found!
dracut[I]: Module 'connman' will not be installed, because command 'connmand' could not be found!
dracut[I]: Module 'connman' will not be installed, because command 'connmanctl' could not be found!
dracut[I]: Module 'connman' will not be installed, because command 'connmand-wait-online' could not be found!
dracut[I]: Module 'network-manager' will not be installed, because command 'NetworkManager' could not be found!
dracut[I]: 62bluetooth: Could not find any command of '/usr/lib/bluetooth/bluetoothd /usr/libexec/bluetooth/bluetoothd'!
dracut[I]: Module 'btrfs' will not be installed, because command 'btrfs' could not be found!
dracut[I]: Module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut[I]: Module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut[I]: Module 'pcsc' will not be installed, because command 'pcscd' could not be found!
dracut[I]: Module 'tpm2-tss' will not be installed, because command 'tpm2' could not be found!
dracut[I]: Module 'nvmf' will not be installed, because command 'nvme' could not be found!
dracut[I]: Module 'nvmf' will not be installed, because command 'jq' could not be found!
dracut[I]: Module 'memstrack' will not be installed, because command 'memstrack' could not be found!
dracut[I]: memstrack is not available
dracut[I]: If you need to use rd.memdebug>=4, please install memstrack and procps-ng
dracut[I]: Module 'squash' will not be installed, because command 'mksquashfs' could not be found!
dracut[I]: Module 'squash' will not be installed, because command 'unsquashfs' could not be found!
dracut[I]: *** Including module: systemd ***
dracut[I]: *** Including module: systemd-initrd ***
dracut[I]: *** Including module: i18n ***
dracut[I]: No KEYMAP configured.
dracut[I]: *** Including module: kernel-modules ***
dracut[I]: *** Including module: kernel-modules-extra ***
dracut[I]: *** Including module: rootfs-block ***
dracut[I]: *** Including module: suse-xfs ***
dracut[I]: *** Including module: terminfo ***
dracut[I]: *** Including module: udev-rules ***
dracut[I]: *** Including module: dracut-systemd ***
dracut[I]: *** Including module: haveged ***
dracut[I]: *** Including module: usrmount ***
dracut[I]: *** Including module: base ***
dracut[I]: *** Including module: fs-lib ***
dracut[I]: *** Including module: shutdown ***
dracut[I]: *** Including module: suse ***
dracut[I]: *** Including module: suse-initrd ***
dracut[I]: *** Including modules done ***
dracut[I]: *** Installing kernel module dependencies ***
dracut[I]: *** Installing kernel module dependencies done ***
dracut[I]: *** Resolving executable dependencies ***
dracut[I]: *** Resolving executable dependencies done ***
dracut[I]: *** Hardlinking files ***
dracut[I]: *** Hardlinking files done ***
dracut[I]: *** Generating early-microcode cpio image ***
dracut[I]: *** Store current command line parameters ***
dracut[I]: Stored kernel commandline:
dracut[I]:  root=UUID=c7fd69e7-8a33-4bd4-8672-90af686abb4d rootfstype=xfs rootflags=rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota
dracut[I]: *** Stripping files ***
dracut[I]: *** Stripping files done ***
dracut[I]: *** Creating image file '/boot/initrd-6.4.0-150600.8.37-azure' ***
dracut[I]: *** Creating initramfs image file '/boot/initrd-6.4.0-150600.8.37-azure' done ***
renamed '/etc/modprobe.d/10-unsupported-modules.conf.rpmsave' -> '/etc/modprobe.d/10-unsupported-modules.conf'
Executing %posttrans scripts .......................................................................................................................................[done]
CommitResult  (total 865, done 865, error 0, skipped 0, updateMessages 0)
Checking for running processes using deleted libraries...
There are running programs which still use files and libraries deleted or updated by recent upgrades. They should be restarted to benefit from the latest updates. Run 'zypper ps -s' to list these programs.
 
Since the last system boot core libraries or services have been updated.
Reboot is suggested to ensure that your system benefits from these updates.
```
7. Verify successful execution of migration.
```bash
sudo echo $?
```
```output
0
```
8. Reboot the VM.
```bash
sudo reboot
```
After reboot, the VM will be successfully migrated to SLES 15 SP6.



## Next steps

If your issue isn't resolved, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot). When you submit your request, attach a copy of the `/var/log/distromigration.log` file for troubleshooting.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
