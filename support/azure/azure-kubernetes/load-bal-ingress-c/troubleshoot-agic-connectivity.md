---
title: Troubleshoot Application Gateway Ingress Controller connectivity
description: This file provides troubleshooting guidance for connectivity issues related to the Application Gateway Ingress Controller (AGIC) in Azure Kubernetes Service (AKS). It includes prerequisites, symptoms of common issues, and initial troubleshooting steps to ensure the application is functioning correctly. The metadata reflects its focus on AGIC connectivity troubleshooting for AKS users.
ms.reviewer: claudiogodoy
ms.service: azure-kubernetes-service
ms.custom: sap:Load balancer and Ingress controller
ms.topic: troubleshoot
ms.date: 05/24/2025
---
# Troubleshoot Application Gateway Ingress Controller connectivity

The [Application Gateway Ingress Controller (AGIC)](https://learn.microsoft.com/azure/application-gateway/ingress-controller-overview) is a Kubernetes application that enables [Azure Kubernetes Service (AKS)](https://learn.microsoft.com/azure/aks/what-is-aks) customers to leverage Azure's native Application Gateway L7 load-balancer to expose cloud software to the Internet.

This article outlines the steps to troubleshoot `AGIC` connectivity issues.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster.

   **Note:** To install kubectl using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- [Azure CLI](/cli/azure/install-azure-cli)

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

## Symptoms

> [!NOTE]
> This article focuses only on `Application Gateway Ingress Controller` issues. However, you might experience similar symptoms due to other problems. See [Troubleshoot connection issues to an app that's hosted in an AKS cluster](/troubleshoot/azure/azure-kubernetes/connectivity/connection-issues-application-hosted-aks-cluster) for more information.

| Symptom | Description |
| --- | --- |
| [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) without `IP address` | Errors in properly assigning an `IP address` to the `ingress` indicate that the `AGIC` is not functioning correctly. |
| `HTTP` Timeout | If you have validated that the `DNS`, `Ingress`, and the `Application` are working, then the problem likely lies with the `AGIC`. |

## Troubleshooting Step 1: Ensure the application is working as expected

First, ensure that your application is working as expected. You can do this using the [port-forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) command.

If you're exposing an application with an `ingress`, it is implicit that you have a well-configured [service](https://kubernetes.io/docs/concepts/services-networking/service/). To validate, follow these steps:

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

3. Port-forward your service:

    ```console
    kubectl port-forward svc/<YOUR_SERVICE> 9090:<YOUR_SERVICE_PORT> -n <YOUR_NAMESPACE>
    ```

4. Make a request to localhost on the mapped port:

    ```console
    curl -v http://localhost:9090 
    ```

5. Validate if your application is working properly:
  
    > [!NOTE]
    > If you see any unexpected errors at this step, you must investigate and resolve the problem before continuing with this guide.

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

Ensure the `Ingress` was created correctly. Follow these steps:

1. Find your `Ingress`:

    ```console
    kubectl get ingress -A
    ```

2. Describe your `Ingress`:

    ```console
    kubectl describe ingress <YOUR_INGRESS> -n <YOUR_NAMESPACE>
    ```

3. Check the events, rules, and address:

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

In this case, you can see that there is no address for this `Ingress`, and there is an event: `Normal ResetIngressStatus 13m (x5 over 13m) azure/application-gateway Reset IP for Ingress default/dummy-web. Application Gateway <APPLICATION_GATEWAY_ID> is in stopped state`.

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

1. Get tha Application Gateway name:

    ```console
    az aks show --name <YOUR_AKS_NAME> --resource-group <YOU_RG_NAME> --query addonProfiles.ingressApplicationGateway
    ```
  
    > [!NOTE]
    > If you see any unexpected error on this step, you might have misconfigured `AGIC`, please read the guide: [Enable the ingress controller add-on for a new AKS cluster with a new application gateway instance](azure/application-gateway/tutorial-ingress-controller-add-on-new).

    ```console
    {
    "config": {
        "applicationGatewayName": "<YOUR_APPLICATION_GATEWAY_NAME>",
        "effectiveApplicationGatewayId": "...",
        "subnetCIDR": "..."
    },
    "enabled": true,
    ..
    }
    ```

2. Validate the Application Gateway `operationalState`:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```
  
The expected `operationalState` is `Running`, if it's different you must restart your Application Gateway.

## Troubleshooting Step 4 (Optional): Inspect the mapped Kubernetes and Applications Gateway ip's

The [AGIC](https://learn.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview) monitors the pod's ip's and map then to `backendAddressPools` in the `Applications Gateway` instance. In this step we are going to validate if that integration is working.

1. Get the Application Gateway `backendAddressPools`:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState --query backendAddressPools
    ```

2. Get the pod's ip's using the Kubernetes endpoints:

    ```console
    kubectl describe endpoints <YOUR_SERVICE_NAME> -n <YOUR_NAMESPACE> | grep Addresses
    ```

3. Compare the results, if the lists are not equal it means the `AGIC` is not working appropriately.

    ```console
    $ az aks show --name <YOUR_AKS_NAME> --resource-group <YOU_RG_NAME> --query addonProfiles.ingressApplicationGateway --query backendAddressPools
    [
        {
            "backendAddresses": [
            {
                "ipAddress": "10.224.0.19"
            },
            {
                "ipAddress": "10.224.0.24"
            },
            {
                "ipAddress": "10.224.0.42"
            },
            {
                "ipAddress": "10.224.0.49"
            },
            {
                "ipAddress": "10.224.0.67"
            },
            {
                "ipAddress": "10.224.0.69"
            },
            {
                "ipAddress": "10.224.0.7"
            },
            {
                "ipAddress": "10.224.0.74"
            },
            {
                "ipAddress": "10.224.0.77"
            },
            {
                "ipAddress": "10.224.0.79"
            },
            {
                "ipAddress": "10.224.0.8"
            },
            {
                "ipAddress": "10.224.0.81"
            },
            {
                "ipAddress": "10.224.0.82"
            },
            {
                "ipAddress": "10.224.0.90"
            }
            ],
            ...
        }]

    $ kubectl describe endpoints <YOUR_SERVICE_NAME> -n <YOUR_NAMESPACE> | grep Addresses
     Addresses:          10.224.0.12,10.224.0.14,10.224.0.15,10.224.0.22,10.224.0.25,10.224.0.27,10.224.0.30,10.224.0.31,10.224.0.33,10.224.0.35,10.224.0.38,10.224.0.4,10.224.0.63,10.224.0.70,10.224.0.77
    ```

## Solution: Start/Restart the Application Gateway

If your `AIGC` is not working as expect it's probably either stopped or misconfigured, if you checked up the Application Gateway operational state and it is not `Running`, you should start it wait some seconds and test again.

```console
az network application-gateway start --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME>
```

## More information

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)

- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]