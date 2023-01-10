---
title: Microsoft 365 users can't open or view attachments in Outlook Web App
description: Describes an issue in which Outlook Web App attachments can't be viewed or opened in Microsoft 365. Provides a resolution and a workaround.
author: simonxjx
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 3/31/2022
---
# Microsoft 365 users can't open or view attachments in Outlook Web App

## Problem

When Microsoft 365 users try to open or view attachments in email messages in Outlook Web App, they experience the following symptoms:

- in Microsoft 365, the attachment isn't displayed in the message. Instead, a generic placeholder, such as "1 Attachment" is displayed, and this can't be opened.
- When users try to view attachments in Microsoft 365, they receive the following error message:   Access to attachments has been blocked. Blocked attachments: \<FileName>.
  
## Cause

This issue occurs if the attachment is blocked by Outlook Web App. By default, Outlook Web App blocks attachments that have the following file name extensions:

vsmacros, msh2xml, msh1xml, ps2xml, ps1xml, mshxml, gadget, mhtml, psc2, psc1, msh2,msh1, aspx, xml, wsh, wsf, wsc, vsw, vst, vss, vbs, vbe, url, tmp, shs, shb, sct,scr, scf, reg, pst, ps2, ps1, prg, prf, plg, pif, pcd, ops, mst, msp, msi, msh,msc, mht, mdz, mdw, mdt, mde, mdb, mda, maw, mav, mau, mat, mas, mar, maq, mam,mag, maf, mad, lnk, ksh, jse, its, isp, ins, inf, htc, hta, hlp, fxp, exe, der,csh, crt, cpl, com, cmd, chm, cer, bat, bas, asx, asp, app, adp, ade, ws, vb, js

## Solution

Change the Outlook Web App mailbox policy to include and exclude the file types that you want.

The following is an example of the Windows PowerShell commands to remove the .xml file type from the BlockedFileTypes and BlockedMimeTypes lists and add it to the AllowedFileTypes and AllowedMimeTypes lists:

```powershell
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -BlockedFileTypes @{Remove = ".xml"}
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -AllowedFileTypes @{Add = ".xml"}
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -BlockedMimeTypes @{Remove = "text/xml", "application/xml"}
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy –AllowedMimeTypes @{Add = "text/xml", "application/xml"}
```

Things to consider:

- It may take several minutes before changes to the Outlook Web App policy take effect.
- Be aware that by changing the Outlook Web App mailbox policy to include file types that are blocked by default, you may make your system more vulnerable to security threats.

## Workaround

Direct users to compress the files that they intend to send (for example, as a .zip file) and then send the compressed files as attachments.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
