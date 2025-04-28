---
title: Troubleshoot the MissingSubscriptionRegistration error code
description: Learn how to troubleshoot the MissingSubscriptionRegistration error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/16/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the MissingSubscriptionRegistration error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the MissingSubscriptionRegistration error code

This article discusses how to identify and resolve the `MissingSubscriptionRegistration` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to deploy an AKS cluster, you receive the following error message:

> Code="MissingSubscriptionRegistration"
>
> Message="**The subscription is not registered to use namespace 'Microsoft.OperationsManagement'.** See <https://aka.ms/rps-not-found> for how to register subscriptions."
>
> Details=[{
>
> "code": "MissingSubscriptionRegistration",
>
> "message": "The subscription is not registered to use namespace 'Microsoft.OperationsManagement'. See <https://aka.ms/rps-not-found> for how to register subscriptions.",
>
> "target": "Microsoft.OperationsManagement"
>
> }]

## Cause

You receive this error message for one of the following reasons:

- The required resource provider isn't registered for your subscription.

- The API version isn't supported for the resource type.

- The location isn't supported for the resource type.

## Solution

To resolve this issue, follow the instructions in the "Solution" section of [Resolve errors for resource provider registration](/azure/azure-resource-manager/troubleshooting/error-register-resource-provider?tabs=azure-portal#solution). Replace the existing namespace with the namespace that's shown in the error message. In the example in the "Symptoms" section, the namespace is `Microsoft.OperationsManagement`.

## More information

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
