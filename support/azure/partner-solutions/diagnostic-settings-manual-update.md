---
title: Manual Updates to Diagnostic Settings Created via Tag Rules
description: "Understand the limitations and behavior when manually updating diagnostic settings that are created based on tag rules in Azure."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 08/04/2025
ai-usage: ai-assisted
---

# Manual Updates to Diagnostic Settings Created via Tag Rules

This article explains the behavior and limitations when attempting to manually update diagnostic settings that are created automatically based on tag rules in Azure.

## Symptoms

- Changes made to log categories in the diagnostic settings page do not persist.
- Unchecked log categories revert to their default settings after saving.
- Modifying destination details results in a new diagnostic setting being created with the original configuration.
- Unable to customize diagnostic settings beyond what is defined by tag rules.

## Cause

Diagnostic settings created via tag rules are managed automatically. Manual changes to log categories through the Azure portal are not supported. Even if you uncheck log categories and save, the settings will revert to the defaults specified by the tag rules. If you modify destination details, a new diagnostic setting is created with the original configuration, subject to the Azure limitation of a maximum of five diagnostic settings per resource.

## Solution

- Be aware that manual changes to log categories in diagnostic settings managed by tag rules will not persist.
- To change the configuration, update the tag rules that govern the diagnostic settings.
- If you need to modify destination details, ensure you do not exceed the maximum of five diagnostic settings per resource.

> [!TIP]
> For more information about diagnostic settings and tag rules, see [Create diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings).

## Related content

- [Create diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings)
- [Resource tag rules in Azure](/azure/azure-resource-manager/management/tag-resources)