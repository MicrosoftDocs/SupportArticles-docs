---
title: Diagnostic Settings Not Created as Expected After Moving a Resource
description: "Resolve issues where diagnostic settings are missing or not created as expected after moving, renaming, or recreating Azure resources."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-solutions
ms.topic: troubleshooting-problem-resolution
ms.date: 08/04/2025
ai-usage: ai-assisted
---

# Diagnostic Settings Not Created as Expected After Moving a Resource

This article helps you resolve issues where diagnostic settings are missing or not created as expected after moving, renaming, or recreating an Azure resource.

## Symptoms

- After moving, renaming, or recreating a resource, expected diagnostic settings are missing.
- Log and metric data is not being collected or forwarded as previously configured.
- Diagnostic settings do not appear on the resource after migration or recreation.

## Cause

When you move, rename, or migrate a resource across resource groups or subscriptions, diagnostic settings are not always moved with the resource. If you delete a resource and then recreate it with the same name, the diagnostic settings from the deleted resource might be automatically included with the new resource, depending on the resource type and configuration. This can result in either missing diagnostic settings or unexpected settings being applied.

## Solution

To ensure diagnostic settings behave as expected when moving, renaming, or recreating resources:

1. **Before moving, renaming, or deleting a resource:**
    - Go to the [Azure Portal](https://portal.azure.com) and sign in.
    - Locate the resource you plan to move, rename, or delete.
    - In the left-hand menu, select **Diagnostic settings** under the **Monitoring** section.
    - Review and delete all diagnostic settings associated with the resource.

2. **After moving or recreating a resource:**
    - Verify that the diagnostic settings are present and configured as needed.
    - If diagnostic settings are missing, manually recreate them to resume log and metric collection.
    - If unexpected diagnostic settings are present, review and update or remove them as appropriate.

> [!TIP]
> Always delete diagnostic settings for resources you plan to delete or no longer use. This helps keep your environment clean and prevents unexpected data collection or forwarding.

## Related content

- [Create diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings)
- [Lock resources using the Azure portal](/azure/azure-resource-manager/management/manage-resources-portal)