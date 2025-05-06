---
title: Azure Kubernetes Service AI toolchain operator add-on issues
description: Learn how to resolve issues that occur when you try to enable the Azure Kubernetes Service (AKS) AI toolchain operator add-on.
ms.date: 05/06/2025
author: sachidesai
ms.author: sachidesai
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons, references_regions
---

# AKS AI toolchain operator add-on issues

This article discusses how to troubleshoot problems that you may experience when you enable the Microsoft Azure Kubernetes Service (AKS) AI toolchain operator add-on during cluster creation or a cluster update.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), the Kubernetes command-line client

## Symptoms

AI toolchain operator add-on has two controllers: the `gpu-provisioner` controller and `workspace` controller. After enabling the add-on and deploying a KAITO workspace, you may experience one or more of the following errors in your pod logs:

| Error message | Cause |
|--|--|
| Workspace was not created | [Cause 1: KAITO custom resource not configured properly](#cause-1-misconfiguration-in-kaito-custom-resource) |
| GPU node was not created | [Cause 2: GPU quota limitations](#cause-2-gpu-quota-limitations) |  
| Resource ready condition is not `True` | [Cause 3: Long model inference image pull time](#cause-3-long-image-pull-time) |


## Cause 1: Misconfiguration in KAITO Custom Resource

After you enable the add-on and deploy either a preset or custom workspace custom resource (CR), the workspace controller has a validation webhook that will block common mistakes of setting wrong values in the CR spec. Check your `gpu-provisioner` and workspace pod logs to ensure that any updates to GPU VM size meet the requirements of your model size. After the workspace CR is created successfully, track  deployment progress by running the following commands:

```azurecli
kubectl get machine -o wide
```

```azurecli
kubectl get workspace -o wide
```

## Cause 2: GPU quota limitations

The `gpu-provisioner` controller may have failed to create the GPU node(s), in this case you can check the machine CR status (internal CR created by the workspace controller) for error messages. The machine CRs created by the `workspace` controller has a label key `kaito.sh/workspace` with workspace's name as the value. Address the potential GPU quota limitations by:

1. Requesting an [increase in the subscription quota](/azure/quotas/quickstart-increase-quota-portal) for the required GPU VM family for your deployment.

2. Checking [GPU instance availability](https://azure.microsoft.com/en-us/explore/global-infrastructure/products-by-region/table?msockid=182ea2d5e1ff6eb61ccbb1b8e5ff608a) in the specific region of your AKS cluster; you may need to switch region or GPU VM size if not available.

## Cause 3: Long image pull time

The model inference image may not be pulled if the image access mode is set to private. This can occur for images that you specify the URL and pull secret.

Note that the inference images are usually large (30GB-100GB), hence please expect a longer image pull time (up to tens of minutes depending on your AKS cluster networking setup).