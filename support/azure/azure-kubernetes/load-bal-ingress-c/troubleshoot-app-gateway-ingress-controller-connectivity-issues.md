---
title: Troubleshoot Application Gateway Ingress Controller Connectivity Issues
description: "Troubleshoot Application Gateway Ingress Controller connectivity issues in AKS with step-by-step checks and fixes to restore ingress traffic quickly. Start now." 
ms.service: azure-kubernetes-service
ms.custom: sap:Load balancer and Ingress controller
ms.date: 07/10/2026
ms.reviewer: kaushika, claudiogodoy
ai-usage: ai-assisted
---

# Troubleshoot Application Gateway Ingress Controller Connectivity Issues - Azure | Microsoft Learn

## Summary

This article explains how to troubleshoot connectivity issues with the Application Gateway Ingress Controller (AGIC) in Azure Kubernetes Service (AKS). [AGIC](/azure/application-gateway/ingress-controller-overview) is a Kubernetes application that integrates with Azure's native Application Gateway L7 load balancer to expose cloud applications to the internet. By following the step-by-step guidance provided, you can quickly identify and resolve AGIC connectivity problems, ensuring uninterrupted ingress traffic and application availability.

## Prerequisites

Before you start, make sure that you have the following tools installed:

- **Azure CLI**: Follow the [installation guide](/cli/azure/install-azure-cli).
- **Kubernetes CLI (`kubectl`)**: Use Azure CLI to install it by running the command, `az aks install-cli`.
- **Client URL (`cURL`) tool**: Install it by following [this guidance](https://www.tecmint.com/install-curl-in-linux/).

## Common symptoms

> [!NOTE]
> This article focuses on Application Gateway Ingress Controller problems. Other underlying problems might cause similar symptoms. For more information, see [Troubleshoot connection problems to an app hosted in an AKS cluster](../connectivity/connection-issues-application-hosted-aks-cluster.md).

You might observe one or more of the following symptoms:

- AGIC pod isn't running or is restarting frequently
- Application Gateway doesn't reflect changes from ingress resources
- Backend pools, listeners, or rules aren't updated
- AGIC logs show errors such as:
  - Failed to fetch or apply Application Gateway configuration  
  - Authorization failures  
  - Connection timeouts  
- Application isn't accessible through Application Gateway

## Resolution

Follow these steps to identify and resolve the issue.

### Step 1: Verify application functionality

Make sure that your application is functioning correctly before you troubleshoot AGIC. Follow these steps:

1. **Describe your service**:

    ```console
    kubectl describe service <YOUR_SERVICE> -n <YOUR_NAMESPACE>
    ```
1. **Copy the port details**:

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
1. **Port-forward your service**:

    ```console
    kubectl port-forward svc/<YOUR_SERVICE> 9090:<YOUR_SERVICE_PORT> -n <YOUR_NAMESPACE>
    ```
1. **Test the application locally**:

    ```console
    curl -v http://localhost:9090 
    ```
1. **Verify application functionality**:

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

### Step 2: Inspect Ingress settings

Verify that you created the `Ingress` correctly:

1. **Describe the specific Ingress**:

    ```console
    kubectl describe ingress <YOUR_INGRESS> -n <YOUR_NAMESPACE>
    ```
1. **Check events, rules, and address**:

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

If the `Ingress` lacks an address or displays events that indicate problems, investigate further.



### Step 3: Verify if AGIC pod is healthy

#### Check Pod Status
```bash
kubectl get pods -n kube-system -l app=ingress-appgw
```

**Expected:**
- Status = Running  
- READY = 1/1  

#### Describe the pod
```bash
kubectl describe pod -n kube-system -l app=ingress-appgw
```

**Check:**
- Pod state = Running  
- Container state = Running  
- No critical errors in Events  

Any other status indicates the pod needs further investigation.

---

#### Check AGIC Pod Logs
```bash
kubectl logs -n kube-system -l app=ingress-appgw
```

If the pod is restarting:
```bash
kubectl logs -p -n kube-system -l app=ingress-appgw
```

---

#### What to Look For
- Errors or warnings in logs  
- CrashLoopBackOff events  
- Connectivity or authentication failures  

---

#### Next Step
- If the pod isn't healthy, resolve pod failures by using the logs.  
- If the pod is healthy, proceed to Step 4.  

---

## Step 4: Validate AGIC and Application Gateway synchronization

AGIC updates Application Gateway automatically when ingress resources change.

---

#### Check AGIC Logs for Updates
Use logs from previous steps and look for:
- Configuration updates being applied  
- Errors preventing updates  

---

#### Check Application Gateway Activity
In Azure Portal → Application Gateway → **Activity log**

**Confirm:**
- Configuration updates are being applied and no failed operations  

---

#### Common Issues
If AGIC can't update Application Gateway, the logs might show:
- Failed to fetch or apply configuration  
- Authorization failures  
- Connection timeouts  

These errors mean that AGIC can't communicate with or update Application Gateway.

---

#### Next step
- If configuration is updating → proceed to application-level troubleshooting  

---

## Step 5: Check Application Gateway operational state

- [Troubleshoot app connection issues in an AKS cluster](../connectivity/connection-issues-application-hosted-aks-cluster.md)


#This section explains how to understand the operational state of the [Application Gateway](/azure/application-gateway/overview) when you use it as an [Ingress Controller on AKS](/azure/application-gateway/ingress-controller-overview).

# [Add-on](#tab/Add-on)
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
1. Verify the Application Gateway operational state:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```

# [Helm](#tab/helm)
1. Get the Application Gateway name:

    ```console
    helm show values agic-controller --jsonpath "appgw.name"
    ```

    > [!NOTE]
    > If you see any unexpected error in this step, you might have misconfigured `AGIC`. For more information, see [Install AGIC by using a new Application Gateway deployment](/azure/application-gateway/ingress-controller-install-new).
1. Validate the Application Gateway operational state:

    ```console
    az network application-gateway show --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME> --query operationalState
    ```

The expected `operationalState` value is `Running`. If it's something different, you might need to restart the Application Gateway. If the Application Gateway operational state isn't `Running`, start or restart AGIC, wait a few seconds, and then test the application again.

```console
az network application-gateway start --name <YOUR_APPLICATION_GATEWAY_NAME> --resource-group <YOUR_RG_NAME>
```
---


