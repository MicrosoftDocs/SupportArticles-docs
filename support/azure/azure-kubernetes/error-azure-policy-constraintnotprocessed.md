---
title: Azure policy reports 'ConstraintNotProcessed' with running container
description: This article provides a solution to an issue where the container such as Gatekeeper is running, but Azure Policy reports it as 'ConstraintNotProcessed'.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
#  Azure policy reports 'ConstraintNotProcessed' with running container

This article provides a solution to the **ConstraintNotProcessed** error encountered with Azure policy.

## Symptoms

 The container such as Gatekeeper is running, but Azure Policy reports it as 'ConstraintNotProcessed'.

## Cause

The issue could be related to the version or compatibility of your Azure Kubernetes Service (AKS). Upgrading the ASK cluster to a newer or supported version can offer additional features, security enhancements, and patches to prevent such issues.

## Solution

To resolve the issue, go to the [Azure portal](Https://portal.azure.com) and then navigate to **Policy**. Check your subscription's compliance status, and review the details of the realted policy. If you don't have management control over the namespace, adjust the policy parameters to exclude that specific namespace.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
