---
title: 404 error when managing objects using Microsoft Graph
description: Provides a solution to a 404 Not Found error when you try to manage a Microsoft Entra object that's just created using Microsoft Graph.
ms.date: 12/27/2024
ms.reviewer: kakapans, v-weizhu
ms.service: entra-id
ms.custom: sap:Problem with querying or provisioning resources
---
# 404 Not Found error when managing objects using Microsoft Graph

This article provides a solution to a 404 Not Found error that occurs when you try to manage a Microsoft Entra object that's just created using Microsoft Graph.

## Symptoms

Assume that you creates an object, such as a user, group, or application, in Microsoft Entra ID using Microsoft Graph. When trying to manage the object, such as get, update or patch it, shortly after its creation, you get a 404 Not Found error. 

## Cause

[Microsoft Entra ID architecture](/entra/architecture/architecture) ensures that all data is replicated across geographically distributed data centers. This issue occurs due to a replication delay for the newly created object to be propagated across all data centers. It can take several minutes for this replication process to complete.

As shown in the following diagram, when your application makes a request via Microsoft Graph to create a user in Microsoft Entra ID, the service begins the replication process and returns an object for that user, which includes the user's ID and other relevant data used in your request. If your application immediately attempts to update this user, it might connect with a replica that hasn't been updated with the new user object yet. Consequently, you receive a 404 error because the user isn't found on that replica.

 :::image type="content" source="media/404-not-found-error-manage-objects-microsoft-graph/404-error-diagram.png" alt-text="Diagram that explains the cause of the 404 error." border="false":::

## Solution

To resolve this issue, wait for some time and then retry the update request. If the 404 error still occurs upon retrying, increase your waiting time by doubling it before attempting again. By allowing sufficient time for replication, you can prevent further occurrences of this error.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]