---
title: Config file isn't available when connecting
description: Troubleshoot issues caused by a missing config file when you attempt to connect to an Azure Kubernetes Service (AKS) cluster.
ms.date: 12/10/2021
ms.reviewer: rissing, chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: cannot-connect-to-cluster-through-api-server
#Customer intent: As an Azure Kubernetes user, I want to fix or restore my config file so that I can successfully connect to my AKS cluster.
---
# Config file isn't available when connecting

This article describes how to fix issues that occur when you can't connect to an Azure Kubernetes Service (AKS) cluster because of a missing or invalid *config* file.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).
- The Kubernetes cluster command-line tool ([kubectl](https://kubernetes.io/docs/tasks/tools/)). You can alternatively install kubectl by running the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command in Azure CLI.

## Symptoms

During a cluster connection attempt, an error message similar to the following text appears:

```output
Unable to connect to the server: dial tcp [::1]:8080: connectex: No connection could be made because the target machine actively refused it. 

error: You must be logged in to the server (the server has asked for the client to provide credentials)
```

## Causes

The [kubectl tool](https://kubernetes.io/docs/reference/kubectl/overview/) and other Kubernetes connection tools use a local configuration file named *config*. The *config* file contains authentication credentials and details to connect to the cluster. By default:

- The [az aks get-credentials](/cli/azure/aks#az-aks-get-credentials) command in Azure CLI, which is used to get access credentials for a managed Kubernetes cluster, modifies the *~/.kube/config* file.

- The kubectl command uses the [kubeconfig (kubectl configuration) file](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/) in the *$HOME/.kube* directory.

So what happens during an attempted Kubernetes session depends on the user who's running the kubectl command. If you've signed in as user A, and executed both commands, here's what happens:

- The `az aks get-credentials` command tries to add the new kubeconfig parameters in the *C:\\Users\\A\\.kube\\config* file.

- The kubectl command tries to search the *C:\\Users\\A\\.kube\\config* file.

But for kubectl, if the pointer to the kubeconfig file has changed, the file that's used for accessing the cluster is supposed to be in a different location.

> [!NOTE]
> A kubeconfig file is a reference to a file that contains configuration parameters for accessing Kubernetes clusters. It doesn't necessarily refer to a file that's named *kubeconfig*.

The error occurs if one of the following scenarios occurs:

## Cause 1: The *config* file doesn't exist

The *config* file doesn't exist on your machine.

### Solution: Save the credentials

Load the *config* file by running the `az aks get-credentials` command in Azure CLI, which saves the credentials. If you don't want to use the default location, specify the `--file <config-file-location>` parameter with the location of *config* (for example, *~/Dir1/Dir2/config* or *C:\\Dir1\\Dir2\\config*).

```azurecli
az aks get-credentials --resource-group <cluster-resource-group> \
    --name <cluster-name> \
    [--file <config-file-location>]
```

## Cause 2: The *config* file is in the wrong directory

The *config* file is on your machine, but it's in a different directory from where the `az aks get-credentials` command and/or the kubectl tool expects it to be.

### Solution: Move the *config* file, save the credentials again, or change the KUBECONFIG environment variable

Take one or more of the following actions:

- Move the *config* file to the directory you want it to be in.

- Run the `az aks get-credentials` command. Specify the location you want if it isn't the default location.

  ```azurecli
  az aks get-credentials --resource-group <cluster-resource-group> \
      --name <cluster-name> \
      [--file <config-file-location>]
  ```

- Use one of the following options to change where kubectl looks for configuration parameters:

  - Modify the `KUBECONFIG` environment variable to point to the *config* file's current location. For more information, see [Set the KUBECONFIG environment variable](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-environment-variable).

  - Run the [kubectl config](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config) command with the `--kubeconfig=<config-file-location>` parameter.

## Cause 3: The *config* file has expired or is corrupted

The *config* file is on your machine. It's also in the expected directory for the `az aks get-credentials` command and the kubectl tool. But the file is expired or corrupted.

### Solution: Reestablish the credentials

Reestablish the credentials, because the existing credentials might be expired or corrupted. In that case, you may run the `az aks get-credentials` command with the `--overwrite-existing` parameter.

```azurecli
az aks get-credentials --resource-group <cluster-resource-group> \
    --name <cluster-name> \
    --overwrite-existing \
    [--file <config-file-location>]
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
