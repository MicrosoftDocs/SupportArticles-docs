---
title: Unlocking an encrypted disk for offline repair in Linux | Microsoft Docs
description: This article describes how to access a os disk of the azure disk encrypted problematic vm
services: virtual-machines
documentationcenter: ''
author: radawn
manager: 
editor: ''
tags: virtual-machines
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 02/19/2021
ms.author: radawn

---

# Unlocking an encrypted disk for offline repair in Linux

In Azure, there are disks attached to compute resources like virtual machine, virtual machine scale sets etc. Encryption can be applied to the disk which is attached resources like virtual machine, this is known as azure disk encryption. 

To understand more about azure disk encryption see 

https://docs.microsoft.com/en-us/azure/security/fundamentals/azure-disk-encryption-vms-vmss

## Azure Disk Encryption in Linux

In Azure, disk encryption is also supported for Microsoft endorsed Linux VMs. 
There are few basic requirements to enable Azure disk encryption in Linux VMs like :
-  Azure Key Vault
-	CLI or Powershell cmdlets
-	Device-Mapper DM Crypt
-	Key encryption Key.

For more information to understand the how Azure linux disk encryption works,  see 
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/disk-encryption-overview.

**DM Crypt**

Device-mapper is infrastructure in the linux kernel that provides a generic way to create virtual layers of block devices.
Device-mapper crypt target provides transparent encryption of block devices using the kernel crypto API.
To gather more information about the functioning of DM-Crypt , please refer 
https://gitlab.com/cryptsetup/cryptsetup/-/wikis/DMCrypt

## When do we require offline troubleshooting

In Azure, the **Serial Console** in the Azure portal provides access to a text-based console for virtual machines (VMs) and virtual machine scale set instances running either Linux or Windows. Please refer , https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/serial-console-overview

If a Linux VM is not accessible through SSH connection, the troubleshooting is generally done leveraging serial console , which is known as online troubleshooting.

However, if the access to the virtual machine by serial console is not possible, then we typically try to troubleshoot using offline method by deploying a troubleshooting virtual machine which is referred to repair or rescue VM.

For more information, visit https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/troubleshoot-vm-by-use-nested-virtualization.

## Automate unlocking disk in offline troubleshooting

For Single pass encrypted VMs you can use the az vm repair command from CLI, it will take a copy of the broken OS disk and create a rescue VM based on Ubuntu, attach the broken OS as a data drive and mount the partitions or LVM structures on /rescueroot so you can chroot and proceed with any fix needed.

you can use the below command to automate unlocking the ADE encrypted disk:

```
az vm repair create --name ORIGINALVM --resource-group ORIGINALRG --repair-password PASSWORD --repair-username USERNAME --repair-vm-name NAMEFORRESCUEVM --unlock-encrypted-vm --verbose --debug
```

More information about the use of az vm repair can be found here: https://docs.microsoft.com/cli/azure/ext/vm-repair/vm/repair?view=azure-cli-latest 

However there are certains limitations while creating a automated rescue VM and unlocking the encrypted disk:

- A new resource group will be created.
- Public IP address will be attached to the rescue VM.
- Ubuntu VM image will be deployed as a rescue VM.

If there are any challenges in executing the above command , then we have to proceed with unlocking the disk manually.

## Unlocking encrypted disk manually

If we want to proceed with the offline troubleshooting of a Azure linux VM we will require creation of a new repair Linux VM (of any distro , preferably ubuntu) and attach the captured disk made out of the snapshot of the OS disk of the problematic Azure linux VM as a data disk.
Post that if we SSH into the repair VM and try to mount the disk for accessing its contents to troubleshoot we fail to do so.

## Symptoms

Upon trying to mount the disk we fail and might get an error if it is encrypted using azure disk encryption. Let us assume you try to mount the attached data disk partition /dev/sdc2 to a directory /investigateroot. 

You might get an error like below:
```
root@rescuevm:/# mount /dev/sdc2 /investigateroot
mount: /investigateroot: wrong fs type, bad option, bad superblock on /dev/sdc2.
```
## Cause

The problematic OS disk which is attached to a repair VM is encrypted with Azure disk encryption and is not accessible because we need to unlock it prior accessing its contents. 
Also the BEK (bitlocker encryption key) volume for the original VM is not present in the repair Linux VM to fetch the azure disk encryption keys to unlock the disk.

## Solution

To resolve the issue we need to unlock (not decrypt) the attached data disk before proceeding with accessing its contents.
**Unlocking** refers to temporarily making the disk available for accessing the contents inside it , without removal of the entire disk encryption.
**Decryption** refers to complete removal of disk encryption on a disk.

We need to follow the steps below in order to create a rescue/repair VM to unlock the encrypted disk.


## Step 1 : Creation of OS Disk snapshot 

To do this , we need to first create the affected OS disk snapshot keeping the region and resource group same as the problematic VM.
 
![image](https://user-images.githubusercontent.com/91187108/135804588-20460036-e35f-4753-8cae-b324c0c86aac.png)

## Step 2 : Creation of new disk 

we need to create the new OS disk from snapshot keeping the region and resource group same as the problematic VM.

![image](https://user-images.githubusercontent.com/91187108/135804769-8ec26d65-e030-4dcf-9ca1-4bc3e91c7139.png)

## Step 3 : Creation of a new linux rescue VM  

Create a new Linux Ubuntu VM , and attach the newly created disk in the disk section as shown below:

![image](https://user-images.githubusercontent.com/91187108/135804895-35b1014d-0937-44d2-9f31-6f53feca587c.png)

***Note :*** *If we fail to attach it while creation of the repair VM and try to attach it as data disk after the repair VM is created , then the BEK volume of the original VM won’t be pulled inside the Guest OS of repair VM.*

## Step 4 : Create /investigateroot , /investigateboot and /key directory

Try  to ssh into the linux VM and create three directories /investigateroot, /investigateboot and /key under the root(/) directory.

These directories are created for us to mount the corresponding contents of the attached data disk directories to them , to recognize the mount points of relevant partitions of data disk required for troubleshooting.

For instance , we will attach the boot partition of the data disk to **/investigateboot** directory.
Likewise, we will attach the root partition of data disk to **/investigateroot** directory
and we will attach the Bek volume of the data disk to the **/key** directory.

## Step 5 : Mount the corresponding partitions under the corresponding directories made

We need to identify the boot partition and the Bek volume and mount it to the created directories as mentioned above.

To identify which is the boot partition run the below command: 

```lsblk```

Below is an example of the output.

```
root@rescuevm:/# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   30G  0 disk
├─sda1    8:1    0 29.9G  0 part /
├─sda14   8:14   0    4M  0 part
└─sda15   8:15   0  106M  0 part /boot/efi
sdb       8:16   0   48M  0 disk
└─sdb1    8:17   0   46M  0 part /key
sdc       8:32   0  128G  0 disk
├─sdc1    8:33   0  500M  0 part 
├─sdc2    8:34   0   63G  0 part  
├─sdc14   8:46   0    4M  0 part
└─sdc15   8:47   0  495M  0 part
sdd       8:48   0   16G  0 disk
└─sdd1    8:49   0   16G  0 part /mnt
sr0      11:0    1 1024M  0 rom 
```

as soon as the output is received we identify the data disk by either or both the below ways:
-	Compare the size of the datadisk in the output with the size in azure portal.
-	Check for which disk there are 3-4 partitions and none of the partitions are mounted in any directory.

The partition which will be around 500Mb in data disk will be the boot partition  , try mounting each of them.

Use the below command to mount the boot partition.

```mount /dev/sdc1 /investigateboot```

```
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   30G  0 disk
├─sda1    8:1    0 29.9G  0 part /
├─sda14   8:14   0    4M  0 part
└─sda15   8:15   0  106M  0 part /boot/efi
sdb       8:16   0   48M  0 disk
└─sdb1    8:17   0   46M  0 part /key
sdc       8:32   0  128G  0 disk
├─sdc1    8:33   0  500M  0 part /investigateboot
├─sdc2    8:34   0   63G  0 part
├─sdc14   8:46   0    4M  0 part
└─sdc15   8:47   0  495M  0 part
sdd       8:48   0   16G  0 disk
└─sdd1    8:49   0   16G  0 part /mnt
sr0      11:0    1 1024M  0 rom
```

The boot partition will be successfully mounted as the boot partition of the OS disk of any Linux VM is not encrypted by Azure Disk encryption.

Use the below command to identify which is the BEK volume

```lsblk -f```

below is the output of the same:

```
root@rescuevm:/# lsblk -f
NAME    FSTYPE LABEL           UUID                                 MOUNTPOINT
sda
├─sda1  ext4   cloudimg-rootfs 7f90b43a-ea0f-4eb8-81e4-84fb3d78ec61 /
├─sda14
└─sda15 vfat   UEFI            CC90-492E                            /boot/efi
sdb
└─sdb1  vfat   BEK VOLUME      8A41-2068                            
sdc
├─sdc1  xfs                    5974c5bb-8ba8-4b5e-970e-0d95e5408b8a /investigateboot
├─sdc2
├─sdc14
└─sdc15 vfat                   7EA0-299D
sdd
└─sdd1  ext4                   524af93c-3eb5-49c1-9920-1ee479c43750 /mnt
sr0
```

here we see that **sdb1** is the BEK volume.

Proceed with mounting the partition on the /key directory made in earlier steps with the below command:

```mount /dev/sdb1 /key```

once we have both the partitions mounted to **/investigateboot** and **/key** we can proceed with the next step of unlocking the disk , below is the command to reconfirm the same:

```
root@rescuevm:/# lsblk -f
NAME    FSTYPE LABEL           UUID                                 MOUNTPOINT
sda
├─sda1  ext4   cloudimg-rootfs 7f90b43a-ea0f-4eb8-81e4-84fb3d78ec61 /
├─sda14
└─sda15 vfat   UEFI            CC90-492E                            /boot/efi
sdb
└─sdb1  vfat   BEK VOLUME      8A41-2068                            /key
sdc
├─sdc1  xfs                    5974c5bb-8ba8-4b5e-970e-0d95e5408b8a /investigateboot
├─sdc2
├─sdc14
└─sdc15 vfat                   7EA0-299D
sdd
└─sdd1  ext4                   524af93c-3eb5-49c1-9920-1ee479c43750 /mnt
sr0
```

## Step 6 : Unlock the encrypted data disk 

Check that there are at least 1 **LinuxPassPhraseFileName** on /key before you continue, if the drive is there but it is empty then you need to check the encryption settings on the disk, Keyvaul, Key, Secret permissions, etc.There could be multiple LinuxPassPhraseFileName if there are more than one disk in the VM which are encrypted.
Verify that **/investigateboot/luks/osluksheader** exists, you need this file in order to open the encrypted layer of the disk.

Open the encrypted layer of the disk by using cryptsetup luksOpen , use the below command for the same:

``` cryptsetup luksOpen --key-file /key/LinuxPassPhraseFileName --header /investigateboot/luks/osluksheader /dev/sdc2 osencrypt ```

This command will unlock the encrypted disk.Below is the output of lsblk command :
```
root@rescuevm:/# lsblk
NAME                MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                   8:0    0   30G  0 disk
├─sda1                8:1    0 29.9G  0 part  /
├─sda14               8:14   0    4M  0 part
└─sda15               8:15   0  106M  0 part  /boot/efi
sdb                   8:16   0   48M  0 disk
└─sdb1                8:17   0   46M  0 part  /key
sdc                   8:32   0  128G  0 disk
├─sdc1                8:33   0  500M  0 part  /investigateboot
├─sdc2                8:34   0   63G  0 part
│ └─osencrypt       253:0    0   63G  0 crypt
│   ├─rootvg-tmplv  253:1    0    2G  0 lvm
│   ├─rootvg-usrlv  253:2    0   10G  0 lvm
│   ├─rootvg-homelv 253:3    0    1G  0 lvm
│   ├─rootvg-varlv  253:4    0    8G  0 lvm
│   └─rootvg-rootlv 253:5    0    2G  0 lvm   
├─sdc14               8:46   0    4M  0 part
└─sdc15               8:47   0  495M  0 part
sdd                   8:48   0   16G  0 disk
└─sdd1                8:49   0   16G  0 part  /mnt
sr0                  11:0    1 1024M  0 rom
```

***Note:*** *Once root disk is unlocked and mounted boot can be unmounted and mounted on /investigateroot/boot*

## Step 7: Mount the unlocked disk 

Post unlocking the disk we will be able to mount the disk with the below command if it is a Red Hat Linux VM.
``` mount /dev/rootvg/rootlv /investigateroot ```
```
root@rescuevm:/# lsblk
NAME                MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                   8:0    0   30G  0 disk
├─sda1                8:1    0 29.9G  0 part  /
├─sda14               8:14   0    4M  0 part
└─sda15               8:15   0  106M  0 part  /boot/efi
sdb                   8:16   0   48M  0 disk
└─sdb1                8:17   0   46M  0 part  /key
sdc                   8:32   0  128G  0 disk
├─sdc1                8:33   0  500M  0 part  /investigateboot
├─sdc2                8:34   0   63G  0 part
│ └─osencrypt       253:0    0   63G  0 crypt
│   ├─rootvg-tmplv  253:1    0    2G  0 lvm
│   ├─rootvg-usrlv  253:2    0   10G  0 lvm
│   ├─rootvg-homelv 253:3    0    1G  0 lvm
│   ├─rootvg-varlv  253:4    0    8G  0 lvm
│   └─rootvg-rootlv 253:5    0    2G  0 lvm   /investigateroot
├─sdc14               8:46   0    4M  0 part
└─sdc15               8:47   0  495M  0 part
sdd                   8:48   0   16G  0 disk
└─sdd1                8:49   0   16G  0 part  /mnt
sr0                  11:0    1 1024M  0 rom
```

## Step 8: Access the disk for troubleshooting 

Now the root partition which was previously inaccessible ( because of being locked)  can be accessed.
```
root@rescuevm:/# cd /investigateroot
root@rescuevm:/investigateroot# ls
1    boot  etc   lib    media  myrepo  proc  run   srv  tmp  var
bin  dev   home  lib64  mnt    opt     root  sbin  sys  usr
```

# Next steps 

To further troubleshoot the "Linux ADE disk unlock issue" contact https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade

