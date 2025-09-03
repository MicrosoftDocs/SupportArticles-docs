---
title: Troubleshoot Performance Issues with the Managed NGINX Ingress Controller in AKS
description: Step-by-step guide to identify and resolve performance issues with the Managed NGINX Ingress Controller in Azure Kubernetes Service (AKS), including common symptoms, root cause analysis, and configuration adjustments. 
ms.reviewer: claudiogodoy
ms.service: azure-kubernetes-service
ms.date: 05/24/2025
---
# Managed NGINX ingress controller guidance

The [Managed NGINX ingress controller](/azure/aks/app-routing) is a routing add-on that enables routing HTTP and HTTPS traffic to applications running on an [Azure Kubernetes Service (AKS)](/azure/aks/) cluster.

In performance-related problems, the routing system may be the root cause. This article provides step-by-step guidance to troubleshoot NGINX ingress controller performance issues.

## Prerequisites

Before you start, ensure you have the following tool installed:

- **Kubernetes CLI (`kubectl`)**: Use Azure CLI and run the command `az aks install-cli`.

## Symptoms

| Symptom | Description |
| --- | --- |
| **HTTP Gateway Errors** | Error codes like `502` and `504` can indicate an NGINX exhaustion problem. |
| **High Response Time Difference** | Significant difference between your service response time and the end-to-end response time. There's a common latency added by NGINX. When it's too large, you might have an NGINX exhaustion problem. |

## Step 1: Verify horizontal pod autoscaler (HPA) behavior

The most common reason for performance issues on the NGINX is CPU exhaustion. During a load spike in the system, a good approach is to monitor [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/) behavior.
By default, the routing add-on creates a [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) named `app-routing-system`.

1. **Get the HPA name**:

    ```console
    kubectl get hpa -n app-routing-system
    ```

2. **Monitor the HPA behavior**:

    ```console
    kubectl get hpa <HPA_NAME> -n app-routing-system -w
    ```

3. **Evaluate the results**:

    ```console
    $ kubectl get hpa <HPA_NAME> -n app-routing-system -w
    NAME    REFERENCE          TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
    nginx   Deployment/nginx   cpu: 83%/70%   1         2         1          77m
    nginx   Deployment/nginx   cpu: 83%/70%   1         2         2          77m
    nginx   Deployment/nginx   cpu: 106%/70%        1         2         2          79m
    nginx   Deployment/nginx   cpu: 133%/70%        1         2         2          80m
    ```

The **TARGETS** column shows the CPU threshold where the `HPA` triggers to scale up the pods. There are a few possibilities for this behavior:

- `HPA` has reached the maximum number of pods.
- There are no available nodes to schedule the pods.

## Step 2: Look for pods in pending state

If in your evaluation you saw that `NGINX HPA` hadn't reached the maximum number of pods, the [kube-scheduler](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/#kube-scheduler) might not be able to find available nodes to schedule the `NGINX pods`.

1. **Get pending pods**:

    ```console
    kubectl get pod --field-selector=status.phase=Pending -n app-routing-system
    ```

 > [!NOTE]
> If there are pending pods, the cluster is probably facing a resource exhaustion problem. See [Troubleshoot pod scheduler errors in Azure Kubernetes Service](azure/azure-kubernetes/availability-performance/troubleshoot-pod-scheduler-errors) for more details.

## Step 3: Verify if there are Limits applied to the NGINX deployment

Any misconfiguration on the `NGINX` [resource limits or requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) can lead to `HPA` scaling up more pods than necessary.

1. **Describe the NGINX deployment**:

    ```console
    kubectl describe deploy nginx -n app-routing-system
    ```

2. **Verify requests and limits**:

    ```console
    $ kubectl describe deploy nginx -n app-routing-system
    Name:                   nginx
    ....
    Selector:               app=nginx
    ....
    Pod Template:
    ....
    Containers:
    controller:
        ...
        Limits:
        ...
        Requests:
        ...
    ```

## Solution

By default, the current version of the NGINX ingress controller doesn't set limits for NGINX pods and requests `500m` CPU, which is used by the `HPA`. It's not recommended to change these values directly in the deployment definition.

If your `HPA` is reaching the maximum number of pods and the deployment's requests and limits remain unchanged, configure the [custom resource definition (CRD)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) named [NginxIngressController](https://github.com/Azure/aks-app-routing-operator/blob/main/config/crd/bases/approuting.kubernetes.azure.com_nginxingresscontrollers.yaml).

### Configuration options

The following configuration options directly impact the `HPA` behavior:

| Property       | Type    | Description                                                                 | Required | Default   |
|----------------|---------|-----------------------------------------------------------------------------|----------|-----------|
| `scaling`      | object  | Configuration for scaling the controller. Contains nested properties.       | No       | -         |
| `maxReplicas`  | integer | Upper limit for replicas.                                                  | No       | 100       |
| `minReplicas`  | integer | Lower limit for replicas.                                                  | No       | 2         |
| `threshold`    | string  | Scaling threshold defining how aggressively to scale. Options include: `rapid`, `steady`, `balanced`. | No       | balanced  |

### Apply the configuration

1. **Edit the NginxIngressController CRD**:

    ```console
    kubectl edit nginxingresscontroller -n app-routing-system
    ```

2. **Add or modify the scaling configuration**:

    ```yaml
    spec:
      scaling:
        maxReplicas: 10
        minReplicas: 2
        threshold: "balanced"
    ```

3. **Save and exit** the editor to apply the changes.

4. **Verify the changes**:

    ```console
    kubectl get hpa -n app-routing-system
    ```

The HPA automatically updates based on your new configuration and the NGINX ingress controller scales according to the specified parameters.

## Additional resources

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)
- [NGINX ingress controller](https://github.com/kubernetes/ingress-nginx)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]