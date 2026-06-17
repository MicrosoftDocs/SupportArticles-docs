---
title: Troubleshoot AKS cluster extension deployment errors
description: Troubleshoot AKS cluster extension deployment errors, including Helm, creation, and scheduling failures. Follow this guide to diagnose and fix issues fast.
ms.date: 03/26/2024
author: JarrettRenshaw
ms.author: jarrettr
editor: v-jsitser
ms.reviewer: nickoman, v-weizhu, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Troubleshoot errors when deploying AKS cluster extensions

## Summary

This article explains how to troubleshoot errors that occur when you deploy cluster extensions for Microsoft Azure Kubernetes Service (AKS), including extension creation failures, Helm errors, and scheduling problems.

## Add-on to core extension migration

### Overview

[Azure Monitor](/azure/azure-monitor/containers/kubernetes-monitoring-overview) services, including [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=cli), [Managed Prometheus](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=cli), and [Application Insights](/azure/azure-monitor/containers/kubernetes-codeless?tabs=portal) are transitioning to a cluster extension-based backend model. This change updates AKS monitoring [add-ons](/azure/aks/integrations) to an extension-based management model, with no change to functionality or user experience.

This backend migration is nondisruptive. It doesn't change the user experience or require customer action There's no impact to workloads, data collection, or monitoring functionality. Azure CLI, Azure portal, and all client experiences continue to work as expected.

> [!IMPORTANT]
> - **Azure policy restrictions** - Custom Azure policies that block creation or updates to the [cluster extensions resource type](/rest/api/kubernetesconfiguration/extensions/extensions/create) must be updated or exempted.
> - **Azure resource locks** - Azure resource locks can block management of [cluster extensions resource types](/rest/api/kubernetesconfiguration/extensions/extensions/create).

#### What's changing 

- Monitoring add-ons are now implemented and managed as AKS cluster extensions.
- Each monitoring service is represented by its own extension.

### Check the Monitoring solution migration

If your Monitoring solution was migrated to the extension-based back end, Monitoring services appear as extensions. To check whether the solution is migrated, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com).
1. Navigate to your AKS cluster resource.
1. under **Settings**, select **Extensions + applications**.
1. Verify that the Monitoring extensions are listed.
1. Verify that each extension shows the **Provisioning State** value as **Succeeded**.

#### Monitoring add-on to extension mapping

Each Monitoring service is represented and managed by its own extension, as shown in the following table.

| Monitoring capability            | Extension name                     | Extension type                                   |
|----------------------------------|------------------------------------|--------------------------------------------------|
| [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=azure-cli#enable-container-insights-and-logging-on-an-aks-cluster)               | aks-managed-azure-monitor-logs     | microsoft.azuremonitor.containers                |
| [Managed Prometheus](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=azure-cli#enable-prometheus-metrics-on-an-aks-cluster)               | aks-managed-azure-monitor-metrics  | microsoft.azuremonitor.containers.metrics        |
| [Application Insights](/azure/azure-monitor/containers/kubernetes-codeless?tabs=portal)             | aks-managed-app-monitoring         | microsoft.azuremonitor.appmonitoring             |

### Troubleshooting

### Problem 1: Extension provisioning state shows "Failed"

#### Cause

A `Failed` provisioning state indicates that the monitoring service isn't enabled successfully.

#### Solution

- Verify that all required monitoring configuration values were provided correctly. 
- Try again to enable the monitoring add-on by disabling and then re-enabling it on the AKS cluster.

Monitoring add-ons are now managed as extensions in the back end. However, the customer experience for enabling or disabling monitoring remains unchanged.

### Problem 2: Can't update or edit a monitoring extension

#### Cause

Monitoring extensions are managed by the AKS resource provider. They aren't user-editable.

If you try to update an extension directly, you might receive an error message that resembles the following example:

> Failed to update 'aks-managed-azure-monitor-logs' for the cluster. Access denied: 'write' operation is not allowed.

#### Solution

This behavior is expected. Customers should enable, disable, or configure monitoring by using the AKS monitoring add-on experience (Azure portal, CLI, or ARM) instead of trying to modify the extension directly.

### Problem 3: Resource locks prevent monitoring add-on disable operations

#### Error

When you disable Azure Monitor services (Container Insights, Managed Prometheus, and Application Insights) on AKS clusters, the operation fails and returns an error message that resembles the following example:

```
Delete of core cluster extension aks-managed-azure-monitor-metrics of type microsoft.azuremonitor.containers.metrics failed.
Please refer https://aka.ms/akscoreextensions-tsg for additional details.
The scope '/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>/providers/Microsoft.KubernetesConfiguration/extensions/aks-managed-azure-monitor-metrics' cannot perform delete operation because following scope(s) are locked: '/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/microsoft.containerservice/managedClusters/<cluster-name>'.
Please remove the lock and try again.
```

#### Cause

Azure resource locks prevent accidental deletion or modification of critical resources. When a **Delete lock** or **ReadOnly lock** is applied at any of the following scopes, monitoring add-on disable operations are blocked:

**Subscription level**: Locks all resources in the subscription

**Resource group level**: Locks all resources in the resource group

**Resource level**: Locks the specific AKS cluster resource

The monitoring add-on disable operation requires write/delete permissions on the cluster resource. These permissions are blocked by the lock.

#### Common scenarios in which locks are applied:

- Organization policies that enforce resource locks for production resources
- Compliance requirements (for example, Azure Policy automatically applying locks)
- Manual locks that are applied by administrators to prevent accidental deletion

#### Solution

#### Step 1: Identify the lock

1. Navigate to the Azure portal.
1. Go to the AKS cluster resource, resource group, or subscription (depending on the lock scope that's mentioned in the error message).
1. In the left menu, select **Settings** > **Locks**.
1. Identify the locks that are blocking the operation.

**Using Azure CLI:**

```azurecli
# Check locks at cluster level
az lock list --resource-group <resource-group> \
  --resource-name <cluster-name> \
  --resource-type Microsoft.ContainerService/managedClusters
# Check locks at resource group level
az lock list --resource-group <resource-group>
# Check locks at subscription level
az lock list
```

#### Step 2: Remove or temporarily disable the lock

> [!WARNING]
> Make sure that you have appropriate permissions and authorization before you remove resource locks. Coordinate with your organization's security or compliance team as needed.

**Using Azure portal:**

1. Navigate to the lock location that you identified in Step 1.
1. Select the lock, and select **Delete**.
1. Verify the deletion.
 
**Using Azure CLI:**

```azurecli
# Delete a lock (you need the lock name from Step 1)
az lock delete --name <lock-name> --resource-group <resource-group>
# For cluster-level lock
az lock delete --name <lock-name> \
  --resource-group <resource-group> \
  --resource-name <cluster-name> \
  --resource-type Microsoft.ContainerService/managedClusters
```

#### Step 3: Retry the disable operation

After you remove the lock, retry the monitoring add-on disable operation:

**Using Azure CLI:**

```azurecli
# Disable Azure Monitor metrics
az aks update --resource-group <resource-group> --name <cluster-name> \
  --disable-azure-monitor-metrics
```

#### Step 4: Reapply the lock (recommended)

If protection for the lock was intentionally applied for, reapply protection after the monitoring add-on disable operation finishes:

```azurecli
az lock create --name <lock-name> \
  --resource-group <resource-group> \
  --resource-name <cluster-name> \
  --resource-type Microsoft.ContainerService/managedClusters \
  --lock-type CanNotDelete
```

### Problem 4: Azure policy blocks monitoring add-on enable operations

#### Error

When you enable or deploy Azure Monitor services (Container Insights, Managed Prometheus, and Application Insights) on AKS clusters, the operation fails and returns an error message that resembles the following example:

```
Create or update of core cluster extension aks-managed-azure-monitor-metrics of type microsoft.azuremonitor.containers.metrics failed.
Please refer https://aka.ms/akscoreextensions-tsg for additional details.
Resource 'aks-managed-azure-monitor-metrics' was disallowed by policy.
Policy identifiers: '[{"policyAssignment":{"name":"Restrict Extensions","id":"/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyAssignments/<assignment-id>"},"policyDefinition":{"name":"Restrict Extensions","id":"/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyDefinitions/<definition-id>","version":"1.0.0"}}]'
```

#### Cause

Azure Policy is enforcing restrictions that prevent the creation or modification of cluster extensions. This action typically occurs when:

- **Deny policies** are configured to restrict which extensions can be installed on AKS clusters

- **Allowed extension types policies** exist that do not include the Azure Monitor extensions in the allowlist

- **Naming convention policies** block resources that don't match specific naming patterns
 
- **Tag enforcement policies** require specific tags that don't exist on the extension resource
 
The policy identifiers in the error message indicate:

**policyAssignment**: The specific policy assignment blocking the operation

**policyDefinition**: The underlying policy definition being enforced

#### Common scenarios:

- Organization security policies that restrict third-party or specific extensions
- Policies intended to control cost or resource sprawl
- Compliance policies that inadvertently block Microsoft-managed extensions

#### Solution

#### Step 1: Identify the blocking policy

Extract the policy information from the error message:

**Policy Assignment Name:** `Restrict Extensions` (example)

**Policy Assignment ID:** `/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyAssignments/<assignment-id>`

**Policy Definition Name:** `Restrict Extensions` (example)

**Using Azure portal:**

1. Navigate to **Policy**.
1. In the left menu, select **Assignments**.
1. In the error message, search for the policy assignment name.
1. Select the assignment to view its details and scope.
 
**Using Azure CLI:**

```azurecli
# Get details of the policy assignment
az policy assignment show --name <assignment-id> --scope /subscriptions/<subscription-id>
# List all policy assignments at subscription level
az policy assignment list --scope /subscriptions/<subscription-id>
# Get the policy definition details
az policy definition show --name <definition-id>
```

#### Step 2: Review the policy rule

Examine the policy definition to understand which conditions are blocking the extension:

**Using Azure portal:**

1. Navigate to **Policy** > **Definitions**.
1. Search for the policy definition name.
1. Review the **Policy rule** JSON to understand the deny conditions.

**Common blocking conditions to look for:**

- Extension type restrictions (not allowing `microsoft.azuremonitor.containers.metrics`)
- Resource name pattern restrictions
- Required tag conditions

#### Step 3: Create a policy exemption (recommended approach)

If the policy is required for compliance, but Azure Monitor extensions should be allowed, create an exemption:

**Using Azure portal:**

1. Navigate to **Policy** > **Assignments**.
1. Select the blocking policy assignment.
1. Select **Create exemption**.
1. Set the scope to the AKS cluster resource or resource group.
1. Select **Waiver** or **Mitigated** as the exemption category.

1. Provide a justification (for example, "Azure Monitor metrics extension are core cluster extensions managed by AKS").

**Using Azure CLI:**

```azurecli
az policy exemption create \
  --name "Allow-Azure-Monitor-Extensions" \
  --policy-assignment <assignment-id> \
  --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>" \
  --exemption-category Waiver \
  --description "Exemption to allow Azure Monitor core extensions for cluster monitoring"
```

#### Step 4: Alternative – modify the policy (if appropriate)

If you have permissions to modify the policy, update it to allow Azure Monitor extensions:

1. Navigate to **Policy** > **Definitions**.
1. Clone the existing policy definition (if it's a built-in policy).
1. Modify the policy rule to exclude Azure Monitor extension types:

- `microsoft.azuremonitor.containers.metrics`
- `microsoft.azuremonitor.containers`
- `microsoft.azuremonitor.appmonitoring`

1. Update or create a policy assignment that uses the modified definition.

**Example policy rule modification to allow Azure Monitor extensions:**

```
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.KubernetesConfiguration/extensions"
      },
      {
        "field": "Microsoft.KubernetesConfiguration/extensions/extensionType",
        "notIn": [
          "microsoft.azuremonitor.containers.metrics",
          "microsoft.azuremonitor.containers",
          "microsoft.azuremonitor.appmonitoring"
        ]
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
} 
```

#### Step 5: Retry the failing operation

After you create an exemption or modifying the policy, retry the failing monitoring add-on enable operation:

**Using Azure CLI:**

```azurecli
# Enable Azure Monitor metrics
az aks update --resource-group <resource-group> --name <cluster-name> \
  --enable-azure-monitor-metrics
# Enable Container Insights
az aks enable-addons --resource-group <resource-group> --name <cluster-name> \
  -a monitoring --workspace-resource-id <workspace-id>
```
 
## Extension creation errors

### Helm errors

You might encounter any of the following Helm-related errors:

- [Timed out waiting for resource readiness](#error-timed-out-waiting-for-resource-readiness)
- [Unable to download the Helm chart from the repo URL](#error-unable-to-download-the-helm-chart-from-the-repo-url)
- [Helm chart rendering failed with given values](#error-helm-chart-rendering-failed-with-given-values)
- [Resource already exists in your cluster](#error-resource-already-exists-in-your-cluster)
- [Operation is already in progress for Helm](#error-operation-is-already-in-progress-for-helm)

#### Error: Timed out waiting for resource readiness

The installation of a Kubernetes application fails and displays the following error messages:

> job failed: BackoffLimitExceeded

> Timed out waiting for the resource to come to a ready/completed state.

#### Cause

This problem has the following common causes:

- Resource constraints: Inadequate memory or CPU resources within the cluster can prevent the successful initialization of pods, jobs, or other Kubernetes resources. Eventually, this situation causes the installation to time out. Policy constraints or node taints (such as `NoSchedule`) can also block resource initialization.

- Architecture mismatches: Trying to schedule a Linux-based application on a Windows-based node (or vice-versa) can cause failures in Kubernetes resource initialization.

- Incorrect configuration settings: Incorrect configuration settings can prevent pods from starting.

#### Solution

To resolve this problem, follow these steps:

1. Check resources: Make sure that your Kubernetes cluster has sufficient resources, and that pod scheduling is permitted on the nodes (you should consider taints). Verify that memory and CPU resources meet the requirements.

1. Inspect events: Check the events within the Kubernetes namespace to identify potential problems that might prevent pods, jobs, or other Kubernetes resources from reaching a ready state.

1. Check Helm charts and configurations: Many Kubernetes applications use Helm charts to deploy resources on the cluster. Some applications might require user input through configuration settings. Make sure that all provided configuration values are accurate and meet the installation requirements.

#### Error: Unable to download the Helm chart from the repo URL

This error is caused by connectivity problems that occur between the cluster and the firewall in addition to egress blocking problems. To resolve this problem, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

#### Error: Helm chart rendering failed with given values

This error occurs if Kubernetes applications rely on Helm charts to deploy resources within the Kubernetes cluster. These applications might require user input that's provided through configuration settings that are passed as Helm values during installation. If any of these crucial configuration settings are missing or incorrect, the Helm chart might not render.

To resolve this problem, check the extension or application documentation to determine whether you omitted any mandatory values or provided incorrect values during the application installation. These guidelines can help you to fix Helm chart rendering problems that are caused by missing or inaccurate configuration values.

#### Error: Resource already exists in your cluster

This error occurs if a conflict exists between the Kubernetes resources within your cluster and the Kubernetes resources that the application is trying to install. The error message usually specifies the name of the conflicting resource.

If the conflicting resource is essential and can't be replaced, you might not be able to install the application. If the resource isn't critical and can be removed, delete the conflicting resource, and then try the installation again.

#### Error: Operation is already in progress for Helm
This error occurs if an operation is already in progress for a particular release. To resolve this problem, wait 10 minutes, and then retry the operation.
