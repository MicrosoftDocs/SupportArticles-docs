---
title: SharePoint files open as read-only
author: helenclu
ms.author: luche
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
  - SPO160
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Files and Documents\Check in
  - CSSTroubleshoot
  - CI 113561
appliesto: 
  - Microsoft SharePoint
  - OneDrive for Business
  - SharePoint Online
description: Describes how to resolve an issue where a SharePoint file checked out from an online or local folder opens as read only.
ms.date: 12/17/2023
---
# SharePoint files open as read-only

## Symptoms

At times, you may find that when you open files from SharePoint or OneDrive for Business they open in read-only mode.

## Cause

There are several reasons why a file may open as read only:

- Antivirus programs may open potentially unsafe files as read-only. Check with your antivirus provider to learn how to adjust these settings.
- If you have libraries with **Checkout Required**, or **Validation** columns or metadata, or when **Draft Item Security** is set to either **Only users who can edit** or **Only users who can approve items** in Version Settings of the library, these items will be synchronized as read-only. For more information, see [Libraries with specific columns or metadata](https://support.microsoft.com/office/restrictions-and-limitations-in-onedrive-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa#librariesspecificcolumns).
- An Office document opens in Protected View even though you enable the "Open Office documents as read/write while browsing" policy setting. For more information, see [An Office document opens in Protected View even though you enable the "Open Office documents as read/write while browsing" policy setting](https://support.microsoft.com/help/983047).

## Resolution

To resolve this issue, one of the following methods may help:

- Instead of selecting the document title, select **Open Menu** (the three dots), and then select **Edit**.
- If the file is stored on OneDrive and your OneDrive storage space is full, you will be unable to save the document until your storage space is below your allowance. Check your free space on OneDrive by selecting the OneDrive icon in the notification center and choosing **Manage storage**, or go to https://onedrive.live.com, sign in, and note the amount of used space in the lower-left corner of the screen.
- If Office is not activated, or if your subscription has expired, you might be in read-only **Reduced Functionality Mode**. For information on how to Activate Office, see [Unlicensed Product and activation errors in Office](https://support.office.com/article/unlicensed-product-and-activation-errors-in-office-0d23d3c0-c19c-4b2f-9845-5344fedc4380).
- Right-click the file and choose **Properties**. If the Read-only attribute is checked, uncheck it and select **OK**.

    :::image type="content" source="media/files-open-as-read-only/read-only-attribute.png" alt-text="Screenshot of the Properties dialog, where you can clear the read-only attribute check box.":::

### Other methods to try

- Restart your computer.
- [Check that all Office updates are installed](https://support.office.com/article/Update-Office-with-Microsoft-Update-f59d3f9d-bd5d-4d3b-a08e-1dd659cf5282).
- [Perform an Online repair of Office](https://support.office.com/Article/Repair-an-Office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
