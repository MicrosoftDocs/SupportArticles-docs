---
title: Microsoft 365 users can't open or view attachments in Outlook on the web
description: Describes an issue in which Outlook on the web attachments can't be viewed or opened in Microsoft 365. Provides a resolution and a workaround.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Microsoft 365 users can't open or view attachments in Outlook on the web

## Problem

When Microsoft 365 users try to open or view attachments in email messages in Outlook on the web, they experience the following symptoms:

- in Microsoft 365, the attachment isn't displayed in the message. Instead, a generic placeholder, such as "1 Attachment" is displayed, and this can't be opened.
- When users try to view attachments in Microsoft 365, they receive the following error message:   Access to attachments has been blocked. Blocked attachments: \<FileName>.
  
## Cause

This issue occurs if the attachment is blocked by Outlook on the web. By default, Outlook on the web blocks attachments that have the following file name extensions:

`.ade`, `.adp`, `.apk`, `.app`, `.appcontent-ms`, `.application`, `.appref-ms`, `.appx`, `.asp`, `.aspx`, `.asx`, `.bas`, `.bat`, `.bgi`, `.cab`, `.cdxml`, `.cer`, `.chm`, `.cmd`, `.cnt`, `.com`, `.cpl`, `.crt`, `.csh`, `.der`, `.diagcab`, `.exe`, `.fxp`, `.gadget`, `.grp`, `.hlp`, `.hpj`, `.hta`, `.htc`, `.img`, `.inf`, `.ins`, `.iso`, `.isp`, `.its`, `.jar`, `.jnlp`, `.js`, `.jse`, `.ksh`, `.lnk`, `.mad`, `.maf`, `.mag`, `.mam`, `.maq`, `.mar`, `.mas`, `.mat`, `.mau`, `.mav`, `.maw`, `.mcf`, `.mda`, `.mdb`, `.mde`, `.mdt`, `.mdw`, `.mdz`, `.mht`, `.mhtml`, `.msc`, `.msh`, `.msh1`, `.msh2`, `.mshxml`, `.msh1xml`, `.msh2xml`, `.msi`, `.msp`, `.mst`, `.msu`, `.ops`, `.osd`, `.pcd`, `.pif`, `.pl`, `.plg`, `.prf`, `.prg`, `.printerexport`, `.ps1`, `.ps1xml`, `.ps2`, `.ps2xml`, `.psc1`, `.psc2`, `.psd1`, `.psdm1`, `.pssc`, `.pst`, `.py`, `.pyc`, `.pyo`, `.pyw`, `.pyz`, `.pyzw`, `.reg`, `.scf`, `.scr`, `.sct`, `.settingcontent-ms`, `.shb`, `.shs`, `.theme`, `.tmp`, `.udl`, `.url`, `.vb`, `.vbe`, `.vbp`, `.vbs`, `.vhd`, `.vhdx`, `.vsmacros`, `.vsw`, `.webpnp`, `.website`, `.ws`, `.wsb`, `.wsc`, `.wsf`, `.wsh`, `.xbap`, `.xll`, `.xnk`

## Resolution

Change the Outlook on the web mailbox policy to include and exclude the file types that you want.

The following is an example of the Windows PowerShell commands to remove the .xml file type from the BlockedFileTypes and BlockedMimeTypes lists and add it to the AllowedFileTypes and AllowedMimeTypes lists:

```powershell
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -BlockedFileTypes @{Remove = ".xml"}
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -AllowedFileTypes @{Add = ".xml"}
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -BlockedMimeTypes @{Remove = "text/xml", "application/xml"}
Get-OwaMailboxPolicy | Set-OwaMailboxPolicy –AllowedMimeTypes @{Add = "text/xml", "application/xml"}
```

Things to consider:

- It may take several minutes before changes to the Outlook on the web policy take effect.
- Be aware that by changing the Outlook on the web mailbox policy to include file types that are blocked by default, you may make your system more vulnerable to security threats.

## Workaround

Direct users to compress the files that they intend to send (for example, as a .zip file) and then send the compressed files as attachments.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
