---
title: Deleted Event Hub Is Automatically Re-created by Diagnostic Settings
description: Resolves issues with an Azure event hub that is automatically re-created by diagnostic settings after being deleted.
ms.date: 03/19/2025
ms.reviewer: jfanjoy, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues with configuring diagnostic settings
---
# Deleted Azure event hub is automatically re-created by diagnostic settings

This article provides a solution to an issue where a deleted Azure event hub is automatically re-created by Azure diagnostic settings or their configuration cache.

## Symptoms

You might see the following symptoms:

- When you delete an event hub from an Event Hubs namespace, the event hub is re-created automatically by the data flowing into it through the diagnostic settings.
- After you delete an event hub and all diagnostic settings configured to send data to it, the event hub is re-created automatically.

## Cause

Here are the causes of the issue:

- When a diagnostic setting is configured to send data to an Azure event hub, if it receives an error indicating that the event hub doesn't exist, the diagnostic setting will try to create it and then continue trying to send the data.
- Azure diagnostic settings maintain a cache of configurations for approximately one hour. During this period, even if the diagnostic settings were removed, they'll continue to send data to the destination, such as a deleted event hub, causing the event hub to be re-created.

## Solution

In a scenario where you delete an event hub from an Event Hubs namespace, use one of the following methods to resolve the issue:

- Update the diagnostic settings to prevent them from sending data to the event hub.
- Delete the diagnostic settings.

In a scenario where you delete an event hub and related diagnostic settings, use this method to resolve the issue:

- Update the diagnostic settings to prevent them from sending data to the event hub, delete them, wait at least one hour to allow their configuration cache to expire, and then delete the event hub.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
