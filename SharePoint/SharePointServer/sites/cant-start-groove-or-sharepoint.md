---
title: Error when starting Groove or SharePoint Workspace
description: Discusses the conditions that will cause you to receive the message Error opening binary file store database when you try to start Groove or Sharepoint Workspace.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: fselkirk
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Workspace 2010
ms.date: 12/17/2023
---

# Error message when you try to start Groove or SharePoint Workspace: "Error opening binary file store database"

## Symptoms

When you try to start Microsoft SharePoint Workspace 2010, Microsoft Office Groove 2007, or an earlier version of Groove, you may receive the following error message:Error opening binary file store database. 

## Cause

This issue occurs when one or more of the following conditions are true: 

- The binary file store is locked because you are trying to run more than one instance of groove.exe through multiple terminal services sessions.   
- The binary file store is locked because the previous Groove shutdown was not completed.    
- You are logged on as a user who does not have permissions to write to the file or to the directory that contains the binary file store.   

**Note** This error occurs in SharePoint Workspace 2010 only if you are a member of a 2007 Groove workspace or a workspace of an earlier version. 

## Resolution

To resolve this issue, use one or more of the following methods, as appropriate for your situation:

- If you are trying to run Groove or SharePoint Workspace through multiple terminal services sessions, exit Groove in one session before you try to start Groove in another session.   
- If the previous Groove shutdown was not completed, follow these steps:
  1. Press CTRL+ALT+DELETE and then click **Task Manager**.   
  2. Click the **Processes** tab. If you find any instances of the Groove.exe process, select each one, and then click
 **End Process**.    
  3. Start Groove again.   
   
- If you do not have permissions to write to the file or to the directory, follow these steps:
  1. Locate the directory that contains the Groovebinaryfilestore.xss file.   
  2. Right-click the directory, click **Properties**, and then click the **Security** tab.   
  3.  In the top pane, select your user account. The lower pane will display your permissions in the directory. You must have
 **Write** permissions to this directory to use Groove from this user account.

## More Information

The binary file store refers to the Groovebinaryfilestore.xss file and folder. This file and this folder are located in the permanent subdirectory of the Groove system data directory. The default location of this directory depends on the version of Groove and on the version of Windows that you are using as in the following examples:

- Groove 2007 on a Windows Vista-based computer

   C:\Users\ username\AppData\Local\Microsoft\Office\Groove\System   
- Groove 2007 on a Windows XP-based computer

  C:\Documents and Settings\username\Local Settings\Application Data\Microsoft\OFFICE\Groove\System   
- Groove Workspace or Groove Virtual Office on a Windows XP-based computer

  C:\Documents and Settings\All Users\Application Data\Groove Networks\Groove\Permanent   

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
