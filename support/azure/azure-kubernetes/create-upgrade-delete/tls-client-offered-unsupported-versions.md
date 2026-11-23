---
title: Resolve tls client offered only unsupported versions error in AKS
description: Fix the "tls - client offered only unsupported versions" error when connecting to the AKS API server. Learn the cause and upgrade to TLS 1.2 to resolve it.
ms.date: 11/19/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, v-leedennis, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot "tls: client offered only unsupported versions" error messages from my client computer or virtual machine so that I can connect successfully to the Azure Kubernetes Service (AKS) API server.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Resolve "tls: client offered only unsupported versions" error when connecting to the Azure Kubernetes Service API server

## Summary

This article helps you resolve the "tls: client offered only unsupported versions" error that occurs on a client computer or virtual machine when you connect to the Azure Kubernetes Service (AKS) API server. Upgrade your client to TLS 1.2 to restore the connection.

## Symptoms

When you try to connect to the AKS API server, you receive the following error message from your client computer or virtual machine.

> tls: client offered only unsupported versions

## Cause

Your version of the Transport Layer Security (TLS) protocol is out of date. The minimum supported version in AKS is TLS 1.2.

## Solution

Upgrade your TLS version to 1.2. For upgrade instructions, see [Enable support for TLS 1.2 in your environment](../../entra-id/ad-dmn-services/enable-support-tls-environment.md).