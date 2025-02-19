---
title: Azure policy reports ConstraintNotProcessed for a running container
description: This article provides a solution to an issue in which Azure Policy reports a running container as ConstraintNotProcessed.
ms.date: 03/27/2024
ms.reviewer: momajed
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Azure policy reports 'ConstraintNotProcessed' for running container

This article provides a solution to the error that you encounter when Azure Policy reports a running container as `ConstraintNotProcessed`.

## Symptoms

A container such as Gatekeeper is running. However, Azure Policy reports the container as `ConstraintNotProcessed`.

## Cause

The issue could be related to the version or compatibility of your Azure Kubernetes Service (AKS).

## Solution

To resolve the issue, upgrade the AKS cluster to a newer or supported version that offers additional features, security enhancements, and updates to prevent issues such as this one.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
