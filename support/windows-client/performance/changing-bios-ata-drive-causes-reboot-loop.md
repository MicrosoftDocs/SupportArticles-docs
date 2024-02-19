---
title: Changing ATA drive setting causes reboot loop
description: Help fix the reboot loop issue that occurs when you change the ATA drive setting in System Bios.
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
# Changing the ATA Drive setting in System Bios causes reboot loop

This article provides a solution to a reboot loop issue that's caused by changing the ATA Drive setting.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2751461

## Symptoms

Consider the following scenario:  

- The BIOS setting for the drive is set to ATA Mode.  
- Install or upgrade the system to Windows 8.
- You boot into the BIOS and changed the ATA setting from ATA Mode to AHCI Mode pressed enter to accept the change.
- You click Yes to the Warning about the detected mode change on the embedded ATA controller.
- You restart the computer and boot normally.
In this scenario, during the system boot when Windows tries to start, you will receive an error with regards to a system failure. The system will be stuck in a reboot loop.

## Cause

This is due to changes in Windows 8 PnP in which Boot Start Drivers are not installed by default.

## Resolution

In order to correct this issue, please walk through the following steps:  

1. Power down or restart the computer and enter the system BIOS.
2. Change the ATA Drive setting back to ATA Mode, press enter to accept the change and restart the computer.
3. Click Yes to the Warning about the detected mode change on the embedded ATA controller.
4. The system will boot normally to the Modern App Start Menu.
    > [!NOTE]
    > Be sure you know the Local Admin account and password and are able to boot successfully before proceeding.
5. Open an elevated command prompt and run the following command to enable SafeMode boot:
bcdedit /set {current} safeboot minimal
6. Restart the computer and boot to the system BIOS.
7. Change the ATA Drive setting from ATA Mode to AHCI Mode, press enter to accept the change.
8. Click Yes to the Warning about the detected mode change on the embedded ATA controller.
9. The system will boot normally to the Modern App Start Menu in SafeMode.
10. Open an elevated command prompt and run the following command to remove the SafeMode boot option:

    ```console
    bcdedit /deletevalue {current} safeboot
    ```

11. Restart the computer and boot normally, the system will boot successfully to the Modern App Start Menu.

## More information

For additional information on Windows 7 in a similar scenario, please see the following KB.

Error message when you start a Windows 7 or Windows Vista-based computer after you change the SATA mode of the boot drive: "STOP 0x0000007B INACCESSABLE_BOOT_DEVICE"[https://support.microsoft.com/kb/922976](https://support.microsoft.com/help/922976)
