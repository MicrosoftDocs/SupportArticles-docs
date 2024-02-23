---
title: Mailbox move request created by New-MoveRequest cmdlet isn't showing in EAC in Exchange Server 2013
description: Resolves an issue in which a mailbox move request that you created by using the New-MoveRequest cmdlet isn't displayed in EAC. This issue occurs when you create a mailbox move request in an Exchange Server 2013 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: lukeds, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Mailbox move request that you created by using the New-MoveRequest cmdlet isn't displayed in EAC in an Exchange Server 2013 environment

_Original KB number:_ &nbsp;2764631

## Symptoms

When you use the `New-MoveRequest` cmdlet to create a mailbox move request in a Microsoft Exchange Server 2013 environment, the mailbox move request isn't displayed in Exchange Administration Console (EAC).

## Cause

This behavior is by design.

Exchange Server 2013 introduces the `MigrationBatch` cmdlet so that you can create and manage mailbox move requests. When you use EAC to create a mailbox move request, EAC runs the `New-MigrationBatch` cmdlet in the background. Additionally, EAC runs the `Get-MigrationBatch` cmdlet so that the move request is displayed in EAC. However, the `Get-MigrationBatch` cmdlet only queries mailbox move requests that are created by using the `New-MigrationBatch` cmdlet. So when you run the `New-MoveRequest` cmdlet in Exchange Management Shell (EMS) to create a mailbox move request, the mailbox move request isn't displayed in EAC.

## Resolution

To view the status of a mailbox move request that you created by using the `New-MoveRequest` cmdlet, run the `Get-MoveRequest` cmdlet in EMS.

## More information

For more information about the `MigrationBatch` cmdlet, go to the following Microsoft websites:

[Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch)

[New-MigrationBatch](/powershell/module/exchange/new-migrationbatch)

[Start-MigrationBatch](/powershell/module/exchange/start-migrationbatch)

[Stop-MigrationBatch](/powershell/module/exchange/stop-migrationbatch)

[Remove-MigrationBatch](/powershell/module/exchange/remove-migrationbatch)