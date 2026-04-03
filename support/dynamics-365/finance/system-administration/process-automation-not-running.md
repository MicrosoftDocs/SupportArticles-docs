---
title: Restore Process Automation in Dynamics 365 Finance
description: Process automation scheduled series or background processes not running in Dynamics 365 Finance? Follow this step-by-step guide to restore your system batch job and resume affected operations.
ms.date: 04/03/2026
audience: IT Pro
ms.reviewer: setharvila, anaborges, twheeloc, v-shaywood
ms.custom: sap:System administration
ms.search.region: Global
ms.search.validFrom: 2020-09-10
ms.dyn365.ops.version: AX 7.0.0
---

# Process automation background processes or scheduled series aren't running

## Summary

This article helps you resolve an issue where [process automation](/dynamics365/fin-ops-core/fin-ops/sysadmin/process-automation) background processes or scheduled series don't run in Microsoft Dynamics 365 Finance. When the process automation system batch job is unhealthy, dependent batch operations like subledger journal transfers, vendor invoice posting, ledger settlements, and data maintenance jobs stall. Reinitializing process automation restores the system batch job and resumes affected processes.

## Prerequisites

- Security role: System Administrator or equivalent.
- Access to the System administration module.

## Symptoms

Process automation background processes or scheduled series don't run as expected. This issue can affect multiple operations, including:

- [Batch transfer for subledger journals](/dynamics365/finance/general-ledger/subledger-transfer)
- Vendor invoice batch posting
- [Ledger settlement processes](/dynamics365/finance/general-ledger/auto-settle)
- Data maintenance jobs

Typical symptoms include:

- Affected operations remain in **Waiting** status indefinitely.
- Users report delays in posting or transfer processes.
- Scheduled process occurrences don't appear in the process automation calendar view.

## Cause

The underlying process automation system batch job might be unhealthy or not running. This job schedules and triggers all process automation tasks. It must:

- Run continuously without an end date.
- Run every minute.
- Never be manually changed or deleted.

If this job stops, pauses, or becomes corrupted, all dependent automation processes stall.

## Solution

Follow these steps to restore the process automation system batch job to a healthy state.

### Reinitialize process automation

1. Go to **System administration** > **Setup** > **Process automations**.
1. Select **Initialize process automation**. This resets the framework-level system job.

### Check system batch job status

1. Go to **System administration** > **Inquiries** > **Batch jobs**.
1. Find the batch job with a description that starts with one of the following values:
    - **Process automation polling system job**
    - **Process automation background process system job**
1. Check that the batch job meets these conditions:
   - Status: **Waiting** or **Executing**
   - Recurrence: Every minute
   - End date: None
1. If the batch job isn't listed or doesn't resume after reinitialization:
    1. Check system logs for errors.
    1. If necessary, restart the Batch service on the Application Object Server (AOS) node.

### Validate dependent processes

Wait a few minutes, and then check for the following conditions:

- Background processes and scheduled series appear in the process automation calendar view.
- Affected batch operations (for example, subledger transfers and invoice postings) resume processing.

> [!NOTE]
> If the issue persists, check that the batch framework is working correctly by confirming that other batch jobs are processing normally.

## Additional recommendations

- Enable alerts or notifications for critical background jobs so you're informed if a job fails or stops running.
- Regularly review batch job status in **System administration** > **Inquiries** > **Batch jobs**, especially after you apply updates or deploy new versions.

## Related content

- [Batch processing overview](/dynamics365/fin-ops-core/dev-itpro/sysadmin/batch-processing-overview)
- [Automated vendor invoicing processes overview](/dynamics365/finance/accounts-payable/auto-vendr-invc-process)
- [Ledger settlements](/dynamics365/finance/general-ledger/ledger-settlements)
