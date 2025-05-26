---
title: Troubleshoot Azure Kubernetes Fleet Manager DNS Load Balancing
description: Troubleshoot errors that occur when using DNS load balancing in Azure Kubernetes Fleet Manager.
author: sjwaight
ms.author: simonwaight
ms.service: azure-kubernetes-fleet-manager
ms.date: 05/13/2025
ms.custom: sap:MultiClusterService issues
---

# Troubleshoot Azure Kubernetes Fleet Manager DNS load balancing

This article provides troubleshooting information for Azure Kubernetes Fleet Manager DNS-based load balancing. Fleet Manager DNS load balancing uses Azure Traffic Manager to balance traffic across public endpoints from multiple Azure Kubernetes Service (AKS) member clusters.

## Use Fleet Manager hub cluster to troubleshoot

1. User should have access to the Azure subscription and resource group where the Azure Traffic Manager profile is created.
2. [Install or upgrade to Azure CLI](/cli/azure/install-azure-cli) version 2.72.0 or a later version.
3. Make sure that the Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool is installed. You can install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
4. Install the **fleet** Azure CLI extension by using the `az extension add`command. Make sure that your installed version is at least 1.5.2.

    ```azurecli-interactive
    az extension add --name fleet
    ```

5. Access the Fleet Manager hub cluster Kubernetes API. For more information, see [Access the Fleet Manager hub cluster API](/azure/kubernetes-fleet/access-fleet-hub-cluster-kubernetes-api).

## Scenario 1: TrafficManagerProfile or Traffic Manager can't be created

This section provides common reasons and solutions for scenarios in which the `TrafficManagerProfile` Kubernetes object and its associated Azure Traffic Manager resource aren't created.

To determine the appropriate resolution, check the status of the `TrafficManagerProfile` object on the Fleet Manager hub cluster using the command shown.

```bash
kubectl get trafficmanagerprofile -n <namespace> <profile-name> -o yaml
```

### Error 1: The client does not have authorization to perform action 

This issue might occur if one of the following conditions is met:

* A nonexistent Azure resource group is specified in the `TrafficManagerProfile` manifest.
* The resource group isn't in the same Azure subscription as the Fleet Manager resource.
* The Fleet Manager hub cluster identity doesn't have permission to create and manage Azure Traffic Manager profiles in the specified resource group.

You can check The `TrafficManagerProfile` status for details of the error. The following example of the `TrafficManagerProfile` status shows insufficient permissions:

```yml
status:
  conditions:
  - lastTransitionTime: "2025-04-29T02:57:33Z"
    message: |
      Invalid profile: GET https://management.azure.com/subscriptions/xxx/resourceGroups/your-fleet-atm-rg/providers/Microsoft.Network/trafficmanagerprofiles/fleet-yyyy
      --------------------------------------------------------------------------------
      RESPONSE 403: 403 Forbidden
      ERROR CODE: AuthorizationFailed
      --------------------------------------------------------------------------------
      {
        "error": {
          "code": "AuthorizationFailed",
          "message": "The client 'xxx' with object id 'xxx' does not have authorization to perform action 
          'Microsoft.Network/trafficmanagerprofiles/read' over scope 
          '/subscriptions/xxx/resourceGroups/your-fleet-atm-rg/providers/Microsoft.Network/trafficmanagerprofiles/fleet-yyyy' or the 
          scope is invalid. If access was recently granted, please refresh your credentials."
        }
      }
      --------------------------------------------------------------------------------
    observedGeneration: 1
    reason: Invalid
    status: "False"
    type: Programmed
```
  
#### Solution

To resolve this issue, follow these steps:

1. Make sure that the Azure resource group exists and has the same Azure Subscription value that the Fleet Manager has.
2. Verify that the Fleet Manager hub cluster identity is granted the `Traffic Manager Contributor` role scoped to the resource group. For more information, see [Configure Fleet Manager permissions](/azure/kubernetes-fleet/howto-dns-load-balancing#configure-fleet-manager-permissions).

### Error 2: Domain name is not available

This issue might occur if the generated DNS prefix is already used by another Azure Traffic Manager profile. The DNS prefix consists of the namespace and the `metadata.name` field in the `TrafficManagerProfile` manifest. For example, if the namespace is `team-a` and the `metadata.name` is `webapp`, the DNS prefix is `team-a-webapp`.

The following example of the `TrafficManagerProfile` status shows that the domain name isn't available:

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

#### Solution

To resolve this issue, use `nslookup` or a similar tool to determine whether the full DNS name (for example, `team-a-webapp.trafficmanager.net`) already exits. If the name isn't available, consider one of the following alternative solutions:

- Change the `metadata.name` field in the `TrafficManagerProfile` manifest to a unique name.
- Use a different namespace for the `TrafficManagerProfile` manifest. This selection affects the `TrafficManagerBackend` and `ServiceExport` objects. These objects must be in the same namespace.

### Error 3: Azure Traffic Manager subscription limits reached

This issue might occur if more than 200 Traffic Manager Profiles or Endpoints exist within a single Azure Subscription.

The following example of the `TrafficManagerProfile` status shows that the Azure Traffic Manager profile limits are reached:

```yml
status:
  conditions:
  - lastTransitionTime: "2025-04-29T06:39:10Z"
    message: Azure Traffic Manager profile limits reached.
    observedGeneration: 2
    reason: Invalid
    status: "False"
    type: Programmed
```
#### Solution

Consider deleting unused profiles or requesting an increase in the limit. For more information, see [Azure Traffic Manager limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-traffic-manager-limits).

### Error 4: Azure Traffic Manager returns an error

This issue might occur if the Azure Traffic Manager service returns an error when it creates the profile.

The following example of the `TrafficManagerProfile` status shows this error:

```yml
status:
  conditions:
  - lastTransitionTime: "2025-04-29T06:39:10Z"
    message: Azure Traffic Manager error message is displayed here.
    observedGeneration: 2
    reason: Invalid
    status: "False"
    type: Programmed
```

#### Solution

If the error persists, check the Azure Traffic Manager service health.

## Scenario 2: TrafficManagerBackend can't be created

This section provides common causes and recommended solutions for scenarios in which the `TrafficManagerBackend` Kubernetes object can't be created.

To determine the appropriate resolution, check the status of the `TrafficManagerBackend` object on the Fleet Manager hub cluster using the command shown.

```bash
kubectl get trafficmanagerbackend -n <namespace> <backend-name> -o yaml
```

### Error 1: TrafficManagerProfile is not found or Invalid trafficManagerProfile

This issue might occur if one of the following conditions is met:

- The `TrafficManagerBackend` was created in a different namespace than the `TrafficManagerProfile`.
- The `TrafficManagerProfile` object exists, but the associated Azure Traffic Manager resource couldn't be found.

The following are the examples of the `TrafficManagerBackend` status that show the error.
  
```yml
status:
  conditions:
  - lastTransitionTime: "2025-04-29T06:43:57Z"
  message: TrafficManagerProfile "nginx-nginx-profile" is not found
  observedGeneration: 1
  reason: Invalid
  status: "False"
  type: Accepted
```

Missing Azure Traffic Manager resource.

```yml
status:
  conditions:
  - lastTransitionTime: "2025-04-29T07:00:04Z"
  message: 'Invalid trafficManagerProfile "nginx-nginx-profile": Domain name is not available. 
  Please choose a different profile name or namespace'
  observedGeneration: 1
  reason: Invalid
  status: "False"
  type: Accepted
```

### Solution

To resolve this issue, follow these steps:

1. Make sure that you create the `TrafficManagerBackend` in the same namespace as the `TrafficManagerProfile`.
2. Make sure that the `Programmed` condition of `TrafficManagerProfile` is `Accepted`. If it's not, check the profile definition for validity, and then resubmit.
3. Make sure the Azure Traffic Manager resource exists. To re-create the resource, delete the `TrafficManagerProfile` from the Fleet Manager hub cluster. and then reapply it.

### Error 2: Invalid Service or ServiceExport

This issue might occur if one of the following conditions is met:

- The `Service` was created in a different namespace than the `TrafficManagerBackend` object.
- The `Service` exists, but the `ServiceExport` object wasn't created in the same namespace as `TrafficManagerBackend`.
- The `Service` isn't defined as a `LoadBalancer` type.
- The `Service` isn't exposed through an Azure public IP address or doesn't have a DNS name assigned.

The following examples of the `TrafficManagerBackend` status show the errors:

```yml
status:
conditions:
- lastTransitionTime: "2025-04-29T07:50:49Z"
  message: ServiceImport "invalid-service" is not found
  observedGeneration: 1
  reason: Invalid
  status: "False"
  type: Accepted
```

The `Service` isn't defined as a `LoadBalancer` type:

```yml
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

### Solution

To resolve this issue, follow these steps:

1. Make sure that at least one `Service` of a member cluster is exported in the same namespace of the `TrafficManagerBackend` object by creating `ServiceExport`.
2. Make sure that the exported `Service` is a load balancer type and is exposed through an Azure public IP address. This address must have an assigned DNS name to be used in a Traffic Manager profile.

### Error 3: Azure Traffic Manager profile is not found

This issue might occur if one of the following conditions is met:

- The `TrafficManagerProfile` object exists, but the associated Azure Traffic Manager resource isn't found.
- The Fleet Manager hub cluster identity doesn't have permission to create and manage Azure Traffic Manager profiles or endpoints in the specified resource group.

The following example of the `TrafficManagerBackend` status shows the error:

```yml
status:
conditions:
- lastTransitionTime: "2025-05-08T09:38:36Z"
  message: Azure Traffic Manager profile "fleet-6dd24764-0e46-4b52-b9c6-cc2a3f2535f9" under "your-fleet-atm-rg" is not found
  observedGeneration: 2
  reason: Invalid
  status: "False"
  type: Accepted
```

### Solution

To resolve this issue, follow these steps:

1. Make sure that the Azure Traffic Manager resource exists. To re-create the resource, delete the `TrafficManagerProfile` profile from the Fleet Manager hub cluster, and then reapply it.
2. Verify that the Fleet Manager hub cluster identity was granted the `Traffic Manager Contributor` role that's scoped to the resource group. For more information, see [Configure Fleet Manager permissions](/azure/kubernetes-fleet/howto-dns-load-balancing#configure-fleet-manager-permissions).

### Error 4: Azure Traffic Manager profile limits reached

This issue might occur if more than 200 Azure Traffic Manager Endpoints would be created within a single Azure subscription.

The following example of the `TrafficManagerBackend` status shows the error:

```yml
status:
  conditions:
  - lastTransitionTime: "2025-04-29T06:39:10Z"
    message: Azure Traffic Manager profile limits reached.
    observedGeneration: 2
    reason: Invalid
    status: "False"
    type: Programmed
```

#### Solution

Consider deleting unused endpoints. For more information, see [Azure Traffic Manager limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-traffic-manager-limits).

## Use Azure Log Analytics to troubleshoot

In addition to querying the Fleet Manager hub cluster, you can use Azure Log Analytics for troubleshooting. 

### TrafficManagerProfile

Filter the entries in the `fleet-hub-net-controller-manager` category by using `trafficmanagerprofile/controller.go`:

```kusto
AzureDiagnostics
| where Category == "fleet-hub-net-controller-manager"
| project TimeGenerated, ResourceId, log_s
| where ResourceId == "/subscriptions/xxx/resourceGroups/your-fleet-rg/providers/Microsoft.ContainerService/fleets/your-fleet"
| where log_s contains "trafficmanagerprofile/controller.go"
| limit 1000
```

### TrafficManagerBackend

Filter the entries in the `fleet-hub-net-controller-manager` category by using `trafficmanagerbackend/controller.go`:

```kusto
AzureDiagnostics
| where Category == "fleet-hub-net-controller-manager"
| project TimeGenerated, ResourceId, log_s
| where ResourceId == "/subscriptions/xxx/resourceGroups/your-fleet-rg/providers/Microsoft.ContainerService/fleets/your-fleet"
| where log_s contains "trafficmanagerbackend/controller.go"
| limit 1000
```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
