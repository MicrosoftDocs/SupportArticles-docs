---
title: Troubleshoot application failures caused by argument list too long error message in AKS
description: Troubleshoot the "argument list too long" error that causes application failures in Azure Kubernetes Service (AKS). Learn how to fix the cause and restore your app.
ms.date: 11/10/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot "argument list too long" error messages so that my application doesn't fail on Azure Kubernetes Service (AKS).
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot application failures caused by the "argument list too long" error message in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the "argument list too long" error message that causes application failures in Azure Kubernetes Service (AKS). Learn how to identify the cause and apply a solution so that your application runs successfully.

## Symptoms

Your application fails when the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) tries to run the executable, and you receive an error message that resembles the following output.

> standard_init_linux.go:228: exec user process caused: argument list too long

## Cause 1: The argument list provided to the executable is too long

The arguments that you provide to the application's executable are too long to process.

### Solution: Shorten the argument list

Eliminate any redundant or unnecessary arguments that you specify for the executable.

## Cause 2: The set of environment variables provided to the executable is too large

If you deploy too many services in one namespace, the environment variable list can become too large. The kubelet produces the error message when it tries to run the executable. The error occurs because the kubelet adds environment variables that record the host and port for each active service, so that [services can use this information to find other active services](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service).

### Solution 1: Reduce the number of active services

Reduce the total number of active services, so that the kubelet adds a smaller number of environment variables.

### Solution 2: Reconfigure the kubelet so that it doesn't add environment variables for the service host and port

Within the [PodSpec core API](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#podspec-v1-core), set the `enableServiceLinks` field to `false`. This change reconfigures the kubelet behavior so that the host and port aren't automatically added as environment variables for each active service.

> [!WARNING]
> If your service relies on these environment variables to find other services, this field change causes the service to fail. To avoid this scenario, rely on DNS for service discovery instead of environment variables, by using [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]