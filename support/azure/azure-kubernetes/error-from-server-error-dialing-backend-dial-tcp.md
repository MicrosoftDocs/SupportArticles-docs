---
title: 'Error from server: error dialing backend: dial tcp'
description: 'Troubleshoot the Error from server: error dialing backend: dial tcp error that blocks you from using kubectl logs or connecting to the API server.'
ms.date: 09/07/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Error from server: error dialing backend: dial tcp" error so that I can connect to the API server or use the `kubectl logs` command to get logs.
---
# "Error from server: error dialing backend: dial tcp" message

## Symptoms

You receive an "Error from server: error dialing backend: dial tcp" error message when you take one of the following actions:

- Use the [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) command to print the logs for a Kubernetes resource
- Connect to the API server

## Cause 1: Ports are disabled

The required ports aren't enabled for use.

### Solution: Enable ports 22, 1194, and 9000

Make sure that ports 22, 1194, and 9000 are open for an API server connection.

## Cause 2: The tunnelfront, aks-link, or konnectivity-agent pod isn't running

When you run the [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command to display the resources in the `kube-system` namespace (`kubectl get pods --namespace kube-system`), the `tunnelfront`, `aks-link`, or `konnectivity-agent` pod is shown to be in a non-running state.

### Solution: Delete the non-running pod

Force delete the non-running pod so that it restarts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
