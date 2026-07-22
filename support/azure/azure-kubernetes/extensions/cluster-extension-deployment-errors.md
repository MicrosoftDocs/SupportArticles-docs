---
title: Troubleshoot AKS cluster extension deployment errors
description: Troubleshoot errors when deploying AKS cluster extensions. Learn how to diagnose and fix extension creation, Helm, and scheduling errors in AKS.
ms.date: 07/22/2026
author: kaushika-msft
ms.author: kaushika
editor: v-jsitser
ms.reviewer: nickoman, v-weizhu, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Troubleshoot errors when deploying AKS cluster extensions

## Summary

This article explains how to troubleshoot errors that occur when you deploy cluster extensions for Microsoft Azure Kubernetes Service (AKS), including extension creation failures, Helm errors, and scheduling problems.

## Identifying the extension category

start by identifying the extension category, then choose the matching section in this article:

- **Core extension: Azure Monitor extension**

  - Provisioning state is `Failed`: [Problem 1: Extension provisioning state shows "Failed"](#problem-1-extension-provisioning-state-shows-failed).
  - Direct extension update is denied: [Problem 2: Can't update or edit a monitoring extension](#problem-2-cant-update-or-edit-a-monitoring-extension).
  - A lock blocks disabling the monitoring add-on: [Problem 3: Resource locks prevent monitoring add-on disable operations](#problem-3-resource-locks-prevent-monitoring-add-on-disable-operations).
  - Azure Policy blocks enabling the monitoring add-on: [Problem 4: Azure Policy blocks monitoring add-on enable operations](#problem-4-azure-policy-blocks-monitoring-add-on-enable-operations).

- **Standard extension or Kubernetes application: Helm-based deployment**

  - Resource readiness timeout or `BackoffLimitExceeded`: [Error: Timed out waiting for resource readiness](#error-timed-out-waiting-for-resource-readiness).
  - Helm chart download failure: [Error: Unable to download the Helm chart from the repo URL](#error-unable-to-download-the-helm-chart-from-the-repo-url).
  - Helm chart rendering failure: [Error: Helm chart rendering failed with given values](#error-helm-chart-rendering-failed-with-given-values).
  - Existing Kubernetes resource conflict: [Error: Resource already exists in your cluster](#error-resource-already-exists-in-your-cluster).
  - Another Helm operation is in progress: [Error: Operation is already in progress for Helm](#error-operation-is-already-in-progress-for-helm).

## Add-on to core extension migration

### Overview

[Azure Monitor](/azure/azure-monitor/containers/kubernetes-monitoring-overview) services, including [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=cli), [Managed Prometheus](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=cli), and [Application Insights](/azure/azure-monitor/containers/kubernetes-codeless?tabs=portal) are transitioning to a cluster extension-based backend model. This change updates AKS monitoring [add-ons](/azure/aks/integrations) to an extension-based management model, with no change to functionality or user experience.

This backend migration is nondisruptive. It doesn't change the user experience or require customer action. There's no impact to workloads, data collection, or monitoring functionality. Azure CLI, Azure portal, and all client experiences continue to work as expected.

> [!IMPORTANT]
- **Azure policy restrictions** - Update or exempt custom Azure policies that block creation or updates to the [cluster extensions resource type](/rest/api/kubernetesconfiguration/extensions/extensions/create).
- **Azure resource locks** - Azure resource locks can block management of [cluster extensions resource types](/rest/api/kubernetesconfiguration/extensions/extensions/create). Temporarily disable the lock to prevent migration failures.

For more information about types of extensions, see [Categories of cluster extensions](/azure/aks/cluster-extensions#categories-of-cluster-extensions).

#### What's changing 

- Monitoring add-ons are now implemented and managed as AKS cluster extensions.
- Each monitoring service is represented by its own extension.

### Check the Monitoring solution migration

If you migrated your Monitoring solution to the extension-based back end, Monitoring services appear as extensions. To check whether the solution is migrated, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com).
1. Go to your AKS cluster resource.
1. In **Settings**, select **Extensions + applications**.
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

- Verify that you provided all required monitoring configuration values correctly. 
- Try again to enable the monitoring add-on by disabling and then re-enabling it on the AKS cluster.

The back end now manages monitoring add-ons as extensions. However, the customer experience for enabling or disabling monitoring remains unchanged.

### Problem 2: Can't update or edit a monitoring extension

#### Cause

The AKS resource provider manages monitoring extensions. You can't edit them.

If you try to update an extension directly, you might receive an error message that resembles the following example:

> Failed to update 'aks-managed-azure-monitor-logs' for the cluster. Access denied: 'write' operation is not allowed.

#### Solution

This behavior is expected. Use the AKS monitoring add-on experience (Azure portal, CLI, or ARM) to enable, disable, or configure monitoring instead of trying to modify the extension directly.

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

Azure resource locks prevent accidental deletion or modification of critical resources. When you apply a **Delete lock** or **ReadOnly lock** at any of the following scopes, monitoring add-on disable operations are blocked:

**Subscription level**: Locks all resources in the subscription

- **Resource group level**: Locks all resources in the resource group

**Resource level**: Locks the specific AKS cluster resource

The monitoring add-on disable operation requires write and delete permissions on the cluster resource. The lock blocks these permissions.

#### Common scenarios in which you apply locks

- Organization policies that enforce resource locks for production resources
- Compliance requirements (for example, Azure Policy automatically applying locks)
- Manual locks that administrators apply to prevent accidental deletion

#### Solution

#### Step 1: Identify the lock

1. Go to the Azure portal.
1. Go to the AKS cluster resource, resource group, or subscription (depending on the lock scope that's mentioned in the error message).
1. In the left menu, select **Settings** > **Locks**.
1. Identify the locks that block the operation.

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

1. Go to the lock location that you identified in Step 1.
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

If you intentionally protect the lock, reapply protection after the monitoring add-on disable operation finishes:

```azurecli
az lock create --name <lock-name> \
  --resource-group <resource-group> \
  --resource-name <cluster-name> \
  --resource-type Microsoft.ContainerService/managedClusters \
  --lock-type CanNotDelete
```

### Problem 4: Azure Policy blocks monitoring add-on enable operations

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

- **Deny policies** restrict which extensions you can install on AKS clusters.

- **Allowed extension types policies** don't include the Azure Monitor extensions in the allowlist.

- **Naming convention policies** block resources that don't match specific naming patterns.
 
- **Tag enforcement policies** require specific tags that don't exist on the extension resource.
 
The policy identifiers in the error message indicate:

- **policyAssignment**: The specific policy assignment blocking the operation.

- **policyDefinition**: The underlying policy definition being enforced.

#### Common scenarios

- Organization security policies that restrict third-party or specific extensions.
- Policies intended to control cost or resource sprawl.
- Compliance policies that inadvertently block Microsoft-managed extensions.

#### Solution

#### Step 1: Identify the blocking policy

Extract the policy information from the error message:

- **Policy Assignment Name:** `Restrict Extensions` (example).

- **Policy Assignment ID:** `/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyAssignments/<assignment-id>`.

- **Policy Definition Name:** `Restrict Extensions` (example).

**Using Azure portal:**

1. Go to **Policy**.
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

Examine the policy definition to understand which conditions block the extension:

**Using Azure portal:**

1. Go to **Policy** > **Definitions**.
1. Search for the policy definition name.
1. Review the **Policy rule** JSON to understand the deny conditions.

**Common blocking conditions to look for:**

- Extension type restrictions (not allowing `microsoft.azuremonitor.containers.metrics`)
- Resource name pattern restrictions
- Required tag conditions

#### Step 3: Resolve the policy restriction

Work with your Azure Policy administrator to update a custom policy or its assignment so that it allows the required Azure Monitor extensions. If the policy must remain in effect, consider creating a narrowly scoped policy exemption for the affected AKS cluster, in accordance with your organization's governance requirements. After the policy change propagates, retry the monitoring add-on operation.

For more information, see [Troubleshoot common errors in Azure Policy](/azure/governance/policy/troubleshoot/general) and [Azure Policy exemption structure](/azure/governance/policy/concepts/exemption-structure).
 
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

1. Check resources: Make sure that your Kubernetes cluster has sufficient resources, and that pod scheduling is permitted on the nodes (consider taints). Verify that memory and CPU resources meet the requirements.

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
