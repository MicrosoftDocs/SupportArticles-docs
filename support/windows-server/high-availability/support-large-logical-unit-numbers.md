---
title: Adding support for more than eight LUNs in Windows Server
description: Describes the support for a large number of logical unit numbers (LUNs) in Windows Server products.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: stevemat, keithpe, kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Adding support for more than eight LUNs in Windows Server

This article describes the support for a large number of logical unit numbers (LUNs) in Windows Server products.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](../performance/windows-registry-advanced-users.md).

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 310072

## Summary

This article describes the support for a large number of logical unit numbers (LUNs) in Windows Server products. When you configure a server with more than eight LUNs, the hardware vendor must be involved in the planning and configuration. There may be several different ways to achieve the configuration you want; the hardware vendor is best equipped to supply the necessary information. This article isn't meant to be all-inclusive because of the various implementations that a hardware vendor can use. Contact your hardware manufacturer to determine if and how your hardware can support more than eight LUNs.

Windows Server 2008 and Windows Server 2008 R2 support up to:

- Eight buses per adapter
- 128 target IDs per bus
- 255 LUNs per target ID

Windows Server 2012 and later versions of Windows support up to:  

- 255 buses per adapter
- 128 target IDs per bus
- 255 LUNs per target ID

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

### Terminology used in this article

- Host Bus Adapter (HBA): This is the controller that is connected to the storage device. It may be a SCSI or Fibre controller because both topologies can support more than eight LUNs.
- Storage device: This is the controller in the array to which the HBA attaches. This is the device that controls the drives.
- Large LUN: This is a commonly used term for the practice of supporting more than eight LUNs.

Windows Server supports Large LUNs, but the method for enabling it depends on the hardware implementation and drivers. If the storage device reports the HiSupport bit in its standard inquiry data, Windows automatically enables Large LUNs without requiring any manual registry entries. Contact the hardware vendor to determine if the storage device reports the HiSupport bit. The hardware drivers may also enable large LUN support during their installation routines.

If the hardware doesn't report the HiSupport bit, or the drivers don't enable Large LUN support, a manual registry entry is required. This feature works only if the storage devices support the SCSI REPORT LUNS command. Note that editing the registry to enable Large LUNs requires detailed knowledge of the devices' hardware IDs and registry entries; this is the least-preferred method. Contact the hardware vendor for additional information. Follow these steps to configure the required registry entry:

1. Find the hardware ID of the storage device. To find the hardware ID:
    1. Start Regedit.exe, and then locate and click the following location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\SCSI`
    2. Disk and storage devices that are enumerated by the system are listed. The storage device on which you want to enable LargeLUNs should appear in the list starting with Disk&Ven_. The name of the storage device should be recognizable after the Disk&Ven_ text.
    3. To find the hardware ID for the proper storage device, open the different Disk&Ven_ keys to display the different instances of the storage devices. A value labeled FriendlyName with a description to the right appears under each of the instances.
    4. After you locate the storage device, double-click hardwareID for one of the instance names. This is typically listed under the FriendlyName value.
    5. The value data lists the hardware ID of the storage device. Often, several hardware IDs are listed. Copy only one of these hardware IDs. Make sure to copy only the portion of the value after "SCSI\\" to the Clipboard.

    > [!NOTE]
    > There may be several hardware IDs for the same device. This occurs because the device may be detected in different ways for different firmware revisions of the same device. You may have to try each of the different hardware IDs in the following steps. If you have any problems with this, contact your storage device hardware manufacturer.
2. With the hardware ID from the previous steps, follow the next steps to enable Large LUN support for the appropriate storage device:
    1. Locate and click the following key in the registry: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ScsiPort\SpecialTargetList`

    2. On the **Edit** menu, point to **New**, and then click **Key**.
    3. A new key named **New Key #1** is created. Right-click **New Key #1**, and then click **Paste** to paste the hardware ID that you copied earlier.

        > [!NOTE]
        > Right-clicking **New Key #1** also displays a Rename command that you can use to attempt to paste the data again if New Key #1 is not in the proper state.
    4. After you create the new key, create a new DWORD value named LargeLuns with a value of 1.

        > [!NOTE]
        > "LargeLuns" is plural.
3. Reboot the computer.

### Issues involved in manually enabling Large LUN support

Duplicate disks may appear after you enable Large LUN support. This can occur if the HBA driver enables Large LUN support in a proprietary fashion coupled with the manual registry entry. The issue occurs if both the Windows LargeLuns feature and the HBA's LargeLuns feature are enabled.

If logical unit 0 isn't present, the REPORT LUNS  command can't be sent to the target device. Windows enumerates only eight logical units, even if more units are present in the disk array. To support large configurations, the time that is necessary to determine the size configuration needed to be minimized. Because the number of logical units can be as high as 255 on some systems (0 - 254), lots of time can be spent in sending inquiry commands to non-existent logical units. Notice that any LUN number returned from Storage should be in range of 0 - 254.

Any LUN with a LUN number larger than 254 will not be recognized by the Windows operating system. Consult your hardware manufacturer about the different parameters that should be used with your particular hardware.

Even though Windows can access Large LUNs, there may be other environment variables that need to be taken into consideration.

### Additional parameters for the SpecialTargetList key

For Windows Server, there are several additional parameters that you can use under the SpecialTargetList key. They are:

- SparseLun - Allow for discontinuous LUN list.
- OneLun - Only scan LUN zero.
- LargeLuns - The device supports more than seven LUNs.
- SetLunInCdb - The device requires the LUN in CDBs sent to it.
- NonStandardVPD - The device supports VPD 0x83 but not 0x80.
- BinarySN - The device returns a binary serial number.

These keys are checked in the order in which they're listed; the information at each level is logically "OR'ed" with that from the previous level.
