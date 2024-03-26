---
title: Document file in Office Document Cache not deleted
description: Describes an issue on a computer that is running a 64-bit version of Windows in which Office 2010 document files in the Office Document Cache are not deleted when you run the Windows Disk Cleanup utility.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: 
  - CSSTroubleshoot
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: debbiery, jenl
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Document files in the Office Document Cache are not deleted when you run the Windows Disk Cleanup utility on a computer that is running a 64-bit version of Windows

## Symptoms

Consider the following scenario:

- You have a 32-bit version of Microsoft Office installed on a computer that is running a 64-bit version of Windows.   
- You try to clean up the Office temporary files from the Office Document Cache when you run the Windows Disk Cleanup utility to free up disk space.   

In this scenario, the Office temporary files are not deleted.

## Cause

This issue occurs because the 32-bit version of the Disk Cleanup Wizard Handler for the Office Document Cache does not run on a 64-bit version of Windows. The 32-bit version of Office 2010 does not install a 64-bit version of the Disk Cleanup Wizard Handler.

## Workaround

To work around this issue, manually delete the cached files. To do this, follow these steps:

1. Click **Start**, click **All Programs**, click **Microsoft Office**, click **Microsoft Office 2010 Tools**, and then click **Microsoft Office 2010 Upload Center**.   
2. In Upload Center, click **Settings**.   
3. Under **Cached Settings**, click **Delete cached files**.   
4. When you are prompted, click **Delete cached information**.   

## More Information

The Disk Cleanup Wizard Handler for the Office Document Cache is available in the Windows Disk Cleanup utility. This handler enables the Windows Disk Cleanup utility to delete files from the Office Document Cache that are not pending upload in order to free up disk space.

To enable the Disk Cleanup Wizard Handler for the Office Document Cache, follow these steps:

1. Start the Disk Cleanup Wizard. To do this, click **Start**, click **All Programs**, click **Accessories**, click **System Tools**, and then click **Disk Cleanup**.   
2. Select the drive that you want to clean up, and then click **OK**.   
3. Under **Files to delete**, click to select the **Microsoft Office Temporary Files** check box.   
