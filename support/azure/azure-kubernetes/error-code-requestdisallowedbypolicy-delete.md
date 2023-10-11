---
title: Troubleshoot the RequestDisallowedByPolicy error code (for deletions)
description: Learn how to troubleshoot the RequestDisallowedByPolicy error when you try to delete an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/01/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-delete-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the RequestDisallowedByPolicy error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the RequestDisallowedByPolicy error code (for cluster deletions)

This article discusses how to identify and resolve the `RequestDisallowedByPolicy` error that occurs when you try to delete a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to delete an AKS cluster, you receive the following error message:

> internalErrorCode: "RequestDisallowedByPolicy"
>
> StatusCode=403 (forbidden)
>
> StatusCode=BadRequest
>
> {
>
> Message: "Resource 'aks-agentpool-test-routetable' was disallowed by policy. Policy identifiers: 'policyAssignment: "name: ....Microsoft.Management/managementGroups/test/providers/Microsoft.Authorization/policyAssignments/test"
>
> }

## Cause

The `RequestDisallowedByPolicy`error can have many policy-related causes. Only customers (not Microsoft) can manage the policies in their environment. Microsoft can't disable or bypass those policies.

## Solution

Verify that you have permission to make any changes to policy services. If you don't have permission, find someone who has access so that they can make the necessary changes. Also, check the policy name that's causing the problem, and then temporarily deny that rule so that you (or someone who has permission) can do the delete operation.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
