---
title: Operation has timed out error when moving mailbox
description: Describes an issue in which you receive an error message when you try to run the New-MoveRequest cmdlet to move a mailbox from Exchange Online in Microsoft 365 to the on-premises environment in a hybrid deployment. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
- Exchange Online
- Exchange
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# "Operation has timed out" error when using New-MoveRequest to move a mailbox from Exchange Online to on-premises

## Symptoms

You have a hybrid deployment of Microsoft Exchange Online in Microsoft 365 and of your on-premises Microsoft Exchange Server environment. When you try to use the New-MoveRequest Windows PowerShell cmdlet to move or offboard a mailbox from Microsoft 365 to the on-premises environment, the mailbox isn't moved. Additionally, you may receive an error message that resembles the following:

> The call to '`https://webmail.domain.com/EWS/mrsproxy.svc`' timed out.  
> The operation has timed out  
> \+ CategoryInfo : NotSpecified: (0:Int32) [New-MoveRequest], RemoteTransientException  
> \+ FullyQualifiedErrorId : 725EBC5,Microsoft.Exchange.Management.RecipientTasks.NewMoveRequest

## Cause

This issue may occur if incorrect syntax is used for domain names and host names in the `New-MoveRequest` cmdlet.

## Resolution

To resolve this issue, make sure that you use the correct syntax for domain names and host names in the `New-MoveRequest` cmdlet. The `New-MoveRequest` cmdlet requires all domain names and host names to be enclosed in single quotation marks (').

The following is an example of incorrect syntax:

```ps
'alias' | New-MoveRequest -Outbound -RemoteHostName webmail.contoso.com -RemoteCredential $onprem -RemoteTargetDatabase Database1 -TargetDeliveryDomain contoso.com
```

The following is an example of correct syntax. (Note that this example uses single quotation marks around domain names and host names.)

```ps
'alias' | New-MoveRequest -OutBound -RemoteTargetDatabase 'Database1' -RemoteHostName 'webmail.contoso.com' -RemoteCredential $onprem -TargetDeliveryDomain 'contoso.com'
```

## More information

For more information about how to use the `New-MoveRequest` cmdlet, see [Understanding Move Requests](/previous-versions/office/exchange-server-2010/dd298174(v=exchg.141)).

If you experience issues when you move mailboxes to Exchange Online in Microsoft 365, you can run the [Troubleshoot migration issues in Exchange Server hybrid environment](/exchange/troubleshoot/move-or-migrate-mailboxes/troubleshoot-migration-issues-in-exchange-hybrid) tool. This diagnostic is an automated troubleshooting tool. If you're experiencing a known issue, you receive a message that states what went wrong. The message includes a link to an article that contains the solution. Currently, the tool is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
