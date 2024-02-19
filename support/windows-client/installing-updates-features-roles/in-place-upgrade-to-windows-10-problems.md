---
title: In-place upgrade to Windows 10 problem
description: Describes an issue where the upgrade hangs when you try to run an in-place upgrade to Windows 10 version 1607. This issue is resolved by installing a compatibility update.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, frankroj
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Updates fix in-place upgrade to Windows 10 problem

This article provides a solution to a problem where an in-place upgrade for Windows 10 on a system that's running Microsoft System Center Configuration Manager hangs.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4020149

## Symptoms

When you run an in-place upgrade for Windows 10 version 1607 on a system that's running Microsoft System Center Configuration Manager, the upgrade hangs. This problem occurs while the Upgrade Operating System task is running.

**Details:**

- No errors are logged in the Configuration Manager or the Windows Setup log files.
- The SMSTS.log and Setupact.log files stop logging entries.
- An indicator that a computer is encountering this problem is that Windows Setup hangs during driver inventory. This issue is identified by the following signature in the setupact.log file under `C:\$WINDOWS.~BT\Sources\Panther`:

    > date time CONX Windows::Compat::Appraiser::WicaDeviceInventory::GetInventory (324): Starting Device Inventory.  
     date time CONX Windows::Compat::Appraiser::DriverInventory::GetInventory (204): Starting Driver Inventory.

## Resolution

To fix this issue, install the update [4013420](https://support.microsoft.com/help/4013420).

Package installation of compatibility updates differs from installation of other Windows updates. To install the compatibility update, follow these steps:

1. Download the hotfix from the [Microsoft Update Catalog](https://catalog.update.microsoft.com/v7/site/Search.aspx?q=KB4013420) website to a new folder on your Windows desktop.
2. After you download the .cab file, extract its contents to a new folder.
3. Determine the source directory of your Windows 10 version 1607 installation files. You can find this in the properties of your Upgrade Operating System Package.
4. After you determine the source directory, copy the contents of the extracted .cab files into the Source folder of the Windows 10 version 1607 installation files. Click **Yes** to overwrite any existing files.
5. Update the Distribution Points for the Upgrade Operating System Package.
6. Retry the deployments and see whether the issue is corrected.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
