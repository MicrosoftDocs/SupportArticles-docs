---
title: The number of bad items exceeds the set limit
description: Describes how to resolve a TooManyBadItemsPermanentException error during migration in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kerbo, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# TooManyBadItemsPermanentException during migration in Microsoft 365

_Original KB number:_ &nbsp; 4023340

## Symptoms

During a migration in Microsoft 365, you received the following error message:

> TooManyBadItemsPermanentException

> [!NOTE]
> The information in this article may also apply to the "TooManyMissingItemsPermanentException" error because the number of missing items is counted in the bad item limit (but doesn't increment it).

## Cause

This issue occurs if the number of bad items is greater than the set limit. The migration cannot continue until the limit is increased or set to **unlimited**.

## Resolution

To resolve this issue, follow these steps:

1. Export the move request, and then import it to analyze it in PowerShell.

    ```powershell
    $stats= Get-MailboxStatistics <SMTP address> -IncludeMoveReport
    $report = $stats.MoveHistory[0].Report
    $report.BadItems
    ```

1. Update the `baditemlimit` value, which has a default value of **0**. Use a larger value or set it to **unlimited**. (This depends on the number determined in the previous step.)

    ```powershell
    Get-Moverequest <identity> | Set-Moverequest –baditemlimit <input value>
    Resume-Moverequest <identity>
    ```
