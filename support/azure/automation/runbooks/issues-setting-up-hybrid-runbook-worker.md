---
title: Common Runbook Creation Problems on Hybrid Runbook Worker
description: Describes some common issues that might occur when you set up a runbook on Hybrid Runbook Worker.
ms.date: 06/13/2025
ms.reviewer: adoyle
ms.service: azure-automation
ms.custom: sap:Runbook not working as expected
---

# : Common Runbook creation problems

This article describes common issues you might experience when you set up runbooks on a hybrid runbook worker.

> [!NOTE]
> The agent-based user hybrid runbook worker (Windows and Linux) was retired on August 31, 2024, and is no longer supported. For more information, see [migration guidance](/azure/automation/migrate-existing-agent-based-hybrid-worker-to-extension-based-workers).

## Troubleshoot tools

- Connectivity problems are a common cause of issues with Hybrid Runbook Workers. Use the [Test Cloud Connectivity tool](azure/azure-monitor/agents/agent-windows-troubleshoot?tabs=UpdateMMA#connectivity-issues) to verify that your environment is correctly configured.

- Run the offline version of the [agent registration script](/azure/azure-monitor/agents/agent-windows-troubleshoot?tabs=UpdateMMA#log-analytics-troubleshooting-tool) to troubleshoot hybrid worker prerequisites. Although the script includes some checks specific to update management, most of the requirements also apply to hybrid workers.

## Common issues and solutions

Review the following table to resolve other common issues.

|Issue/ Error |Solution|
|-----|---------------|
| VM extension-based Hybrid Runbook Worker issues|[Troubleshoot VM extension-based Hybrid Runbook Worker issues in Automation](/azure/automation/troubleshoot/extension-based-hybrid-runbook-worker)|
|Error: Job action 'Activate' cannot be run.|See the [hybrid runbook worker troubleshooting guide under "Runbook execution fails"](/azure/automation/troubleshoot/hybrid-runbook-worker#runbook-execution-fails).|
|Error: No certificate was found in the certificate store.|To resolve this issue, follow the ["No certificate was found" section of the hybrid worker troubleshooter](/azure/automation/troubleshoot/hybrid-runbook-worker#no-cert-found).|
|Error: Machine is already registered.|Follow the troubleshooting guide for ["Unable to add a hybrid runbook worker"](/azure/automation/troubleshoot/hybrid-runbook-worker#already-registered).|

## Reference

- [Automation hybrid runbook workers](/azure/automation/automation-hybrid-runbook-worker)
- [Deploy an extension-based Windows or Linux User Hybrid Runbook Worker in Azure Automation](/azure/automation/extension-based-hybrid-runbook-worker-install)
- [Migrate the existing agent-based hybrid workers to extension-based hybrid workers](/azure/automation/migrate-existing-agent-based-hybrid-worker-to-extension-based-workers)
