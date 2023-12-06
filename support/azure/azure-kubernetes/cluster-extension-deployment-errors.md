---
title: Troubleshoot errors when deploying extensions in an AKS cluster
description: Describes the errors that occur when you deploy cluster extensions in an Azure Kubernetes Service (AKS) cluster and how to troubleshoot them.
ms.date: 11/06/2023
ms.reviewer: maanasagovi, nickoman, v-weizhu
ms.service: azure-kubernetes-service
---
# Troubleshoot errors while deploying AKS cluster extensions

This article describes how to troubleshoot errors that occur when you deploy cluster extensions for Azure Kubernetes Service (AKS).

## Extension creation errors

### Unable to get a response from the agent in time

This error occurs when Azure services don't receive a response from the cluster extension agent. It might be because the AKS cluster can't establish a connection with Azure.

#### Cause 1: The cluster extension agent and manager pods fail to be initialized

The cluster extension agent and manager are crucial system components. They're responsible for managing the lifecycle of Kubernetes applications. The initialization of the cluster extension agent and manager pods might fail due to the following problems:

- Resource limitations 
- Policy restrictions
- Node taints, such as `NoSchedule`

#### Solution for Cause 1: Ensure the cluster extension agent and manager pods work correctly

To resolve this issue, ensure that the cluster extension agent and manager pods are correctly scheduled and can start. If the pods are stuck in a non-ready state, check the pod description by using the `kubectl describe pod` command for more details about the underlying issues (for example, taints preventing scheduling, insufficient memory, or policy restrictions).

Once the cluster extension agent and manager pods are operational and healthy, they'll establish communication with Azure services to install and manage Kubernetes applications.

#### Cause 2: There's an issue with the egress block or firewall

If the cluster extension agent and manager pods are healthy, and you still encounter the "Unable to get a response from the agent in time" error, an egress block or firewall issue likely exists. This issue might block the cluster extension agent and manager pods from communicating with Azure.

#### Solution for Cause 2: Ensure networking prerequisites are met

To resolve this issue, ensure that you follow the networking prerequisites outlined in [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

## Helm errors

Here are some Helm-related errors:

- [Timed out waiting for resource readiness](#timed-out-waiting-for-resource-readiness)
- [Unable to download the Helm chart from the repo URL](#unable-to-download-the-helm-chart-from-the-repo-url)
- [Helm chart rendering failed with given values](#helm-chart-rendering-failed-with-given-values)
- [Resource already exists in your cluster](#resource-already-exists-in-your-cluster)

### Timed out waiting for resource readiness

The installation of a Kubernetes application fails with the following error messages:

> job failed: BackoffLimitExceeded

> Timed out waiting for the resource to come to a ready/completed state.

#### Cause

Here are some common causes of this issue:

- Resource constraints: Inadequate memory or CPU resources within the cluster can prevent the successful initialization of pods, jobs, or other Kubernetes resources, eventually causing the installation to time out. Policy constraints or node taints (such as `NoSchedule`) can also hinder resource initialization.

- Architecture mismatches: Attempting to schedule a Linux-based application on a Windows-based node or vice versa can lead to failures in Kubernetes resource initialization.

- Incorrect configuration settings: Incorrect configuration settings can prevent pods from starting.

#### Solution

To resolve this issue, follow these steps:

1. Check resources: Ensure your Kubernetes cluster has sufficient resources and that pod scheduling is permitted on the nodes (consider taints). Verify that memory and CPU resources meet the requirements.

2. Inspect events: Check the events within the Kubernetes namespace to identify potential issues that might prevent pods, jobs, or other Kubernetes resources from reaching a ready state.

3. Check Helm charts and configurations: Many Kubernetes applications use Helm charts to deploy resources on the cluster. Some applications might require user input through configuration settings. Ensure that all provided configuration values are accurate and meet the installation requirements.

### Unable to download the Helm chart from the repo URL

When connectivity problems occur between the cluster and the firewall, coupled with egress block problems, this error occurs. To resolve this issue, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

### Helm chart rendering failed with given values

This error occurs when Kubernetes applications rely on Helm charts for deploying resources within the Kubernetes cluster. These applications might require user input, which is provided through configuration settings passed as Helm values during installation. If any of these crucial configuration settings are missing or incorrect, the Helm chart might fail to render, leading to this error.

To resolve this issue, check the extension/application documentation to confirm if you omit any mandatory values or provide incorrect values during the application installation. By following these guidelines, the Helm chart rendering issues caused by missing or inaccurate configuration values can be rectified.

### Resource already exists in your cluster

This error occurs when there's a conflict between the Kubernetes resources within your cluster and the Kubernetes resources that the application is attempting to install. The error message usually specifies the name of the conflicting resource.

If the conflicting resource is essential and can't be replaced, installing the application might not be feasible. If the resource isn't critical and can be removed, you can resolve this issue by deleting the conflicting resource and attempting the installation again.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]