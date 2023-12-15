---
title: Microsoft 365 users can't open or view attachments in Outlook Web App
description: Describes an issue in which Outlook Web App attachments can't be viewed or opened in Microsoft 365. Provides a resolution and a workaround.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 03/31/2022
ms.reviewer: v-six
---
# Microsoft 365 users can't open or view attachments in Outlook Web App

## Problem

When Microsoft 365 users try to open or view attachments in email messages in Outlook Web App, they experience the following symptoms:

- in Microsoft 365, the attachment isn't displayed in the message. Instead, a generic placeholder, such as "1 Attachment" is displayed, and this can't be opened.
- When users try to view attachments in Microsoft 365, they receive the following error message:   Access to attachments has been blocked. Blocked attachments: \<FileName>.
  
## Cause

This issue occurs if the attachment is blocked by Outlook Web App. By default, Outlook Web App blocks attachments that have the following file name extensions:

.settingcontent-ms .printerexport .appcontent-ms .application .appref-ms .vsmacros .website .msh2xml .msh1xml .diagcab .webpnp .ps2xml .ps1xml .mshxml .gadget .theme .psdm1 .mhtml .cdxml .xbap .vhdx.pyzw .pssc .psd1 .psc2 .psc1 .msh2 .msh1
.jnlp .aspx .appx.xnk .xll .wsh .wsf .wsc .wsb .vsw .vhd .vbs .vbp .vbe .url.udl .tmp .shs .shb .sct .scr .scf .reg .pyz .pyw .pyo .pyc .pst .ps2 .ps1 .prg .prf .plg .pif .pcd .osd .ops .msu .mst .msp .msi .msh .msc .mht .mdz .mdw .mdt .mde .mdb .mda .mcf .maw
.mav .mau .mat .mas .mar .maq .mam .mag .maf .mad .lnk .ksh .jse .jar .its .isp .iso .ins .inf .img .htc .hta .hpj .hlp .grp .fxp .exe .der .csh .crt .cpl .com .cnt .cmd .chm .cer .cab .bgi .bat .bas .asx .asp .app .apk .adp .ade .ws .vb .py.pl .js

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
