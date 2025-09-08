---
title: Moving migration mailbox fails
description: This article describes an issue that can occur when you try to move a mailbox by using the New-MigrationBatch cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error when you try to move a mailbox in Exchange Server 2016: The migration mailbox for the organization is either missing or invalid

_Original KB number:_ &nbsp; 2812509

## Symptoms

When you try to move a mailbox by using the `New-MigrationBatch` cmdlet in Exchange Server 2016, you may receive an error message that resembles the following one:

> The migration mailbox for the organization is either missing or invalid.

## Cause

This issue occurs if the migration mailbox isn't enabled or was deleted.

> [!NOTE]
> To move a mailbox by using the `New-MigrationBatch` cmdlet, the migration mailbox must be present and enabled.

## Resolution

To resolve this issue, follow these steps:

1. Start the Active Directory Users and Computers snap-in.
2. Click **Users**, and then verify that the following account doesn't exist:

    Migration.8f3e7716-2011-43e4-96b1-aba62d229136

    > [!NOTE]
    >  If this account exists in the **Users** container, go to step 4.

3. Run the following cmdlet:

    ```console
    Setup /PrepareAD /IAcceptExchangeServerLicenseTerms
    ```

4. Run the following cmdlets:

    ```console
    Enable-Mailbox -Arbitration -Identity "Migration.8f3e7716-2011-43e4-96b1-aba62d229136"

    Set-Mailbox "Migration.8f3e7716-2011-43e4-96b1-aba62d229136" -Arbitration -Management:$true
    ```

## References

- [Mailbox Moves in Exchange 2013](/Exchange/recipients/mailbox-moves)

- [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch)
