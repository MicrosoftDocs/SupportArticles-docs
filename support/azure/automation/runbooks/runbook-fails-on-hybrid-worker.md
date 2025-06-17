---
title: Troubleshoot Hybrid Runbook Worker Job Failures in Azure Automation
description: Describes some common issues that might occur when you run a runbook on Hybrid Runbook Worker.
ms.date: 06/13/2025
ms.reviewer: adoyle
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---

# Hybrid runbook worker job isn't working as expected

This article provides guidance for troubleshooting and resolving issues with Hybrid Runbook Workers in Azure Automation.

> [!NOTE]
> Azure Automation enables recovery of runbooks deleted in the last 29 days. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).

## Troubleshoot connectivity issues

Connectivity problems are a common cause of issues with Hybrid Runbook Workers. Use the [Test Cloud Connectivity tool](/azure/azure-monitor/agents/agent-windows-troubleshoot?tabs=UpdateMMA#connectivity-issues) to verify that your environment is correctly configured.

## General troubleshooting

| **Issue** | **Resolution** |
|----------|----------------|
| Runbooks behave differently on a Hybrid Worker than in Azure Automation. | See [Runbook permissions](/azure/automation/automation-hrw-run-runbooks#runbook-permissions) for information on authentication differences. |
| Error: No certificate was found. | Follow the [No Certificate Found](/azure/automation/troubleshoot/hybrid-runbook-worker#no-cert-found) section in the troubleshooting guide. |
| You need to troubleshoot a custom runbook. | See [Troubleshoot runbook issues](/azure/automation/troubleshoot/runbooks). |
| You need to check job status. | Review [job details and statuses](/azure/automation/automation-runbook-execution#job-statuses). |
| Hybrid worker doesn't run jobs or is unresponsive. | Troubleshoot using [Hybrid Runbook Worker diagnostics](/azure/automation/troubleshoot/hybrid-runbook-worker). |
| Runbooks suddenly stopped working. | Ensure you've [migrated to managed identity](/azure/automation/migrate-run-as-accounts-managed-identity?tabs=sa-managed-identity#cert-renewal) and that webhooks haven't expired. |
| Need help with passing parameters into a webhook. | See [Start a runbook from a webhook](/azure/automation/automation-webhooks#parameters-used-when-the-webhook-starts-a-runbook). |
| You want to use both `Az` and `AzureRM` modules in runbook. | This scenario isn't supported. Use only [Az modules in runbooks](/azure/automation/automation-update-azure-modules). |
| Can't start or schedule a runbook. | Verify that the runbook is in a [published state](/azure/automation/manage-runbooks#publish-a-runbook). |
| Runbook is suspended or failed unexpectedly. | Review [job statuses](/azure/automation/automation-runbook-execution#job-statuses). Add logging to the runbook using [output streams](/azure/automation/automation-runbook-output-and-messages#working-with-message-streams). If the job fails three times, check [Automation limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#automation-limits) and consider using a [Hybrid Worker](/azure/automation/automation-hybrid-runbook-worker). |


### Windows Hybrid Runbook Worker issues

| **Issue** | **Resolution** |
|-----------|----------------|
| Event 4502 appears in the Operations Manager log. | See [Event 4502](/azure/automation/troubleshoot/hybrid-runbook-worker#event-4502). |
| Script using `Connect-MsolService` can't connect to Microsoft 365. | See [Sandbox can't connect to Microsoft 365](/azure/automation/troubleshoot/hybrid-runbook-worker#scenario-orchestratorsandboxexe-cant-connect-to-microsoft-365-through-proxy). |
| Machine is running but not sending heartbeat data. | See [Hybrid worker not reporting](/azure/automation/troubleshoot/hybrid-runbook-worker#corrupt-cache). |


### Linux Hybrid Runbook Worker issues

| **Issue** | **Resolution** |
|-----------|----------------|
| Unexpected password prompt appears when using `sudo`. | See [Linux runbook worker prompts for password](/azure/automation/troubleshoot/hybrid-runbook-worker#prompt-for-password). |
| Log file shows "The specified class does not exist." | See [Class does not exist error](/azure/automation/troubleshoot/hybrid-runbook-worker#class-does-not-exist). |
| Linux job is stuck in **Running** state | 1. Switch to `sudo` permissions: `sudo su`<br>2. Check to make sure that `hwd` service is running: `systemctl status hwd.service`<br>3. Open the following file in Hybrid Worker: `vi /lib/systemd/system/hwd.service`<br>4. Update the setting from `CPUQuota=25%` to `CPUQuota=` to make the usage unrestricted as shown in the following example: <br><br>`[Unit]`<br>`Description=HW Service`<br>`After=network.target`<br>`[Service]`<br>`Type=simple`<br>`ExecStart=/usr/bin/python3 .../automationWorkerStarterScript.py`<br>`TimeoutStartSec=5`<br>`Restart=always`<br>`RestartSec=10s`<br>`TimeoutStopSec=600`<br>`CPUQuota=`<br>`KillMode=process`<br>`[Install]`<br>`WantedBy=multi-user.target`<br><br> 5. Restart `hwd` service: <br>`systemctl daemon-reload` <br> `systemctl restart hwd.service`<br>|

## Other error messages

| **Error** | **Resolution** |
|-----------|----------------|
| "The subscription cannot be found" | This usually means the runbook isn't using a managed identity. Follow steps in [Unable to find subscription](/azure/automation/troubleshoot/runbooks#unable-to-find-subscription). |
| "Strong authentication enrollment is required." | See [Authentication to Azure failed due to MFA](/azure/automation/troubleshoot/runbooks#auth-failed-mfa). |
| "No permission" or similar error | Ensure the [Managed Identity has proper permissions](/azure/role-based-access-control/role-assignments-portal). |

## Reference

- [Automation Hybrid Runbook Worker overview](/azure/automation/automation-hybrid-runbook-worker)  
- [Deploy a Windows Hybrid Runbook Worker](/azure/automation/automation-windows-hrw-install)  
- [Deploy a Linux Hybrid Runbook Worker](/azure/automation/automation-linux-hrw-install)  
- [Run runbooks on a Hybrid Runbook Worker](/azure/automation/automation-hrw-run-runbooks)