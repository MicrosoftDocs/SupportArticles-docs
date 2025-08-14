---
title: Log Forwarding Persists After Service Is Disabled
description: "Learn how to resolve persistent log forwarding in Azure when a service is disabled but diagnostic settings remain active due to a delete lock."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution 
ms.date: 08/04/2025
ai-usage: ai-assisted
---

# Log Forwarding Persists After Service Is Disabled

This article addresses a scenario where log forwarding continues unexpectedly after an Azure Native Integrations service is disabled. It explains the underlying cause and provides steps to resolve the issue by managing resource locks in Azure.

> [!TIP]
> If the delete lock is removed *after* the service has already been deleted, the diagnostic settings must be manually cleaned up to stop log forwarding.

## Symptoms

Logs continue to be emitted and diagnostic settings remain active on monitored resources, even after the service is disabled or tag rules are modified to exclude certain resources.

## Cause

A delete lock is applied to the resource or the resource group containing the resource. This lock prevents the cleanup of diagnostic settings, which causes logs to continue being forwarded.

## Solution

To remove the delete lock from the affected resource or resource group:

1. Go to [Azure Portal](https://portal.azure.com) and sign in using your Azure credentials.
1. Use the **Search** bar at the top of the portal to locate the specific **resource** or **resource group**.
1. Select the resource name to open its **Overview** page.
1. In the left-hand menu, under the **Settings** section, select **Locks**.
1. You’ll see a list of any **management locks** applied to the resource.
1. Look for a lock with **Lock type: Delete** (often labeled as `CanNotDelete`).
1. Select the **ellipsis (⋯)** next to the lock entry.
1. Choose **Delete** from the dropdown menu.
1. Confirm the deletion when prompted.

## Related content
[Lock resources using the Azure portal](/azure/azure-resource-manager/management/manage-resources-portal)
[Configure locks - Azure portal](/azure/azure-resource-manager/management/lock-resources?tabs=json)
