﻿---
title: SharePoint files open as read-only 
author: todmccoy
ms.author: warrenr
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
- SPO160
audience: ITPro
ms.topic: article
ms.service: sharepoint-online
ms.custom: 
- CSSTroubleshoot
- CI 113561
ms.prod: sharepoint
appliesto:
- Microsoft SharePoint
- OneDrive for Business
- SharePoint Online
description: Describes how to resolve an issue where a SharePoint file checked out from an online or local folder opens as read only.
---
# SharePoint files open as read-only 

## Symptoms

At times, you may find that when you open files from SharePoint or OneDrive for Business they open in read-only mode. 

## Cause

There are several reasons why a file may open as read only:

- Antivirus programs may open potentially unsafe files as read-only. Check with your antivirus provider to learn how to adjust these settings. BitDefender, for example, has content on adding application exclusions here: [How to add application or process exclusions in Bitdefender Control Center](https://www.bitdefender.com/support/how-to-add-application-or-process-exclusions-in-bitdefender-control-center-1119.html).
- If you have libraries with **Checkout**, **Required**, or **Validation** columns or metadata, or when **Draft Item Security** is set to either **Only users who can edit** or **Only uses who can approve items** in Version Settings of the library, these items will be synchronized as read-only. For more information, see the section "[Libraries with specific columns or metadata](https://support.office.com/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa?ui=en-US&rs=en-001&ad=US#librariesspecificcolumns)" in the document Invalid file names and file types in OneDrive, OneDrive for Business, and SharePoint.
- An Office document opens in Protected View even though you enable the "Open Office documents as read/write while browsing" policy setting. For more information, see [An Office document opens in Protected View even though you enable the "Open Office documents as read/write while browsing" policy setting](https://support.microsoft.com/help/983047/an-office-document-opens-in-protected-view-even-though-you-enable-the).


## Resolution

To resolve this issue, one of the following methods may help:

- Instead of selecting the document title, select **Open Menu** (the three dots), and then select **Edit**.
- If the file is stored on OneDrive and your OneDrive storage space is full, you will be unable to save the document until your storage space is below your allowance. Check your free space on OneDrive by selecting the OneDrive icon in the notification center and choosing **Manage storage**, or go to http://onedrive.live.com, sign in, and note the amount of used space in the lower-left corner of the screen.
- If Office is not activated, or if your subscription has expired, you might be in read-only **Reduced Functionality Mode**. For information on how to Activate Office, see [Unlicensed Product and activation errors in Office](https://support.office.com/article/unlicensed-product-and-activation-errors-in-office-0d23d3c0-c19c-4b2f-9845-5344fedc4380).
- Right-click the file and choose **Properties**. If the Read-only attribute is checked, uncheck it and select **OK**.<br/>
![Uncheck the read-only box. ](media/files-open-as-read-only/files-open-as-read-only.jpg)

### Other methods to try
- Restart your computer.
- [Check that all Office updates are installed](https://support.office.com/article/Update-Office-with-Microsoft-Update-f59d3f9d-bd5d-4d3b-a08e-1dd659cf5282).
- [Perform an Online repair of Office](https://support.office.com/Article/Repair-an-Office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
