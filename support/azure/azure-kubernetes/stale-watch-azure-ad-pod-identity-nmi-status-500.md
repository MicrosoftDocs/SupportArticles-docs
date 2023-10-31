---
title: Stale watch or HTTP status 500 in Microsoft Entra Pod Identity NMI
description: Troubleshoot a stale watch or status 500 message that's returned by a Microsoft Entra Pod Identity Node Managed identity (NMI) in Azure Kubernetes Service (AKS).
ms.date: 07/08/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why a stale watch or an HTTP status 500 error is returned by a Microsoft Entra Pod Identity Node Managed identity (NMI) so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Stale watch or HTTP status 500 error returned by a Microsoft Entra Pod Identity NMI

## Symptoms

When you [use Azure Firewall to restrict egress traffic](/azure/aks/limit-egress-traffic#restrict-egress-traffic-using-azure-firewall), you discover that your network watch is stale, or that the Node Managed Identity (NMI) for your Microsoft Entra Pod Identity is returning an internal server error message (HTTP status 500).

## Cause

This issue can occur if you have long-lived TCP connections through the firewall, and a known issue in the application rules causes the TCP `keepalive` operations in the Go language to be terminated on the firewall.

## Workaround

Add a network rule instead of an application rule to the Microsoft Azure Kubernetes Service (AKS) API server IP address.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
