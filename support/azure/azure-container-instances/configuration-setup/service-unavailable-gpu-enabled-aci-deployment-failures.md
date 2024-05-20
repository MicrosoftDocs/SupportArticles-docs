---
title: Azure Container Instances fails to run GPU-enabled containers
description: Provides solutions to GPU-enabled Azure container instance deployment failures.
ms.date: 05/20/2024
ms.reviewer: v-rekhanain, momajed, v-weizhu
ms.service: container-instances
ms.custom: sap:Configuration and Setup
---
# GPU-enabled container deployment fails with "service unavailable" error

This article discusses the causes of GPU-enabled Azure container instance deployment failures and provides solutions.

## Symptoms

When you try to deploy a GPU-enabled container to Azure Container Instances, you encounter the following symptoms:

- You receive the following error message:

  > Service unavailable. Please try again later or contact support if this problem persists.

- When you check the status of your container group, you see that the GPU ACI provisioning state is "Failed" and the error code is "ServiceUnavailable".
- When you view the logs of your container group, you see that the GPU driver installation failed or timed out.

## Cause 1: Not enough GPU quota

Your subscription or region doesn't have enough GPU quota to deploy the container group. GPU quota is limited and subject to availability.

## Solution 1: Increase GPU quota

Check your GPU quota and availability for your subscription and region, and request GPU quota increases by using the Azure CLI or the Azure portal.

## Cause 2: Incompatible container group configuration

Your container group configuration isn't compatible with the GPU SKU. Running GPU-enabled containers require specific CPU, memory, and operating system (OS) settings.

## Solution 2: Update container group configuration to match GPU SKU

Check your container group configuration and make sure that it matches the GPU SKU requirements. You can re-create or update your container group configuration by using the Azure CLI or the Azure portal.

Check the region availability of the GPU SKUs that you want to use. Not all regions support all GPU SKUs. The following table shows the current region availability of GPU SKUs for Linux OS.

|Region|	OS	|Available GPU SKUs|
|---|---|---|
|East US|	Linux|	V100|
|West Europe|	Linux|	V100|
|West US 2|	Linux|	V100|
|Southeast Asia|	Linux|	V100|
|Central India|	Linux	|V100|

If your region doesn't support the GPU SKU that you need, you can choose a different region or GPU SKU that's available in your region.


## Cause 3: Incorrect GPU driver or toolkit is installed

Your container image doesn't have the correct GPU driver or toolkit installed. GPU-enabled containers require NVIDIA drivers and CUDA or TensorRT libraries to access GPU resources.

## Solution 3: Install NVIDIA Container Toolkit or use Azure Machine Learning base images

Check your container image and make sure that it has the correct GPU driver and toolkit installed. You can install the NVIDIA Container Toolkit or use the Azure Machine Learning base images to build and run your GPU-enabled containers.

## Cause 4: No NVIDIA drivers or libraries are installed

Your container image doesn't have NVIDIA drivers or libraries installed. GPU-enabled containers require NVIDIA drivers and CUDA or TensorRT libraries to access the GPU resources.
 
## Solution 4: Use the NVIDIA GPU Cloud (NGC) repository

Check your container image and make sure that it has the NVIDIA drivers and libraries installed. You can use the NVIDIA GPU Cloud (NGC) repository to find and pull pre-built GPU-accelerated images for various frameworks and applications.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
