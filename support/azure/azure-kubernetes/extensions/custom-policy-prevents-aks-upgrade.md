---
title: AKS upgrade fails when using an Azure custom policy
description: Resolve AKS upgrade failures caused by Azure custom policies blocking upgrades. Learn how to fix this issue with the Azure Policy Add-on for AKS.
ms.date: 04/23/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why a Kubernetes upgrade fails when I'm using an Azure custom policy so that I can use the Azure Policy Add-on for an upgraded Azure Kubernetes Service cluster successfully.
---
# AKS upgrade fails when using an Azure custom policy

## Summary

This article explains how to resolve AKS upgrade failures that occur when an Azure custom policy blocks the upgrade. Learn the cause of this issue and how to apply the correct fix using the Azure Policy Add-on for Azure Kubernetes Service (AKS).

## Symptoms

You see a message in the Azure portal that indicates that your AKS cluster is compliant with your Azure custom policy. However, when you try to upgrade AKS, the custom policy blocks the upgrade attempt.

## Cause

During an AKS upgrade, the policies that are defined for the upgrade might differ from the policies that are defined for a running cluster. This scenario can create policy-related issues that appear only during the upgrade process. The scenario might occur if you start the upgrade process by using Azure CLI.

## Solution

Try using the [Azure portal](https://portal.azure.com) instead of Azure CLI to start the upgrade.

 
