---
title: Troubleshoot Runbook Execution Issues in Azure Automation
description: Provides troubleshooting guidance on runbook execution issues in Azure Automation.
ms.date: 06/30/2025
ms.service: azure-automation
ms.reviewer: adoyle, v-weizhu
ms.custom: sap:Runbook not working as expected
---
# Troubleshoot runbook execution issues in Azure Automation

Process automation in Azure Automation allows you to create and manage PowerShell, a PowerShell workflow, and graphical runbooks. Azure Automation executes your runbooks based on the logic defined within them. This article provides troubleshooting guidance on runbook execution issues in Azure Automation.

> [!NOTE]
>
> - If you use the Newtonsoft.Json v10, be sure to import this module explicitly so that your PowerShell 5.1 and PowerShell 7.1 runbooks that have a dependency on this version of the module function correctly.
> - PowerShell 7.1 is no longer supported by the parent product PowerShell. We recommend creating PowerShell 7.2 runbooks for long-term support. Learn more about [PowerShell 7.2 runbooks](/azure/automation/automation-runbook-types).
> - If none of the following solutions resolves your issue, see [Data to collect when opening a case for Microsoft Azure Automation](/azure/automation/troubleshoot/collect-data-microsoft-azure-automation-case) before opening a support case.
> - Azure Automation enables the recovery of runbooks deleted in the last 29 days. You can restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Troubleshoot error code 400, 403, and 429

|Error|Solution|
|---|---|
|`400 Bad Request: This webhook is expired or disabled`|To resolve this error, see [400 Bad Request status when calling a webhook](/azure/automation/troubleshoot/runbooks#expired%20webhook).|
|`The remote server returned an error: (403) Forbidden`|To resolve this error, see [Access blocked to Azure Storage, or Azure Key Vault, or Azure SQL](/azure/automation/troubleshoot/runbooks#scenario-access-blocked-to-azure-storage-or-azure-key-vault-or-azure-sql).|
|`this.Client.SubscriptionId cannot be null`|To resolve this error, see [Runbook fails with "this.Client.SubscriptionId cannot be null." error message](/azure/automation/troubleshoot/runbooks#runbook-fails-no-permission).|
|`ErrorCode: AuthorizationFailed` </br></br>`StatusCode: 403`|To resolve this error, see [Runbooks fail when dealing with multiple subscriptions](/azure/automation/troubleshoot/runbooks#runbook-auth-failure).|
|`429: The request rate is currently too large. Please try again.`|To resolve this error, see [429: The request rate is currently too large](/azure/automation/troubleshoot/runbooks#429).|

## Troubleshoot errors related to cmdlet not recognized, sign-in required, or subscription missing

|Error|Solution|
|---|---|
|Runbooks fail with the error `The subscription named <subscription name> cannot be found.`|This error can occur when the runbook doesn't use a managed identity to access Azure resources. To resolve this error, see [Unable to find the Azure subscription](/azure/automation/troubleshoot/runbooks#unable-to-find-subscription).|
|`Your Azure credentials haven't been set up or have expired, please run connect-azureRmAccount to set up your azure credentials.`|This error can occur when you don't use a managed identity. To resolve this error, use a managed identity.|
|`Command not recognized.`|This error often occurs when modules aren't imported or are out of date. Make sure that dependent modules in your script are [imported into Azure Automation](/azure/automation/automation-runbook-gallery#modules-in-the-powershell-gallery) and are the correct version. If the module is in your Automation account, there might be an issue loading it into the sandbox. Try adding an explicit `import-module` statement at the beginning of your runbook.|
|`Forbidden with client authentication scheme 'anonymous'`.|This error occurs when using credentials in an Azure Automation sandbox. To resolve this error, use a managed identity.|
|`Unable to require token for tenant <tenant-id>`.|This error occurs when using credentials in an Azure Automation sandbox. To resolve this error, use a managed identity.|
|`Server failed to authenticate the request.`|This error occurs when using credentials in an Azure Automation sandbox. To resolve this error, use a managed identity.|
|Errors when using the `Connect-AzAccount` cmdlet.|To resolve this issue, see [Sign-in to Azure account failed](/azure/automation/troubleshoot/runbooks#sign-in-failed).|
|`The term 'Connect-AzAccount' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if the path was included verify that the path is correct and try again.`|To resolve this error, see [Term not recognized as the name of a cmdlet, function, or script](/azure/automation/troubleshoot/runbooks#not-recognized-as-cmdlet).|
|Cmdlet fails in PnP PowerShell runbook on Azure Automation.|To resolve this issue, see [Cmdlet fails in PnP PowerShell runbook on Azure Automation](/azure/automation/troubleshoot/runbooks#scenario-cmdlet-fails-in-pnp-powershell-runbook-on-azure-automation).|
|`<cmdlet name>: The term <cmdlet name> is not recognized as the name of a cmdlet, function, script file, or operable program.`|To resolve this error, see [Cmdlet not recognized when executing a runbook](/azure/automation/troubleshoot/runbooks#cmdlet-not-recognized).|

## Troubleshoot issues with suspended runbooks, job failures, stopped runbooks, hybrid workers, and subscriptions

|Issue|Solution|
|---|---|
|Runbook is suspended or unexpectedly fails.|Review your [Job Statuses](/azure/automation/automation-runbook-execution#job-statuses) for runbook statuses and possible causes. [Add more output](/azure/automation/automation-runbook-output-and-messages#message-streams) to identify what happens before the runbook is suspended. [Handle any exceptions](/azure/automation/automation-runbook-execution#exceptions) thrown by your job. Retry your job when certain exceptions occur, such as WebSocket exceptions, to prevent transient network failures from causing runbook failures. If you have issues with a cmdlet, you might find more information with the service you try to use through the cmdlet. For example, the `New-AzAnalysisServicesServer` cmdlet related issues might end up with the Analysis Services team.|
|Job was tried three times, but it failed.|Check the [Automation Limits](/azure/azure-subscription-service-limits#azure-automation-limits). If the limitation applies to Azure sandboxes only, consider moving to a [hybrid worker](/azure/automation/automation-hybrid-runbook-worker).|
|Runbooks were working but stopped.|[Make sure to use a managed identity](/azure/automation/migrate-run-as-accounts-managed-identity#cert-renewal). If [using webhooks to start runbooks](/azure/automation/automation-webhooks#renew-webhook), make sure the webhook hasn't expired.|
|Issues when using a hybrid worker.|To resolve these issues, see [Hybrid Runbook Worker troubleshooting guide](/azure/automation/troubleshoot/hybrid-runbook-worker).|
|Runbook is stuck.|If you can't stop a runbook job in the Azure portal, try stopping it by using the PowerShell cmdlet `Stop-AzureRmAutomationJob` or `Stop-AzAutomationJob`.|
|Can't start or schedule a runbook.|To resolve this issue, make sure your runbook [is published](/azure/automation/manage-runbooks#publish-a-runbook).|
|Issues when using cmdlets that depend on binaries.|Some cmdlets rely on binaries, such as Microsoft Data Access Components (MDAC) or the Azure Fabric SDK. These cmdlets can't be run in the Azure Automation sandbox and must be executed through [a hybrid worker](/azure/automation/automation-hybrid-runbook-worker).|
|Issues when there are multiple subscriptions in a runbook.|To manage Azure resources across several subscriptions with Azure Automation, see [Dealing with multiple subscriptions](/azure/automation/troubleshoot/runbooks#runbook-auth-failure) to prevent errors.|

## Troubleshoot common issues

The following table helps you troubleshoot common issues with runbooks:

|Issue|Solution|
|---|---|
|Unable to create a new Automation job in the West Europe region.|This issue occurs because of scalability limits with the Automation service in the West Europe region. To resolve it, follow the steps in [Unable to create new Automation job in West Europe region](/azure/automation/troubleshoot/runbooks#scenario-unable-to-create-new-automation-job-in-west-europe-region).|
|Runbook bugs or Azure Automation issues.|To learn how to troubleshoot common scenarios, see [Troubleshoot runbook issues](/azure/automation/troubleshoot/runbooks#runbook-fails).|
|Runbook output and message issues.| To resolve such issues, see [Retrieve runbook output and messages](/azure/automation/automation-runbook-output-and-messages#runbook-output).|
|PowerShell module issues in Azure Automation.|To resolve such issues, see [Update Azure PowerShell modules in Automation](/azure/automation/automation-update-azure-modules).|

## References

- [How to start a runbook in Azure Automation](/azure/automation/start-runbooks)
- [PowerShell runbooks](/azure/automation/automation-runbook-types#powershell-runbooks)
- [Set-AzSqlDatabase](/powershell/module/az.sql/set-azsqldatabase) that sets properties for a database or move an existing database into an elastic pool
