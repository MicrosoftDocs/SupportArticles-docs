---
title: 0x0000007B Stop error after replacing or switching to an alternate iSCSI boot adapter
description: Describes an issue where you receive a STOP 0X0000007B error when you switch to an alternate iSCSI boot adapter on a Windows Server 2008 R2-based or Windows 7-based computer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# 0x0000007B Stop error after replacing or switching to an alternate iSCSI boot adapter on a Windows Server 2008 R2-based or Windows 7-based computer

This article describes an issue where you receive a STOP 0X0000007B error when you switch to an alternate iSCSI boot adapter on a Windows Server 2008 R2-based or Windows 7-based computer.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2507616

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows Server 2008 R2 or Windows 7.
- The computer is configured to boot from an iSCSI disk.
- The computer has an alternate iSCSI adapter that is configured for booting.
- You boot the computer from the alternate iSCSI adapter.

In this scenario, you may receive the following stop error message:

> STOP 0X0000007B ( parameter1, parameter2, parameter3, parameter4 )
>
> INACCESSIBLE_BOOT_DEVICE

> [!NOTE]
>
> - The four parameters in this stop error message may vary, depending on the configuration of the computer.
> - Not all "0x0000007B" stop error messages are caused by this problem.

## Cause

In Windows Server 2008 R2 and Windows 7, a new NDIS Light Weight Filter (LWF) driver was introduced, called "WFP Lightweight Filter". When Windows is installed from media to a local disk, this filter is bound to all network adapters by default. Alternatively, when Windows is installed from media directly to an iSCSI disk, Windows setup ensures that the LWF driver doesn't get bound to the network adapter used for iSCSI boot. If there are any alternate iSCSI boot adapters (as in a fail-over environment) present in the machine, the LWF driver will get bound to these adapters.

The NDIS LWF driver is not a boot-start driver or is it compatible with paging I/O. When the NDIS LWF is bound to an iSCSI boot adapter, Windows may fail to boot and display the stop error 0x0000007B (INACCESSIBLE_BOOT_DEVICE).

## Resolution

You can recover a non-bootable system with the following steps.

1. Boot from the Windows installation media.
2. At the first screen, select 'Next'.
3. At the next screen, select 'Repair your computer'.
4. At the 'System Recovery Options' screen, ensure the correct operating system is highlighted and select 'Next'.
5. At the 'Choose a recovery tool' screen, select 'Command Prompt'.
6. At the command prompt, type `regedit` and press enter.
7. From the registry editor, highlight HKEY_LOCAL_MACHINE, then from the 'File' menu select 'Load Hive'.
8. From the 'Load Hive' dialog, browse to the following directory on the drive where Windows is installed: %windir%\system32\config
9. Select the file named SYSTEM and click 'Open'.
10. Provide a key name of your choice (for example, temp).
11. Navigate to the following registry location in the hive that was loaded in step 10.

    `HKEY_LOCAL_MACHINE\<name from step 10>\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{B70D6460-3635-4D42-B866-B8AB1A24454C}\Ndi`

12. Double-click the FilterRunType value in the right-hand pane, and change the value to 2.
13. Highlight the registry hive loaded in step 10, and then from the 'File' menu select 'Unload Hive'.
14. Close registry editor and restart the machine.

Once Windows is booted, open the registry editor again and change the FilterRunType value, from step 11 above, back to a value of 1. Before rebooting, ensure that the NDIS LWF is unbound from all iSCSI booted adapters as described in the resolution section of [KB976042](https://support.microsoft.com/help/976042).
