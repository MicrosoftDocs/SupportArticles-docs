---
title: (We can't display your message right now) in Outlook Web App
description: Describes an issue that occurs when a user tries to read a message that was encrypted by Office 365 Message Encryption. Provides a solution.
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

# Error (We can't display your message right now) in Outlook Web App when an Exchange Online user views an encrypted message

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;2971787

## Problem

When a Microsoft Exchange Online user tries to read a message that was encrypted by Microsoft Office 365 Message Encryption in Microsoft Outlook Web App, the user receives the following error message:
We can't display your message right now.
This issue occurs even if the user can send encrypted messages from Outlook Web App.

## Cause

This problem occurs because the MIME types that are associated with the default Outlook Web App policy changed so that the text/html MIME type was removed or changed.

## Solution

To resolve this problem, reset the MIME types that are associated with the default Outlook Web App policy to the default values. To do this, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online Using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.150%29.aspx).
2. Run the following commands:

    ```powershell
    $owapolicy = Get-OwaMailboxPolicy
    ```

    ```powershell
    $owapolicy.AllowedMimeTypes.Remove("text/html")
    ```

    ```powershell
    Set-OwaMailboxPolicy -AllowedMimeTypes $owapolicy.AllowedMimeTypes -Identity $owapolicy.Identity
    ```

    > [!NOTE]
    > It may take as long as 30 minutes for the changes to take effect.

## More information

For more information about Outlook Web App mailbox policies, go to [Outlook Web App Mailbox Policy Procedures](https://technet.microsoft.com/library/jj674295%28v=exchg.150%29.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
