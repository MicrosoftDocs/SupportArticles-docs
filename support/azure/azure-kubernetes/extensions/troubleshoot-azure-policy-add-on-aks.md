---
title: Troubleshoot the Azure Policy Add-on for AKS
description: See an overview about the Azure Policy Add-on for Azure Kubernetes Service (AKS). View troubleshooting articles that address Azure Policy Add-on issues.
ms.date: 06/19/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: overview
#Customer intent: As an Azure Kubernetes user, I want to see what troubleshooting articles are available for the Azure Policy Add-on so that I fix various Azure Policy Add-on issues.
---
# Troubleshoot the Azure Policy Add-on for Azure Kubernetes Service (AKS)

This article contains a list of resources that can help you recover from issues that occur when you use the Microsoft Azure Policy Add-on in conjunction with an Azure Kubernetes Service (AKS) cluster.

## Before you begin

Review the [official guide to troubleshooting Kubernetes clusters](https://kubernetes.io/docs/tasks/debug/). There's also a [troubleshooting guide on GitHub](https://github.com/feiskyer/kubernetes-handbook/blob/master/en/troubleshooting/index.md) that's published by a Microsoft engineer for troubleshooting pods, nodes, clusters, and other features.

## Related content

The following articles address specific issues that you might encounter when you use the Azure Policy Add-on for AKS:

- [AKS container CPU and memory limits aren't enforced](./enforce-container-cpu-memory-limits.md)

- [AKS upgrade fails when using an Azure custom policy](./custom-policy-prevents-aks-upgrade.md)

- [Azure Policy can't exclude privileged containers from AKS clusters](./privileged-container-exclusion-not-working.md)

- [Azure policy failure alert shows an empty list of affected resources](./policy-failure-alert-show-empty-list-of-affected-resources.md)

- [Azure policy reports 'ConstraintNotProcessed' for running container](./error-azure-policy-constraintnotprocessed.md)

- [Custom Azure Policy for validating controllers doesn't work](./custom-policy-for-validating-controller-not-working.md)

- [Pods are created in the user namespaces](./pods-created-user-namespaces.md)

- [Pods fail and restart after you enable Defender Profile for AKS](./failure-restart-azure-defender-publisher-daemonset-pods.md)

- ['Policy definition not found' during policy assignments in Terraform](./error-in-policy-assign-main-file-terraform.md)

- [Retain privileged mode while adding capabilities](./retain-privileged-mode-add-capabilities.md)

- [Security best practice: Don't run as root in containers](./avoid-running-as-root-in-containers.md)

- [Third-party scanner detects run-time host incident](./runtime-host-incidents-third-party-scanner.md)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
