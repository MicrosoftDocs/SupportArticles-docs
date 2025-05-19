---
title: Troubleshoot DnsServiceIpOutOfServiceCidr Error Code
description: Learn how to resolve the DnsServiceIpOutOfServiceCidr error when you try to create or upgrade an AKS cluster.
ms.date: 10/17/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InUseRouteTableCannotBeDeleted error so that I can successfully delete an AKS cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the DnsServiceIpOutOfServiceCidr error code

This article discusses how to identify and resolve the `DnsServiceIpOutOfServiceCidr` error that occurs when you try to create or upgrade an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see [Upgrade an AKS cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster create operation fails, and you receive a `DnsServiceIpOutOfServiceCidr` error message.

>`(DnsServiceIpOutOfServiceCidr) The DNS service IP 10.0.0.10 is out of the range defined by service CIDR 10.200.0.0/16.`

- **Code**: `DnsServiceIpOutOfServiceCidr`
- **Message**: The DNS service IP 10.0.0.10 is out of the range defined by service CIDR 10.200.0.0/16.
- **Target**: networkProfile.dnsServiceIP

## Cause

This error occurs if the DNS service IP (`--dns-service-ip`) for AKS is out of the range that's defined by the service CIDR (`--service-cidr`).

## Solution

Make sure that the DNS service IP is within the range that's defined by service CIDR.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
