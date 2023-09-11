---
title: Troubleshoot common issues for Azure Linux Container Host for AKS
description: Troubleshoot commonly reported issues for Azure Linux container hosts on Azure Kubernetes Service (AKS). 
ms.date: 09/08/2023
author: suhuruli
ms.author: suhuruli
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---

# Troubleshoot common issues for Azure Linux Container Host for AKS

This article provides troubleshooting steps for some of the commonly reported issues that you might experience when you use Azure Linux container hosts in Azure Kubernetes Service (AKS). For more information about how to get started using Azure Linux container hosts in AKS, see [Use Azure Linux with AKS](/azure/aks/use-azure-linux).

## Before you begin

Read the [official guide for troubleshooting Kubernetes clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/_print/). Also, read the [Microsoft engineer's guide to Kubernetes troubleshooting](https://github.com/feiskyer/kubernetes-handbook/blob/master/en/troubleshooting/index.md). This guide contains commands for troubleshooting pods, nodes, clusters, and other features.

Finally, review the [list of known limitations in Azure Linux](/azure/aks/use-azure-linux#limitations). An issue that you're trying to resolve might be one that we're already working on.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.31 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## About Azure Linux Container Host for AKS

Azure Linux is an open-source Linux distribution that Microsoft created. As a lightweight OS, Azure Linux has the following features:

- Contains only the packages that are needed to run container workloads
- Undergoes Azure validation tests
- Is compatible with Azure agents

Azure Linux Container Host for AKS is an operating system image for AKS that's optimized for running container workloads. It's maintained by Microsoft and based on Azure Linux. It provides reliability and consistency from cloud to edge across the [AKS](/azure/aks/intro-kubernetes), [AKS on Azure Stack HCI](/azure/aks/hybrid/overview), and [Azure Arc](/azure/azure-arc/overview) products. You can use Azure Linux container hosts to do the following processes:

- Deploy Azure Linux node pools in a new cluster.
- Add Azure Linux node pools to your existing Ubuntu clusters.
- Migrate your Ubuntu nodes to Azure Linux nodes.

For more information about Azure Linux, see the [Azure Linux](https://github.com/microsoft/CBL-Mariner) GitHub repository.

## Troubleshooting checklist

### Step 1: Review equivalent commands in Ubuntu and Azure Linux

Most commands in the Azure Linux OS, such as the process status (`ps`) command, resemble commands that are used in Ubuntu. However, package management is done by using the Tiny DNF (`tdnf`) command. The following table lists some common commands in Ubuntu and their equivalents in Azure Linux.

| Ubuntu command            | Suggested Azure Linux command                                                    |
|---------------------------|------------------------------------------------------------------------------|
| `apt -- list installed`   | `rpm -qa`                                                                    |
| `apt autoclean`           | `tdnf clean all`                                                             |
| `apt autoremove`          | `dnf autoremove`                                                             |
| `apt dist-upgrade`        | `dnf distro-sync`                                                            |
| `apt download`            | `tdnf download`                                                              |
| `apt install`             | `tdnf install`                                                               |
| `apt install --reinstall` | `tdnf reinstall`                                                             |
| `apt list - upgradable`   | `dnf list updates`                                                           |
| `apt remove`              | `tdnf remove`                                                                |
| `apt search`              | `tdnf search`                                                                |
| `apt show`                | `tdnf list`                                                                  |
| `apt upgrade`             | `tdnf upgrade`                                                               |
| `apt cache dump`          | `tdnf list available`                                                        |
| `apt-cache dumpavail`     | `tdnf list available`                                                        |
| `apt-cache policy`        | `tdnf list`                                                                  |
| `apt-cache rdepends`      | `dnf repoquery -- alldeps - whatrequires`                                    |
| `apt-cache search`        | `tdnf search`                                                                |
| `apt-cache show`          | `tdnf info`                                                                  |
| `apt-cache stats`         | (no exact equivalent; read the *Packages* file in the */var/lib/rpm* folder) |
| `apt-config shell`        | `dnf shell`                                                                  |
| `apt-file list`           | `dnf repoquery -l`                                                           |
| `apt-file search`         | `tdnf provides`                                                              |
| `apt-get autoremove`      | `dnf autoremove`                                                             |
| `apt-get install`         | `tdnf install`                                                               |
| `apt-get remove`          | `tdnf remove`                                                                |
| `apt-get update`          | `dnf clean expire-cache dnf check-update`                                    |
| `apt-mark auto`           | `tdnf install dnf mark remove`                                               |
| `apt-mark manual`         | `dnf mark install`                                                           |
| `apt-mark showmanual`     | `dnf history userinstalled`                                                  |

### Step 2: Check the Azure Linux version

Make sure that you're using the correct version of Azure Linux. The supported version of Azure Linux for consumption is Azure Linux 2.0. In the output of the following [az aks nodepool list](/cli/azure/aks/nodepool#az-aks-nodepool-list) command, the `osSKU` property should read `AzureLinux`.

```azurecli
az aks nodepool list --resource-group <resource-group-name> --cluster-name <aks-cluster-name>
```

Although this command might not address the issue that you're experiencing, versioning is a common issue for users who report that agents or extensions aren't working correctly on Azure Linux.

### Step 3: Understand the difference in certificate file paths

Azure Linux (and other RPM distributions) store certificates differently from Ubuntu.

On Azure Linux, the */etc/ssl/certs* path is a symbolic link to */etc/pki/tls/certs*. If a container expects to map */etc/ssl/certs* to use the *ca-certificates.crt* certificate file on Azure Linux, the container instead gets a symbolic link that points to nowhere. This behavior causes certificate-related errors in the container. The container also has to map */etc/pki* so that the container can follow the symbolic link chain. If the container has to work on both Ubuntu and Azure Linux hosts, you can map */etc/pki* by using the `DirectoryOrCreate` type in a [hostPath volume](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath).

### Step 4: Update Azure CLI and the AKS preview extension

If you try to deploy an Azure Linux AKS cluster by using Azure CLI, you might receive an error message that states that the `AzureLinux` option isn't supported for the `OSSku` parameter. This message means that you might be using an outdated version of the Azure CLI or the AKS preview extension. To fix this issue, take one or both of the following two actions:

- If Azure CLI isn't up to date, install the latest version. To upgrade Azure CLI, run the following [az upgrade](/cli/azure/reference-index#az-upgrade) command:

  ```azurecli
  az upgrade
  ```

- If you have an older version of the `aks-preview` extension installed, install a newer version so that the `OSSku` parameter has a value of `AzureLinux`. To upgrade the extension, run the following [az extension update](/cli/azure/extension#az-extension-update) command:

  ```azurecli
  az extension update --name aks-preview
  ```

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
