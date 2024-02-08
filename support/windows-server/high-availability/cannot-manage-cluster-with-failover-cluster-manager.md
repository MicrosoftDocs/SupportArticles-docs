---
title: Can't manage cluster with failover cluster manager
description: Helps fix an error that you receive when managing cluster by using failover cluster management console.
ms.date: 12/09/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.subservice: high-availability
---
# Unable to manage cluster using failover cluster manager. Error Received: "Connection to the cluster is not allowed since you are not an administrator on the cluster node(s)"

This article provides a solution to fix an error that you receive when managing cluster by using failover cluster management console.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2462468

## Symptoms

While managing cluster using failover cluster management console, we receive the following error:

> Error  
The operation has failed.  
An error occurred connecting to the cluster '.'.  
>
> [Expanded Information]  
An error occurred trying to display the cluster information.  
Connection to the cluster is not allowed since you are not an administrator on the cluster node(s) (Node name)  

:::image type="content" source="media/cannot-manage-cluster-with-failover-cluster-manager/error-message-dialog.png" alt-text="Screenshot of the Error window which shows The operation has failed error message.":::
or

When you run the Cluster validation, you receive the following error:

> Unable to determine if you have administrator privileges on server "Node name" . Ensure sure that the server service and remote registry services are enabled, and that the firewall is properly configured for remote access.  

Managing cluster using command prompt will still work and will be able to list groups (cluster group), resources (cluster. res) and even be able to do failover of groups (cluster group "cluster group" /move) but will error out while managing cluster using GUI (Failover Cluster Management console).

> [!Note]
> Command to list group & resources, move group are given in bracket.

## Cause

This issue occurs if you have server service not started on the node that is shown in the error. Expand the error to check node name.
Additionally, you may get above mentioned issue due to incorrect protocol enabled which are required for Microsoft clustering.

## Resolution

Open services console and start the Server service.

Ensure the cluster network has both the mentioned below protocol checked:

1. Client for Microsoft networks
2. File and printer sharing for Microsoft networks
