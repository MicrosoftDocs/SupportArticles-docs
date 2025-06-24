---
title: Runbook Jobs Get Suspended in Azure Automation
description: Provides solutions to an issue where runbook jobs are suspended in Azure Automation.
ms.date: 06/24/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Runbook jobs are suspended in Azure Automation

This article provides solutions to an issue where runbook jobs are suspended in Azure Automation.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in the last 29 days. You can restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore a deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Symptoms

Runbook jobs might be suspended after three failed start attempts.

## Cause 1: Exceeding memory or network socket limits in an Azure sandbox

- Memory limits

    A job might fail if it uses more than 400 MB of memory.
- Network socket limits

    An Azure sandbox is limited to 1,000 concurrent network sockets.

For more information, see [Azure Automation limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-automation-limits).

Here are some suggestions for working within memory limits:

- Split the workload among multiple runbooks.
- Reduce the amount of data processed in memory.
- Avoid writing unnecessary output from your runbooks.
- Consider the number of checkpoints written in your PowerShell workflow runbooks.

Here are some actions that can reduce the memory footprint of your runbook during runtime:

- Use the `clear` method, such as `$myVar.clear`, to clear variables.
- Use the `[GC]::Collect` command to run the garbage collection immediately.

## Cause 2: Module incompatibility

Module dependencies might be incorrect. In this case, your runbook typically returns a "Command not found" or "Cannot bind parameter" error message.

To resolve this issue, [update Azure PowerShell modules in Azure Automation](/azure/automation/automation-update-azure-modules).

## Cause 3: Not authenticated with Microsoft Entra ID in an Azure sandbox

Azure Automation runbooks that attempt to call executables or subprocesses within an Azure sandbox environment can't use Microsoft Authentication Library (MSAL) to authenticate with Microsoft Entra ID.

To resolve this issue, use a managed identity for the Automation account. When you authenticate this runbook with Microsoft Entra ID by using a managed identity, ensure the following things:

- The Microsoft Graph PowerShell module is available in your Automation account.
- The managed identity is granted the permissions required to execute the runbook automation tasks.

If your runbook can't call an executable or subprocess in an Azure sandbox, run the runbook on a [hybrid worker](/azure/automation/automation-hrw-run-runbooks). Hybrid workers aren't constrained by the memory and network limits of Azure sandboxes.

## References

- [Understand how Azure Resource Manager throttles requests](/azure/azure-resource-manager/management/request-limits-and-throttling)
- [Troubleshooting API throttling errors](../../virtual-machines/windows/troubleshooting-throttling-errors.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
