---
title: Troubleshoot Performance Issues in the Managed NGINX Ingress Controller in AKS
description: Step-by-step guide to identify and resolve performance issues in the Managed NGINX Ingress Controller in AKS. 
ms.reviewer: claudiogodoy
ms.service: azure-kubernetes-service
ms.date: 05/24/2025
---
# Troubleshoot issues in Managed NGINX ingress controller 

The [Managed NGINX ingress controller](/azure/aks/app-routing) is a routing add-on that enables the routing of HTTP and HTTPS traffic to applications that run on an [Azure Kubernetes Service (AKS)](/azure/aks/) cluster.

The routing system might be the root cause of performance-related problems. This article provides step-by-step guidance to troubleshoot NGINX ingress controller performance issues. This article also discusses common symptoms, root cause analysis, and configuration adjustments.

## Prerequisites

Before you start, make sure that you have the following tool installed:

- Kubernetes CLI (`kubectl`)

Use Azure CLI, and run the `az aks install-cli` command.

## Symptoms

| Symptom | Description |
| --- | --- |
| **HTTP Gateway Errors** | Error codes like `502` and `504` can indicate an NGINX exhaustion problem. |
| **High Response Time Difference** | Significant difference between your service response time and the end-to-end response time. There's a common latency added by NGINX. When it's too large, you might have an NGINX exhaustion problem. |

## Cause

The most common cause of performance issues on the NGINX is CPU exhaustion. During a load spike in the system, a good troubleshooting method is to monitor [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/) behavior. By default, the routing add-on creates a [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) that's named `app-routing-system`.

## Resolution

To troubleshoot the issue, follow these steps.

### Step 1: Verify horizontal pod autoscaler (HPA) behavior

1. Get the HPA name:

    ```console
    kubectl get hpa -n app-routing-system
    ```

2. Monitor the `HPA` behavior:

    ```console
    kubectl get hpa <HPA_NAME> -n app-routing-system -w
    ```

3. Evaluate the results:

    ```console
    $ kubectl get hpa <HPA_NAME> -n app-routing-system -w
    NAME    REFERENCE          TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
    nginx   Deployment/nginx   cpu: 83%/70%   1         2         1          77m
    nginx   Deployment/nginx   cpu: 83%/70%   1         2         2          77m
    nginx   Deployment/nginx   cpu: 106%/70%        1         2         2          79m
    nginx   Deployment/nginx   cpu: 133%/70%        1         2         2          80m
    ```

The **TARGETS** column shows the CPU threshold at which the `HPA` is triggered to scale up the pods. This behavior has several possible causes:

- The `HPA` reached the maximum number of pods.
- No nodes are available to use to schedule the pods.

### Step 2: Look for pods in a pending state

If your evaluation reveals that `NGINX HPA` didn't reach the maximum number of pods, the [kube-scheduler](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/#kube-scheduler) might not be able to find available nodes to use to schedule the `NGINX pods`. To find pending pods, run the following command:

    ```console
    kubectl get pod --field-selector=status.phase=Pending -n app-routing-system
    ```

> [!NOTE]
> If there are pending pods, the cluster might experience a resource exhaustion problem. For more information, see [Troubleshoot pod scheduler errors in Azure Kubernetes Service](azure/azure-kubernetes/availability-performance/troubleshoot-pod-scheduler-errors).

### Step 3: Check whether limits are applied to the NGINX deployment

Any misconfiguration on the `NGINX` [resource limits or requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) can cause the `HPA` to scale up more pods than it needs. To check the limits, follow these steps:

1. Describe the NGINX deployment:

    ```console
    kubectl describe deploy nginx -n app-routing-system
    ```

2. Verify the requests and limits:

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

## More information

By default, the current version of the NGINX ingress controller doesn't set limits for NGINX pods. The controller requests `500m` CPU to be used by the `HPA`. We recommend that you don't change these settings directly in the deployment definition.

If the `HPA` reaches the maximum number of pods, and the deployment requests and limits remain unchanged, configure the [custom resource definition (CRD)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) that's named [NginxIngressController](https://github.com/Azure/aks-app-routing-operator/blob/main/config/crd/bases/approuting.kubernetes.azure.com_nginxingresscontrollers.yaml).

### Configuration options

The following configuration options directly affect the `HPA` behavior.

| Property       | Type    | Description                                                                 | Required | Default   |
|----------------|---------|-----------------------------------------------------------------------------|----------|-----------|
| `scaling`      | object  | Configuration for scaling the controller. Contains nested properties.       | No       | Not applicable         |
| `maxReplicas`  | integer | Upper limit for replicas.                                                  | No       | 100       |
| `minReplicas`  | integer | Lower limit for replicas.                                                  | No       | 2         |
| `threshold`    | string  | Scaling threshold that defines how aggressively to scale. Options include: `rapid`, `steady`, `balanced`. | No       | balanced  |

### Apply the configuration

1. Edit the NginxIngressController CRD:

    ```console
    kubectl edit nginxingresscontroller -n app-routing-system
    ```

2. Add or modify the scaling configuration:

    ```yaml
    spec:
      scaling:
        maxReplicas: 10
        minReplicas: 2
        threshold: "balanced"
    ```

3. To apply the changes, save them, and then exit the editor.

4. Verify the changes:

    ```console
    kubectl get hpa -n app-routing-system
    ```

The HPA automatically updates, based on your new configuration. The NGINX ingress controller scales according to the specified parameters.

## References

- [Learn more about Azure Kubernetes Service (AKS) best practices](/azure/aks/best-practices)
- [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze)
- [NGINX ingress controller](https://github.com/kubernetes/ingress-nginx)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
