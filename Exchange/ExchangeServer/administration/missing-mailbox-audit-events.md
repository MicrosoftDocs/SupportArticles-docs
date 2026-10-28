---
title: Mailbox audit events are missing from Search results
description: Describes how to diagnose and work around indexing failures in Exchange Server Subscription Edition.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:temp
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dkhrebin
appliesto: 
  - Exchange Server SE
search.appverid: MET150
ms.date: 10/28/2026
ai-usage: ai-assisted
---

# Mailbox audit events are missing from Search results

## Summary

This article describes how to diagnose the cause of missing mailbox audit events in Search results and provides a workaround for the issue.

## Symptoms

After Exchange Search resumes operation, some mailbox audit events are missing from `Search-MailboxAuditLog` results, although other mailbox items are searchable.

## Cause

To diagnose the issue, check the affected mailbox. Download the latest [Troubleshoot-ModernSearch script](https://microsoft.github.io/CSS-Exchange/Search/Troubleshoot-ModernSearch/) and run the following commands in an elevated Exchange Management Shell on the server hosting the mailbox's active database:

```powershell
$Mailbox = 'affected.user@contoso.com'

.\Troubleshoot-ModernSearch.ps1 -MailboxIdentity $Mailbox -Category NotIndexed
```

The output might include the following group:

```text
Message Index Status: NotIndexed, IPM.AuditLog

TotalItems                      = <number of affected items>
ErrorMessage                    = FailedToConnect: skip adding Poi
IsPermanentFailure              = False
EarliestLastIndexingAttemptTime = <timestamp>
LastIndexingAttemptTime         = <timestamp>
```

The script also exports individual records to a `<MailboxGuid>-Messages-<id>.csv` file and displays its location. Open this file and filter `MessageClass` to `IPM.AuditLog`. Use `DateCreated` to help select a query period, allowing a margin around the timestamps and checking the time zone. Don't use `LastIndexingAttemptTime` as the time of the audited operation. Retain the CSV and diagnostic package for further investigation.

On the active mailbox server, check the following log folders for the affected mailbox:

- `%ExchangeInstallPath%\Logging\BigFunnelRetryFeederTimeBasedAssistant\`: item save failures.
- `%ExchangeInstallPath%\Logging\Search\RetryContentIndexingConnection\`: related indexing attempts and correlation IDs, if present.

A failure to save an existing audit record can contain the following error:

```text
RetriableItem.Retry ... Item Class: IPM.AuditLog
Microsoft.Exchange.Data.Storage.AccessDeniedException:
Cannot update existing items in the Audits folder.
    at Microsoft.Exchange.Data.Storage.COWLogProtector.SkipItemOperation(...)
```

To check assistant log files modified during the last day, run the following commands:

```powershell
$MailboxGuid = (Get-Mailbox -Identity $Mailbox -ErrorAction Stop).ExchangeGuid.ToString()
$LogFolder = Join-Path $env:ExchangeInstallPath 'Logging\BigFunnelRetryFeederTimeBasedAssistant'
$Since = (Get-Date).AddDays(-1)

Get-ChildItem -LiteralPath $LogFolder -Filter '*.log' -File -ErrorAction Stop |
    Where-Object { $_.LastWriteTime -ge $Since } |
    Select-String -SimpleMatch $MailboxGuid |
    Where-Object { $_.Line -match 'AccessDeniedException|COWLogProtector' } |
    Select-Object Path, LineNumber, Line
```

> [!NOTE]
> - An `IsPermanentFailure` value of `False` doesn't rule out this issue.
> - Category scans can return incomplete results on large mailboxes. If the group or error isn't found, review script warnings and older or rotated logs. You can still try the read-only procedure in the "Workaround" section. Neither `NotIndexed` output nor successful retrieval alone confirms this cause.

Audit records can be saved while indexing is unavailable. Subsequent attempts to save updated index information for existing records can fail because the Audits folder protects those records from updates.

The `COWLogProtector` error isn't caused by missing mailbox permissions. Changing permissions or repeating the usual indexing retry doesn't remove this restriction.

## Workaround

To work around this issue, retrieve the stored audit records without server-side logon-type filtering, and then filter the results locally. To do this, follow these steps.

> [!Important]
> This procedure retrieves audit records; it doesn't repair their index. The empty `LogonTypes` behavior isn't documented in the [Search-MailboxAuditLog cmdlet reference](/powershell/module/exchangepowershell/search-mailboxauditlog). Verify that a known missing event is returned on your installed Exchange build before relying on the results.

1. Run the following commands in Exchange Management Shell on the Exchange server. Replace the mailbox and dates with a short period containing the missing events. Use the server's local time. If you use a remote client in another time zone, first verify the time interpretation with a known event.

    ```powershell
    $Mailbox = 'affected.user@contoso.com'
    $Start = Get-Date '2026-10-20 08:00:00'
    $End = Get-Date '2026-10-20 09:00:00'
    $Limit = 1000

    $Events = @()
    $Events = @(Search-MailboxAuditLog -Identity $Mailbox -StartDate $Start -EndDate $End -LogonTypes @() -ShowDetails -ResultSize $Limit -ErrorAction Stop)

    if ($Events.Count -ge $Limit) {
        $Events = @()
        throw 'Result limit reached. Split the date range into smaller windows and repeat before treating the results as complete.'
    }
    ```

    Use the following conditions for this query:

    - Specify `-LogonTypes @()` explicitly. Omitting the parameter or using `$null` isn't equivalent.
    - Don't add `-ExternalAccess`, even with `$false`. Also omit `-Operations` and `-HasAttachments`. Apply these filters to the returned objects instead.
    - Query one mailbox at a time and keep the date range short. `ResultSize` limits returned rows, not the work needed to retrieve them.

    If the result limit is reached, repeat the query with smaller windows before filtering. Each window includes its start and excludes its end. For consecutive windows, use the previous `$End` as the next `$Start`. Continue only after the query finishes without errors.

2. Filter the returned records to match your requirements. For example, the following commands select administrator and delegate events for the `SoftDelete` and `HardDelete` operations:

    ```powershell
    $FilteredEvents = $Events | Where-Object {
        $_.LogonType -in @('Admin', 'Delegate') -and
        $_.Operation -in @('SoftDelete', 'HardDelete')
    }

    $FilteredEvents | Format-List LastAccessed, LogonType, Operation, LogonUserDisplayName, ItemSubject, SourceItemSubjectsList
    ```

    Change or remove these filters as needed.

3. Verify a known missing event by its time, operation, actor, and source-message details:

    - If the event is in `$Events` but not `$FilteredEvents`, adjust the local filters.
    - If the event is absent from `$Events`, check the dates, time zone, result limit, and whether the event was logged and retained. If it remains missing, provide Microsoft Support with the script output, relevant logs, query dates, and exact Exchange build.

    Verify success by the return of the expected events, not by a lower `NotIndexed` count.

> [!NOTE]
> - This procedure is read-only and doesn't require moving the mailbox. Don't disable auditing, change Audits-folder permissions, or edit item properties.
> - This workaround can't recreate events that were never logged or have expired under audit retention.
> - This procedure doesn't apply to Microsoft Purview audit searches in Exchange Online.
