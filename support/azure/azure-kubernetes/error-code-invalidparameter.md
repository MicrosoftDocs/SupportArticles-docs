---
title: Troubleshoot the InvalidParameter error code
description: Learn how to troubleshoot the InvalidParameter error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/22/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InvalidParameter error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the InvalidParameter error code

This article discusses how to identify and resolve the `InvalidParameter` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.81 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## Symptoms

When you create an AKS cluster, the provided input is usually validated before the cluster is created. However, on rare occasions, a parameter passes the precreation validation but causes errors when the resources for the AKS cluster are created. Errors that are related to invalid parameters might resemble the following example:

> Code="InvalidParameter"
>
> Message="**The requested VM size Standard_D4s_v3 is not available in the current region.** The sizes available in the current region are: ExtraSmall_Internal, Small_Internal, Medium_Internal, Large_Internal, ExtraLarge_Internal, Standard_DC2as_v5, Standard_DC4as_v5, Standard_DC8as_v5, Standard_DC16as_v5, Standard_DC32as_v5, Standard_DC48as_v5, Standard_DC64as_v5, Standard_DC96as_v5, Standard_DC2ads_v5, Standard_DC4ads_v5, Standard_DC8ads_v5, Standard_DC16ads_v5, Standard_DC32ads_v5, Standard_DC48ads_v5, Standard_DC64ads_v5, Standard_DC96ads_v5, Standard_EC2as_v5, Standard_EC4as_v5, Standard_EC8as_v5, Standard_EC16as_v5, Standard_EC20as_v5, Standard_EC32as_v5, Standard_EC48as_v5, Standard_EC64as_v5, Standard_EC96as_v5, Standard_EC96ias_v5, Standard_EC2ads_v5, Standard_EC4ads_v5, Standard_EC8ads_v5, Standard_EC16ads_v5, Standard_EC20ads_v5, Standard_EC32ads_v5, Standard_EC48ads_v5, Standard_EC64ads_v5, Standard_EC96ads_v5, Standard_EC96iads_v5.\r\nFind out more on the available VM sizes in each region at <https://aka.ms/azureregions>."
>
> Target="vmSize"

## Cause

This issue occurs because one of the following conditions is true:

- The Azure Virtual Machine SKU isn't available in the selected region.
- The service principal is invalid.
- A virtual network, subnet, or route table is invalid.
- An Azure CLI parameter is invalid.

There might also be other reasons that your cluster creation attempt failed.

## Solution

In the following table, follow the link for the appropriate troubleshooting step.

| Troubleshooting step | Reference link |
| -------------------- | -------------- |
| Check whether the SKU is available | [Resolve errors for SKU not available](/azure/azure-resource-manager/troubleshooting/error-sku-not-available) |
| Verify that the service principal is valid | [Service principals with AKS](/azure/aks/kubernetes-service-principal) |
| Verify that any commands that were used to create the cluster are valid | [az aks](/cli/azure/aks#az-aks-create) (Azure CLI reference) |
| Verify that any custom network resources that were used to create the cluster are valid | [Configure Azure CNI networking in AKS](/azure/aks/configure-azure-cni) and [Customize cluster egress with a user-defined route](/azure/aks/egress-outboundtype) |

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
