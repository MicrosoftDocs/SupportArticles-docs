---
title: Disk Event ID 154
description: Fixes event ID 154 that occurs on a computer that's connected to a storage array such as Fibre Channel (FC) storage.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: nbassett, kaushika
ms.custom: sap:data-corruption-and-disk-errors, csstroubleshoot
---
# Disk Event ID 154: The IO Operation failed due to a hardware error

This article provides a solution to fix event ID 154 that occurs on a computer that's connected to a storage array such as Fibre Channel (FC) storage.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2806730

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Symptoms

On a Windows Server 2012-based computer that is connected to a storage array such as Fibre Channel (FC) storage, the event ID 154 is logged in the system event log.

## Cause

This behavior can occur for one of the following reasons:

- The FC connection dropped a packet somewhere between the Host Bus Adapter (HBA) and the storage array.
- The array controller or a device in the array responded to an I/O request and indicated that the hardware exceeded hardware-defined time-outs in the array.

## Resolution

To resolve this issue, contact the vendor of your adapter, switch, or array to determine the cause of the dropped FC packets or hardware time-outs.

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Disk Event 154 is a new system event in Windows Server 2012 that is intended to log cases in which an FC packet may have been dropped. The intention is to make these issues more discoverable. A dropped FC frame can have a large effect on user experience, because the time that the operating system will wait for an I/O operation to finish is based on the disk.sys **TimeOutValue** value, and the operating system may seem to be frozen or to hang while it waits for the I/O operation to finish. After the time-out value is reached, the disk/class layer will retry the I/O operation eight times. (Each attempt waits the full amount of the **TimeOutValue** value).

Currently, we recommend that you set the disk.sys **TimeOutValue** value as low as possible. (We recommend that you set it to a value no greater than 20 to 30 seconds). However, as with any change, the value that you use should be evaluated in a test environment before you implement that value in production.

The value is global. Therefore, avoid very short time-out values. Otherwise, you may experience time-out errors in scenarios such as when you are waiting for a sleeping disk or DVD drive to spin up.

To set the disk.sys **TimeOutValue** value, follow these steps:

1. Start Registry Editor. To do this, click **Start**, type *regedit* in the **Start Search** box, and then press Enter.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Disk`

3. Locate **TimeOutValue**.
4. On the **Edit** menu, click **Modify**.
5. In the **Value data** box, type the desired number of seconds.
6. Exit Registry Editor.
