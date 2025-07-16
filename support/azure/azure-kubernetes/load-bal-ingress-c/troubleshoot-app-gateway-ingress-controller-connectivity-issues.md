---
title: Troubleshoot Application Gateway Ingress Controller Connectivity Issues
description: Provides troubleshooting guidance for connectivity issues related to the Application Gateway Ingress Controller in Azure Kubernetes Service. 
ms.reviewer: claudiogodoy
ms.service: azure-kubernetes-service
ms.custom: sap:Load balancer and Ingress controller
ms.date: 05/24/2025
---
# Troubleshoot Application Gateway Ingress Controller connectivity issues

The [Application Gateway Ingress Controller (AGIC)](/azure/application-gateway/ingress-controller-overview) is a Kubernetes application that enables [Azure Kubernetes Service (AKS)](/azure/aks/what-is-aks) users to use Azure's native Application Gateway L7 load-balancer to expose cloud software to the internet.

This article provides step-by-step guidance to troubleshoot AGIC connectivity issues effectively.

## Prerequisites

Before you start, make sure that you have the following tools installed:

- **Azure CLI**: Follow the [installation guide](/cli/azure/install-azure-cli).
- **Kubernetes CLI (`kubectl`)**: Use Azure CLI to install it by running the command, `az aks install-cli`.
- **Client URL (`cURL`) tool**: Install it by following [this guidance](https://www.tecmint.com/install-curl-in-linux/).

## Common symptoms

> [!NOTE]
> This article focuses on Application Gateway Ingress Controller issues. Other underlying problems might cause similar symptoms. For more information, see [Troubleshoot connection issues to an app hosted in an AKS cluster](../connectivity/connection-issues-application-hosted-aks-cluster.md).

| Symptom | Description |
| --- | --- |
| **Ingress without IP address** | Errors in assigning an `IP address` to the `Ingress` indicate that AGIC isn't functioning correctly. |
| **HTTP Timeout** | If `DNS`, `Ingress`, and `Application` are working, AGIC is the likely cause of the issue. |

## Step 1: Verify application functionality

Make sure that your application is functioning correctly before you troubleshoot AGIC. Follow these steps:

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

5. **Verify application functionality**:

    > [!NOTE]
    > Investigate and resolve any errors that you encountered during this step before you proceed.

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

## Step 2: Inspect Ingress settings

Verify that the `Ingress` was created correctly:

1. **Describe the specific Ingress**:

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

If the `Ingress` lacks an address or displays events that indicate issues, investigate further.

## Step 3: Inspect Ingress pod logs

1. **Find the Ingress pod**:

    ```console
    kubectl get pod -A | grep ingress
    ```

2. **Inspect the logs**:

     ```console
    kubectl logs <INGRESS_POD_NAME> -n <YOUR_NAMESPACE>
    ```
   For the AGIC that is deployed by using the add-on, run the following command:
    
    ```console
   kubectl logs -n kube-system -l=app=ingress-appgw
    ```

Look for any errors or warnings that might indicate what's going wrong.

## Step 4: Check Application Gateway operational State

It focuses on understanding the operational state of the [Application Gateway](/azure/application-gateway/overview) if it's used as an [Ingress Controller on AKS](/azure/application-gateway/ingress-controller-overview).

### [Add-on](#tab/Add-on)

1. Get the Application Gateway name:

    ```console
    az aks show --name <YOUR_AKS_NAME> --resource-group <YOUR_RG_NAME> --query addonProfiles.ingressApplicationGateway
    ```
  
    > [!NOTE]
    > If you encounter an unexpected error during this step, AGIC might be misconfigured. In this case, refer to the following guide: [Enable the ingress controller add-on for a new AKS cluster with a new application gateway instance](/azure/application-gateway/tutorial-ingress-controller-add-on-new).

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

2. Verify the Application Gateway operational state:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```


### [Helm](#tab/helm)

1. Get the Application Gateway name:

    ```console
    helm show values agic-controller --jsonpath "appgw.name"
    ```

    > [!NOTE]
    > If you see any unexpected error on this step, you might have misconfigured `AGIC`, see [Install AGIC by using a new Application Gateway deployment](/azure/application-gateway/ingress-controller-install-new).

2. Validate the Application Gateway operational state:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```
  
The expected `operationalState` value is `Running`. If it's something different, you might have to restart the Application Gateway.

---
## Step 5 (Optional): Inspect Mapped Kubernetes and Application Gateway IPs

The [AGIC](/azure/application-gateway/ingress-controller-overview) monitors the pod IPs and maps them to `backendAddressPools` in the `Application Gateway` instance. This step verifies that integration.

1. **Get the Application Gateway `backendAddressPools`**:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query backendAddressPools
    ```

2. **Get the pod IPs by using Kubernetes endpoints**:

    ```console
    kubectl describe endpoints <YOUR_SERVICE_NAME> -n <YOUR_NAMESPACE> | grep Addresses
    ```

3. **Compare the results**:

    Make sure that the lists from steps 1 and 2 are equivalent. If they're not, AGIC might not be working correctly.

## Solution: Start the Application Gateway

If AGIC isn't working as expected, it might be stopped or misconfigured. If the Application Gateway operational state isn't `Running`, start or restart AGIC, wait a few seconds, and then test the application again.

```console
az network application-gateway start --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME>
```

## Additional resources

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
