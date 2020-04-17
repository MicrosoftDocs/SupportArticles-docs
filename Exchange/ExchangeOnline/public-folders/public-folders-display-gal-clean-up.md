---
title: Public folders are displayed in GAL despite having been cleaned up
description: Public folders remain on the global address list (GAL) even though you have removed them. This article provides a resolution.
author: TobyTu
ms.author: Bhalchandra.Atre
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- CI 116313
- CSSTroubleshoot
ms.reviewer: Bhalchandra.Atre
appliesto:
- Exchange Online
search.appverid: 
- MET150
---

# Public folders are displayed in GAL despite having been cleaned up

## Symptoms

Public folders remain on the global address list (GAL) after removing the public folder mailboxes and the public folders.

## Cause

Mail enabled public folders were not removed properly. The mail enabled public folder (MEPF) objects may still be present.

## Resolution

1. Connect to Exchange Online PowerShell.
2. Run the following command to list mail enabled public folders:

    ```powershell
    Get-MailPublicFolder
    ```

3. Run following command to remove the mail enabled public folders:

    ```powershell
    Get-MailPublicFolder | Disable-MailPublicFolder
    ```

    > [!NOTE]
    > Make Sure the MEPF's are no longer needed before removing them.

4. Use Outlook on the web to verify if the entries were removed.

    > [!NOTE]
    > Address list changes take a while to be reflected in Outlook client .
