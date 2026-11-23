---
title: Troubleshoot AKS API server authorized IP range access
description: Can't access the AKS cluster API server with authorized IP ranges? Learn the fix steps and restore kubectl connectivity quickly. Start troubleshooting now.
ms.date: 10/29/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, wonkilee, v-leedennis, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot access issues to the cluster API server when I use authorized IP address ranges so that I can work with my Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---
# Troubleshoot cluster API server access when using authorized IP ranges in Azure Kubernetes Service

## Summary

This article helps you troubleshoot AKS API server access problems when authorized IP address ranges block your connection. Follow the steps to update the allowed ranges and restore `kubectl` access to your cluster.

## Symptoms

If you try to create or manage resources in an AKS cluster, you can't access the cluster API server. When you run `kubectl`, you receive the following error message.

> Unable to connect to the server: dial tcp x.x.x.x:443: i/o timeout

## Cause

You configured your AKS cluster to access the cluster API server by using authorized IP address ranges that your computer can't access.

## Solution

Make sure that when you run the [az aks create](/cli/azure/aks#az-aks-create) or [az aks update](/cli/azure/aks#az-aks-update) command in [Azure CLI](/cli/azure/install-azure-cli), the `--api-server-authorized-ip-ranges` parameter includes the IP addresses or IP address ranges of the automation, development, or tooling systems that you're using.

## References

- [How to find my IP to include in --api-server-authorized-ip-ranges?](/azure/aks/api-server-authorized-ip-ranges#how-to-find-my-ip-to-include-in---api-server-authorized-ip-ranges)