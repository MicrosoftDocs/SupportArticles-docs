---
title: Troubleshoot issues with runbook execution start time in Azure Automation
description: Learn how to troubleshoot Azure Automation runbook jobs that don't start on time. Understand the SLA for runbook start times and resolve delays.
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
# Troubleshoot issues with runbook execution start time in Azure Automation

## Summary

This article helps you troubleshoot delayed runbook start times in Azure Automation. It also explains the service-level agreement (SLA) that defines when runbook jobs are expected to start.

Process automation in Azure Automation allows you to create and manage PowerShell, a PowerShell workflow, and graphical runbooks. Azure Automation executes your runbooks based on the logic defined within them.

## Service-level agreement (SLA) for runbook start times

The SLA for runbook automation is 30 minutes. It's expected that 99.9 percent of runbooks start within 30 minutes of the planned start time. For more information, see [SLAs for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

The *SLA for the Automation Service - Process Automation* defines the following terms:

- "Delayed Jobs" is the total number of jobs, for a given Azure subscription, that fail to start within 30 minutes of their planned start times.
- "Job" means the execution of a runbook.
- "Planned Start Time" is a time at which a job is scheduled to begin executing.
- "Runbook" means a set of actions you specify to run within Azure.

> [!NOTE]
>
> - Azure Automation enables the recovery of runbooks deleted in the last 29 days. You can restore the deleted runbook by running a PowerShell script as a job in your Automation account. For more information, see [Restore deleted runbook](/azure/automation/manage-runbooks#restore-deleted-runbook).
> - Before opening a case, follow the steps in [Data to collect when opening a case for Azure Automation](/azure/automation/troubleshoot/collect-data-microsoft-azure-automation-case). This process helps resolve your case as quickly as possible.

## References

- [Start a runbook in Azure Automation](/azure/automation/start-runbooks)
- [Azure Automation runbook types](/azure/automation/automation-runbook-types)