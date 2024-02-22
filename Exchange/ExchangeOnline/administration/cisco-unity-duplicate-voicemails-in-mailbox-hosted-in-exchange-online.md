---
title: Cisco Unity duplicate voicemails in mailbox
description: Mailboxes hosted in Exchange Online may receive Cisco Unity duplicate voicemails if the VoiceMessages search folder is configured to use content indexing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: logonzal, v-six
appliesto: 
  - MSfC O365-Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Cisco Unity duplicate voicemails appear if VoiceMessages search folder uses content indexing

_Original KB number:_ &nbsp; 4486630

## Symptoms

Assume that your mailbox is hosted in Microsoft Exchange Online. If the **VoiceMessages** search folder is configured to use content indexing, you may receive duplicate voice messages from Cisco Unity.

## Resolution

Microsoft implemented a fix to prevent this issue. However, if an existing mailbox is still affected, you can connect to Exchange Online PowerShell to run a move request on the mailbox and resolve this issue. To do this, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true).

2. Run the following cmdlet:

    ```powershell
    New-MoveRequest -Identity <MailboxOrMailUserIdParameter>
    ```

   The following example uses a user alias of *tony* in the Contoso domain:

    ```powershell
    New-MoveRequest -Identitytony@contoso.com
    ```
