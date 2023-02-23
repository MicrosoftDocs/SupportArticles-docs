---
title: Troubleshoot common issues with Mariner container hosts on AKS
description: Learn how to address some common issues reported with Mariner nodes on AKS 
ms.date: 02/22/2023
author: Sudhanva Huruli
ms.author: suhuruli
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-common-mariner-aks
#Customer intent: As an Azure Kubernetes user using Mariner container hosts, I want to take basic troubleshooting steps.
---

# Troubleshoot Common Issues with Mariner container hosts on AKS

This article provides troubleshooting steps for some of the commonly reported issues when using Mariner container hosts with AKS. For more information on how to use Mariner container hosts with AKS and get started, please visit the [Use Mariner with AKS](https://learn.microsoft.com/en-us/azure/aks/use-mariner) documentation. 

## Before you begin

Read the [official guide for troubleshooting Kubernetes clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/_print/). Also, read the [Microsoft engineer's guide to Kubernetes troubleshooting](https://github.com/feiskyer/kubernetes-handbook/blob/master/en/troubleshooting/index.md). This guide contains commands for troubleshooting pods, nodes, clusters, and other features.

Furthermore, please check the [Known Limitations](https://learn.microsoft.com/en-us/azure/aks/use-mariner#limitations) list to see if a scenario you are trying is already a known limitation we are working on. 

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.31 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## Basic troubleshooting

Mariner AKS Container Host (MACH) is an operating system image for Azure Kubernetes Service (AKS) that is optimized for running container workloads. It is maintained by Microsoft and based on Mariner, an open-source Linux distribution created by Microsoft. Mariner is lightweight, containing only the packages needed to run container workloads, undergoes Azure validation tests, and is compatible with Azure agents. MACH provides reliability and consistency from cloud to edge across the AKS, AKS-HCI, and Arc products. You can deploy Mariner node pools in a new cluster, add Mariner node pools to your existing Ubuntu clusters, or migrate your Ubuntu nodes to Mariner nodes. To learn more about Mariner, see the [CBL-Mariner](https://github.com/microsoft/CBL-Mariner) Github repository.

### Check Mariner version 
Check to see that you are using the correct Mariner version. The supported version of Mariner for consumption is Mariner 2.0. In the output of the below command, the "osSKU" property should say `Mariner` and not `CBL-Mariner` or anything else. 

```bash
az aks nodepool list -g suhuruliMariner --cluster-name suhuruliMarinerAKS
```

While doing this may not address the issue you are facing, this has been a common issue when customers report agents/extensions not working on Mariner as it should. 

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
