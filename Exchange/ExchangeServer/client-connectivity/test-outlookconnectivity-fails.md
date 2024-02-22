---
title: Cannot run Test-OutlookConnectivity
description: Describes an issue that causes the Test-OutlookConnectivity cmdlet to fail in Exchange 2016 or Exchange 2013. This issue is caused by a case-sensitive parameter. A resolution is provided.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Test-OutlookConnectivity cmdlet fails with Sequence contains no elements error in Exchange Server

_Original KB number:_ &nbsp; 3186849

## Symptoms

When you run the `Test-OutlookConnectivity` test in an Exchange Server 2016 or 2013 environment, you receive the following warning:

```console
WARNING: An unexpected error has occurred and a Watson dump is being generated:  
Sequence contains no elements  
 + CategoryInfo : NotSpecified: (:) [Test-OutlookConnectivity], InvalidOperationException  
 + FullyQualifiedErrorId : System.InvalidOperationException,Microsoft.Exchange.Management.Tasks.TestOutlookConnectivity  
 + PSComputerName : toys-e15-mbx1.tailspintoys.com  
```

## Cause

This issue occurs because the database value that's specified in the ProbeIdentity parameter is case-sensitive.

## Resolution

To resolve this issue, determine the database name value by running the `Get-Mailbox` cmdlet, as follows:

```console
$db = (Get-Mailbox <Alias>).Database
```

Then, run the `Test-OutlookConnecivity` cmdlet by using the database variable from the preceding `Get-Mailbox` cmdlet:

```console
Test-OutlookConnectivity OutlookRpcDeepTestprobe\$db -RunFromServerId <ServerName> -MailboxId <Alias>
```

## More information

For more information about this PowerShell cmdlet, see [Test-OutlookConnectivity](/powershell/module/exchange/test-outlookconnectivity).
