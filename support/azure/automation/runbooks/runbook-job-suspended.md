---
title: Runbook jobs get suspended in Azure Automation
description: Provides solutions to an issue where runbook jobs get suspended in Azure Automation.
ms.date: 06/17/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Runbook jobs get suspended in Azure Automation

This article provides solutions to an issue where runbook jobs get suspended in Azure Automation.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in last 29 days - Restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Symptoms

Runbook jobs might be in a suspended state after three failed start attempts.

## Cause 1: Exceed memory or network socket limits in an Azure sandbox

- Memory limit

    A job might fail if using more than 400 MB of memory.
- Network socket limit

    An Azure sandbox is limited to 1,000 concurrent network sockets.

For more information, see [Azure Automation limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-automation-limits).

Here are some suggestions to work within the memory limits:

- Split the workload among multiple runbooks.
- Reduce the amount of data processed in memory.
- Avoid writing unnecessary output from your runbooks.
- Consider the number of checkpoints written in your PowerShell workflow runbooks.

Here are some actions that can reduce the memory footprint of your runbook during runtime:

- Use the `clear` method, such as `$myVar.clear`, to clear out variables.
- Use the `[GC]::Collect` command to run the garbage collection immediately.

## Cause 2: Module incompatibility

Module dependencies might not be correct. In this case, your runbook typically returns a "Command not found" or "Cannot bind parameter" error message.

To resolve this issue, [update Azure PowerShell modules in Azure Automation](/azure/automation/automation-update-azure-modules).

## Cause 3: No authentication with Microsoft Entra ID in an Azure sandbox

Azure Automation runbooks that attempt to call executables or subprocesses within the Azure sandbox environment can't use Microsoft Authentication Library (MSAL) for authentication with Microsoft Entra ID.

To resolve this issue, use Managed Identity for the Automation account. When you authenticate this runbook with Microsoft Entra ID by using Managed Identity, ensure the following things:

- The Azure AD PowerShell module is available in your Automation account.
- The Managed Identity is granted the required permissions to execute the tasks automated by the runbook.

If your runbook can't call an executable or subprocess in an Azure sandbox, run the runbook on a [hybrid worker](/azure/automation/automation-hrw-run-runbooks). Hybrid workers aren't limited by the memory and network limits that Azure sandboxes have.

## References

- [Throttling Azure Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling)
- [Troubleshooting API throttling errors](../../virtual-machines/windows/troubleshooting-throttling-errors.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]