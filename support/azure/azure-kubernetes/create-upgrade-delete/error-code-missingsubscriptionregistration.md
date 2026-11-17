---
title: Troubleshoot the MissingSubscriptionRegistration error
description: Learn how to troubleshoot the MissingSubscriptionRegistration error when you create and deploy an Azure Kubernetes Service (AKS) cluster, and register the provider.
ms.date: 11/13/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, addobres, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the MissingSubscriptionRegistration error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the MissingSubscriptionRegistration error

## Summary

This article explains how to identify and resolve the `MissingSubscriptionRegistration` error that occurs when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to deploy an AKS cluster, you receive the following error message.

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

- You didn't register the required resource provider for your subscription.
- You used an API version that isn't supported for the resource type.
- You selected a location that isn't supported for the resource type.

## Solution

To resolve this issue, follow the instructions in [Resolve errors for resource provider registration](/azure/azure-resource-manager/troubleshooting/error-register-resource-provider?tabs=azure-portal#solution). Replace the existing namespace with the namespace that's shown in the error message. In the example in the Symptoms section, the namespace is `Microsoft.OperationsManagement`.

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)