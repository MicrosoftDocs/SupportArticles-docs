---
title: Troubleshoot Error Codes During Runbook Execution in Azure Automation
description: Helps you troubleshoot some errors that occur during runbook execution in Azure Automation.
ms.date: 06/20/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Troubleshoot error codes during runbook execution in Azure Automation

When using runbooks in Azure Automation, you might encounter issues due to runtime or PowerShell exceptions or due to specific error messages. This article lists some issues and provides solutions to them.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in the last 29 days - Restore the deleted runbook by running a PowerShell script as a job in your Automation account.  For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Troubleshoot error messages

Review the following table to resolve runbook execution related error messages:

|Error|Description|Solution|
|-----|-----------|
|Unable to create a new Automation job in the West Europe region.|This issue occurs due to scalability limits with the Automation service in the West Europe region. |To resolve it, follow the steps in [Unable to create new Automation job in West Europe region](/answers/questions/910816/index.html).|
|`The subscription cannot be found.`|This issue can occur when the runbook isn't using a managed identity to access Azure resources. |To resolve, follow the steps in [Scenario: Unable to find the Azure subscription](/azure/automation/troubleshoot/runbooks#unable-to-find-subscription).|
|`Strong authentication enrollment is required.`|If you have multifactor authentication on your Azure account, you can't use a Microsoft Entra user to authenticate to Azure.|To resolve this issue, see [Authentication to Azure failed because multifactor authentication is enabled](/azure/automation/troubleshoot/runbooks#auth-failed-mfa)|
|Runbook fails with "No permission" or some variation.|Managed identities might not have the same permissions against Azure resources as your current account.|Make sure that your managed identity [has permissions to access any resources](/azure/role-based-access-control/role-assignments-portal) used in your script.|
|Error: "429: The request rate is currently too large. Please try again."|This error can occur when retrieving job output from a runbook that has many verbose streams.|To resolve this error, see [Request rate too large](/azure/automation/troubleshoot/runbooks#429)|
|`400 Bad Request.`|A "400 Bad Request" error can occur for several reasons. First, verify if the runbook works outside of Azure Automation. Typically, the runbook code doesn't work with this error due to missing values, wrong values being passed, older modules being used, or a resource being referenced is disabled, for example, the runbook calls a webhook that's disabled or expired.|To resolve this error, see [Scenario: 400 Bad Request status when calling a webhook](/azure/automation/troubleshoot/runbooks#expired%20webhook)|
|`Resource not found.`|Check the values provided for the resource. |The three values to check are:<br><br>- Resource name<br>- Resource group name<br>- Subscription<br><br>Check that the runbook has permissions in the subscription that contains the resource. Using the `Set-AzContext` or `az account set` command can change the subscription on the command running by using the `-DefaultProfile` parameter. Many commands provide a subscription parameter that allows a different subscription to be used than the current context.<br>Sign in to the Microsoft Azure portal. Find the resource being used and examine the resource name, resource group, and subscription.|

If none of these solutions addresses your issue, see [Troubleshoot runbook issues](/azure/automation/troubleshoot/runbooks).

> [!NOTE]
> Before opening a case, follow the steps in [Data to collect when opening a case for Azure Automation](/azure/automation/troubleshoot/collect-data-microsoft-azure-automation-case). This process will help us resolve your case as quickly as possible. 

## Reference

- [Start a runbook in Azure Automation](/azure/automation/start-runbooks)
- [Run runbooks on a Hybrid Runbook Worker](/azure/automation/automation-hrw-run-runbooks)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]