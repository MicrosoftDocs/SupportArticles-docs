---
title: Troubleshoot the LinkedAuthorizationFailed error code
description: Fix the LinkedAuthorizationFailed error during AKS cluster creation or deployment by identifying missing permissions and applying role assignments now.
ms.date: 07/21/2026
author: kaushika-msft
ms.author: kaushika
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, andraciobanu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the LinkedAuthorizationFailed error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the LinkedAuthorizationFailed error code

## Summary

Use this article to troubleshoot the `LinkedAuthorizationFailed` error when you create or deploy an Azure Kubernetes Service (AKS) cluster. By following these steps, you can complete the operation successfully.

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
> Message="**The client 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' with object id '123456789-1234-1234-1234-1234567890987' has permission to perform action 'Microsoft.Network/virtualNetworks/write' on scope '/subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyRG_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vnet'; however, it doesn't have permission to perform action 'Microsoft.Network/ddosProtectionPlans/join/action' on the linked scope(s) '/subscriptions/*\<subscription-id-guid>*/resourcegroups/ddos-protection-plan-rg/providers/microsoft.network/ddosprotectionplans/upmddosprotectionplan'** or the linked scope(s) are invalid.";
>
> AKSTeam: Networking, Retriable: false.

## Cause

A service principal doesn't have permission to use a resource that's required for cluster creation.

## Solution

Grant the service principal permissions to use the resource that's mentioned in the error message. The example output in the "Symptoms" section provides the following information.

| Item | Value |
| ---- | ----- |
| Service principal | aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb |
| Resource | /subscriptions/*\<subscription-id-guid>*/resourcegroups/ddos-protection-plan-rg/providers/microsoft.network/ddosprotectionplans/upmddosprotectionplan |
| Operation | Microsoft.Network/ddosProtectionPlans/join/action |

For more information about how to grant permissions to the service principal, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

## More information

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

If role assignments appear correct but cluster creation still fails, verify role assignment propagation, confirm permissions at the linked resource scope, inspect Activity Logs for authorization failures, and validate that the referenced resource still exists and is accessible from the target subscription and resource group. Review the exact operation shown in the error (for example, `Microsoft.Network/ddosProtectionPlans/join/action`) and confirm the identity has that permission on the linked resource.

If the required permission appears to be assigned but the deployment still fails with LinkedAuthorizationFailed, verify the identity and scope involved in the authorization check. Review the full error message to identify:

The client or object ID performing the operation.
The linked resource scope referenced in the error.
The specific action that is denied (for example, `Microsoft.Network/ddosProtectionPlans/join/action`).

Confirm that the identity used by the AKS deployment (service principal or managed identity) has the required role assignment on both the primary resource and any linked resources referenced in the error message. Also verify that the role assignment exists at the correct scope and that inherited permissions are effective.
For complex scenarios involving resources in different resource groups or subscriptions, review Azure Activity Logs and role assignments to determine where authorization fails before retrying the cluster creation.

 
