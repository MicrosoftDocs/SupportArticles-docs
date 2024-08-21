---
title: Time zone settings are incorrect or missing for multiple mailboxes in Microsoft 365
description: Describes an issue in which time zone settings are incorrect or missing on multiple mailboxes in Microsoft 365. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# Time zone settings are incorrect or missing for multiple mailboxes in Microsoft 365

## Symptoms

Multiple mailboxes in Microsoft 365 may have incorrect or missing time zone settings. This symptom applies to all kinds of mailboxes, such as user mailboxes, resource mailboxes, and equipment mailboxes.

## Resolution

To resolve this issue, bulk change the time zone info for mailboxes in Microsoft 365. To do this, follow these steps:

1. [Connect to Exchange Online by using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following Windows PowerShell commands:

    ```powershell
    $users = Get-Mailbox -ResultSize unlimited -Filter{(RecipientTypeDetails -eq <RoomMailbox>)}
    
    $users | %{Set-MailboxRegionalConfiguration $_.Identity -TimeZone <Pacific Standard Time>}
    ```

    > [!NOTE]
    >
    > - You can replace "RoomMailbox" with another valid Exchange recipient type, such as "UserMailbox" or "EquipmentMailbox."
    > - Replace "Pacific Standard Time" with the time zone that's appropriate for you.

## Reference

For more information, see [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration) for more information.
