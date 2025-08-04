---
title: Diagnostic Settings Persist After Resource Deletion or Move
description: "Learn how to resolve issues where diagnostic settings persist after deleting, renaming, or moving Azure resources."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-solutions
ms.topic: troubleshooting-problem-resolution
ms.date: 08/04/2025
ai-usage: ai-assisted
---

# Diagnostic Settings Persist After Resource Deletion or Move

This article addresses a scenario where diagnostic settings remain active or are unexpectedly applied to new resources after deleting, renaming, or moving Azure resources. It explains the cause and provides steps to resolve and prevent this issue.

## Symptoms

- After deleting, renaming, or moving a resource, diagnostic settings continue to collect and forward logs.
- When recreating a resource with the same name, previous diagnostic settings are automatically applied.
- Unexpected log or metric data is sent to previously configured destinations.

## Cause

If diagnostic settings are not deleted before deleting, renaming, or moving a resource, they may persist and be associated with new or moved resources. This can result in the continued collection and forwarding of logs and metrics, even for resources you no longer intend to monitor.

## Solution

To prevent diagnostic settings from persisting or being reapplied:

1. **Before deleting, renaming, or moving a resource:**
    - Go to the [Azure Portal](https://portal.azure.com) and sign in.
    - Locate the resource you plan to delete, rename, or move.
    - In the left-hand menu, select **Diagnostic settings** under the **Monitoring** section.
    - Review the list of diagnostic settings.
    - Delete all diagnostic settings associated with the resource.

2. **If you have already deleted or moved the resource:**
    - Check for any unexpected diagnostic settings on new or moved resources.
    - Manually delete any unwanted diagnostic settings to stop unnecessary data collection and forwarding.

> [!TIP]
> Always delete diagnostic settings for resources you plan to remove or no longer use to keep your environment clean and avoid unexpected data flow.

## Related content

- [Create diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings)
- [Lock resources using the Azure portal](/azure/azure-resource-manager/management/manage-resources-portal)