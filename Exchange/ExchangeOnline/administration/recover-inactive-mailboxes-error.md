---
title: Can't recover inactive mailboxes with additional shards
description: Fixes an issue in which you can't recover inactive mailboxes that have additional shards.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 166460
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: malgzetsky, lindabr 
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 9/21/2022
---
# "The mailbox has additional shards that need recovery" error when recovering inactive mailboxes

## Symptoms

You're an administrator in an organization and have sufficient permissions. When you try to [recover inactive mailboxes](/microsoft-365/compliance/recover-an-inactive-mailbox), you receive the following error message about multiple component shards:  

> The inactive mailbox '\<identity of the inactive mailbox>' cannot be recovered because the mailbox has additional shards that need recovery.
  
## Cause  

This issue occurs if the inactive mailboxes have `AuxPrimary` shards in addition to `Primary` shards.  

To see which inactive mailboxes are affected by multiple shards, you can check the mailbox location information by running the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):  
  
```powershell
Get-Mailbox -InactiveMailboxOnly | fl UserPrincipalName,MailboxLocations
```

In the following example output, the mailbox shard location type has `AuxPrimary` and `Primary`, which means the mailbox has `AuxPrimary` shards:

:::image type="content" source="media/recover-inactive-mailboxes-error/shards.png" alt-text="Screenshot of an example output in which AuxPrimary is highlighted.":::

## Resolution  

To resolve this issue, [restore the inactive mailboxes](/microsoft-365/compliance/restore-an-inactive-mailbox) instead of recovering them.  
