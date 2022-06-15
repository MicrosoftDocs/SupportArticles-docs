---
title: TLS client offered only unsupported versions
description: Troubleshoot tls client offered only unsupported versions error messages from my client when connecting to the Azure Kubernetes Service (AKS) API server.
ms.date: 6/1/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot "tls: client offered only unsupported versions" error messages from my client computer or virtual machine so that I can connect successfully to the Azure Kubernetes Service (AKS) API server.
---
# "TLS: client offered only unsupported versions" messages from my client when connecting to the AKS API server

When you try to connect to the Microsoft Azure Kubernetes Service (AKS) API server, you'll receive a "tls: client offered only unsupported versions" error message from your client computer or virtual machine if your version of Transport Layer Security (TLS) is out of date. The minimum supported TLS version in AKS is TLS 1.2.

To upgrade your TLS version to 1.2, see [Enable support for TLS 1.2 in your environment](/troubleshoot/azure/active-directory/enable-support-tls-environment).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
