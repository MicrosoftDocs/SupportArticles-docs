---
title: Office 2016 for Mac 64-bit upgrade
description: Discusses the conversion of Office 2016 for Mac to 64-bit in the August 2016 release.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: lauraho
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel for Microsoft 365 for Mac 
  - OneNote for Microsoft 365 for Mac 
  - Outlook for Microsoft 365 for Mac
  - PowerPoint for Microsoft 365 for Mac 
  - Word for Microsoft 365 for Mac
ms.date: 06/06/2024
---
# Office 2016 for Mac 64-bit upgrade

## Summary

Existing Office 2016 for Mac customers will be seamlessly upgraded to 64-bit versions of Word, Excel, PowerPoint, Outlook, and OneNote as part of the August product release (version 15.25). This affects customers of all license types: Retail, Microsoft 365 for home, Microsoft 365 for business, and Volume License installations.

## Deployment options for the 64-bit update 

### AutoUpdate (MAU)

Customers who use Microsoft AutoUpdate (MAU) to keep their Office applications up-to-date will see a "regular" monthly update notification when their selected channel is upgraded to 64-bit builds. Depending on which version is installed on the local computer, MAU will offer either a delta or full update. The update package size does not change between 32-bit and 64-bit versions. Also, MAU can deliver a delta update when applicable to update a user from 32-bit to 64-bit applications. Therefore, customers won't experience a sharp increase in download activity. For the release to the Production channel, customers will see "(64-bit)" in the update title to make them aware that this is a 64-bit update.

For information about how to use the MAU, see [Check for Office for Mac updates automatically](https://support.office.com/article/check-for-office-for-mac-updates-automatically-bfd1e497-c24d-4754-92ab-910a4074d7c1?ui=en-us&rs=en-us&ad=us).

:::image type="content" source="media/office-2016-for-mac-64-bit-upgrade/check-update.png" alt-text="Screenshot to use Microsoft AutoUpdate to keep the Office applications up-to-date.":::

### Manual updates

The August release of Office for Mac is available for manual download. The following file provides a 64-bit package to replace existing 32-bit applications with 64-bit variants during installation:

 :::image type="icon" source="media/office-2016-for-mac-64-bit-upgrade/download-icon.png":::
[Download the Microsoft Office 2016 for Mac August update package now](https://go.microsoft.com/fwlink/?linkid=525133).

Virus-scan claim

Microsoft scanned this file for viruses, using the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to it.

### Volume License Service Center

Volume License customers typically get their Office 2016 software from the Volume License Service Center (VLSC). These builds are refreshed infrequently and are typically aligned with new language editions. The VLSC will continue to offer 32-bit installers (15.23) until November 2016. However, all updater packages that are released after August will be based on 64-bit builds. Therefore, a VLSC customer who updates either manually or through AutoUpdate will be transitioned to 64-bit builds.

## More Information

### 64-bit only

The Mac operating system has been 64-bit for several years. Unlike for Windows, there's no choice between running a 32-bit or 64-bit version of the Mac operating system. Similarly, we won't offer a choice between 32-bit and 64-bit versions of Office 2016 for Mac. After each "channel" is transitioned per the rollout schedule, only 64-bit builds will be available.

### Effect on third-party applications and add-ins

The transition to 64-bit Office for Mac was announced in April 2016. IT Pros will want to understand which compiled add-ins are deployed to the users whom they manage so that they can assess the effect of the upgrade. The following Microsoft Office website summarizes the issues that affect the more common add-ins that are used together with Office 2016 for Mac:

[What to try if you can't install or activate Office for Mac](https://support.office.com/article/error-messages-after-updating-to-office-for-mac-64-bit-b62d842c-b099-434f-af65-96cb03c03242)

### Tools for inspecting product architecture

To verify the architecture of an Office application (that is, to understand whether you have a 32-bit or 64-bit build), start the application, open the Activity Monitor, and then enable the **Kind** column.

:::image type="content" source="media/office-2016-for-mac-64-bit-upgrade/activity-monitor.png" alt-text="Screenshot to enable the Kind column in the Activity Monitor window.":::

You can also use the file command in a terminal session to inspect the binary. For this use, type file -N <_path of binary_>.
This method can be used with for any binary file, including third-party add-ins.

:::image type="content" source="media/office-2016-for-mac-64-bit-upgrade/file-command.png" alt-text="Screenshot to use the file command in a terminal session to inspect the binary.":::

The file command returns one of three values.

|Return value|Meaning|
|---|---|
|Mach-O 64-bit executable x86_64|64-bit binary|
|Mach-O executable i386|32-bit binary|
|Mach-O 64-bit executable x86_64 |FAT binary (compatible with both 32-bit and 64-bit processes)|
Mach-O executable i386|FAT binary (compatible with both 32-bit and 64-bit processes)|

### Options for reverting to 32-bit installations

There may be situations in which the customer has to change code that's not 64-bit ready. If customers can't immediately move forward to 64-bit builds, we will make available a one-time 32-bit update for the 15.25 release in addition to the default 64-bit updates. The 32-bit updates will be available only for manual download from the Office CDN.

The latest 32-bit release of Office 2016 for Mac (15.25.160818) can be downloaded from [https://go.microsoft.com/fwlink/?LinkId=823192](https://go.microsoft.com/fwlink/?linkid=823192).

Customers who manually install the 32-bit release won't be offered the 64-bit version of 15.25 through MAU. However, MAU will offer the 64-bit version of 15.26 in September 2016. Therefore, customers have a limited time to remain on 32-bit builds.

If a customer has already upgraded to the 64-bit update of Office for Mac 15.25 and wants to revert to the 32-bit version, follow these steps:

1. Exit all open Office 2016 applications.   
2. Start Safari, and then browse to [https://go.microsoft.com/fwlink/?LinkId=823192](https://go.microsoft.com/fwlink/?linkid=823192) to start the download of the 32-bit installer.   
3. Double-click the downloaded package, and then follow the instructions.   

The 64-bit installation has a build date of 160817. The 32-bit version has a build date of 160818.
