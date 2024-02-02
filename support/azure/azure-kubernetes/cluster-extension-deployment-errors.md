---
title: Troubleshoot errors when deploying extensions in an AKS cluster
description: Learn about the errors that occur when you deploy cluster extensions in an Azure Kubernetes Service (AKS) cluster and how to troubleshoot them.
ms.date: 12/22/2023
author: maanasagovi
ms.author: maanasagovi
editor: v-jsitser
ms.reviewer: nickoman, v-weizhu, v-leedennis
ms.service: azure-kubernetes-service
---
# Troubleshoot errors when deploying AKS cluster extensions

This article dicsusses how to troubleshoot errors that occur when you deploy cluster extensions for Microsoft Azure Kubernetes Service (AKS).

## Extension creation errors

### Error: Unable to get a response from the agent in time

This error occurs when Azure services don't receive a response from the cluster extension agent. It might occur because the AKS cluster can't establish a connection with Azure.

#### Cause 1: The cluster extension agent and manager pods aren't initialized

The cluster extension agent and manager are crucial system components that are responsible for managing the lifecycle of Kubernetes applications. The initialization of the cluster extension agent and manager pods might fail because of the following problems:

- Resource limitations 
- Policy restrictions
- Node taints, such as `NoSchedule`

##### Solution for Cause 1: Make sure that the cluster extension agent and manager pods work correctly

To resolve this issue, make sure that the cluster extension agent and manager pods are correctly scheduled and can start. If the pods are stuck in a non-ready state, check the pod description by running the `kubectl describe pod` command to get more details about the underlying problems (for example, taints preventing scheduling, insufficient memory, or policy restrictions).

When the cluster extension agent and manager pods are operational and healthy, they establish communication with Azure services to install and manage Kubernetes applications.

#### Cause 2: An issue affects the egress block or firewall

If the cluster extension agent and manager pods are healthy, and you still encounter the "Unable to get a response from the agent in time" error, an egress block or firewall issue probably exists. This issue might block the cluster extension agent and manager pods from communicating with Azure.

##### Solution for Cause 2: Make sure that networking prerequisites are met

To resolve this issue, make sure that you follow the networking prerequisites that are outlined in [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

## Helm errors

You might encounter any of several Helm-related errors:

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

Here are some common causes of this issue:

- Resource constraints: Inadequate memory or CPU resources within the cluster can prevent the successful initialization of pods, jobs, or other Kubernetes resources. Eventually, this causes the installation to time out. Policy constraints or node taints (such as `NoSchedule`) can also block resource initialization.

- Architecture mismatches: Trying to schedule a Linux-based application on a Windows-based node (or vice-versa) can cause failures in Kubernetes resource initialization.

- Incorrect configuration settings: Incorrect configuration settings can prevent pods from starting.

##### Solution

To resolve this issue, follow these steps:

1. Check resources: Make sure that your Kubernetes cluster has sufficient resources and that pod scheduling is permitted on the nodes (you should consider taints). Verify that memory and CPU resources meet the requirements.

2. Inspect events: Check the events within the Kubernetes namespace to identify potential issues that might prevent pods, jobs, or other Kubernetes resources from reaching a ready state.

3. Check Helm charts and configurations: Many Kubernetes applications use Helm charts to deploy resources on the cluster. Some applications might require user input through configuration settings. Make sure that all provided configuration values are accurate and meet the installation requirements.

### Error: Unable to download the Helm chart from the repo URL

This error is caused by connectivity problems that occur between the cluster and the firewall in addition to egress blocking problems. To resolve this issue, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

### Error: Helm chart rendering failed with given values

This error occurs if Kubernetes applications rely on Helm charts to deploy resources within the Kubernetes cluster. These applications might require user input that's provided through configuration settings that are passed as Helm values during installation. If any of these crucial configuration settings are missing or incorrect, the Helm chart might not render.

To resolve this issue, check the extension or application documentation to determine whether you omitted any mandatory values or provided incorrect values during the application installation. These guidelines can help you to fix Helm chart rendering issues that are caused by missing or inaccurate configuration values.

### Error: Resource already exists in your cluster

This error occurs if there's a conflict between the Kubernetes resources within your cluster and the Kubernetes resources that the application is trying to install. The error message usually specifies the name of the conflicting resource.

If the conflicting resource is essential and can't be replaced, it might not be possible to install the application. If the resource isn't critical and can be removed, delete the conflicting resource, and then try the installation again.

### Error: Operation is already in progress for Helm

This error occurs when there's an operation already in progress for a particular release. To resolve this issue, wait 10 minutes, and then retry the operation.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
