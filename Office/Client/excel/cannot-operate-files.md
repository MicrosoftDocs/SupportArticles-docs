---
title: Microsoft 365 users cannot open or synchronize SharePoint files
description: Discusses that Microsoft 365 users cannot open or synchronize files that are stored on a SharePoint server. This issue occurs after the Office 2013 update for March 12, 2013 (KB2768349) is installed. Provides a resolution and a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: scotlanw
appliesto: 
  - Office Professional Plus 2013
  - SharePoint Online
  - OneDrive for Business
ms.date: 03/31/2022
---

# Microsoft 365 users cannot open or synchronize SharePoint files after the Office 2013: March 12, 2013 update is installed

## Symptoms

Microsoft 365 users may be unable to open, edit, or synchronize files if the following conditions are true: 

- The user tries to open, edit, or synchronize files by using the Office 2013 rich client.   
- The files are stored on a server that is running SharePoint.   
- The Office 2013 update for March 12, 2013 is installed.   
In this scenario, users may be prompted for credentials multiple times.

## Cause

This issue occurs because of a problem in the Office 2013 update for March 12, 2013.

**Note** To verify the file versions, and to determine whether this issue applies to your situation, see the "How to determine whether the update is installed" section in the following article in the Microsoft Knowledge Base:

[2768349 ](https://support.microsoft.com/help/2768349) Description of the Office 2013 update: March 12, 2013

## Resolution

To resolve this issue, use the appropriate method.

### MSI installation: Uninstall the Office update for March 12, 2013

To uninstall the Office update for March 12, 2013, follow these steps:

1. Open **Control Panel**.   
2. Click **Programs and Features**.   
3. Click **View installed updates**.   
4. Click **Microsoft Office update KB2768349**, and then click **Uninstall**.  

### Click-to-Run (C2R) installation: Run an online repair

To run an online repair, follow these steps:

1. Open **Control Panel**.   
2. Click **Programs and Features**.   
3. Click **Microsoft Office 2013**.   
4. Click **Change**, click **Online Repair**, and then click **Repair**.   

## Workaround

To work around this issue, use one of the following methods.

### Method 1: Use Office Online

Use Office Online instead of the Office 2013 rich client.

### Method 2: Download the file

Download the file from Microsoft SharePoint Online to your computer. Open the file, make the changes that you want, and then save the file to your computer. Then upload the file to the SharePoint server to replace any earlier versions of the file.

## Status

We are aware of this issue, and we are working to resolve it. This article will be updated when a solution is available.

## References

For more information about Office Online, visit the following Microsoft website:

[Office Online](https://office.microsoft.com/online)

## More Information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
