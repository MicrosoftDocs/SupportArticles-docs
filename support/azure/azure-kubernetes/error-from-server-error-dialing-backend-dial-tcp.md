---
title: 'Error from server: error dialing backend: dial tcp...'
description: 'Troubleshoot the Error from server: error dialing backend: dial tcp… message, which blocks you from using kubectl logs or connecting to the API server.'
ms.date: 6/1/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Error from server: error dialing backend: dial tcp…" message so that I can connect to the API server or use the `kubectl logs` command to get logs.
---
# "Error from server: error dialing backend: dial tcp..." messages

When you try to use the [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) command to print the logs for a Kubernetes resource, or when you try to connect to the API server, you may receive the "Error from server: error dialing backend: dial tcp..." message. To troubleshoot the error, review the following cause and solution matrix:

| Cause | Solution |
| --- | --- |
| The required ports aren't enabled for use. | Make sure ports 22, 1194, and 9000 are open for an API server connection. |
| When you run the [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command to show the resources in the `kube-system` namespace (`kubectl get pods --namespace kube-system`), the `tunnelfront` or `aks-link` pod isn't shown in the running state. | Force the deletion of the non-running pod so that it restarts. |

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
