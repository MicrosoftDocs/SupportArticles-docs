---
title: Errors after restricting egress traffic
description: Troubleshoot errors that occur after you restrict egress traffic from an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/25/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors that occur after I restrict egress traffic so that I can access my Azure Kubernetes Service (AKS) cluster successfully.
---
# Errors after restricting egress traffic in AKS

This article discusses how to troubleshoot issues that occur after you restrict egress traffic for cluster nodes in Microsoft Azure Kubernetes Service (AKS).

## Symptoms

Certain commands of the [kubectl](https://kubernetes.io/docs/reference/kubectl/) command-line tool don't work correctly, or you experience errors when you create an AKS cluster.

## Cause

When you restrict egress traffic from an AKS cluster, there are [required and optionally recommended egress traffic settings for AKS](/azure/aks/limit-egress-traffic). If your settings are in conflict with any of these rules, the symptoms of egress traffic restriction issues will occur.

## Solution

Verify that your configuration doesn't conflict with any of the [required or optionally recommended settings](/azure/aks/limit-egress-traffic) for the following items:

- Outbound ports
- Network rules
- Fully qualified domain names (FQDNs)
- Application rules

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
