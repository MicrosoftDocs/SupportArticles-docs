---
title: Troubleshoot the LinkedAuthorizationFailed error code
description: Learn how to troubleshoot the LinkedAuthorizationFailed error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the LinkedAuthorizationFailed error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the LinkedAuthorizationFailed error code

This article describes how to identify and resolve the `LinkedAuthorizationFailed` error, which might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create the cluster, you receive the following error message:

> Reconcile VNet failed.
>
> Details: VNetReconciler retry failed:
>
> Category: ClientError; SubCode: LinkedAuthorizationFailed;
>
> Dependency: Microsoft.Network/virtualNetworks; OrginalError: Code="LinkedAuthorizationFailed"
>
> Message="**The client '12345678-1234-1234-1234-123456789098' with object id '123456789-1234-1234-1234-1234567890987' has permission to perform action 'Microsoft.Network/virtualNetworks/write' on scope '/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/MC_MyRG_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vnet'; however, it does not have permission to perform action 'Microsoft.Network/ddosProtectionPlans/join/action' on the linked scope(s) '/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/ddos-protection-plan-rg/providers/microsoft.network/ddosprotectionplans/upmddosprotectionplan'** or the linked scope(s) are invalid.";
>
> AKSTeam: Networking, Retriable: false.

## Cause

A service principal doesn't have permission to use a resource that's needed for cluster creation.

## Solution

Grant the service principal permissions to use the resource that's shown in the error. The example output above provides the following information:

| Item | Value |
| ---- | ----- |
| Service principal | 12345678-1234-1234-1234-123456789098 |
| Resource | /subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/ddos-protection-plan-rg/providers/microsoft.network/ddosprotectionplans/upmddosprotectionplan |
| Operation | Microsoft.Network/ddosProtectionPlans/join/action |

For instructions on how to grant permissions to the service principal, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
