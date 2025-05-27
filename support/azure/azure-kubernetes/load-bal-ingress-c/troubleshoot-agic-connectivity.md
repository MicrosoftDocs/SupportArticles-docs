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

4. Make a request to localhost on mapped port:

    ```console
    curl -v http://localhost:9090 
    ```

5. Validate if your application is working properly:
  
    > [!NOTE]
    > If you see any unexpected error on this step, you must investigate the problem and solve it to continue reading this guide.

    ```console
    $ curl -v http://localhost:9090 
    * Host localhost:9090 was resolved.
    * IPv6: ::1
    * IPv4: 127.0.0.1
    *   Trying [::1]:9090...
    * Connected to localhost (::1) port 9090
    > GET / HTTP/1.1
    > Host: localhost:9090
    > User-Agent: curl/8.5.0
    > Accept: */*
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=utf-8
    < Date: Tue, 27 May 2025 00:54:58 GMT
    < Server: Kestrel
    < Transfer-Encoding: chunked
    ```

## Troubleshooting Step 2: Inspect the Ingress settings

Now you have to make sure if the `Ingress` was created correctly, to do so follow the steps:

1. Find out your `Ingress`:

    ```console
    kubectl get ingress -A
    ```

2. Describe you `Ingress`:

    ```console
    kubectl describe ingress <YOUR_INGRESS> -n <YOUR_NAMESPACE>
    ```

3. Check the events, the rules, and the address:

    ```console
    $ kubectl describe ingress <YOUR_INGRESS> -n <YOUR_NAMESPACE>
    Name:             dummy-web
    Labels:           <none>
    Namespace:        default
    Address:
    Ingress Class:    azure-application-gateway
    Default backend:  <default>
    Rules:
    Host        Path  Backends
    ----        ----  --------
    *
                /   dummy-web:8080 (10.224.0.70:8080,10.224.0.72:8080,10.224.0.88:8080 + 12 more...)
    Annotations:  <none>
    Events:
    Type    Reason              Age                  From                       Message
    ----    ------              ----                 ----                       -------
    Normal  ResetIngressStatus  13m (x5 over 13m)    azure/application-gateway  Reset IP for Ingress default/dummy-web. Application Gateway <APPLICATION_GATEWAY_ID> is in stopped state
    ```

In this case, you can see that there is no address for this `Ingress`, and there is an event: Normal  ResetIngressStatus  13m (x5 over 13m)    azure/application-gateway  Reset IP for Ingress default/dummy-web. Application Gateway <APPLICATION_GATEWAY_ID> is in stopped state.

## Troubleshooting Step 3: Inspect the ingress pod logs

1. Find out the `Ingress` pod:

    ```console
    kubectl get pod -A | grep ingress
    ```

2. Inspect `logs`:

    ```console
    kubectl get pod -A | grep ingress
    ```

If in the previous step you saw any event on the ingress, you must try to look for then at this `logs` or find out any unexpected errors.

## Troubleshooting Step 4: Inspect the Application Gateway operational state

This step focus on understanding the operation state of the [Application Gateway](/azure/application-gateway/overview) used as [Ingress Controller on AKS](/azure/application-gateway/ingress-controller-overview).

1. Get tha Application Gateway ID:

    > [!NOTE]
    > If you see any unexpected error on this step, you must might have misconfigured `AGIC`, please read the guide: [Enable the ingress controller add-on for a new AKS cluster with a new application gateway instance](azure/application-gateway/tutorial-ingress-controller-add-on-new).

    ```console
    {
    "config": {
        "applicationGatewayName": "<APPLICATION_GATEWAY_NAME>",
        "effectiveApplicationGatewayId": "...",
        "subnetCIDR": "..."
    },
    "enabled": true,
    ..
    }
    ```


