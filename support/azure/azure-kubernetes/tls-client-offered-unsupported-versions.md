---
title: TLS client offered only unsupported versions
description: Troubleshoot tls client offered only unsupported versions error messages from the client when connecting to the Azure Kubernetes Service (AKS) API server.
ms.date: 07/08/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot "tls: client offered only unsupported versions" error messages from my client computer or virtual machine so that I can connect successfully to the Azure Kubernetes Service (AKS) API server.
---
# "TLS: client offered only unsupported versions" error on client when connecting to the AKS API server

## Symptoms

When you try to connect to the Microsoft Azure Kubernetes Service (AKS) API server, you receive the following error message from your client computer or virtual machine:

> tls: client offered only unsupported versions

## Cause

Your version of the Transport Layer Security (TLS) protocol is out of date. The minimum supported version in AKS is TLS 1.2.

## Solution

Upgrade your TLS version to 1.2. For upgrade instructions, see [Enable support for TLS 1.2 in your environment](../entra-id/ad-dmn-services/enable-support-tls-environment.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
