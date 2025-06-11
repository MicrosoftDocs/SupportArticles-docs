---
title: Troubleshoot runbook execution issues when using PowerShell
description: Describes some runbook execution issues that occur when you use PowerShell in Azure Automation and provides solutions to them.
ms.date: 06/10/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Troubleshoot runbook execution issues when using PowerShell in Azure Automation

This article provides guidance for diagnosing and resolving runbook execution issues that occur when executing PowerShell scripts or cmdlets in Azure Automation.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in last 29 days. You can restore a deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## PowerShell runbooks

PowerShell runbooks are built on Windows PowerShell. You can edit their code directly by using the text editor in the Azure portal. You can also use an offline text editor and then [import the runbooks](/azure/automation/manage-runbooks) into Azure Automation. The PowerShell version is determined by the **Runtime version** specified.

## Limitations and known issues with PowerShell runbooks

**Limitations:**

- For the PowerShell 7 runtime version, the module activities aren't extracted for the imported modules.
- The `PSCredential` runbook parameter type isn't supported in PowerShell 7 runtime version.
- PowerShell 7.x doesn't support workflows runbooks. For more information, see [PowerShell workflow](/azure/automation/automation-powershell-workflow).
- PowerShell 7.x currently doesn't support signed runbooks.
- Source control integration doesn't support PowerShell 7.2. PowerShell 7.2 runbooks in the source control are created in an Automation account as runtime 5.1.
- Currently, only cloud jobs are supported for the PowerShell 7.2 runtime version.
- Using Az modules and AzureRM modules in the same Automation account isn't supported. For more information, see [Update Azure PowerShell modules in Automation](/azure/automation/automation-update-azure-modules).

**Known issues:**

- Runbook properties defining logging preference isn't supported in PowerShell 7 runtime.

  To work around this issue, explicitly set the preference at the start of the runbook as follows:

  ```azurepowershell
  $VerbosePreference = "Continue"
  $ProgressPreference = "Continue"
  ```

- When you use the [ExchangeOnlineManagement](/powershell/exchange/exchange-online-powershell) module version 3.0.0 or later, you can experience errors.

  To resolve this issue, make sure that you explicitly upload the `PowerShellGet` and `PackageManagement` modules.

For more information, see [Limitations and Known issues](/azure/automation/automation-runbook-types#powershell-workflow-runbooks).

## Before troubleshooting

Follow these steps to identify and resolve common errors before further troubleshooting:

1. Verify that your PowerShell script works outside of Azure Automation.
2. Verify that the required modules are imported into your Azure Automation account.

## Issue 1: Runbook execution fails due to deserialized object

**Symptoms:**

When you run a runbook, the following error message might be displayed:

> Cannot bind parameter \<ParameterName>.
>
> Cannot convert the \<ParameterType> value of type Deserialized \<ParameterType> to type \<ParameterType>.

**Cause:**

This error occurs with PowerShell Workflow runbooks because PowerShell Workflow stores complex objects in a deserialized format to persist your runbook state when the workflow is suspended.

**Resolution:**

To resolve this issue, use one of the following methods:

- If you pipe complex objects from one PowerShell cmdlet to another one, wrap these cmdlets in an `InlineScript` activity.
- Pass the name or value that you need from the complex object instead of passing the entire object.
- Use a PowerShell runbook instead of a PowerShell Workflow runbook.

## Issue 2: PowerShell jobs fail with the "Cannot invoke method" error

**Symptoms:**

When you start a PowerShell job in a runbook that runs in an Azure sandbox, you receive the following error message:

> Exception was thrown - Cannot invoke method. Method invocation is supported only on core types in this language mode.

**Cause:**

This error might occur because the runbook can't run in the [Full Language mode](/powershell/module/microsoft.powershell.core/about/about_language_modes).

**Resolution:**

To resolve this error, use one of the following methods:

- Use [Start-AzAutomationRunbook](/powershell/module/az.automation/start-azautomationrunbook) instead of [Start-Job](/powershell/module/microsoft.powershell.core/start-job) to start the runbook.
- Try running the runbook on a [Hybrid Runbook Worker](/azure/automation/automation-hybrid-runbook-worker).

## Reference

- [Troubleshoot runbook issues](/azure/automation/troubleshoot/runbooks)
- [Start a runbook in Azure Automation](/azure/automation/start-runbooks)
- [Run runbooks on a Hybrid Runbook Worker](/azure/automation/automation-hrw-run-runbooks)
- [Update Azure PowerShell modules in Automation](/azure/automation/automation-update-azure-modules)

[!INCLUDE [Azure Help Support](../../../includes/ai-generated-attribution.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure/classic-vm-deprecation.md)]

