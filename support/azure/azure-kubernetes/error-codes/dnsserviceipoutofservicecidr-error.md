---
title: Troubleshoot DnsServiceIpOutOfServiceCidr error code
description: Learn how to fix the DnsServiceIpOutOfServiceCidr error when you create or upgrade an AKS cluster. Follow these steps to align your DNS service IP with the service CIDR.
ms.date: 11/25/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, edneto, v-leedennis, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InUseRouteTableCannotBeDeleted error so that I can successfully delete an AKS cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the DnsServiceIpOutOfServiceCidr error in Azure Kubernetes Service

## Summary

This article helps you fix the `DnsServiceIpOutOfServiceCidr` error that occurs when you create or upgrade an Azure Kubernetes Service (AKS) cluster. Learn how to identify the cause and set a Domain Name System (DNS) service IP that falls within the service Classless Inter‑Domain Routing (CIDR) range so your deployment succeeds.

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. To install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

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

Ensure that the DNS service IP is within the range that's defined by the service CIDR.