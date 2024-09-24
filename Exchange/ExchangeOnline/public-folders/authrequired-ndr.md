---
title: 5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired NDR in Microsoft 365
description: Describes an issue that triggers a 5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired nondelivery report when external users try to send mail to mail-enabled public folders in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Error when external users send mail to mail-enabled public folders

_Original KB number:_&nbsp;2984402

## Problem

When external users try to send email messages to mail-enabled public folders in Microsoft 365, they receive a nondelivery report (NDR) that contains the following error code:

> Remote Server returned '\<xxxxxxxx> #5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired; authentication required [Stage: CreateMessage]>'

## Cause

By default, mail-enabled public folders are prevented from accepting mail from external senders. This behavior is by design and is intended to help protect mail-enabled public folders.

## Solution

To change the behavior so that mail-enabled public folders can accept mail from external senders, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, see [Connect to Exchange Online using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Add permission for the Anonymous account to public folders. To do this, run the following command:

    ```powershell
    Add-PublicFolderClientPermission -identity <Public Folder> -User Anonymous -AccessRights CreateItems
    ```

    For example, run the following command:

    ```powershell
    Add-PublicFolderClientPermission -identity "\SpecificFolder" -User Anonymous -AccessRights CreateItems
    ```

## More information

For more information about mail-enabled public folders and Microsoft 365, see [Mail-enable or mail-disable a public folder](/exchange/collaboration-exo/public-folders/enable-or-disable-mail-for-public-folder).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
