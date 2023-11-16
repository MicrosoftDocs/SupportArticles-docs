---
title: Stop 0x0000007B error after you use a Group Policy setting to prevent the installation of devices
description: Describes an issue that occurs when you uninstall a third-party SATA controller driver and then restart the computer
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, tjung
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.technology: windows-server-deployment
---
# "Stop 0x0000007B" error after you use a Group Policy setting to prevent the installation of devices

This article helps to fix the error "Stop 0x0000007B" after you use a Group Policy setting to prevent the installation of devices.

_Applies to:_ &nbsp; Windows Server 2008 R2, Windows 7  
_Original KB number:_ &nbsp; 2773300

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows 7 or Windows Server 2008 R2.
- You use the following Group Policy setting to restrict the installation of devices on the computer: Computer Configuration\Administrative Templates\System\Device Installation\Device Installation Restrictions  
For example, you enable one of the following Group Policy settings:
  - Prevent installation of devices that match any of these device IDs 
  - Prevent installation of devices using drivers that match these device setup classes 
  - Prevent installation of removable devices 
  - Prevent installation of devices not described by other policy settings. For more information about this Group Policy setting, see [Step-By-Step Guide to Controlling Device Installation Using Group Policy](https://msdn.microsoft.com/library/bb530324.aspx).
- You uninstall a third-party Serial ATA (SATA) controller driver and then restart the computer. Or, you run sysprep and deploy the OS image to another computer that has a different storage controller or that's running a different storage controller firmware revision.  

In this scenario, you encounter a "Stop 0x0000007B" error during restart.

## Cause

After you enable the Group Policy setting, the following registry entries are set so that access to the critical device database is prohibited and raw devices cannot be started:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\DisableCDDB` 
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\DontStartRawDevices`  
Therefore, the storage controller driver cannot be found, and you encounter the "Stop 0x0000007B" error.

## Resolution

To resolve the issue, set the following registry entries to 0:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\DisableCDDB` 
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\DontStartRawDevices`  
To do this, follow these steps:
1. Start the computer from Windows PE. To create a Window PE image, see [Walkthrough: Create a Custom Windows PE Image](https://technet.microsoft.com/library/cc709665%28v=ws.10%29.aspx).
2. Load the System registry hive for offline registry editing. The System registry hive is located in %SystemRoot%\system32\config. To do this, follow the steps in [Load or unload registry hives](https://technet.microsoft.com/library/cc732157.aspx).
3. Expand the System registry hive that you have loaded, and then click **Select**.
4. In the details pane, locate **Current**, and then note the value in the **Data** column.
5. Expand the following registry entry. (The **x** placeholder represents the value from the **Data** column that you noted in step 4.)HKEY_LOCAL_MACHINE\SYSTEM\ControlSet00 **x** \Control\PnP

6. Change the value of DisableCDDB and DontStartRawDevices to 0.
7. Unload the registry hive.
8. Restart the computer in the standard way.  
> [!NOTE]
> These steps do not delete any policy settings.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
