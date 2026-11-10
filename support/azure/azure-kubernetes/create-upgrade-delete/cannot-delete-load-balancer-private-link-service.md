---
title: Cant delete load balancer with a private link service or a private link service with private endpoint connections in AKS
description: Learn how to fix the error when you can't delete a load balancer or private link service while deleting an AKS cluster. Follow the steps to resolve it.
ms.date: 11/10/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, edneto, v-leedennis, v-weizhu, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the CannotDeleteLoadBalancerWithPrivateLinkService or PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# A load balancer with a private link service or a private link service with private endpoint connections can't be deleted in Azure Kubernetes Service

## Summary

This article helps you resolve the issue where you can't delete a load balancer or private link service when you delete an Azure Kubernetes Service (AKS) cluster. It covers the `CannotDeleteLoadBalancerWithPrivateLinkService` and `PrivateLinkServiceWithPrivateEndpointConnectionsCannotBeDeleted` errors so that you can delete your cluster successfully.

## Symptoms

When you try to delete an AKS cluster, you receive one of the following error messages.

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

You can't delete the private link service because the cluster is associated with private endpoint connections.

## Solution

Ensure that the private link service isn't associated with any private endpoint connections. Delete all private endpoint connections before you delete the private link service. For more information, see [Azure: How to delete a private link service that has a private endpoint connected to it?](https://stackoverflow.com/questions/60623484/azure-how-to-delete-a-private-link-service-that-has-a-private-endpoint-connecte)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
