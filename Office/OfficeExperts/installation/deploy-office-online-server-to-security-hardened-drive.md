---
title: Deploy Microsoft Offices Online 2013 or Office Online Server to a security hardened drive
description: When you install and deploy Microsoft Offices Online 2013 to a security hardened drive, Microsoft Offices Online 2013 may not work correctly.
author: helenclu
ms.author: luche
ms.reviewer: jhaak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 06/06/2024
---

# Deploy Microsoft Offices Online 2013 or Office Online Server to a security hardened drive

This article was written by [Dan Fox](https://social.technet.microsoft.com/profile/Dan+F.+-+MSFT), Support Escalation Engineer.

## Symptoms

Permissions errors to the Windows registry and file system resources can manifest in many ways within Microsoft Offices Online.

When you install and deploy Microsoft Offices Online 2013 to a security hardened drive, Microsoft Offices Online 2013 may not work correctly if there are permissions missing from the security hardened drive, including but not limited to Microsoft Offices Online cache locations. For locations, see [Set-OfficeWebAppsFarm](/powershell/module/officewebapps/set-officewebappsfarm?view=officewebapps-ps&preserve-view=true).

The default location on most systems is the drive C, but some customers may install it to non-system drives, such as a drive D or drive E, and permissions may be stripped from those drives.

The Microsoft Offices Online 2013 or Office Online installer enables the installation path to be specified and non-system drives are valid. By default, certain configurations such as **CacheLocation** are also set to the system drive, and those can be overridden by using the **New-OfficeWebAppsFarm** or **Set-OfficeWebAppsFarm** cmdlet. The Microsoft Offices Online installation will still need to put some small files in the %PROGRAMDATA% folder, which is typical on the system drive.

## Resolution

When you deploy Microsoft Offices Online 2013 to a hard disk drive that is security hardened (permissions are removed), assign "CREATOR OWNER" and "SERVERNAME\users" with the following permissions to the installation location on the non-system drive:

:::image type="content" source="media/deploy-office-online-server-to-security-hardened-drive/programs-files-properties.png" alt-text="Screenshot of the Program Files Properties page." border="false":::

For more information, see [Deploy Office Online Server](/officeonlineserver/deploy-office-online-server).
