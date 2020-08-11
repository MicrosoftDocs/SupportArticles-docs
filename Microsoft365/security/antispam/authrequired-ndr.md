---
title: 5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired NDR in Office 365
description: Describes an issue that triggers a "5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired" nondelivery report when external users try to send mail to mail-enabled public folders in Office 365.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
---

# "5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired" nondelivery report when external users try to send mail to mail-enabled public folders in Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;2984402

## Problem

When external users try to send email messages to mail-enabled public folders in Office 365, they receive a nondelivery report (NDR) that contains the following error code:

> Remote Server returned '\<xxxxxxxx> #5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired; authentication required [Stage: CreateMessage]>'

## Cause

By default, mail-enabled public folders are prevented from accepting mail from external senders. This behavior is by design and is intended to help protect mail-enabled public folders.

## Solution

To change the behavior so that mail-enabled public folders can accept mail from external senders, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, see [Connect to Exchange Online using remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.150%29.aspx).
2. Add permission for the Anonymous account to public folders. To do this, run the following command:

    ```powershell
    Add-PublicFolderClientPermission -identity <Public Folder> -User Anonymous -AccessRights CreateItems
    ```

    For example, run the following command:

    ```powershell
    Add-PublicFolderClientPermission -identity "\SpecificFolder" -User Anonymous -AccessRights CreateItems
    ```

## More information

For more information about mail-enabled public folders and Office 365, see [Mail-enable or mail-disable a public folder](https://technet.microsoft.com/library/aa997560%28v=exchg.150%29.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
