---
title: Deleted Event Hub is automatically recreated by Diagnostic Settings
description: Learn why a deleted Azure event hub is automatically recreated by diagnostic settings, and follow these steps to stop it from being recreated.
ms.date: 03/19/2025
ms.reviewer: jfanjoy, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues with configuring diagnostic settings
---
# Deleted Azure Event Hub is automatically recreated by Azure Diagnostic Settings

## Summary

This article provides a solution to an issue where Azure Diagnostic Settings or their configuration cache automatically recreates a deleted Azure Event Hub.

## Symptoms

You might see the following symptoms:

- When you delete an event hub from an Event Hubs namespace, the event hub is automatically recreated by the data flowing into it through the diagnostic settings.
- After you delete an event hub and all diagnostic settings configured to send data to it, the event hub is automatically recreated.

## Cause

Here are the causes of the issue:

- When you configure a diagnostic setting to send data to an Azure event hub, if it receives an error indicating that the event hub doesn't exist, the diagnostic setting tries to create the event hub and then continues trying to send the data.
- Azure diagnostic settings maintain a cache of configurations for approximately one hour. During this period, even if you remove the diagnostic settings, they continue to send data to the destination, such as a deleted event hub, causing the event hub to be recreated.

## Solution

If you delete an event hub from an Event Hubs namespace, use one of the following methods to resolve the issue:

- Update the diagnostic settings to stop sending data to the event hub.
- Delete the diagnostic settings.

If you delete an event hub and related diagnostic settings, use the following method to resolve the issue:

- Update the diagnostic settings to stop sending data to the event hub, delete them, wait at least one hour to allow their configuration cache to expire, and then delete the event hub.

 
