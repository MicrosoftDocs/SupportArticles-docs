---
title: Troubleshoot Error Codes During Runbook Execution in Azure Automation
description: Helps you troubleshoot some errors that occur during runbook execution in Azure Automation.
ms.date: 06/27/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Troubleshoot error codes during runbook execution in Azure Automation

When using runbooks in Azure Automation, you might encounter issues due to runtime or PowerShell exceptions or specific error messages. This article lists some issues and provides solutions to them.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in the last 29 days. You can restore the deleted runbook by running a PowerShell script as a job in your Automation account.  For more information, see [Restore a deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Troubleshoot error messages

Review the following table to resolve runbook execution-related error messages:

|Error|Description|Solution|
|-----|-----------|
|Unable to create a new Automation job in the West Europe region.|This issue occurs due to the scalability limits of the Automation service in the West Europe region. |To resolve this issue, follow the steps in [Unable to create new Automation job in West Europe region](/azure/automation/troubleshoot/runbooks#scenario-unable-to-create-new-automation-job-in-west-europe-region).|
|`The subscription cannot be found.`|This issue can occur when the runbook doesn't use a managed identity to access Azure resources. |To resolve this issue, follow the steps in [Unable to find the Azure subscription](/azure/automation/troubleshoot/runbooks#unable-to-find-subscription).|
|`Strong authentication enrollment is required.`|If you have multifactor authentication on your Azure account, you can't use a Microsoft Entra user to authenticate to Azure.|To resolve this issue, see [Authentication to Azure fails because multifactor authentication is enabled](/azure/automation/troubleshoot/runbooks#auth-failed-mfa).|
|Runbook fails with "No permission" or some variation.|The managed identity might not have the same permissions to Azure resources as your current account.|Make sure that your managed identity [has permission to access any resources](/azure/role-based-access-control/role-assignments-portal) used in your script.|
|Error: "429: The request rate is currently too large. Please try again."|This error can occur when retrieving job output from a runbook that has many verbose streams.|To resolve this error, see [The request rate is too large](/azure/automation/troubleshoot/runbooks#429).|
|`400 Bad Request.`|A "400 Bad Request" error can occur for several reasons. First, verify if the runbook works outside of Azure Automation. Typically, the runbook code doesn't work with this error due to:<br><br>- Missing values.<br>- Wrong values being passed.<br>- Older modules being used.<br>- A referenced resource being disabled; for example, the runbook calls a disabled or expired webhook.|To resolve this error, see [400 Bad Request status when calling a webhook](/azure/automation/troubleshoot/runbooks#expired%20webhook).|
|`Resource not found.`|Check the values provided for the resource. |The three values to check are:<br><br>- Resource name<br>- Resource group name<br>- Subscription<br><br>Confirm that the runbook has permissions in the subscription that contains the resource. To change the subscription, you can use the `Set-AzContext` or `az account set` command together with the `-DefaultProfile` parameter. Many commands provide a subscription parameter that allows a different subscription to be used than the current one.<br>Sign in to the Microsoft Azure portal. Find the resource being used and examine the resource name, resource group, and subscription.|

If none of these solutions addresses your issue, see [Troubleshoot runbook issues](/azure/automation/troubleshoot/runbooks).

> [!NOTE]
> Before opening a case, follow the steps in [Data to collect when opening a case for Azure Automation](/azure/automation/troubleshoot/collect-data-microsoft-azure-automation-case). This process will help us resolve your case as quickly as possible. 

## References

- [Start a runbook in Azure Automation](/azure/automation/start-runbooks)
- [Run Automation runbooks on a Hybrid Runbook Worker](/azure/automation/automation-hrw-run-runbooks)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
