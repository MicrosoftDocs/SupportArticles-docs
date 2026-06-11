---
title: Get-MailboxStatistics doesn't display a value in StorageLimitStatus field in Exchange Server
description: Describes an issue in which the StorageLimitStatus field is blank when you run the Get-MailboxStatistics cmdlet to query mailbox quotas.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11985
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/03/2026
---

# Empty StorageLimitStatus field when you run the Get-MailboxStatistics cmdlet in Microsoft Exchange Server

_Original KB number:_ &nbsp;2819389

## Summary

When you run the Get-MailboxStatistics cmdlet to check mailbox quota status, the `StorageLimitStatus` field might appear blank. This behavior is by design. Microsoft Exchange Server doesn't return quota values in this field. This behavior helps to avoid performance issues that are caused by frequent queries to Active Directory. To view mailbox quota status, use the Exchange admin center (EAC) or run Get-MailboxStatistics by using additional parameters that display quota and size information.

## Symptoms

If you run the `Get-MailboxStatistics` cmdlet to verify the status of a mailbox quota in an instance of Exchange Server, the `StorageLimitStatus` field in the results is empty.

## Cause

This behavior is by design.

The Exchange Server Information Store doesn't cache the values of mailbox quotas. Instead, the Information Store makes frequent calls to Active Directory to retrieve the values of mailbox quotas for each mailbox that's specified in the `Get-MailboxStatistics` cmdlet. Because of the frequent calls to Active Directory, you might experience poor performance in Exchange Server. To avoid this problem, the default `Get-MailboxStatistics` cmdlet doesn't retrieve the mailbox quotas and doesn't display a value in the `StorageLimitStatus` field.

## Workaround 1: Use the Exchange Admin Console (EAC)

To verify the status of individual mailbox quotas, follow these steps:

1. Use an account that has the [Mail Recipients role](/exchange/permissions/permissions) at a minimum to sign in to the [Exchange admin center (EAC)](/exchange/architecture/client-access/exchange-admin-center).

1. In the feature pane, select **recipients**. A list of mailboxes displays.

1. Select the mailbox for which you want to verify the quota status, and then select the **Edit** button on the toolbar.

1. Select **mailbox usage**. The mailbox quota usage appears.

## Workaround 2: Use Exchange Management Shell (EMS)

Follow these steps:

1. Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange server to open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell).

1. To verify the status of individual mailbox quota, run the [Get-MailboxStatistics](/powershell/module/exchange/get-mailboxstatistics) PowerShell cmdlet, as shown in the following example:

```powershell
Get-MailboxStatistics DisplayName | ft *quota*,*size -AutoSize -Wrap
```

To verify the status of the mailbox quota for all the mailboxes that are hosted on a database, run the [Get-MailboxStatistics](/powershell/module/exchange/get-mailboxstatistics) PowerShell cmdlet, as shown in the following example:

```powershell
Get-MailboxStatistics -Database DatabaseName | ft displayname,*quota*,*size -AutoSize -Wrap
```
