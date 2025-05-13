---
title: Troubleshoot Azure Kubernetes Fleet Manager DNS load balancing
description: Troubleshoot errors that occur when using DNS load balancing in Azure Kubernetes Fleet Manager.
editor: simonwaight
ms.reviewer: simonwaight
ms.service: azure-kubernetes-fleet-manager
ms.date: 05/13/2025
---

# Troubleshoot Azure Kubernetes Fleet Manager DNS load balancing

This article provides troubleshooting information for Azure Kubernetes Fleet Manager's DNS-based load balancing which uses Azure Traffic Manager to deliver load balancing for Kubernetes Services exposed as public endpoints across multiple member clusters.

## Prerequisites

- User should have access to the Azure subscription and resource group where the Azure Traffic Manager profile is created.

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool

   **Note:** To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- Access to the Fleet Manager hub cluster Kubernetes API. For more information, see [Access the Fleet Manager hub cluster API](/azure/kubernetes-fleet/access-fleet-hub-cluster-kubernetes-api).

## TrafficManagerProfile or Traffic Manager can't be created

Common reasons and solutions for the `TrafficManagerProfile` Kubernetes object and its associated Azure Traffic Manager resource not being created.

In all cases, check the status of the `TrafficManagerProfile` object on the Fleet Manager hub cluster.

```bash
kubectl get trafficmanagerprofile -n <namespace> <profile-name> -o yaml
```

1. Invalid resource group was specified in `TrafficManagerProfile` manifest or the Fleet Manager hub cluster identity has not been granted permissions to create and manage Azure Traffic Manager profiles in the resource group. The `TrafficManagerProfile` status provides details of the error.

  ```yml
  status:
    conditions:
    - lastTransitionTime: "2025-04-29T02:57:33Z"
      message: |
        Invalid profile: GET https://management.azure.com/subscriptions/xxx/resourceGroups/your-fleet-atm-rg/providers/Microsoft.Network/trafficmanagerprofiles/fleet-34ec2e40-5cc4-4a30-8c09-4b787169cef0
        --------------------------------------------------------------------------------
        RESPONSE 403: 403 Forbidden
        ERROR CODE: AuthorizationFailed
        --------------------------------------------------------------------------------
        {
          "error": {
            "code": "AuthorizationFailed",
            "message": "The client 'xxx' with object id 'xxx' does not have authorization to perform action 
            'Microsoft.Network/trafficmanagerprofiles/read' over scope 
            '/subscriptions/xxx/resourceGroups/your-fleet-atm-rg/providers/Microsoft.Network/trafficmanagerprofiles/fleet-34ec2e40-5cc4-4a30-8c09-4b787169cef0' or the 
            scope is invalid. If access was recently granted, please refresh your credentials."
          }
        }
        --------------------------------------------------------------------------------
      observedGeneration: 1
      reason: Invalid
      status: "False"
      type: Programmed
  ```
  
   **Resolution:** Ensure that the Azure resource group exists and that the Fleet Manager hub cluster identity has been granted the `Traffic Manager Contributor` role scoped to the resource group. For more information, see [Configure Fleet Manager permissions](/azure/kubernetes-fleet/howto-dns-load-balancing#configure-fleet-manager-permissions).

1. Azure Traffic Manager DNS prefix is not available as it is already in use. The `TrafficManagerProfile` status provides details of the error.

  ```yml
  status:
    conditions:
    - lastTransitionTime: "2025-04-29T06:39:10Z"
      message: Domain name is not available. Please choose a different profile name or namespace
      observedGeneration: 2
      reason: DNSNameNotAvailable
      status: "False"
      type: Programmed
  ```

 **Resolution:** change the `metadata.name` field in the `TrafficManagerProfile`. You can use nslookup to check if the DNS name is available.

1. Azure Traffic Manager Subscription limits are reached for either Profiles or Endpoints. Up to 200 profiles and endpoints are allowed per subscription. The `TrafficManagerProfile` status provides details of the error.

  ```yml
  status:
    conditions:
    - lastTransitionTime: "2025-04-29T06:39:10Z"
      message: Azure Traffic Manager profile limit reached.
      observedGeneration: 2
      reason: Invalid
      status: "False"
      type: Programmed
  ```

  **Resolution:** Consider deleting unused profiles or requesting an increase in the limit. For more information, see [Azure Traffic Manager limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-traffic-manager-limits).

1. Azure Traffic Manager returns an error when creating the profile. The `TrafficManagerProfile` status provides details of the error.

  ```yml
  status:
    conditions:
    - lastTransitionTime: "2025-04-29T06:39:10Z"
      message: Azure Traffic Manager error message is displayed here
      observedGeneration: 2
      reason: Invalid
      status: "False"
      type: Programmed
  ```

  **Resolution:** resubmit the request. If the error persists, check the Azure Traffic Manager service health.

It is also possible to troubleshoot using Azure Log Analytics, looking for `trafficmanagerprofile/controller.go` entries in the hub-net-controller-manager logs.

## TrafficManagerBackend can't be created

Common reasons and solutions for the `TrafficManagerBackend` Kubernetes object not being created.

In all cases, check the status of the `TrafficManagerBackend` object on the Fleet Manager hub cluster.

```bash
kubectl get trafficmanagerbackend -n <namespace> <profile-name> -o yaml
```

Common reasons and solutions for `TrafficManagerBackend` not being accepted:

1. An Invalid `TrafficManagerProfile` was provided - not found.
  
  ```yml
  # sample status
  status:
    conditions:
    - lastTransitionTime: "2025-04-29T06:43:57Z"
    message: TrafficManagerProfile "nginx-nginx-profile" is not found
    observedGeneration: 1
    reason: Invalid
    status: "False"
    type: Accepted
  ```

  **Resolution:** make sure to create the `TrafficManagerBackend` in the same namespace as the `TrafficManagerProfile`.

1. An Invalid `TrafficManagerProfile` was provided - not provisioned due to DNS name not available.

  ```yml
  # sample status
  status:
    conditions:
    - lastTransitionTime: "2025-04-29T07:00:04Z"
    message: 'Invalid trafficManagerProfile "nginx-nginx-profile": Domain name is not available. Please choose a different profile name or namespace'
    observedGeneration: 1
    reason: Invalid
    status: "False"
    type: Accepted
  ```

  **Resolution:** Ensure the Azure Traffic Manager profile exists. It may have been manually deleted. To recover the profile, delete the `TrafficManagerProfile` from the hub Fleet Manager cluster and re-create it.

1. Invalid `backend`
   - Ensure that the `Service` exists in the same namespace of the `TrafficManagerBackend`.
   ```yaml
   # sample status
   status:
    conditions:
    - lastTransitionTime: "2025-04-29T07:50:49Z"
      message: ServiceImport "invalid-service" is not found
      observedGeneration: 1
      reason: Invalid
      status: "False"
      type: Accepted
   ```
   - Ensure that the at least `Service` of a member cluster is exported in the same namespace of the `TrafficManagerBackend` by creating `ServiceExport`.
   - Ensure that the exported `Service` is load balancer type and exposed via an Azure public IP address, which must have a DNS name assigned to be used in a Traffic Manager profile.
   ```yaml
   # sample status
   status:
    conditions:
    - lastTransitionTime: "2025-04-29T07:56:05Z"
      message: '1 service(s) exported from clusters cannot be exposed as the Azure
        Traffic Manager, for example, service exported from aks-member-5 is invalid:
        unsupported service type "ClusterIP"'
      observedGeneration: 1
      reason: Invalid
      status: "False"
      type: Accepted
   ```
1. Invalid resource group or not enough permissions to create/update Azure traffic manager endpoints in the resource group.
    - Ensure that the resource group exists and fleet hub networking controller has been configured correctly to access the resource group.
   ```yaml
   # sample status
   status:
    conditions:
    - lastTransitionTime: "2025-05-08T09:38:36Z"
      message: Azure Traffic Manager profile "fleet-6dd24764-0e46-4b52-b9c6-cc2a3f2535f9" under "your-fleet-atm-rg" is not found
      observedGeneration: 2
      reason: Invalid
      status: "False"
      type: Accepted
   ```
1. Not enough permissions to read the public IP address of the exported `Service` on the members.
   - Ensure fleet hub networking controller has been configured correctly to access public IP address of services on the members.
1. [Reach the Azure Traffic Manager limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-traffic-manager-limits).
    - 200 endpoints are allowed per profile. If the limit is reached, consider deleting unused endpoints or requesting an increase in the limit.
   
Please check the `status` field of the `TrafficManagerBackend` or the `trafficmanagerbackend/controller.go` hub-net-controller-manager logs for more information.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
