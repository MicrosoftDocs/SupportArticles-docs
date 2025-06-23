---
title: Troubleshoot issues with runbook execution start time
description: Discusses an issue where jobs don't start as expected in Azure Automation.
ms.date: 06/23/2025
ms.reviewer: adoyle, v-weizhu
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---
# Troubleshoot issues with runbook execution start time in Azure Automation

Process automation in Azure Automation lets you create and manage PowerShell, a PowerShell workflow, and graphical runbooks. Automation executes your runbooks based on the logic defined within them.

## Service-level agreement (SLA)

The SLA for runbook automation is 30 minutes. It's expected that 99.999 percent of runbooks start within 5 minutes of the scheduled time. For more information, see [SLAs for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

The *SLA for the Automation Service - Process Automation* defines the following:

- "Delayed Jobs" is the total number of Jobs, for a given Microsoft Azure subscription, that fail to start within 30 minutes of their Planned Start Times.
- "Job" means the execution of a Runbook.
- "Planned Start Time" is a time at which a Job is scheduled to begin executing.
- "Runbook" means a set of actions specified by you to run within Microsoft Azure.

> [!NOTE]
>
> - Azure Automation enables recovery of runbooks deleted in last 29 days - Restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).
> - Before opening a case, follow the steps in [Data to collect when opening a case for Azure Automation](/azure/automation/troubleshoot/collect-data-microsoft-azure-automation-case). This process helps us resolve your case as quickly as possible.

## References

- [Start a runbook in Azure Automation](/azure/automation/start-runbooks)
- [Azure Automation runbook types](/azure/automation/automation-runbook-types)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]