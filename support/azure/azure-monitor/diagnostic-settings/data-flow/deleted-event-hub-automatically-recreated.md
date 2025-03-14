---
title: Deleted Azure Event Hub is Automatically Recreated by Diagnostic Settings
description: Resolve issues with an Azure Event Hub that is automatically recreated by diagnostic settings after being deleted.
ms.date: 03/14/2025
ms.reviewer: jfanjoy, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues with configuring diagnostic settings
---
# Deleted Azure Event Hub is automatically recreated by diagnostic settings

This article provides a solution to an issue where a deleted Azure Event Hub is automatically recreated by Azure diagnostic settings or their configuration cache.

## Symptoms

You might see the following symptoms:

- When you delete an Event Hub from an Event Hub namespace, the Event Hub is recreated automatically by the data flowing into it through diagnostic settings.
- After you delete an Event Hub and all diagnostic settings configured to send data to it, it's recreated automatically.

## Cause

Here's are causes of the issue:

- When a diagnostic setting is configured to send data to an Azure Event Hub, if it receives an error that the Event Hub doesn't exist, it will try to create it and then continue trying to send the data.
- Azure diagnostic settings maintain a cache of configurations for approximately one hour. During this period, even if diagnostic settings have been removed, they will continue to send data to the destination such as a deleted Event Hub, causing it to be recreated.

## Solution

In a scenario where you delete an Event Hub from an Event Hub namespace, use one of the following methods to resolve the issue:

- Update the diagnostic settings to prevent them from sending data to the Event Hub.
- Delete the diagnostic settings.

In a scenario when you delete an Event Hub and related diagnostic settings, update the diagnostic settings to prevent them from sending data to the Event Hub, delete them, wait for at least one hour to allow their configuration cache to expire, and then delete the Event Hub.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
