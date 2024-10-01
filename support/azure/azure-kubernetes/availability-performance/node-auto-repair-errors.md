---
title: Troubleshoot common node auto-repair errors
description: Troubleshoot scenarios where node auto-repair returns an error code when trying to repair your NotReady node.
ms.date: 10/01/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to make sure the automatic repair actions from AKS node auto-repair do not cause any impacts on my applications or cluster health.
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot common node auto-repair errors

When AKS detects a node which reports the NotReady status for more than 5 minutes, we will attempt to automatically repair your node. Learn more about the node auto-repair process [here](https://learn.microsoft.com/en-us/azure/aks/node-auto-repair).

During this process, AKS will initiate reboot, reimage, and redeploy actions on your unhealthy node. These repair actions may be unsuccessful due to an underlying cause, resulting in an error code. This article will discuss how to monitor for node auto-repair errors, as well as the potential causes and next steps when encountering common error types.

## Prerequisites

- Viewing events within 1 hour: Portal access to Events blade for easy searching, or kubectl get events
- Viewing historical events: container insights configured with events in LA workspace
- 

## Symptoms
to get to this page, customer likely already saw the error (through events, or alert). they should have the error code already

## Common error codes


## Best practices

- Enable container insights to persist events for more than 1 hour
- Configure alerts for remediation errors to detect when issues occur
- Proactively detect and resolve node NotReady errors. see [Basic troubleshooting]
