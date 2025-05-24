---
title: Troubleshoot Application Gateway Ingress Controller connectivity
description: #TODO.
ms.reviewer: claudiogodoy
ms.service: azure-kubernetes-service
ms.custom: sap:Load balancer and Ingress controller
ms.topic: troubleshoot
ms.date: 05/24/2025
---
# Troubleshoot Application Gateway Ingress Controller connectivity

The [Application Gateway Ingress Controller (AGIC)](https://learn.microsoft.com/azure/application-gateway/ingress-controller-overview) is a Kubernetes application, which makes it possible for [Azure Kubernetes Service (AKS)](https://learn.microsoft.com/azure/aks/what-is-aks) customers to leverage Azure's native Application Gateway L7 load-balancer to expose cloud software to the Internet.

This article shows the steps to troubleshoot `AGIC` connectivity issues.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster.

   **Note:** To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- [Azure CLI](/cli/azure/install-azure-cli)

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

## Symptoms

> [!NOTE]
> This articles focus only on `Application Gateway Ingress Controller` issues, tough you might experience the same symptoms due to other problems. See [Troubleshoot connection issues to an app that's hosted in an AKS cluster](/troubleshoot/azure/azure-kubernetes/connectivity/connection-issues-application-hosted-aks-cluster) for more information.

| Symptom | Description |
| --- | --- |
| [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) without `IP address` | Errors to properly assign `IP address` to the `ingress` is a indicative that the `AGIC` is not working well |
| `Http` Timeout | When you validated that the `DNS`, `Ingress`, and the `Application` is working then likely the problem lies on the `AGIC` |

## Troubleshooting Step 1: Ensure the application is working as expected

First of all you must guarantee that you application is working as expect, you can do it through [port-forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) command.

If you're exposing a application with an `ingress` it's implicit that you have a well configured [service](https://kubernetes.io/docs/concepts/services-networking/service/), to validate follow the steps:

1. Describe your service:

    ```console
    kubectl describe service <YOUR_SERVICE> -n <YOUR_NAMESPACE>
    ```

2. Copy the Port:

    ```console
    $ kubectl describe service <YOUR_SERVICE> -n <YOUR_NAMESPACE>
    Name:                     dummy-web
    Namespace:                default
    Labels:                   app=dummy-web
    Annotations:              <none>
    Selector:                 app=dummy-web
    Type:                     ClusterIP
    IP Family Policy:         SingleStack
    IP Families:              IPv4
    IP:                       10.0.29.113
    IPs:                      10.0.29.113
    Port:                     <unset>  8080/TCP 
    TargetPort:               8080/TCP
    Endpoints:                10.224.0.49:8080,10.224.0.47:8080,10.224.0.4:8080 + 12 more...
    Session Affinity:         None
    Internal Traffic Policy:  Cluster
    Events:
    Type     Reason                        Age    From                       Message
    ----     ------                        ----   ----                       -------
    ```

3. Port-Forward your service:

    ```console
    kubectl port-forward svc/<YOUR_SERVICE> 9090:<YOUR_SERVICE_PORT> -n <YOUR_NAMESPACE>
    ```

