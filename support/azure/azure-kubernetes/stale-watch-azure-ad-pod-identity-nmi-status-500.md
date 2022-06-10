---
title: Stale watch or status 500 in Azure AD Pod Identity NMI
description: Troubleshoot a stale watch or a status 500 returned from an Azure Active Directory Pod Identity Node Managed identity (NMI) in Azure Kubernetes Service (AKS).
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why the provisioning status of my cluster changed from Ready to Failed, even if I didn't do an operation, so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot a stale watch or a status 500 error returned from an Azure Active Directory Pod Identity NMI

If you [use Azure Firewall to restrict egress traffic](/azure/aks/limit-egress-traffic#restrict-egress-traffic-using-azure-firewall), you might discover that your network watch is stale, or that the Node Managed Identity (NMI) for your Azure Active Directory (Azure AD) Pod Identity is returning an internal server error (status 500).

## Cause

This issue can occur if you have long-lived TCP connections through the firewall, and a known issue in the application rules causes the TCP `keepalive` operations in the Go language to be terminated on the firewall.

## Workaround

Add a network rule instead of an application rule to the Microsoft Azure Kubernetes Service (AKS) API server IP address.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
