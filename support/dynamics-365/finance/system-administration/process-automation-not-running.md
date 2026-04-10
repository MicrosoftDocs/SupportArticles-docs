---
title: Restore process automation in Dynamics 365 Finance
description: If process automation scheduled series or background processes aren't running in Dynamics 365 Finance, follow this step-by-step guide to restore your system batch job and resume the affected operations.
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

This article helps you resolve an issue in which [process automation](/dynamics365/fin-ops-core/fin-ops/sysadmin/process-automation) background processes or scheduled series don't run in Microsoft Dynamics 365 Finance. If the process automation system batch job is unhealthy, dependent batch operations and data maintenance jobs might stall. Such operations include subledger journal transfers, vendor invoice posting, and ledger settlements. By reinitializing process automation, you can restore the system batch job and resume the affected processes.

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
- Scheduled occurrences or background processes are processed, but not on time.

## Cause

The underlying process automation system batch job might be unhealthy or not running. This job schedules and triggers all process automation tasks. To perform as expected, this job must:

- Run continuously without an end date
- Run every minute
- Never be manually changed or deleted

If this job stops, pauses, or becomes corrupted, all dependent automation processes stall.

## Solution

To restore the process automation system batch job to a healthy state, follow these steps.

### Reinitialize process automation

1. Go to **System administration** > **Setup** > **Process automations**.
1. Select **Initialize process automation**. This step resets the framework-level system job.

### Check system batch job status

1. Go to **System administration** > **Inquiries** > **Batch jobs**.
1. Find the batch job that has a description that starts by using one of the following values:
    - **Process automation polling system job**
    - **Process automation background process system job**
1. Verify that the batch job meets these conditions:
   - Status: **Waiting** or **Executing**
   - Recurrence: Every minute
   - End date: None
1. If the batch job isn't listed or doesn't resume after reinitialization:
    1. Check the system logs for errors.
    1. If it's necessary, restart the Batch service on the Application Object Server (AOS) node.

### Verify batch job recurrence and priority

1. Go to **System administration** > **Inquiries** > **Batch jobs**.
1. Find the process automation system batch job, select it, and then select **View tasks** on the Action Pane. Confirm that the batch job contains a task that uses the **ProcessAutomationPollingEngine** class.
1. Verify the following settings:
   - **Recurrence** is set to **1 minute**. If not, set the recurrence to **1 minute**.
   - **Effective Scheduling Priority** is set to **Critical** or **Reserved Capacity**. If not, enable the **Scheduling priority is overridden** option, and then set **Job scheduling priority** to **Reserved Capacity**. For more information, see [Priority-based batch scheduling](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling).

### Validate dependent processes

Wait a few minutes, and then check for the following conditions:

- Background processes and scheduled series appear in the process automation calendar view.
- Affected batch operations (for example, subledger transfers and invoice postings) resume processing.

> [!NOTE]
> If the issue persists, check whether the batch framework is working correctly. To make this check, verify that other batch jobs are processing normally.

## Additional recommendations

- Enable alerts or notifications for critical background jobs. This setting keeps you informed if a job fails or stops running.
- Regularly review batch job status in **System administration** > **Inquiries** > **Batch jobs**, especially after you apply updates or deploy new versions.

## Related content

- [Batch processing overview](/dynamics365/fin-ops-core/dev-itpro/sysadmin/batch-processing-overview)
- [Automated vendor invoicing processes overview](/dynamics365/finance/accounts-payable/auto-vendr-invc-process)
- [Ledger settlements](/dynamics365/finance/general-ledger/ledger-settlements)
