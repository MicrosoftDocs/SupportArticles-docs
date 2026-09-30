---
title: Troubleshoot common runbook creation problems on Hybrid Runbook Worker
description: Troubleshoot common runbook creation problems on Hybrid Runbook Worker, including certificate, registration, and job activation errors. Learn how to fix them.
ms.date: 09/29/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-automation
ms.custom: sap:Problems with Hybrid Runbook Worker
ai-usage: ai-assisted
---

# Troubleshoot common runbook creation problems on Hybrid Runbook Worker

## Summary

This article describes common runbook creation problems on a Hybrid Runbook Worker and helps you resolve errors related to connectivity, certificates, registration, and job activation.

> [!NOTE]
> The agent-based user Hybrid Runbook Worker (Windows and Linux) was retired on August 31, 2024, and is no longer supported. For more information, see [migration guidance](/azure/automation/migrate-existing-agent-based-hybrid-worker-to-extension-based-workers).

## Tools to troubleshoot Hybrid Runbook Worker issues

The following tools can help you troubleshoot issues with Hybrid Runbook Workers:

- Connectivity problems are a common cause of issues with Hybrid Runbook Workers. Use the [Test Cloud Connectivity tool](/azure/azure-monitor/agents/agent-windows-troubleshoot?tabs=UpdateMMA#connectivity-issues) to verify that your environment is correctly configured.
- Run the offline version of the [agent registration script](/azure/azure-monitor/agents/agent-windows-troubleshoot?tabs=UpdateMMA#log-analytics-troubleshooting-tool) to troubleshoot Hybrid Runbook Worker prerequisites. Although the script includes some checks specific to update management, most of the requirements also apply to Hybrid Runbook Workers.

## Common runbook issues and solutions

Review the following table to resolve other common issues.

| Issue or error | Solution |
|-----|---------------|
| Virtual machine (VM) extension-based Hybrid Runbook Worker issues | See [Troubleshoot VM extension-based Hybrid Runbook Worker issues in Automation](/azure/automation/troubleshoot/extension-based-hybrid-runbook-worker). |
| Error: "Job action 'Activate' cannot be run." | See the [hybrid runbook worker troubleshooting guide under "Runbook execution fails"](/azure/automation/troubleshoot/hybrid-runbook-worker#runbook-execution-fails).|
| Error: "No certificate was found in the certificate store."| To resolve this issue, follow the ["No certificate was found" section of the hybrid worker troubleshooter](/azure/automation/troubleshoot/hybrid-runbook-worker#no-cert-found). |
| Error: "Machine is already registered." | Follow the troubleshooting guidance in [Unable to add a hybrid runbook worker](/azure/automation/troubleshoot/hybrid-runbook-worker#already-registered). |

## Reference

- [Automation hybrid runbook workers](/azure/automation/automation-hybrid-runbook-worker)
- [Deploy an extension-based Windows or Linux User Hybrid Runbook Worker in Azure Automation](/azure/automation/extension-based-hybrid-runbook-worker-install)
- [Migrate the existing agent-based hybrid workers to extension-based hybrid workers](/azure/automation/migrate-existing-agent-based-hybrid-worker-to-extension-based-workers)
