---
title: MapiExceptionPartialCompletion Unable to copy to target error when moving a mailbox in Exchange Server 2013
description: "Describes an issue that causes a mailbox move operation to fail at 95% when the -IgnoreRuleLimitErrors:$true switch is used with New-MoveRequest cmdlet in Exchange Server 2013."
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Move Mailbox within same organization
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nickul, genli, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you use the IgnoreRuleLimitErrors switch in the New-MoveRequest cmdlet in Exchange Server 2013 - MapiExceptionPartialCompletion: Unable to copy to target

_Original KB number:_ &nbsp;4009796

## Symptoms

When you use the `New-MoveRequest` cmdlet together with the `-IgnoreRuleLimitErrors:$true` switch, the move fails at 95% if the mailbox is moved from one database to the other in Microsoft Exchange Server 2013.

For example, when you run the `New-MoveRequest 2013 -TargetDatabase dag2013db2-IgnoreRuleLimitErrors:$true` cmdlet, the following error is returned:

```console
FailureType: MapiExceptionPartialCompletionFailure
Code: -2147023232
MapiLowLevelError: 0
FailureSide: Source
FailureSideInt: 1
ExceptionTypes: {Exchange, Mapi, DataProviderPermanent,MapiPartialCompletion}
ExceptionTypesInt: {1, 30, 102, 54}
Message: MapiExceptionPartialCompletion: Unable to copy to target. (hr=0x40680, ec=0)
```

## Workaround

To work around this issue, don't include the `-IgnoreRuleLimitErrors:$true` switch when you run the `New-MoveRequest` cmdlet.

## More information

The `IgnoreRuleLimitErrors` parameter specifies that the command doesn't move the user's rules to the target server that's running Exchange Server.
