---
title: Troubleshoot the health probe mode for AKS cluster service load balancer
description: Diagnoses and fixes common issues with the health probe mode feature.
ms.date: 06/03/2024
ms.reviewer: niqi, cssakscic, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance, devx-track-azurecli, innovation-engine
---

# Troubleshoot issues when enabling the AKS cluster service health probe mode

The health probe mode feature allows you to configure how Azure Load Balancer probes the health of the nodes in your Azure Kubernetes Service (AKS) cluster. You can choose between two modes: Shared and ServiceNodePort. The Shared mode uses a single health probe for all external traffic policy cluster services that use the same load balancer. In contrast, the ServiceNodePort mode uses a separate health probe for each service. The Shared mode can reduce the number of health probes and improve the performance of the load balancer, but it requires some additional components to work properly. To enable this feature, see [How to enable the health probe mode feature using the Azure CLI](#how-to-enable-the-health-probe-mode-feature-using-the-azure-cli).

This article describes some common issues about using the health probe mode feature in an AKS cluster and helps you troubleshoot and resolve these issues.

## Symptoms 

When creating or updating an AKS cluster by using the Azure CLI, if you enable the health probe mode feature using the `--cluster-service-load-balancer-health-probe-mode Shared` flag, the following issues occur:

- The load balancer doesn't distribute traffic to the nodes as expected. 

- The load balancer reports unhealthy nodes even if they're healthy. 

- The health-probe-proxy sidecar container crashes or doesn't start. 

- The cloud-node-manager pod crashes or doesn't start.  

The following operations also happen:

1. RP frontend checks if the request is valid and updates the corresponding property in the LoadBalancerProfile.

2. RP async calls the cloud provider config secret reconciler to update the cloud provider config secret based on the LoadBalancerProfile. 

3. Overlaymgr reconciles the cloud-node-manager chart to enable the health-probe-proxy sidecar.

## Initial troubleshooting

To troubleshoot these issues, follow these steps:

0. First, connect to your AKS cluster using the Azure CLI:

    ```azurecli
    export RESOURCE_GROUP="aks-rg"
    export AKS_CLUSTER_NAME="aks-cluster"
    az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --overwrite-existing
    ```

1. Next, check the RP frontend log to see if the health probe mode in the LoadBalancerProfile is properly configured. You can use the `az aks show` command to view the LoadBalancerProfile property of your cluster. 

    ```azurecli
    export RESOURCE_GROUP="aks-rg"
    export AKS_CLUSTER_NAME="aks-cluster"
    az aks show --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "networkProfile.loadBalancerProfile"
    ```
    Results:

    <!-- expected_similarity=0.3 -->

    ```output
    {
      "clusterServiceLoadBalancerHealthProbeMode": "Shared",
      "managedOutboundIPs": null,
      "outboundIPs": null,
      "outboundIPPrefixes": null,
      "allocatedOutboundPorts": null,
      "effectiveOutboundIPs": [
        {
          "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/MC_aks-rg_aks-cluster_eastus2/providers/Microsoft.Network/publicIPAddresses/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        }
      ],
      "idleTimeoutInMinutes": 30,
      "loadBalancerSku": "standard",
      "managedOutboundIPv6": null
    }
    ```

2. Check the cloud provider configuration. In modern AKS clusters, the cloud provider configuration is managed internally and the `ccp` namespace doesn't exist. Instead, check for cloud provider related resources and verify the cloud-node-manager pods are running properly:


    ```bash
    # Check for cloud provider related ConfigMaps in kube-system
    kubectl get configmap -n kube-system | grep -i azure
    
    # Check if cloud-node-manager pods are running (indicates cloud provider integration is working)
    kubectl get pods -n kube-system | grep cloud-node-manager
    
    # Check the azure-ip-masq-agent-config if it exists
    kubectl get configmap azure-ip-masq-agent-config-reconciled -n kube-system -o yaml 2>/dev/null || echo "ConfigMap not found"
    ```
    Results:

    <!-- expected_similarity=0.3 -->

    ```output
    configmap/azure-ip-masq-agent-config-reconciled   1      11h
    
    cloud-node-manager-rfb2w                        2/2     Running   0          16m
    ```

3. Check the chart or overlay daemonset cloud-node-manager to see if the health-probe-proxy sidecar container is enabled. You can use the `kubectl get ds` command to view the daemonset.

    ```shell
    kubectl get ds -n kube-system cloud-node-manager -o yaml
    ```
    Results:

    <!-- expected_similarity=0.3 -->

    ```output
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: cloud-node-manager
      namespace: kube-system
      ...
    spec:
      template:
        spec:
          containers:
          - name: cloud-node-manager
            image: mcr.microsoft.com/oss/kubernetes/azure-cloud-node-manager:xxxxxxxx
          - name: health-probe-proxy
            image: mcr.microsoft.com/oss/kubernetes/azure-health-probe-proxy:xxxxxxxx
          ...
    ```

## Cause 1: The health probe mode isn't Shared or ServiceNodePort

The health probe mode feature only works with these two modes. If you use any other mode, the feature won't work. 

### Solution 1: Use the correct health probe mode

Make sure you use the Shared or ServiceNodePort mode when creating or updating your cluster. You can use the `--cluster-service-load-balancer-health-probe-mode` flag to specify the mode. 

## Cause 2: The toggle for the health probe mode feature is off

The health probe mode feature is controlled by a toggle that can be enabled or disabled by the AKS team. If the toggle is off, the feature won't work. 

### Solution 2: Turn on the toggle

Contact the AKS team to check if the toggle for the health probe mode feature is on or off. If it's off, ask them to turn it on for your subscription. 

## Cause 3: The load balancer SKU is Basic

The health probe mode feature only works with the Standard Load Balancer SKU. If you use the Basic Load Balancer SKU, the feature won't work. 

### Solution 3: Use the Standard Load Balancer SKU

Make sure you use the Standard Load Balancer SKU when creating or updating your cluster. You can use the `--load-balancer-sku` flag to specify the SKU. 

## Cause 4: The feature isn't registered

The health probe mode feature requires you to register the feature on your subscription. If the feature isn't registered, it won't work. 

### Solution 4: Register the feature

Make sure you register the feature for your subscription before creating or updating your cluster. You can use the `az feature register` command to register the feature. 

```azurecli
export FEATURE_NAME="EnableSLBSharedHealthProbePreview"
export PROVIDER_NAMESPACE="Microsoft.ContainerService"
az feature register --name $FEATURE_NAME --namespace $PROVIDER_NAMESPACE
```
Results:

<!-- expected_similarity=0.3 -->

```output
{
  "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/providers/Microsoft.Features/providers/Microsoft.ContainerService/features/EnableAKSClusterServiceLoadBalancerHealthProbeMode",
  "name": "Microsoft.ContainerService/EnableAKSClusterServiceLoadBalancerHealthProbeMode",
  "properties": {
    "state": "Registering"
  },
  "type": "Microsoft.Features/providers/features"
}
```

## Cause 5: The Kubernetes version is earlier than v1.28.0

The health probe mode feature requires a minimum Kubernetes version of v1.28.0. If you use an older version, the feature won't work. 

### Solution 5: Upgrade the Kubernetes version

Make sure you use Kubernetes v1.28.0 or a later version when creating or updating your cluster. You can use the `--kubernetes-version` flag to specify the version. 

## Known issues 

For Windows, the kube-proxy component doesn't start until you create the first non-HPC pod in a node. This issue affects the health probe mode feature and causes the load balancer to report unhealthy nodes. It will be fixed in a future update.

## How to enable the health probe mode feature using the Azure CLI

To enable the health probe mode feature, run one of the following commands:

Enable `ServiceNodePort` health probe mode (default) for a cluster:

```shell
export RESOURCE_GROUP="aks-rg"
export AKS_CLUSTER_NAME="aks-cluster"
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --cluster-service-load-balancer-health-probe-mode ServiceNodePort 
```
Results:

```output
{
  "name": "aks-cluster",
  "location": "eastus2",
  "resourceGroup": "aks-rg",
  "kubernetesVersion": "1.28.x",
  "provisioningState": "Succeeded",
  "loadBalancerProfile": {
    "clusterServiceLoadBalancerHealthProbeMode": "ServiceNodePort",
    ...
  },
  ...
}
```

Enable `Shared` health probe mode for a cluster:

```shell
export RESOURCE_GROUP="MyAksResourceGroup"
export AKS_CLUSTER_NAME="MyAksCluster"
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --cluster-service-load-balancer-health-probe-mode Shared
```

Results:

```output
{
  "name": "MyAksCluster",
  "location": "eastus2",
  "resourceGroup": "MyAksResourceGroup",
  "kubernetesVersion": "1.28.x",
  "provisioningState": "Succeeded",
  "loadBalancerProfile": {
    "clusterServiceLoadBalancerHealthProbeMode": "Shared",
    ...
  },
  ...
}
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)] 