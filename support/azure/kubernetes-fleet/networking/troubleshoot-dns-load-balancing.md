---
title: Troubleshoot Azure Kubernetes Fleet Manager DNS load balancing
description: Troubleshoot errors that occur when using DNS load balancing in Azure Kubernetes Fleet Manager.
author: sjwaight
ms.author: sjwaight
ms.service: azure-kubernetes-fleet-manager
ms.date: 05/13/2025
---

# Troubleshoot Azure Kubernetes Fleet Manager DNS load balancing

This article provides troubleshooting information for Azure Kubernetes Fleet Manager's DNS-based load balancing. Fleet Manager DNS load balancing uses Azure Traffic Manager to balance traffic across public endpoints from multiple AKS member clusters.

## Use Fleet Manager hub cluster to troubleshoot

1. User should have access to the Azure subscription and resource group where the Azure Traffic Manager profile is created.
2. [Install or upgrade Azure CLI](/cli/azure/install-azure-cli) to version `2.72.0` or later.
3. Make sure that the Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line tool is installed. You can install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
4. Install the **fleet** Azure CLI extension using the `az extension add`command, making sure your version is at least `1.5.2`.

    ```azurecli-interactive
    az extension add --name fleet
    ```

5. Access to the Fleet Manager hub cluster Kubernetes API. For more information, see [Access the Fleet Manager hub cluster API](/azure/kubernetes-fleet/access-fleet-hub-cluster-kubernetes-api).

## TrafficManagerProfile or Traffic Manager can't be created

Common reasons and solutions for the `TrafficManagerProfile` Kubernetes object and its associated Azure Traffic Manager resource not being created.

In all the following scenarios you can check the status of the `TrafficManagerProfile` object on the Fleet Manager hub cluster using the `kubectl` command.

```bash
kubectl get trafficmanagerprofile -n <namespace> <profile-name> -o yaml
```

### Invalid resource group or insufficient permissions

Possible causes:

* A nonexistent Azure resource group was specified in the `TrafficManagerProfile` manifest.
* The resource group is not the same Azure Subscription as the Fleet Manager resource.
* The Fleet Manager hub cluster identity does not have permission to create and manage Azure Traffic Manager profiles in the specified resource group.

The `TrafficManagerProfile` status provides details of the source of the error.

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
  
**Possible Resolutions:**

* Ensure the Azure resource group exists and is the same Azure Subscription as the Fleet Manager.
* Check the Fleet Manager hub cluster identity has been granted the `Traffic Manager Contributor` role scoped to the resource group. For more information, see [Configure Fleet Manager permissions](/azure/kubernetes-fleet/howto-dns-load-balancing#configure-fleet-manager-permissions).

### Azure Traffic Manager DNS prefix is unavailable

Possible causes:

* The DNS prefix generated is already in use by another Azure Traffic Manager profile. The DNS prefix consists of the namespace and the `metadata.name` field in the `TrafficManagerProfile` manifest. For example, if the namespace is `team-a` and the `metadata.name` is `webapp`, the DNS prefix would `team-a-webapp`.

The `TrafficManagerProfile` status provides details of the source of the error.

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

**Possible Resolutions:**

* Use `nslookup` or a similar tool to check if the full DNS name (`team-a-webapp.trafficmanager.net`) is available.
* Change the `metadata.name` field in the `TrafficManagerProfile` manifest to a unique name.
* Use a different namespace for the `TrafficManagerProfile` manifest. THis impacts the `TrafficManagerBackend` and `ServiceExport` objects, which must be in the same namespace.

### Azure Traffic Manager subscription limits reached

Possible causes:

* More than 200 Traffic Manager Profiles or Endpoints within a single Azure Subscription.

The `TrafficManagerProfile` status provides details of the error.

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

**Possible Resolutions:** Consider deleting unused profiles or requesting an increase in the limit. For more information, see [Azure Traffic Manager limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-traffic-manager-limits).

### Azure Traffic Manager returns an error

Possible causes:

* The Azure Traffic Manager service returns an error when creating the profile.

The `TrafficManagerProfile` status provides details of the error.

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

**Possible Resolutions:** If the error persists, check the Azure Traffic Manager service health.

## TrafficManagerBackend can't be created

Common reasons and solutions for the `TrafficManagerBackend` Kubernetes object not being created.

In all cases, check the status of the `TrafficManagerBackend` object on the Fleet Manager hub cluster.

```bash
kubectl get trafficmanagerbackend -n <namespace> <backend-name> -o yaml
```

### Invalid TrafficManagerProfile

Possible causes:

* The `TrafficManagerBackend` was created in a different namespace than the `TrafficManagerProfile`.
* The `TrafficManagerProfile` object exists, but the associated Azure Traffic Manager resource couldn't be found.

The `TrafficManagerBackend` status provides details of the error.
  
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

**Possible Resolutions:**

* Make sure to create the `TrafficManagerBackend` in the same namespace as the `TrafficManagerProfile`.
* Ensure that the `Programmed` condition of `TrafficManagerProfile` is `Accepted`. If not, check the profile definition for validity and resubmit.
* Ensure the Azure Traffic Manager resource exists. To recreate the resource, delete the `TrafficManagerProfile` from the Fleet Manager hub cluster and reapply it.

### Invalid Service or ServiceExport

Possible causes:

* The `Service` was created in a different namespace than the `TrafficManagerBackend`.
* The `Service` exists, but the `ServiceExport` was not created in the same namespace as the `TrafficManagerBackend`.
* The `Service` isn't defined as a `LoadBalancer` type.
* The `Service` isn't exposed via an Azure public IP address or doesn't have a DNS name assigned.

The `TrafficManagerBackend` status provides details of the error.

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

The `Service` is not defined as a `LoadBalancer` type.

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

**Possible Resolutions:**

* Ensure at least one `Service` of a member cluster is exported in the same namespace of the `TrafficManagerBackend` by creating `ServiceExport`.
* Ensure that the exported `Service` is load balancer type and exposed via an Azure public IP address, which must have a DNS name assigned to be used in a Traffic Manager profile.

## Invalid TrafficManagerProfile resource group or insufficient permissions

Possible causes:

* The `TrafficManagerProfile` was object exists, but the associated Azure Traffic Manager resource couldn't be found.
* The Fleet Manager hub cluster identity doesn't have permission to create and manage Azure Traffic Manager profiles or endpoints in the specified resource group.

The `TrafficManagerBackend` status provides details of the error.

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

**Possible Resolutions:**

* Ensure the Azure Traffic Manager resource exists. To recreate the resource, delete the `TrafficManagerProfile` from the Fleet Manager hub cluster and reapply it.
* Check the Fleet Manager hub cluster identity has been granted the `Traffic Manager Contributor` role scoped to the resource group. For more information, see [Configure Fleet Manager permissions](/azure/kubernetes-fleet/howto-dns-load-balancing#configure-fleet-manager-permissions).

### Azure Traffic Manager endpoint limits reached

Possible causes:

* More than 200 Azure Traffic Manager Endpoints would be created within a single Azure Subscription.

The `TrafficManagerBackend` status provides details of the error.

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

**Possible Resolutions:** Consider deleting unused endpoints. For more information, see [Azure Traffic Manager limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-traffic-manager-limits).

## Use Azure Log Analytics to troubleshoot

In addition to querying the Fleet Manager hub cluster, you can use Azure Log Analytics for troubleshooting. 

### TrafficManagerProfile

Filter entries in the `fleet-hub-net-controller-manager` category using `trafficmanagerprofile/controller.go`.

```kusto
AzureDiagnostics
| where Category == "fleet-hub-net-controller-manager"
| project TimeGenerated, ResourceId, log_s
| where ResourceId == "/subscriptions/xxx/resourceGroups/your-fleet-rg/providers/Microsoft.ContainerService/fleets/your-fleet"
| where log_s contains "trafficmanagerprofile/controller.go"
| limit 1000
```

### TrafficManagerBackend

Filter entries in the `fleet-hub-net-controller-manager` category using `trafficmanagerbackend/controller.go`.

```kusto
AzureDiagnostics
| where Category == "fleet-hub-net-controller-manager"
| project TimeGenerated, ResourceId, log_s
| where ResourceId == "/subscriptions/xxx/resourceGroups/your-fleet-rg/providers/Microsoft.ContainerService/fleets/your-fleet"
| where log_s contains "trafficmanagerbackend/controller.go"
| limit 1000
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
