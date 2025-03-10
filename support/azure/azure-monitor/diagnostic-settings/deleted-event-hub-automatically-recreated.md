---
title: Deleted Azure Event Hub is automatically recreated by Diagnostic Settings
description: Resolve issues with an Azure Event Hub that is automatically recreated by Diagnostic Settings after being deleted.
ms.date: 03/10/2025
ms.reviewer: jfanjoy
ms.service: azure-monitor
---

# Deleted Azure Event Hub is automatically recreated by Diagnostic Settings

## Symptoms

1. When an Azure Event Hub is deleted from an Azure Event Hub Namespace, it is automatically recreated by the data flowing into the Event Hub through an Azure Diagnostic Setting.

1. After deleting an Azure Event Hub and all Azure Diagnostic Settings configured to send data to it, the Event Hub is automatically recreated.

## Causes

1. This is by-design behavior of the Azure Diagnostic Settings.  When configured to send data to an Azure Event Hub, if the Diagnostic Setting receives an error that the Event Hub does not exist, it will attempt to create it and then continue attempting to send the data.

1. Azure Diagnostic Settings maintain a cache of configurations that lasts approximately 1 hour.  Since the Diagnostic Setting will continue to send data for up to an hour after having been deleted, an Azure Event Hub that is the destination could get recreated even though the relevant Diagnostic Setting was deleted.

## Resolutions

1. Update any Diagnostic Settings that are configured to send data to the problem Azure Event Hub so that either the Diagnostic Setting is no longer configured to send data to that destination, or delete the Diagnostic Settings.

1. Update any Diagnostic Settings that are configured to send data to the problem Azure Event Hub so that either the Diagnostic Setting is no longer configured to send data to that destination, or delete the Diagnostic Settings.  Wait a minimum of 1 hour, then delete the Azure Event Hub.
