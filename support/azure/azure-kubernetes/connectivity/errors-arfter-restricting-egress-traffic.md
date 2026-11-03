---
title: Troubleshoot AKS errors after restricting egress traffic
description: Learn how to troubleshoot AKS errors after restricting egress traffic and restore cluster operations. Follow these steps to resolve connectivity issues.
ms.date: 11/02/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, jaewonpark, v-leedennis, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors that occur after I restrict egress traffic so that I can access my AKS cluster successfully.
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---
# Troubleshoot errors after restricting egress traffic in Azure Kubernetes Service

## Summary

This article helps you troubleshoot errors that occur after you restrict egress traffic for cluster nodes in Azure Kubernetes Service (AKS). Use it to identify conflicting outbound network and FQDN rules and restore kubectl commands, cluster creation, and node pool scaling.

## Symptoms

Certain commands of the [kubectl](https://kubernetes.io/docs/reference/kubectl/) command-line tool don't work correctly, or you experience errors when you create an AKS cluster or scale a node pool.

## Cause

When you restrict egress traffic from an AKS cluster, your settings must comply with required outbound network and fully qualified domain name (FQDN) rules for AKS clusters. If your settings conflict with any of these rules, the egress traffic restriction causes problems.

## Solution

Verify that your configuration doesn't conflict with any of the [required Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress) for the following items:

- Outbound ports
- Network rules
- FQDNs
- Application rules

Check for conflicts with the rules that might occur in the network security group (NSG), firewall, or appliance that AKS traffic passes through according to the configuration.

> [!NOTE]
> The AKS outbound dependencies are almost entirely defined by using FQDNs. These FQDNs don't have static addresses behind them. The lack of static addresses means that you can't use NSGs to restrict outbound traffic from an AKS cluster. Additionally, scenarios that allow only IPs that are obtained from required FQDNs after all deny in NSG aren't enough to restrict outbound traffic. Because the IPs aren't static, issues might occur later.

## References

- [Limit network traffic with Azure Firewall in AKS clusters](/azure/aks/limit-egress-traffic)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]