---
title: Azure policy reports ConstraintNotProcessed for a running container
description: Learn why Azure Policy reports running containers as ConstraintNotProcessed in AKS, and follow the fix to upgrade your cluster and restore compliance.
ms.date: 03/27/2024
ms.reviewer: momajed
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Azure Policy reports ConstraintNotProcessed for a running container

## Summary

If Azure Policy reports a running container as `ConstraintNotProcessed`, this article helps you identify the AKS version issue and apply the cluster upgrade fix.

## Symptoms

A container such as Gatekeeper is running. However, Azure Policy reports the container as `ConstraintNotProcessed`.

## Cause

The issue could be related to the version or compatibility of your Azure Kubernetes Service (AKS).

## Solution

To resolve the issue, upgrade the AKS cluster to a newer or supported version that offers additional features, security enhancements, and updates to prevent issues such as this one.

 
