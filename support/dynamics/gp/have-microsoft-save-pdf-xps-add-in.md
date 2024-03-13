---
title: Have Microsoft Save as PDF or XPS add-in
description: Provides a solution to an error that occurs when you try to send a SOP Invoice via email in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You must have the Microsoft Save as PDF or XPS add-in for 2007 Microsoft Office

This article provides a solution to an error that occurs when you try to send a SOP Invoice via email in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2424823

## Symptom

When trying to send a SOP Invoice via email in Microsoft Dynamics GP, the user is getting the following message:

> "You must have the Microsoft Save as PDF or XPS add-in for 2007 Microsoft Office to send documents."

## Cause

Various causes, but typically, the install of Microsoft Office wasn't complete.  

## Resolution

Review the below to troubleshoot this issue:

- Run a **Repair** for Microsoft Office
- Uninstall/reinstall Microsoft Office
- Make sure the user has Admin rights to the %temp% folder.
- Text boxes inserted on the template. For more information, see [Word Templates - When emailing documents as PDF, a save as window opens and email fails](https://community.dynamics.com/blogs/post/?postid=720a8a45-c2f5-4eda-af83-6a0ef8d08618).
- Go to **Administration | Setup | Company | E-mail Settings**, and select all the File Formats. (Mark DOCX, HTML, PDF, and XPS.)  If you select a different format, does it work?
- If you switch to the canned version of the report, does it email?
- Make sure the dll version of the Word Add-In is up to date for Office 2007.  (Go to the **AddIns** folder in the Dynamics GP code folder and view *Microsoft.Dynamics.GPBusinessIntelligence.TemplateProcessing.dll* and *Microsoft.Dynamics.GP.BusinessIntelligence.Office.dll*)
- Go to `C:\\Windows\assembly` and make sure the Microsoft.Office.Interop.Word.dll file is installed.  For more information, see ["You must have the Microsoft Save as PDF or XPS Add-in for 2007 Microsoft Office installed to send documents."](https://community.dynamics.com/blogs/post/?postid=72eb5136-5f92-4abd-ba43-6dd9a0cb3eaf).
- A field may exist on the Word template that isn't in Report Writer.
- Install all Microsoft Office updates
- The dynamics.dic may be damaged. Reinstall Dynamics GP.
