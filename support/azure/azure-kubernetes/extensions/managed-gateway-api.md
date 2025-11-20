---
title: Managed Gateway API Installation Troubleshooting
description: Learn how to do Managed Gateway API CRD installation troubleshooting for Azure Kubernetes Service (AKS).
ms.date: 08/26/2025
author: nshankar13
ms.author: nshankar
ms.reviewer: jkatariya
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the Managed Gateway API installation so that I can use the Kubernetes Gateway API successfully.
---

# Managed Gateway API installation troubleshooting

The [Managed Gateway API installation](/azure/aks/managed-gateway-api) for Azure Kubernetes Service (AKS) allows users to opt into a managed installation of the [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) Custom Resource Definitions (CRDs). You must have at least one AKS add-on installed, such as the [Istio add-on](/azure/aks/istio-about), to use the Managed Gateway API CRDs in a fully supported mode.

## Step 1: Verify existing Gateway API CRD channel and bundle version

If you already installed the Gateway API CRDs before you enabled the Managed Gateway API installation, make sure that the Gateway API CRD [bundle version is compatible with your cluster's Kubernetes version](/azure/aks/managed-gateway-api#gateway-api-bundle-version-and-aks-kubernetes-version-mapping) and that you have only CRDs installed for the `standard` channel. Before you enable the Managed Gateway API installation, also verify that the self-managed CRDs in the existing installation have the following annotations:

- `gateway.networking.k8s.io/bundle-version`
- `gateway.networking.k8s.io/channel`

You might continue to experience issues that affect installing the Managed Gateway CRDs despite having the correct bundle version and Kubernetes version and only `standard` channel CRDs. In this case, we recommend that you disable the Managed Gateway API installation, uninstall all the self-managed CRDs, and re-enable the Managed Gateway API CRDs.

## Step 2: Make sure that managed CRDs have expected annotations

When AKS successfully installs fresh managed Gateway API CRDs, or takes ownership of pre-existing user-managed installations of the CRDs, the following annotations should appear on the CRD objects:

- `app.kubernetes.io/managed-by: aks`
- `app.kubernetes.io/part-of: <hash>`
- `eno.azure.io/replace: true`

If these annotations are missing, it's possible that an issue affects the Managed Gateway API CRD provisioning. [Make sure that no conflicts exist in pre-existing installations of the Gateway API CRDs](#step-1-verify-existing-gateway-api-crd-channel-and-bundle-version). Then, try to uninstall and re-install the Managed Gateway CRDs to determine whether the expected annotations are successfully added.

## Step 3: Inspect Managed Gateway API CRD version after AKS upgrades

If you upgrade your AKS cluster to a new minor version after you install the Managed Gateway API CRDs, the CRDs are automatically upgraded to the [new supported Gateway API bundle version for that Kubernetes version](/azure/aks/managed-gateway-api#gateway-api-bundle-version-and-aks-kubernetes-version-mapping). You should verify that the Gateway API CRD bundle version is updated accordingly based on the value of the `gateway.networking.k8s.io/bundle-version` annotation. If it's not, try uninstalling and re-installing the Managed Gateway CRDs to see whether the bundle version is updated to the newer version.
