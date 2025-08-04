---
title: Troubleshoot log emission and diagnostic settings limitations for Azure partner service integration
description: "Learn how to identify and resolve issues with log emission and diagnostic settings when integrating Azure resources with partner solutions."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 08/04/2025
ai.usage: ai-assisted

#customer intent: As an Azure administrator, I want to understand and resolve issues with log emission and diagnostic settings for partner service integrations so that I can ensure logs are properly sent and monitored.

---

# Troubleshoot log emission and diagnostic settings limitations for Azure partner service integration

This article helps you identify and resolve issues that prevent Azure resources from emitting logs to partner services. It covers common causes, limitations of diagnostic settings, and steps to verify and correct configuration issues.

## Prerequisites

- Access to the Azure portal.
- Sufficient permissions to view and modify diagnostic settings on Azure resources.
- Knowledge of the partner solution integration requirements.

## Potential quick workarounds

1. Remove unused diagnostic settings if the resource has reached the maximum allowed.
1. Confirm that the resource type supports diagnostic settings and log categories.

## Troubleshooting checklist

### Verify resource log support

- Navigate to the Azure portal and select the affected resource.
- Go to **Diagnostic settings**.
- Check if you can add a new diagnostic setting. If not, the resource may not support log emission.

### Check diagnostic settings limit

- Each Azure resource supports up to five diagnostic settings.
- If you see an error about reaching the maximum, remove unused settings before adding new ones.

### Confirm metrics export limitation

- Metrics data export is not supported for partner solutions via Azure Monitor diagnostic settings. Only log data can be sent.

## Causes and/or solutions

### Cause: Resource does not support log emission

Some Azure resource types do not emit logs because they lack monitoring log categories.

**Solution:**

1. Review the [Azure Monitor supported resource log categories](/azure/azure-monitor/essentials/resource-logs-categories).
1. If your resource is not listed, it cannot emit logs to partner services.

### Cause: Diagnostic settings limit reached

Each resource can have a maximum of five diagnostic settings.

**Solution:**

1. Remove unused diagnostic settings from the resource.
1. Add a new diagnostic setting for the partner service.

### Cause: Metrics data not exported

Export of metrics data is not currently supported for partner solutions.

**Solution:**
- Only log data can be sent to the partner service. No action is needed for metrics.

## Advanced troubleshooting and data collection

- Collect screenshots of the diagnostic settings pane for the affected resource.
- Note any error messages or warnings shown when configuring diagnostic settings.
- Gather the resource type and region information for support escalation.

## Related content

- [Azure Monitor supported resource log categories](/azure/azure-monitor/essentials/resource-logs-categories)
- [Create diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings)