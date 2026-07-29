---
title: The migration mailbox for the organization is either missing or invalid
description: This article describes an issue that can occur when you move a mailbox by using the New-MigrationBatch PowerShell cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11517
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 07/28/2026
ms.reviewer: v-six, v-kccross
---

# Error when you try to move a mailbox in Exchange Server The migration mailbox for the organization is either missing or invalid

_Original KB number:_ &nbsp; 2812509

## Summary

Use this article to troubleshoot the Exchange Server error "The migration mailbox for the organization is either missing or invalid" when you run the New-MigrationBatch cmdlet. It explains why the error occurs and provides steps to verify, recreate, and enable the required migration arbitration mailbox in Active Directory and Exchange.

## Symptoms

When you try to move a mailbox by using the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) PowerShell cmdlet in Exchange Server, you might receive an error message that resembles the following one:

> The migration mailbox for the organization is either missing or invalid.

## Cause

This problem occurs if the migration mailbox isn't enabled or was deleted.

> [!NOTE]
> To move a mailbox by using the `New-MigrationBatch` PowerShell cmdlet, the migration mailbox must be present and enabled.

## Resolution

To resolve this issue, follow these steps:

1. Start the Active Directory Users and Computers (ADUC) snap-in.
1. Select **Users**, and then verify that the following account doesn't exist:

    `Migration.8f3e7716-2011-43e4-96b1-aba62d229136`

   If this account exists in the **Users** container, go to step 4.

1. Run the following command:

    ```console
    Setup /PrepareAD /IAcceptExchangeServerLicenseTerms
    ```

1. Run the [Enable-Mailbox](/powershell/module/exchange/enable-mailbox) and [Set-Mailbox](/powershell/module/exchange/set-mailbox) cmdlets as shown in the following example:

    ```console
    Enable-Mailbox -Arbitration -Identity "Migration.8f3e7716-2011-43e4-96b1-aba62d229136"

    Set-Mailbox "Migration.8f3e7716-2011-43e4-96b1-aba62d229136" -Arbitration -Management:$true
    ```

## References

- [Mailbox Moves in Exchange Server](/Exchange/recipients/mailbox-moves)
