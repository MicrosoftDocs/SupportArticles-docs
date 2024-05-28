---
title: Troubleshoot the health probe mode for AKS cluster service load balancer
description: Diagnoses and fixes common issues with the health probe mode feature.
ms.date: 05/29/2024
ms.reviewer: niqi, cssakscic, v-weizhu
ms.service: azure-kubernetes-service
ms.custom:
---
# Troubleshoot issues when enabling the AKS cluster service health probe mode

The health probe mode feature allows you to configure how the Azure Load Balancer probes the health of the nodes in your Azure Kubernetes Service (AKS) cluster. You can choose between two modes: Shared and ServiceNodePort. The Shared mode uses a single health probe for all external traffic policy cluster services that use the same load balancer, while the ServiceNodePort mode uses a separate health probe for each service. The Shared mode can reduce the number of health probes and improve the performance of the load balancer, but it requires some additional components to work properly. 

This article describes some common issues about the using health probe mode feature in an AKS cluster and helps you troubleshoot and resolve these issues. It also explains the differences of the feature implementation in the upstream Kubernetes and AKS, and how to enable the feature using the Azure CLI.

## Symptoms 

When creating or updating the AKS cluster by using the Azure CLI, if you enable the health probe mode feature using the `--cluster-service-load-balancer-health-probe-mode Shared` flag, the following issues occur:

- The load balancer doesn't distribute the traffic to the nodes as expected. 

- The load balancer reports unhealthy nodes even if they are healthy. 

- The health-probe-proxy sidecar container crashes or doesn't start. 

- The cloud-node-manager pod crashes or doesn't start.  

The following operations also happen:

1. RP frontend checks if the request is valid and updates the corresponding property in the LoadBalancerProfile.

2. RP async calls the cloud provider config secret reconciler to update the cloud provider config secret based on the LoadBalancerProfile. 

3. Overlaymgr reconciles the cloud-node-manager chart to enable the health-probe-proxy sidecar.

## Troubleshooting

To troubleshoot these issues, follow these steps:

1. Check the RP frontend log to see if the health probe mode in the LoadBalancerProfile is properly configured. You can use the `az aks show` command to view the LoadBalancerProfile property of your cluster. 

2. Check the *overlaymgr* log to see if the cloud provider secret is updated. The keyword to look for is `cloudConfigSecretResolver`. Or check the content of the cloud-provider-config secret in the ccp namespace. You can use the `kubectl get secret` command to view the secret. 

3. Check the chart or overlay daemonset cloud-node-manager to see if the health-probe-proxy sidecar container is enabled. You can use the `kubectl get ds` command to view the daemonset.

## Cause 1: The health probe mode isn't Shared or ServiceNodePort

The health probe mode feature only works with these two modes. If you use any other mode, the feature won't work. 

### Solution 1: Use the correct health probe mode

Make sure you use the Shared or ServiceNodePort mode when creating or updating your cluster. You can use the `--cluster-service-load-balancer-health-probe-mode` flag to specify the mode. 

## Cause 2: The toggle for the health probe mode feature is off

The health probe mode feature is controlled by a toggle that can be enabled or disabled by the AKS team. If the toggle is off, the feature won't work. 

### Solution 2: Turn the toggle on

Contact the AKS team to check if the toggle for the health probe mode feature is on or off. If it's off, ask them to turn it on for your subscription. 

## Cause 3: The load balancer SKU is Basic

The health probe mode feature only works with the Standard load balancer SKU. If you use the basic load balancer SKU, the feature won't work. 

### Solution 3: Use the standard load balancer SKU

Make sure you use the standard load balancer SKU when creating or updating your cluster. You can use the `--load-balancer-sku` flag to specify the SKU. 

## Cause 4: The feature isn't registered

The health probe mode feature requires a feature registration on your subscription. If the feature isn't registered, the feature won't work. 

### Solution 4: Register the feature

Make sure you register the feature for your subscription before creating or updating your cluster. You can use the `az feature register` command to register the feature. 

## Cause 5: The Kubernetes version is less than v1.28.0

The health probe mode feature requires a minimum Kubernetes version of v1.28.0. If you use an older version, the feature won't work. 

### Solution 5: Upgrade the Kubernetes version

Make sure you use Kubernetes v1.28.0 or a later version when creating or updating your cluster. You can use the `--kubernetes-version` flag to specify the version. 

## Known issues 

For Windows, the kube-proxy component won't start until you create the first non-HPC pod in the node. This issue will affect the health probe mode feature and cause the load balancer to report unhealthy nodes. It will be fixed in a future update.

## How to enable the health probe mode feature using the Azure CLI

To enable the health probe mode feature, run one of the following commands:

- `az aks create/update --cluster-service-load-balancer-health-probe-mode Shared`

- `az aks create/update --cluster-service-load-balancer-health-probe-mode ServiceNodePort (default)`

## Differences when using the feature in upstream Kubernetes and AKS

When you use the health probe mode feature in a Kubernetes cluster, the health-probe-proxy sidecar container monitors port 10356 and forwards to port 10256 (kube-proxy healthz server port).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)] 