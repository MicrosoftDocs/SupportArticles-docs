---
title: Troubleshoot GitOps with Argo CD extension deployment errors
description: Learn how to troubleshoot and fix GitOps with Argo CD extension installation and deployment errors on AKS and Azure Arc-enabled Kubernetes clusters.
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-kubernetes-service
ms.topic: troubleshooting
ms.date: 09/28/2026
ms.subservice: aks-developer
ms.reviewer: ponatara
ai-usage: ai-assisted
---

# Troubleshoot Argo CD extension installation errors

## Summary

This article helps you troubleshoot common issues when you install and operate the GitOps with Argo CD extension on Azure Kubernetes Service (AKS) and Azure Arc-enabled Kubernetes clusters.

## Errors when installing the GitOps with Argo CD extension

If you encounter an installation error, or if the extension enters a `Failed` provisioning state, verify the following items:

- The cluster has sufficient compute capacity to deploy all required Argo CD components.
- No Azure Policy, Gatekeeper, Kyverno, or admission controller policies are blocking creation of the `argocd` namespace or resources within it.
- Required Custom Resource Definitions (CRDs) can be installed.
- The cluster can pull container images from Azure Container Registry (ACR).
- The cluster can reach Azure management endpoints required by the extension.

## Scenario 1: Installation fails with context deadline exceeded error

### Symptoms

The extension installation fails with an error similar to the following message.

```
(ExtensionOperationFailed) Helm installation failed: context deadline exceeded
```

### Cause

This error typically indicates that the Helm installation timed out while waiting for Argo CD pods to become ready.

A common cause is deploying the extension with **High Availability (HA)** enabled on clusters that don't have sufficient node capacity. HA deployments require multiple replicas of core Argo CD components and generally need at least four schedulable worker nodes.

Other causes include the following:

- Insufficient CPU or memory on cluster nodes
- Pending pods due to resource constraints
- Image pull failures
- Storage provisioning delays
- Network connectivity issues preventing component startup

### Resolution

1. Verify pod status. Run the following command.

   ```bash
   kubectl get pods -n argocd
   ```

1. Check for pending or failed pods. Run the following command.

   ```bash
   kubectl describe pod <pod-name> -n argocd
   ```

1. Review extension deployment logs and Kubernetes events. Run the following command.

   ```bash
   kubectl get events -n argocd --sort-by=.lastTimestamp
   ```

1. If HA is enabled, do one of the following:

   - Reinstall the extension with HA disabled.
   - Increase cluster capacity to support the required replicas.
1. Retry installation after resolving resource constraints.

## Scenario 2: Installation fails because the argocd namespace can't be created

### Symptoms

The extension installation fails and the extension remains in a `Failed` state.

### Cause

Cluster governance policies might block creation of the `argocd` namespace or resources that the extension needs.

Examples include the following items:

- Azure Policy constraints
- Gatekeeper admission policies
- Kyverno policies
- Namespace allow-list restrictions
- Resource quota limitations

### Resolution

1. Verify whether the namespace exists. Run the following command.

   ```bash
   kubectl get namespace argocd
   ```

1. Check admission controller or policy violations. Run the following command.

   ```bash
   kubectl get events --all-namespaces
   ```

1. Review policy configuration and ensure resources in the `argocd` namespace are permitted. Update the policy configuration if necessary.
1. Retry the extension installation after updating the policy configuration.

## Scenario 3: Pods remain in Pending state after installation

### Symptoms

The extension is created, but some Argo CD pods never become Ready.

### Cause

Kubernetes can't successfully schedule the pods.

Common reasons include the following:

- Insufficient CPU or memory
- Taints preventing scheduling
- Unsatisfied node selectors or affinity rules
- Persistent volume provisioning failures

### Resolution

Inspect pod scheduling information. Run the following command.

```bash
kubectl describe pod <pod-name> -n argocd
```

Review scheduler events and resolve any reported scheduling constraints.

## Scenario 4: Container image pull failures

### Symptoms

Pods enter an `ImagePullBackOff` or `ErrImagePull` status.

### Cause

The cluster can't pull required images from Microsoft Container Registry (MCR).

Common causes include the following items:

- Firewall restrictions
- Proxy misconfiguration
- DNS resolution failures
- Missing outbound connectivity

### Resolution

Check pod details. Run the following command.

```bash
kubectl describe pod <pod-name> -n argocd
```

Verify that nodes can reach required MCR endpoints and that any proxy settings are correctly configured.

## Scenario 5: CRD installation failures

### Symptoms

The installation fails while creating Argo CD custom resources.

### Cause

The installation of one or more required CRDs failed.

Potential reasons include the following items:

- Existing conflicting CRDs
- Insufficient permissions
- Admission policy restrictions

### Resolution

Check the CRD status. Run the following command.

```bash
kubectl get crds | grep argoproj.io
```

Review Kubernetes events and admission controller logs for more details.

## Scenario 6: Extension is installed but shows a Failed provisioning state

### Symptoms

The extension resource exists in Azure, but the provisioning state shows `Failed`.

### Cause

The extension deployment completed partially, but one or more validation or health checks didn't succeed.

### Resolution

Review the extension status. Run the following command.

```azurecli
az k8s-extension show \
  --cluster-name <cluster-name> \
  --resource-group <resource-group> \
  --cluster-type connectedClusters \
  --name <extension-name>
```

Inspect Argo CD pod health. Run the following command.

```bash
kubectl get pods -n argocd
```

Resolve any unhealthy components, and then refresh or re-create the extension.

## Scenario 7: Extension upgrade fails

### Symptoms

An extension upgrade operation remains stuck or fails.

### Cause

Upgrade failures can occur when one of the following conditions is true:

- Cluster capacity is insufficient.
- Existing workloads are unhealthy.
- Previous extension resources are in an inconsistent state.
- Admission policies block modified resources.

### Resolution

Follow these steps to troubleshoot and resolve extension upgrade failures.

1. Verify that all existing Argo CD components are healthy.
1. Review extension operation status in Azure.
1. Check Kubernetes events and pod logs.
1. Resolve any reported issues and retry the upgrade.

## Scenario 8: Workload Identity integration isn't functioning

### Symptoms

Applications managed through Argo CD can't authenticate to Azure resources by using Workload Identity.

### Cause

One or more Workload Identity configuration steps are missing or incorrect.

### Resolution

Verify the following configuration:

- The AKS or Arc-enabled cluster has **Workload Identity** enabled.
- Federated identity credentials are configured correctly.
- Service accounts contain the required annotations.
- Managed identities have appropriate Azure role-based access control (RBAC) permissions.

Review pod logs for authentication-related errors.

## Collect diagnostic information

Before opening a Microsoft Support request, gather the following information. Run the following commands.

```bash
kubectl get pods -n argocd
```

```bash
kubectl get events -n argocd --sort-by=.lastTimestamp
```

```bash
kubectl describe pod <pod-name> -n argocd
```

```bash
kubectl logs <pod-name> -n argocd
```

```azurecli
az k8s-extension show \
  --name <extension-name> \
  --cluster-name <cluster-name> \
  --resource-group <resource-group>
```

## Next steps

If the issue persists after completing the troubleshooting steps in this article, collect diagnostics and open a Microsoft Support request. Include extension status information, Kubernetes events, and relevant pod logs to expedite the investigation.