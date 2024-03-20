---
title: Can't connect to a specialized Debian Linux VM that is migrated from VMware to Azure
description: Works around an issue in which you can't connect to a specialized Debian Linux virtual machine that is migrated from VMware to Azure.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.custom: linux-related-content
ms.collection: linux
---
# Can't connect to a specialized Debian Linux VM that is migrated from VMware to Azure

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4056276

## Symptoms

After creating a specialized Debian 9.1 (Stretch) virtual machine (VM) and then migrate that VM from VMware to Microsoft Azure, you can't connect to the VM.

## Cause

This issue occurs because the NIC card name was listed as 'ens33p0' instead of 'eth0' on the virtual machine. In fact, 'eth0' is the default NIC card requirement per the Azure Linux network configurations settings.

## Workaround

Debian now uses "ens33" (or "ens33p0") interface names instead of "eth0." To work around this change, adjust the GRUB file, and then manually configure the " eth0" ethernet adapter as DHCP. To do this, follow these steps:  

1. Change the GRUB file to include both the Azure requirements and "eth0" requirements. To do this, run the following command:

    ```console
    GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200 earlyprintk=ttyS0,115200 rootdelay=30 net.ifnames=0 biosdevname=0"
    ```  

2. Manually update the `/etc/network/interfaces` file by removing the `ens33` entry and then adding `auto eth0` and `iface inet eth0 dhcp`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
