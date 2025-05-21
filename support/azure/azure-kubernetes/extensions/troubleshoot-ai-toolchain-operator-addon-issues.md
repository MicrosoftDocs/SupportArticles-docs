---
title: Troubleshoot AKS AI Toolchain Operator Add-on Errors
description: Learn how to resolve errors that occur when you try to enable the Azure Kubernetes Service (AKS) AI toolchain operator add-on.
ms.date: 05/16/2025
ms.reviewer: sachidesai, albarqaw, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons, references_regions
---
# Troubleshoot AKS AI toolchain operator add-on errors

This article provides guidance on resolving errors that might occur when you enable the Microsoft Azure Kubernetes Service (AKS) AI Toolchain Operator (KAITO) add-on during cluster creation or update.

## Prerequisites

Ensure the following tools are installed and configured. They're used in the following sections.

- [Azure CLI](/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), the Kubernetes command-line client

## Symptoms

The KAITO add-on consists of two controllers: the `gpu-provisioner` controller and the `workspace` controller. After enabling the add-on and deploying a KAITO workspace, you might encounter one or more of the following errors in your pod logs:

| Error message | Cause |
| --- | --- |
| Workspace was not created | [Cause 1: Incorrect KAITO custom resource configuration](#cause-1-incorrect-kaito-custom-resource-configuration) |
| GPU node was not created | [Cause 2: GPU quota limitations](#cause-2-gpu-quota-limitations) |
| Resource ready condition is not `True` | [Cause 3: Long pull time for model inference images](#cause-3-long-pull-time-for-model-inference-images)|

## Cause 1: Incorrect KAITO custom resource configuration

After you enable the add-on and deploy a preset or custom workspace custom resource (CR), the `workspace` controller includes a validation webhook. This webhook blocks common mistakes of setting wrong values in the CR specification.

To resolve this issue, follow these steps:

1. Check your `gpu-provisioner` and `workspace` pod logs.
2. Ensure that any updates to the GPU virtual machine (VM) size meet the requirements of your model size.
3. Once the workspace CR is successfully created, track the deployment progress by running the following commands:

    ```azurecli
    kubectl get machine -o wide
    ```

    ```azurecli
    kubectl get workspace -o wide
    ```

## Cause 2: GPU quota limitations

The `gpu-provisioner` controller might fail to create GPU nodes due to quota limitations in your subscription or region. In this case, you can check the machine CR status (internal CR created by the `workspace` controller) for error messages. The machine CR created by the `workspace` controller has a `kaito.sh/workspace` label key whose value is the workspace's name.

To resolve this issue, use one of the following methods:

- Request an [increase in the subscription quota](/azure/quotas/quickstart-increase-quota-portal?) for the required GPU VM family of your deployment.
- Check the [GPU instance availability](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/table?msockid=182ea2d5e1ff6eb61ccbb1b8e5ff608a) in the specific region of your AKS cluster.

    If the required GPU VM size is unavailable in your current region, consider switching to a different region or selecting an alternative GPU VM size.

## Cause 3: Long pull time for model inference images

If the image access mode is set to private, the model inference image might not be pulled. This issue can occur for images with specified URLs and pull secrets.

Inference images are typically large (30 GB -100 GB), so a longer image pull time is expected. Depending on your AKS cluster's networking setup, the pull process might take up to tens of minutes.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
