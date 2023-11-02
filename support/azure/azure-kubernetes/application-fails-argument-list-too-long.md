---
title: Argument list too long application failures
description: Troubleshoot an argument list too long error message that causes an application to fail in Azure Kubernetes Service (AKS).
ms.date: 05/23/2023
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot "argument list too long" error messages so that my application doesn't fail on Azure Kubernetes Service (AKS).
---
# Application failures caused by the "argument list too long" error message

This article discusses troubleshooting strategies for resolving application failures that are caused by the "argument list too long" error message in Microsoft Azure Kubernetes Service (AKS).

## Symptoms

Your application fails when the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) tries to run the executable, and you receive an error message that resembles the following output:

> standard_init_linux.go:228: exec user process caused: argument list too long

## Cause 1: The argument list provided to the executable is too long

The arguments that are provided to the application's executable are too long to be processed.

### Solution: Shorten the argument list

Eliminate any redundant or unnecessary arguments that you specify for the executable.

## Cause 2: The set of environment variables provided to the executable is too large

If too many services are deployed in one namespace, the environment variable list can become too large, and the kubelet will produce the error message when it tries to run the executable. The error occurs because the kubelet adds environment variables that record the host and port for each active service, so that [services can use this information to find other active services](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service).

### Solution 1: Reduce the number of services that are active

You can reduce the total number of active services, so that the kubelet adds a smaller number of overall environment variables.

### Solution 2: Reconfigure the kubelet so that it doesn't add environment variables for the service host and port

Within the [PodSpec core API](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#podspec-v1-core), set the `enableServiceLinks` field to `false`. This change reconfigures the kubelet behavior so that the host and port aren't automatically added as environment variables for each active service.

> [!WARNING]
> If your service relies on these environment variables to find other services, this field change will cause the service to fail. To avoid this scenario, rely on DNS for service discovery instead of environment variables, by using [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
