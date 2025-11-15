---
title: Istio Service Mesh Add-on CNI Troubleshooting
description: Learn how to troubleshoot the Istio CNI add-on for Azure Kubernetes Service (AKS).
ms.date: 10/22/2025
ms.reviewer: gerobayopaz, kochhars
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the Istio CNI add-on so that I can use the Istio service mesh successfully.
---
# Istio service mesh add-on CNI troubleshooting

This article discusses how to troubleshoot issues that affect the [Istio CNI][istio-cni-addon] feature for the Istio service mesh add-on for Azure Kubernetes Service (AKS).

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)
- The `aks-preview` Azure CLI extension version 19.0.0b5 or later:

    ```azurecli-interactive
    az extension add --name aks-preview
    ```

    If you already have the `aks-preview` extension installed, update it to the latest version:

    ```azurecli-interactive
    az extension update --name aks-preview
    ```
- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) CLI, or a similar tool to connect to the cluster

   Alternatively, you can install kubectl using Azure CLI by using the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.
- Make sure that your Istio service mesh uses revision `asm-1-25` or a later version. To check the current revision, run the following command:

    ```azurecli-interactive
    az aks show --resource-group <resource-group-name> --name <cluster-name> --query 'serviceMeshProfile.istio.revisions'
    ```
- Make sure that Istio CNI is enabled in your cluster:

    ```azurecli-interactive
    az aks show --resource-group <resource-group-name> --name <cluster-name> --query "serviceMeshProfile.istio.components.proxyRedirectioMechanism" -o table
    ```

    The command output should be `CNIChaining`. If the add-on isn't enabled, refer to [this guide to Istio CNI](/azure/aks/istio-cni).

## CNI DaemonSet provisioning issues troubleshooting

### Step 1: Verify that the Istio CNI DaemonSet is provisioned and ready

Check that the CNI DaemonSet is deployed and that all pods are running:

```bash
kubectl get daemonset azure-service-mesh-istio-cni-addon-node -n aks-istio-system
kubectl get pods -n aks-istio-system -l k8s-app=azure-service-mesh-istio-cni-addon-node
```

You should see a DaemonSet that has pods that run on each node in your cluster.

### Step 2: Check CNI DaemonSet pod logs

To identify any installation or configuration issues, examine the logs of the CNI DaemonSet pods:

```bash
kubectl logs -n aks-istio-system -l k8s-app=azure-service-mesh-istio-cni-addon-node
```

Look for error messages that are related to the following items:
- CNI plugin installation failures
- Network configuration errors
- Permission or file system issues
- Node-specific issues

### Step 3: Check for node taints and tolerations

Verify that the CNI DaemonSet can be scheduled on all nodes:

```bash
kubectl describe daemonset istio-cni-node -n aks-istio-system
kubectl get nodes -o wide
kubectl describe nodes
```

Look for node taints that might prevent CNI pod scheduling, and make sure that the DaemonSet has appropriate tolerations.

## Init container injection issues troubleshooting
### Step 1: Check whether istio-init containers are still injected

For newly created pods in the mesh, verify that `istio-init` containers are no longer present:

```bash
# Check a sample pod in an injected namespace
kubectl get pods -n $NAMESPACE -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.initContainers[*].name}{"\n"}{end}'
```

If `istio-init` containers are still being injected, CNI isn't working correctly.

### Step 2: Inspect pod events for CNI-related errors

Check pod events for any CNI plugin failures during pod startup:

```bash
kubectl describe pod $POD_NAME -n $NAMESPACE
```

Look for events that are related to the following items:
- Network setup failures
- CNI plugin errors
- Container creation issues

### Step 3: Verify istio-proxy sidecar startup

Check whether the `istio-proxy` sidecar container starts successfully without the init container:

```bash
kubectl logs $POD_NAME -n $NAMESPACE -c istio-proxy
```

If CNI is working correctly, the sidecar should start normally even without the `istio-init` container.

## Pod startup failure troubleshooting

If pods don't start, check for `istio-validation` init container errors:

```bash
kubectl logs $POD_NAME -n $NAMESPACE -c istio-validation
```

Look for "connection refused" error messages that indicate failures in traffic redirection setup.

## References

[Open-source Istio's CNI troubleshooting](https://istio.io/latest/docs/ops/diagnostic-tools/cni/)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[istio-deploy-addon]: /azure/aks/istio-deploy-addon
[istio-cni-addon]: /azure/aks/istio-cni
