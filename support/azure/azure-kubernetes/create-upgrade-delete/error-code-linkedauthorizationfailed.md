---
title: Troubleshoot the LinkedAuthorizationFailed error code
description: Learn how to troubleshoot the LinkedAuthorizationFailed error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 08/28/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the LinkedAuthorizationFailed error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the LinkedAuthorizationFailed error code

This article discusses how to identify and resolve the `LinkedAuthorizationFailed` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> Reconcile VNet failed.
>
> Details: VNetReconciler retry failed:
>
> Category: ClientError; SubCode: LinkedAuthorizationFailed;
>
> Dependency: Microsoft.Network/virtualNetworks; OrginalError: Code="LinkedAuthorizationFailed"
>
> Message="**The client '12345678-1234-1234-1234-123456789098' with object id '123456789-1234-1234-1234-1234567890987' has permission to perform action 'Microsoft.Network/virtualNetworks/write' on scope '/subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyRG_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vnet'; however, it does not have permission to perform action 'Microsoft.Network/ddosProtectionPlans/join/action' on the linked scope(s) '/subscriptions/*\<subscription-id-guid>*/resourcegroups/ddos-protection-plan-rg/providers/microsoft.network/ddosprotectionplans/upmddosprotectionplan'** or the linked scope(s) are invalid.";
>
> AKSTeam: Networking, Retriable: false.

## Cause

A service principal doesn't have permission to use a resource that's required for cluster creation.

## Solution

Grant the service principal permissions to use the resource that's mentioned in the error message. The example output in the "Symptoms" section provides the following information.

| Item | Value |
| ---- | ----- |
| Service principal | 12345678-1234-1234-1234-123456789098 |
| Resource | /subscriptions/*\<subscription-id-guid>*/resourcegroups/ddos-protection-plan-rg/providers/microsoft.network/ddosprotectionplans/upmddosprotectionplan |
| Operation | Microsoft.Network/ddosProtectionPlans/join/action |

For more information about how to grant permissions to the service principal, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
