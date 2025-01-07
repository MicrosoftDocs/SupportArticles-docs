---
title: 404 Error When Managing Objects Using Microsoft Graph
description: Provides a solution to a 404 error when you try to manage a Microsoft Entra object that was just created using Microsoft Graph.
ms.date: 01/07/2025
ms.reviewer: kakapans, v-weizhu
ms.service: entra-id
ms.custom: sap:Problem with querying or provisioning resources
---
# 404 error when managing objects using Microsoft Graph

This article provides a solution to a 404 (object not found) error that occurs when you try to manage a Microsoft Entra object that was just created using Microsoft Graph.

## Symptoms

Suppose you create an object, such as a user, group, or application, in Microsoft Entra ID using Microsoft Graph. When trying to manage the object, such as getting, updating, or patching it, shortly after its creation, you receive a 404 (object not found) error. 

## Cause

The [Microsoft Entra ID architecture](/entra/architecture/architecture) ensures that all data is replicated across geographically distributed data centers. This issue occurs due to a replication delay in propagating the newly created object across all data centers. This replication process might take several minutes to complete.

As shown in the following diagram, when your application makes a request via Microsoft Graph to create a user in Microsoft Entra ID, the service begins the replication process and returns an object for that user, which includes the user's ID and other relevant data used in your request. If your application immediately tries to update this user, it might connect to a replica that hasn't yet been updated with the new user object. So, you receive a 404 error because the user isn't found on that replica.

 :::image type="content" source="media/404-not-found-error-manage-objects-microsoft-graph/404-not-found-error-diagram.png" alt-text="Diagram that explains the cause of the 404 error.":::

## Solution

To resolve this issue, wait some time and retry the update request. If the 404 error still occurs after retrying, double your waiting time and try again. By allowing sufficient time for replication, you can prevent this error from happening again.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]