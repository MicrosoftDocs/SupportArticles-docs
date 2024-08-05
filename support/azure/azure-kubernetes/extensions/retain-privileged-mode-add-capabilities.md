---
title: Retain privileged mode while adding capabilities
description: Learn how to retain privileged mode while you add capabilities when you use the Azure Policy Add-on for Azure Kubernetes Service (AKS).
ms.date: 04/23/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: how-to
#Customer intent: As an Azure Kubernetes user, I want to learn how to retain privileged mode while I add capabilities so that I increase security when I use the Azure Policy Add-on for Azure Kubernetes Service.
---
# Retain privileged mode while adding capabilities

This article discusses how to retain privileged mode while you add capabilities when you use the Microsoft Azure Policy Add-on for Azure Kubernetes Service (AKS).

## Overview

Node access always requires a certain level of privilege. Default policies flag these access levels. Even if you don't grant full node access, there are policies that detect access to the file system. In most cases, you have to create exceptions or carefully fine-tune policies based on your requirements.

Although it's possible to specify individual capabilities in the pod's security context without marking the pod as privileged, other policies still apply. You can find a list of these policies in [Azure Kubernetes built-in policy definitions](/azure/governance/policy/samples/built-in-policies#kubernetes). Even if the daemonset's container doesn't trigger the "privileged" policy, the container still requires access to the host's file system in order to copy agent files and scripts and so on. Consider the requirements of your container, and review the policy requirements accordingly.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
