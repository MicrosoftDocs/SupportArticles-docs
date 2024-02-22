---
title: Get-MailboxStatistics doesn't display a value in StorageLimitStatus field in Exchange Server
description: Describes an issue in which the StorageLimitStatus field is blank when you run the Get-MailboxStatistics cmdlet to query mailbox quotas.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Empty StorageLimitStatus field when you run the Get-MailboxStatistics cmdlet in Exchange Server 2013 or Exchange Server 2016

_Original KB number:_ &nbsp;2819389

## Symptoms

When you run the Get-MailboxStatistics cmdlet to verify the status of a mailbox quota in a Microsoft Exchange Server 2013 or Exchange Server 2016 environment, the StorageLimitStatus field in the results is empty.

## Cause

This behavior is by design.

Unlike Exchange Server Information Store versions earlier than Exchange Server 2013 Information Store, the new Information Store doesn't cache the values of mailbox quotas. The Information Store makes frequent calls to Active Directory to retrieve the values of mailbox quotas for each mailbox that's specified in the Get-MailboxStatistics cmdlet. Because of the frequent calls to Active Directory, you may experience poor performance in Exchange Server. To avoid poor performance in Exchange Server, the default Get-MailboxStatistics cmdlet doesn't retrieve the mailbox quotas and doesn't display a value in the StorageLimitStatus field.

## Workaround 1: Use Exchange Admin Console (EAC)

If you want to verify the status of individual mailbox quotas, follow these steps:

1. Sign in EAC by using a user account that's assigned at least the Mail Recipients role.
1. In the feature pane, click **recipients**. A list of mailboxes is displayed.
1. Select the mailbox of which you want to verify the quota status, and then click the **Edit** button on the toolbar.
1. Click **mailbox usage**. The mailbox quota usage is displayed.

## Workaround 2: Use Exchange Management Shell

If you want to verify the status of individual mailbox quota, run the following command in Exchange Management Shell:

```powershell
Get-MailboxStatistics DisplayName | ft *quota*,*size -AutoSize -Wrap
```

If you want to verify the status of the mailbox quota for all the mailboxes that are hosted on a database, run the following command:

```powershell
Get-MailboxStatistics -Database DatabaseName | ft displayname,*quota*,*size -AutoSize -Wrap
```

## More information

For more information about the Get-MailboxStatistics cmdlet in Exchange Server 2013, see [General information about the Get-MailboxStatistics cmdlet](/powershell/module/exchange/get-mailboxstatistics).