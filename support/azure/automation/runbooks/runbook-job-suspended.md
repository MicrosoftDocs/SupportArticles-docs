---
title: Runbook jobs are suspended in Azure Automation
description: Learn how to fix suspended runbook jobs in Azure Automation caused by sandbox memory limits, module incompatibility, or Microsoft Entra ID authentication issues.
ms.date: 09/29/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: adoyle, v-weizhu, kaushika
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
ai-usage: ai-assisted
---
# Runbook jobs are suspended in Azure Automation

## Summary

This article explains how to fix runbook jobs that are suspended in Azure Automation after three failed start attempts.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in the last 29 days. You can restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore a deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

### Symptoms

Runbook jobs might be suspended after three failed start attempts.

### Cause 1: Exceeding memory or network socket limits in an Azure sandbox

The following limits apply to an Azure sandbox:

- Memory limits. A job might fail if it uses more than 400 MB of memory.
- Network socket limits. An Azure sandbox is limited to 1,000 concurrent network sockets.

For more information, see [Azure Automation limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-automation-limits).

### Resolution

The following suggestions can help you work within memory limits:

- Split the workload among multiple runbooks.
- Reduce the amount of data processed in memory.
- Avoid writing unnecessary output from your runbooks.
- Consider the number of checkpoints written in your PowerShell workflow runbooks.

The following actions can reduce the memory footprint of your runbook during runtime:

- Use the `clear` method, such as `$myVar.clear`, to clear variables.
- Use the `[GC]::Collect` command to run the garbage collection immediately.

### Cause 2: Module incompatibility

Module dependencies might be incorrect. In this case, your runbook typically returns a "Command not found" or "Cannot bind parameter" error message.

### Resolution

To resolve this issue, [update Azure PowerShell modules in Azure Automation](/azure/automation/automation-update-azure-modules).

### Cause 3: Not authenticated with Microsoft Entra ID in an Azure sandbox

Azure Automation runbooks that attempt to call executables or subprocesses within an Azure sandbox environment can't use Microsoft Authentication Library (MSAL) to authenticate with Microsoft Entra ID.

### Resolution

To resolve this issue, use a managed identity for the Automation account. When you authenticate this runbook with Microsoft Entra ID by using a managed identity, ensure the following conditions:

- The Microsoft Graph PowerShell module is available in your Automation account.
- The managed identity has the permissions required to execute the runbook automation tasks.

If your runbook can't call an executable or subprocess in an Azure sandbox, run the runbook on a [hybrid worker](/azure/automation/automation-hrw-run-runbooks). Hybrid workers aren't constrained by the memory and network limits of Azure sandboxes.

## References

- [Understand how Azure Resource Manager throttles requests](/azure/azure-resource-manager/management/request-limits-and-throttling)
- [Troubleshooting API throttling errors](../../virtual-machines/windows/troubleshooting-throttling-errors.md)