---
title: Shared mailbox in Exchange Online is unexpectedly disconnected
description: Provides a resolution for an issue in which a regular mailbox that was migrated to Exchange Online and then converted to a shared mailbox is unexpectedly disconnected.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: apascual, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# Shared mailbox in Exchange Online is unexpectedly disconnected

## Symptoms

In a hybrid environment, you migrate a regular mailbox from Microsoft Exchange Server to Exchange Online, and then convert the regular mailbox in Exchange Online to a shared mailbox. The shared mailbox in Exchange Online is unlicensed and doesn't have a hold applied. However, sometime after the conversion, the shared mailbox in Exchange Online becomes disconnected.

## Cause

This issue occurs because the mailbox type in Exchange Online no longer matches the mailbox type of the on-premises remote mailbox. Because the direction of synchronization is from on-premises to Exchange Online, the mismatch in the mailbox type can cause Exchange Online to later revert the shared mailbox to a regular mailbox. Exchange Online might disconnect a regular mailbox if it has no license assigned and no hold applied.

## Resolution

> [!IMPORTANT]
> Permanent loss of the mailbox contents can occur if these steps aren't completed within 30 days from the time that the mailbox was disconnected. If you assign a license after the 30-day period, the mailbox won't be reconnected, and a new mailbox will be provisioned instead.

To fix the issue, follow these steps:

1. Temporarily assign a license to reconnect the mailbox.

2. Update the on-premises remote mailbox to the `Shared` type by running the following cmdlet in the on-premises Exchange Management Shell (EMS):

   ```powershell
   Set-RemoteMailbox -Identity <mailbox ID> -Type Shared
   ```

3. Convert the regular mailbox to a shared mailbox in Exchange Online by running the following command in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```powershell
   Set-Mailbox -Identity <mailbox ID> -Type Shared
   ```

4. Remove the temporary license.
