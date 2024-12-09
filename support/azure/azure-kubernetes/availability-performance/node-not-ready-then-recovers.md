---
title: Node not ready but then recovers
description: Troubleshoot scenarios in the status of an Azure Kubernetes Service (AKS) cluster node is Node Not Ready, but then the node recovers.
ms.date: 10/15/2024
ms.reviewer: rissing, chiragpa, momajed, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to prevent the Node Not Ready status for nodes that later recover so that I can avoid future errors within an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot Node Not Ready failures that are followed by recoveries

This article provides a guide to troubleshoot and resolve node "Not ready" issues in AKS clusters. When a node enters a "Not Ready" state, it can disrupt the application's functionality, causing it to stop responding. Typically, the node recovers automatically after a short period. However, to prevent recurring issues and maintain a stable environment, it's important to understand the underlying causes and implementing effective resolutions. 

## Cause

There are several scenarios that could lead to this issue:

- One possible reason for a node entering a "Not Ready" state is the unavailability of the API server, which causes the readiness probe to fail. This failure prevents the pod from being attached to the service, resulting in traffic not being forwarded to the pod instance.

- Virtual machine (VM) host faults occur. To determine whether VM host faults occurred, check the following information sources:
  - [AKS diagnostics](/azure/aks/concepts-diagnostics)
  - [Azure status](https://status.azure.com/)
  - Azure notifications (for any recent outages or maintenance periods)

## Resolution

Check the API server availability by running the following command: `kubectl get apiservices`.

Ensure that the readiness probe is correctly configured in the deployment YAML file.

For further steps check here: [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md).

## Prevention

To prevent this issue from occurring in the future, take one or more of the following actions:

- Make sure that your service tier is fully paid for.
- Reduce the number of `watch` and `get` requests to the API server.
