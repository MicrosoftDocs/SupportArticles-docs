---
title: Log Emission and Diagnostic Settings Limitations for Partner Service Integration
description: "Understand which Azure resources emit logs to the partner service, how to verify log emission, and the limitations of diagnostic settings for partner solutions."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-solutions
ms.topic: troubleshooting-problem-resolution
ms.date: 08/04/2025
ai-usage: ai-assisted
---

# Log Emission and Diagnostic Settings Limitations for Partner Service Integration

This article explains which Azure resources emit logs to the partner service, how to verify log emission, and the limitations of diagnostic settings for partner solutions.

## Symptoms

- Logs are not appearing in the partner service as expected.
- Unable to configure diagnostic settings for certain resources.
- Error or warning about reaching the maximum number of diagnostic settings.
- Metrics data is not exported to the partner service.

## Cause

- Only resources listed in Azure Monitor resource log categories can emit logs to the partner service.
- Some resource types do not support sending logs because they lack monitoring log categories.
- Each Azure resource can have a maximum of five diagnostic settings.
- Export of Metrics data is not currently supported by partner solutions under Azure Monitor diagnostic settings.

## Solution

1. **Verify Resource Log Support:**
    - Navigate to the Azure diagnostic settings for the resource.
    - Check if a diagnostic setting option is available.
    - If not, the resource does not support sending logs.

2. **Check Diagnostic Settings Limit:**
    - Each resource can have up to five diagnostic settings.
    - If the limit is reached, remove unused settings before adding new ones.

3. **Metrics Export Limitation:**
    - Metrics data export is not supported for partner solutions. Only log data can be sent to the partner service.

> [!TIP]
> For more information, see [Azure Monitor supported resource log categories](/azure/azure-monitor/essentials/resource-logs-categories) and [diagnostic settings documentation](/azure/azure-monitor/essentials/diagnostic-settings).

## Related content

- [Create diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings)
-