---
title: Can't delete load balancer with a private link service or a private link service with private endpoint connections
description: Provides a solution to the CannotDeleteLoadBalancerWithPrivateLinkService or PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted error when you delete an AKS cluster.
ms.date: 12/04/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the CannotDeleteLoadBalancerWithPrivateLinkService or PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# A load balancer with a private link service or a private link service with private endpoint connections can't be deleted

This article discusses how to identify and resolve the `CannotDeleteLoadBalancerWithPrivateLinkService` or `PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted` error that occurs when you try to delete a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to delete an AKS cluster, you receive one of the following error messages:

- For the `CannotDeleteLoadBalancerWithPrivateLinkService` error code:

  > internalErrorCode: "CannotDeleteLoadBalancerWithPrivateLinkService"
  >
  > StatusCode=BadRequest
  >
  > {
  >
  > "Cannot delete load balancer ...../providers/Microsoft.Network/loadBalancers/kubernetes-internal since it is referenced by private link service ...../providers/Microsoft.Network/privateLinkServices/test. Please delete private link service prior to deleting load balancer."
  >
  > }

- For the `PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted` error code:

  > internalErrorCode: "PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted"
  >
  > StatusCode=BadRequest
  >
  > {
  >
  > message: "Private link service ...../Microsoft.Network/privateLinkServices/test cannot be deleted since it has 1 private endpoint connection. Please delete all private endpoint connections before deleting the private link service."
  >
  > }

## Cause

The private link service can't be deleted because the cluster is associated with private endpoint connections.

## Solution

Make sure that the private link service isn't associated with any private endpoint connections. Delete all private endpoint connections before you delete the private link service. For more information, see [Azure: How to delete a private link service that has a private endpoint connected to it?](https://stackoverflow.com/questions/60623484/azure-how-to-delete-a-private-link-service-that-has-a-private-endpoint-connecte).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
