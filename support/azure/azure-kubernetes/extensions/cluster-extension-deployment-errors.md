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

Azure Monitor services, including Container Insights, Managed Prometheus, and Application Insights, are transitioning to an extension‑based backend on Azure Kubernetes Service (AKS).

As part of this change, AKS monitoring add-ons are now managed as cluster extensions. This is a backend-only change and does not impact functionality or customer experience.

#### What’s changing 

• Monitoring add-ons are now implemented and managed as AKS cluster extensions 

• Each monitoring service is represented by its own extension

#### What’s not changing 

• No disruption to workloads 

• No impact to data collection or monitoring functionality 

• No customer action required 

• Azure Portal, Azure CLI, and all client experiences continue to work as before

### How to Check if Your AKS Cluster Is Migrated

If your AKS cluster has been migrated to the extension-based backend, monitoring services will appear as extensions.

Steps in Azure Portal:

1. Go to the Azure Portal

1. Navigate to your AKS cluster resource

1. Select “Extensions + applications” under Settings

1. Verify that the monitoring extensions are listed

1. Confirm each extension shows Provisioning State as Succeeded

Each monitoring service is represented and managed by its own extension.

#### Monitoring Add-on to Extension Mapping

| Monitoring Service / Add-on              | Extension Name                          | Extension Type                                  |

|-----------------------------------------|------------------------------------------|------------------------------------------------|

 Logging             | aks-managed-azure-monitor-logs           | microsoft.azuremonitor.containers              |

| Managed Prometheus                      | aks-managed-azure-monitor-metrics        | microsoft.azuremonitor.containers.metrics      |

| Application Insights / Monitoring       | aks-managed-app-monitoring               | microsoft.azuremonitor.appmonitoring           |

### Troubleshooting

**Issue 1: Extension provisioning state shows “Failed”**

A Failed provisioning state indicates that the monitoring service was not enabled successfully.

**How to fix** 

• Verify that all required monitoring configuration values were provided correctly 

• Retry enabling the monitoring add-on by disabling and then re-enabling it on the AKS cluster

Monitoring add-ons are now managed as extensions in the backend, but the customer experience for enabling or disabling monitoring remains unchanged.

**Issue 2: Unable to update or edit a monitoring extension**

Monitoring extensions are managed by the AKS resource provider and are not user-editable.

If you attempt to update an extension directly, you may see an error such as:

“Failed to update ‘aks-managed-azure-monitor-logs’ for the cluster. Access denied: ‘write’ operation is not allowed.”

**How to fix** 

This behavior is expected. Customers should enable, disable, or configure monitoring using the AKS monitoring add-on experience (Azure Portal, CLI, or ARM), rather than attempting to modify the extension directly.

## Extension creation errors

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

 
