---
title: Mailbox move request created by New-MoveRequest cmdlet isn't showing in EAC in Exchange Server 2013
description: Resolves an issue in which a mailbox move request that you created by using the New-MoveRequest cmdlet isn't displayed in EAC. This issue occurs when you create a mailbox move request in an Exchange Server 2013 environment.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
ms.reviewer: lukeds
appliesto:
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
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

[Get-MigrationBatch](https://technet.microsoft.com/library/jj219164%28v=exchg.150%29.aspx)

[New-MigrationBatch](https://technet.microsoft.com/library/jj219166%28v=exchg.150%29.aspx)

[Start-MigrationBatch](https://technet.microsoft.com/library/jj219165%28v=exchg.150%29.aspx)

[Stop-MigrationBatch](https://technet.microsoft.com/library/jj219168%28v=exchg.150%29.aspx)

[Remove-MigrationBatch](https://technet.microsoft.com/library/jj219167%28v=exchg.150%29.aspx)
