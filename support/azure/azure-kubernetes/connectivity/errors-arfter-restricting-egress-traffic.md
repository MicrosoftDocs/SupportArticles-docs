---
title: Errors after restricting egress traffic
description: Troubleshoot errors that occur after you restrict egress traffic from an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/20/2025
ms.reviewer: chiragpa, nickoman, jaewonpark, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors that occur after I restrict egress traffic so that I can access my AKS cluster successfully.
ms.custom: sap:Connectivity
---
# Errors after restricting egress traffic in AKS

This article discusses how to troubleshoot issues that occur after you restrict egress traffic for cluster nodes in Microsoft Azure Kubernetes Service (AKS).

## Symptoms

Certain commands of the [kubectl](https://kubernetes.io/docs/reference/kubectl/) command-line tool don't work correctly, or you experience errors when you create an AKS cluster or scale a node pool.

## Cause

When you restrict egress traffic from an AKS cluster, your settings must comply with required Outbound network and FQDN (fully qualified domain names) rules for AKS clusters. If your settings are in conflict with any of these rules, the egress traffic restriction issues occur.

## Solution

Verify that your configuration doesn't conflict with any of the [required Outbound network and FQDN (fully qualified domain names) rules for AKS clusters](/azure/aks/outbound-rules-control-egress) for the following items:

- Outbound ports
- Network rules
- FQDNs
- Application rules

Check for conflicts with the rules that might occur in the NSG (network security group), firewall, or appliance that AKS traffic passes through according to the configuration.

> [!NOTE]
> The AKS outbound dependencies are almost entirely defined by using FQDNs. These FQDNs don't have static addresses behind them. The lack of static addresses means that you can't use NSGs to restrict outbound traffic from an AKS cluster. Additionally, scenarios that allow only IPs that are obtained from required FQDNs after all deny in NSG are not enough to restrict outbound traffic. Because the IPs are not static, issues might occur later.

## More information

- [Limit network traffic with Azure Firewall in AKS clusters](/azure/aks/limit-egress-traffic)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
