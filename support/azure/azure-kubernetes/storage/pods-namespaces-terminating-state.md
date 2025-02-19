---
title: Troubleshoot pods and namespaces stuck in the Terminating state
description: Learn troubleshooting strategies for a scenario in which pods and namespaces remain stuck in the Terminating state in Azure Kubernetes Service (AKS).
ms.date: 05/10/2024
ms.author: skatkar
ms.reviewer: v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-general
#Customer intent: As an Azure Kubernetes user, I want to fix a scenario in which pods and namespaces remain stuck in the Terminating state (or an unknown state) so that I can successfully use my Azure Kubernetes Service cluster.
ms.custom: sap:Storage
---
# Troubleshoot pods and namespaces stuck in the Terminating state

This article discusses troubleshooting strategies for a scenario in Microsoft Azure Kubernetes Service (AKS) in which pods and namespaces remain stuck in the `Terminating` state.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool.

  **Note:** To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Troubleshooting checklist

### Step 1: Determine which pod to delete

Verify the name of the pod that you have to remove and the namespace that the pod belongs to. To determine which pods are running on your AKS cluster and the namespaces that the pods are operating in, run the following [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/) command:

```bash
kubectl get pod --all-namespaces
```

### Step 2: Delete the pod

Using the information from Step 1, run the following [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/) command to delete the pod:

```bash
kubectl delete <pod-name> --namespace <namespace-name>
```

> [!NOTE]
> You can omit the `--namespace <namespace-name>` parameter if the specified pod belongs to the "default" namespace.

If you receive the following error message, make sure that the pod name and the namespace name are correct:

> Error from server (NotFound): pods "\<POD NAME\>" not found

If the pod and namespace names are correct, but the pod wasn't deleted, you can forcibly delete the pod. To do this, run the following `kubectl delete` command:

```bash
kubectl delete pod <pod-name> --namespace <namespace-name> --grace-period=0 --force --wait=false
```

### Step 3: Determine which namespace to delete

Verify the name of the namespace that you have to remove. To determine which namespaces are running on your AKS cluster, run the following `kubectl get` command:

```bash
kubectl get namespace
```

### Step 4: Find resources within the namespace

If a namespace is stuck in the `Terminating` state, find all the resources that are defined within the namespace. To do this, run the following `kubectl get` command:

```bash
kubectl get all --namespace <namespace-name>
```

### Step 5: Delete resources within the namespace

After you discover which resources are defined within the namespace, delete those resources. For each resource to delete, run the following `kubectl delete` command:

```bash
kubectl delete <resource> <resource name> --namespace <namespace-name> --grace-period=0 --force --wait=false
```

For example, if you want to delete the `nginxtest` pod within the `nginx` namespace, run the following command:

```bash
kubectl delete pod nginxtest --namespace nginx --grace-period=0 --force --wait=false
```

### Step 6: Delete the namespace

After you delete all the resources within the namespace, delete the namespace itself. To do this, run the following `kubectl delete` command:

```bash
kubectl delete namespace <namespace-name>  --grace-period=0 --force --wait=false
```

> [!WARNING]
> The `kubectl delete` command might not be successful initially if you [use finalizers to prevent accidental deletion](https://kubernetes.io/blog/2021/05/14/using-finalizers-to-control-deletion/). Finalizers are keys on resources that signal pre-delete operations. Finalizers control the garbage collection on resources, and they're designed to alert controllers about what cleanup operations to do before they remove a resource.
>
> However, finalizers don’t necessarily identify code that should be executed. In fact, finalizers resemble annotations in the following manner:
>
> - They are basically lists of keys.
> - They can be manipulated.
> 
> If you try to delete a resource that has a finalizer on it, the resource remains in finalization until the controller removes the finalizer keys or the finalizers are removed by using kubectl. After the finalizer list is emptied, Kubernetes can reclaim the resource and put it into a queue to be deleted from the registry.
>
> If no resources remain in the namespace, but the namespace is still stuck in the `Terminating` state, run the following [kubectl patch](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_patch/) command to empty the finalizer field:
>
> ```bash
> kubectl patch namespace <namespace-name> --patch '{"metadata": {"finalizers": null}}'
> ```
>
> This action enables you to delete the namespace successfully when you run the `kubectl delete` command again.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
