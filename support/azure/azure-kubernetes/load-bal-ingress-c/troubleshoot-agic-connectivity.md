---
title: Troubleshoot Application Gateway Ingress Controller connectivity
description: This file provides troubleshooting guidance for connectivity issues related to the Application Gateway Ingress Controller (AGIC) in Azure Kubernetes Service (AKS). It includes prerequisites, symptoms of common issues, and initial troubleshooting steps to ensure the application is functioning correctly. The metadata reflects its focus on AGIC connectivity troubleshooting for AKS users.
ms.reviewer: claudiogodoy
ms.service: azure-kubernetes-service
ms.custom: sap:Load balancer and Ingress controller
ms.date: 05/24/2025
---
# Troubleshoot Application Gateway Ingress Controller connectivity

The [Application Gateway Ingress Controller (AGIC)](/azure/application-gateway/ingress-controller-overview) is a Kubernetes application that enables [Azure Kubernetes Service (AKS)](/azure/aks/what-is-aks) customers to use Azure's native Application Gateway L7 load-balancer to expose cloud software to the Internet.

This article provides step-by-step guidance to troubleshoot `AGIC` connectivity issues effectively.

## Prerequisites

Before starting, ensure you have the following tools installed:

- **Kubernetes CLI (`kubectl`)**: Use [Azure CLI](/cli/azure/install-azure-cli) to install it by running the command `az aks install-cli`.
- **Azure CLI**: Follow the [installation guide](/cli/azure/install-azure-cli).
- **Client URL (`cURL`) tool**: Install it using [this guide](https://www.tecmint.com/install-curl-in-linux/).

## Common Symptoms

> [!NOTE]
> This article focuses on `Application Gateway Ingress Controller` issues. Similar symptoms may arise from other problems. Refer to [Troubleshoot connection issues to an app hosted in an AKS cluster](/troubleshoot/azure/azure-kubernetes/connectivity/connection-issues-application-hosted-aks-cluster) for additional information.

| Symptom | Description |
| --- | --- |
| **Ingress without IP address** | Errors in assigning an `IP address` to the `ingress` indicate that `AGIC` is not functioning correctly. |
| **HTTP Timeout** | If `DNS`, `Ingress`, and the `Application` are working, the issue likely lies with `AGIC`. |

## Step 1: Verify Application Functionality

Ensure your application is functioning correctly before troubleshooting `AGIC`. Follow these steps:

1. **Describe your service**:

    ```console
    kubectl describe service <YOUR_SERVICE> -n <YOUR_NAMESPACE>
    ```

2. **Copy the port details**:

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

3. **Port-forward your service**:

    ```console
    kubectl port-forward svc/<YOUR_SERVICE> 9090:<YOUR_SERVICE_PORT> -n <YOUR_NAMESPACE>
    ```

4. **Test the application locally**:

    ```console
    curl -v http://localhost:9090 
    ```

5. **Validate application functionality**:

    > [!NOTE]
    > Investigate and resolve any errors encountered during this step before proceeding.

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

## Step 2: Inspect Ingress Settings

Verify that the `Ingress` was created correctly:

1. **Describe the specific ingress**:

    ```console
    kubectl describe ingress <YOUR_INGRESS> -n <YOUR_NAMESPACE>
    ```

2. **Check events, rules, and address**:

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

If the `Ingress` lacks an address or shows events indicating issues, investigate further.

## Step 3: Inspect Ingress Pod Logs

1. **Inspect the logs**:

    ```console
    kubectl logs -n kube-system -l=app=ingress-appgw
    ```

Look for any errors or warnings that might indicate what is going wrong.

## Step 4: Check Application Gateway Operational State

This step focuses on understanding the operational state of the [Application Gateway](/azure/application-gateway/overview) used as [Ingress Controller on AKS](/azure/application-gateway/ingress-controller-overview).

### [Add-on](#tab/Add-on)

1. **Get the Application Gateway name**:

    ```console
    az aks show --name <YOUR_AKS_NAME> --resource-group <YOUR_RG_NAME> --query addonProfiles.ingressApplicationGateway
    ```
  
    > [!NOTE]
    > If you see any unexpected error on this step, you might have misconfigured `AGIC`, please read the guide: [Enable the ingress controller add-on for a new AKS cluster with a new application gateway instance](/azure/application-gateway/tutorial-ingress-controller-add-on-new).

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

2. **Validate the Application Gateway operational state**:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```

### [Helm](#tab/helm)

1. **Get the Application Gateway name**:

    ```console
    helm show values agic-controller --jsonpath "appgw.name"
    ```

    > [!NOTE]
    > If you see any unexpected error on this step, you might have misconfigured `AGIC`, please read the guide: [Install AGIC by using a new Application Gateway deployment](/azure/application-gateway/ingress-controller-install-new).

2. **Validate the Application Gateway operational state**:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```
  
The expected `operationalState` is `Running`. If it's different, you may need to restart your Application Gateway.

## Step 5 (Optional): Inspect Mapped Kubernetes and Application Gateway IPs

The [AGIC](/azure/application-gateway/ingress-controller-overview) monitors the pod IPs and maps them to `backendAddressPools` in the `Application Gateway` instance. This step validates that integration.

1. **Get the Application Gateway `backendAddressPools`**:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query backendAddressPools
    ```

2. **Get the pod IPs using Kubernetes endpoints**:

    ```console
    kubectl describe endpoints <YOUR_SERVICE_NAME> -n <YOUR_NAMESPACE> | grep Addresses
    ```

3. **Compare the results**:

    Ensure the lists from steps 1 and 2 are equal. If not, `AGIC` may not be working correctly.

## Solution: Start/Restart the Application Gateway

If your `AGIC` is not working as expected, it might be stopped or misconfigured. If the Application Gateway operational state is not `Running`, start it, wait a few seconds, and test again.

```console
az network application-gateway start --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME>
```

## Additional Resources

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]