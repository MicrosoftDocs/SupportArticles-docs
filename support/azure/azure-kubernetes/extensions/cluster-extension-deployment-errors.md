---
title: Troubleshoot AKS cluster extension deployment errors
description: Troubleshoot errors when deploying AKS cluster extensions. Learn how to diagnose and fix extension creation, Helm, and scheduling errors in AKS.
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

This article explains how to troubleshoot errors that occur when you deploy cluster extensions for Microsoft Azure Kubernetes Service (AKS), including extension creation failures, Helm errors, and scheduling issues.

## Addon to Core Extension Migration

### Overview

[Azure Monitor](/azure/azure-monitor/containers/kubernetes-monitoring-overview) services, including [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=cli), [Managed Prometheus](/azure/azure-monitor/containers/kubernetes-monitoring-enable?tabs=cli), and [Application Insights](/azure/azure-monitor/containers/kubernetes-codeless?tabs=portal) are transitioning to a cluster extension based backend model. This change updates AKS monitoring [add-ons](/azure/aks/integrations) to an extension‑based management model, with no change to functionality or user experience.

This backend migration is nondisruptive and doesn't change user experience or require customer action.

There's no impact to workloads, data collection, or monitoring functionality.

Azure CLI, Azure portal, and all client experiences continue to work as expected.

#### What’s changing 

• Monitoring add-ons are now implemented and managed as AKS cluster extensions 

• Each monitoring service is represented by its own extension

### How to Check if the Monitoring solution on your AKS Cluster Is Migrated

If your Monitoring solution has been migrated to the extension-based backend, Monitoring services will appear as extensions.

Steps in Azure Portal:

1. Go to the Azure Portal

1. Navigate to your AKS cluster resource

1. Select “Extensions + applications” under Settings

1. Verify that the Monitoring extensions are listed

1. Confirm each extension shows Provisioning State as "Succeeded"

Each Monitoring service is represented and managed by its own extension.

#### Monitoring Add-on to Extension Mapping


 Monitoring Capability              | Extension Type                      | Extension Name                                   |
|----------------------------------|------------------------------------|--------------------------------------------------|
| Logging                          | aks-managed-azure-monitor-logs     | microsoft.azuremonitor.containers                |
| Managed Prometheus (Metrics)     | aks-managed-azure-monitor-metrics  | microsoft.azuremonitor.containers.metrics        |
| Application Insights / Monitoring| aks-managed-app-monitoring         | microsoft.azuremonitor.appmonitoring             |


### Troubleshooting

### Issue 1: Extension provisioning state shows “Failed”

#### Cause

A Failed provisioning state indicates that the monitoring service was not enabled successfully.

#### Solution

• Verify that all required monitoring configuration values were provided correctly 

• Retry enabling the monitoring add-on by disabling and then re-enabling it on the AKS cluster

Monitoring add-ons are now managed as extensions in the backend, but the customer experience for enabling or disabling monitoring remains unchanged.

### Issue 2: Unable to update or edit a monitoring extension

#### Cause

Monitoring extensions are managed by the AKS resource provider and are not user-editable.

If you attempt to update an extension directly, you may see an error such as:

“Failed to update ‘aks-managed-azure-monitor-logs’ for the cluster. Access denied: ‘write’ operation is not allowed.”

#### Solution

This behavior is expected. Customers should enable, disable, or configure monitoring using the AKS monitoring add-on experience (Azure Portal, CLI, or ARM), rather than attempting to modify the extension directly.

####   
Issue 3: Resource Lock Prevents Extension Deletion

#### Error

When deploying or managing Azure Monitor services (Container Insights, Managed Prometheus, and Application Insights) on AKS clusters, the operation fails with an error similar to:


```

Delete of core cluster extension aks-managed-azure-monitor-metrics of type microsoft.azuremonitor.containers.metrics failed.

Please refer https://aka.ms/akscoreextensions-tsg for additional details.

The scope '/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>/providers/Microsoft.KubernetesConfiguration/extensions/aks-managed-azure-monitor-metrics' cannot perform delete operation because following scope(s) are locked: '/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/microsoft.containerservice/managedClusters/<cluster-name>'.

Please remove the lock and try again.

```

#### Cause

Azure Resource Locks prevent accidental deletion or modification of critical resources. When a **Delete lock** or **ReadOnly lock** is applied at any of the following scopes, extension deletion operations are blocked:

**Subscription level** – Locks all resources in the subscription

**Resource group level** – Locks all resources in the resource group

**Resource level** – Locks the specific AKS cluster resource

The extension deletion operation requires write/delete permissions on the cluster resource, which are blocked by the lock.

**Common scenarios where locks are applied:**

Organization policies that enforce resource locks for production resources

Compliance requirements (e.g., Azure Policy automatically applying locks)

Manual locks applied by administrators to prevent accidental deletion

#### Solution

#### Step 1: Identify the Lock

Navigate to the Azure Portal

Go to the AKS cluster resource, resource group, or subscription (depending on the lock scope mentioned in the error)

Select **Settings** > **Locks** from the left menu

Identify the lock(s) that are blocking the operation

**Using Azure CLI:**


```

```

#### Step 2: Remove or Temporarily Disable the Lock

> ⚠️ **Warning:** Ensure you have appropriate permissions and authorization before removing resource locks. Coordinate with your organization's security/compliance team if necessary.

**Using Azure Portal:**

Navigate to the lock location identified in Step 1

Select the lock and click **Delete**

Confirm the deletion

**Using Azure CLI:**


```

```

#### Step 3: Retry the Extension Deletion

After removing the lock, retry the extension deletion operation:

**Using Azure CLI:**


```

az aks update --resource-group <resource-group> --name <cluster-name> \

  --disable-azure-monitor-metrics

```

#### Step 4: Re-apply the Lock (Recommended)

If the lock was intentionally applied for protection, re-apply it after the extension operation completes:


```

az lock create --name <lock-name> \

  --resource-group <resource-group> \

  --resource-name <cluster-name> \

  --resource-type Microsoft.ContainerService/managedClusters \

  --lock-type CanNotDelete

```

### Issue 4: Azure Policy Blocks Extension Creation or Update

#### Error

When deploying or managing Azure Monitor services (Container Insights, Managed Prometheus, and Application Insights) on AKS clusters, the operation fails with an error similar to:


```

Create or update of core cluster extension aks-managed-azure-monitor-metrics of type microsoft.azuremonitor.containers.metrics failed.

Please refer https://aka.ms/akscoreextensions-tsg for additional details.

Resource 'aks-managed-azure-monitor-metrics' was disallowed by policy.

Policy identifiers: '[{"policyAssignment":{"name":"Restrict Extensions","id":"/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyAssignments/<assignment-id>"},"policyDefinition":{"name":"Restrict Extensions","id":"/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyDefinitions/<definition-id>","version":"1.0.0"}}]'

```

#### Cause

Azure Policy is enforcing restrictions that prevent the creation or modification of cluster extensions. This typically occurs when:

**Deny policies** are configured to restrict which extensions can be installed on AKS clusters

**Allowed extension types policies** exist that do not include the Azure Monitor extensions in the allowlist

**Naming convention policies** block resources that don't match specific naming patterns

**Tag enforcement policies** require specific tags that are not present on the extension resource

The policy identifiers in the error message indicate:

**policyAssignment** – The specific policy assignment blocking the operation

**policyDefinition** – The underlying policy definition being enforced

#### Common scenarios:

Organization security policies that restrict third-party or specific extensions

Policies intended to control cost or resource sprawl

Compliance policies that inadvertently block Microsoft-managed extensions

#### Solution

#### Step 1: Identify the Blocking Policy

Extract the policy information from the error message:

**Policy Assignment Name:** `Restrict Extensions` (example)

**Policy Assignment ID:** `/subscriptions/<subscription-id>/providers/Microsoft.Authorization/policyAssignments/<assignment-id>`

**Policy Definition Name:** `Restrict Extensions` (example)

**Using Azure Portal:**

Navigate to **Policy** in the Azure Portal

Select **Assignments** from the left menu

Search for the policy assignment name from the error message

Click on the assignment to view its details and scope

**Using Azure CLI:**


```

```

#### Step 2: Review the Policy Rule

Examine the policy definition to understand what conditions are blocking the extension:

**Using Azure Portal:**

Navigate to **Policy** > **Definitions**

Search for the policy definition name

Review the **Policy rule** JSON to understand the deny conditions

**Common blocking conditions to look for:**

Extension type restrictions (not allowing `microsoft.azuremonitor.containers.metrics`)

Resource name pattern restrictions

Required tag conditions

#### Step 3: Create a Policy Exemption (Recommended Approach)

If the policy is required for compliance but Azure Monitor extensions should be allowed, create an exemption:

**Using Azure Portal:**

Navigate to **Policy** > **Assignments**

Select the blocking policy assignment

Click **Create exemption**

Set the scope to the AKS cluster resource or resource group

Select **Waiver** or **Mitigated** as the exemption category

Provide a justification (e.g., "Azure Monitor metrics extension are core cluster extensions managed by AKS")

**Using Azure CLI:**


```

az policy exemption create \

  --name 
```

#### Step 4: Alternative – Modify the Policy (If Appropriate)

If you have permissions to modify the policy, update it to allow Azure Monitor extensions:

Navigate to **Policy** > **Definitions**

Clone the existing policy definition (if it's a built-in policy)

Modify the policy rule to exclude Azure Monitor extension types:

- `microsoft.azuremonitor.containers.metrics`

- `microsoft.azuremonitor.containers`

- `microsoft.azuremonitor.appmonitoring`

1. Update or create a new policy assignment with the modified definition

**Example policy rule modification to allow Azure Monitor extensions:**


```

{

  
```

#### Step 5: Retry the Extension Operation

After creating an exemption or modifying the policy, retry the extension operation:

**Using Azure CLI:**


```

```

###   
Extension creation errors

#### Helm errors

You might encounter any of the following Helm-related errors:

- [Timed out waiting for resource readiness](#error-timed-out-waiting-for-resource-readiness)
- [Unable to download the Helm chart from the repo URL](#error-unable-to-download-the-helm-chart-from-the-repo-url)
- [Helm chart rendering failed with given values](#error-helm-chart-rendering-failed-with-given-values)
- [Resource already exists in your cluster](#error-resource-already-exists-in-your-cluster)
- [Operation is already in progress for Helm](#error-operation-is-already-in-progress-for-helm)

### Error: Timed out waiting for resource readiness

The installation of a Kubernetes application fails and displays the following error messages:

> job failed: BackoffLimitExceeded

> Timed out waiting for the resource to come to a ready/completed state.

#### Cause

This problem has the following common causes:

- Resource constraints: Inadequate memory or CPU resources within the cluster can prevent the successful initialization of pods, jobs, or other Kubernetes resources. Eventually, this situation causes the installation to time out. Policy constraints or node taints (such as `NoSchedule`) can also block resource initialization.

- Architecture mismatches: Trying to schedule a Linux-based application on a Windows-based node (or vice-versa) can cause failures in Kubernetes resource initialization.

- Incorrect configuration settings: Incorrect configuration settings can prevent pods from starting.

##### Solution

To resolve this problem, follow these steps:

1. Check resources: Make sure that your Kubernetes cluster has sufficient resources, and that pod scheduling is permitted on the nodes (you should consider taints). Verify that memory and CPU resources meet the requirements.

2. Inspect events: Check the events within the Kubernetes namespace to identify potential problems that might prevent pods, jobs, or other Kubernetes resources from reaching a ready state.

3. Check Helm charts and configurations: Many Kubernetes applications use Helm charts to deploy resources on the cluster. Some applications might require user input through configuration settings. Make sure that all provided configuration values are accurate and meet the installation requirements.

### Error: Unable to download the Helm chart from the repo URL

This error is caused by connectivity problems that occur between the cluster and the firewall in addition to egress blocking problems. To resolve this problem, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

### Error: Helm chart rendering failed with given values

This error occurs if Kubernetes applications rely on Helm charts to deploy resources within the Kubernetes cluster. These applications might require user input that's provided through configuration settings that are passed as Helm values during installation. If any of these crucial configuration settings are missing or incorrect, the Helm chart might not render.

To resolve this problem, check the extension or application documentation to determine whether you omitted any mandatory values or provided incorrect values during the application installation. These guidelines can help you to fix Helm chart rendering problems that are caused by missing or inaccurate configuration values.

### Error: Resource already exists in your cluster

This error occurs if a conflict exists between the Kubernetes resources within your cluster and the Kubernetes resources that the application is trying to install. The error message usually specifies the name of the conflicting resource.

If the conflicting resource is essential and can't be replaced, you might not be able to install the application. If the resource isn't critical and can be removed, delete the conflicting resource, and then try the installation again.

### Error: Operation is already in progress for Helm

This error occurs if there's an operation already in progress for a particular release. To resolve this problem, wait 10 minutes, and then retry the operation.

 
