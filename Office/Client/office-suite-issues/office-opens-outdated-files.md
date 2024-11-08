---
title: Microsoft 365 apps open files from SharePoint on-premises that aren’t the current version
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 06/06/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Server
  - Microsoft 365
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Web Server Integration (SharePoint & Non-SharePoint)
  - Open
  - CI 144436
  - CSSTroubleshoot
ms.reviewer: sharepoint_triage
description: When you open a Word or PowerPoint file from SharePoint on-premises in a Microsoft 365 desktop app, you see the local cached file instead of the current server document contents.
---

# Microsoft 365 apps open files from SharePoint on-premises that aren’t the current version

## Symptoms
When you open a Word or PowerPoint file from SharePoint on-premises in a Microsoft 365 desktop app, you see the local cached file instead of the current server document contents. An **Updates Available** button appears in the middle of the status bar at the bottom of the app window.

## Cause
This behavior is by design. The AutoSave feature isn't available in SharePoint on-premises. Therefore, the app doesn't merge the changes from the SharePoint server until you select **Updates Available**.

## Workaround

If you want Office to open the current file on the server every time, you can turn off AutoSave.

> [!IMPORTANT]
> If you turn AutoSave off, and then you open files from SharePoint Online, real-time co-authoring will not work. To enable real-time co-authoring, you must manually turn on AutoSave.

### Turn off AutoSave on an individual computer

1. Select Start, enter *regedit*, and then select **Registry Editor** from the search results.
2. Navigate to the following subkey:

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\word`
3. Right-click the subkey, select **New**, and then select **DWORD (32-bit value)**.
4. Name the value *:::no-loc text="autosavebydefaultadminchoice":::*.
5. Right-click the new value, select **Modify**, and then set the **Value data** to **2**.
6. Navigate to the following subkey:

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\powerpoint`
7. Repeat steps 3-5 to create the new DWORD value for this subkey.

### Turn off AutoSave for all users by IT administrators 
For IT administrators who want to turn off AutoSave for all users by using Group Policy, create the DWORD value **autosavebydefaultadminchoice** in the following registry hives, and set its **Hexadecimal value** to **2**:

- `HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\word`
- `HKEY_CURRENT_USER\software\policies\microsoft\office\160\powerpoint`
