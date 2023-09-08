---
title: Troubleshoot common Bring Your Own Key (BYOK) issues
description: Learn how to troubleshoot common Bring Your Own Key (BYOK) issues, including key vault and ephemeral OS disk problems, on Azure Kubernetes Service (AKS).
ms.date: 07/28/2023
author: andyzhangx
ms.author: xiazhang
editor: v-jsitser
ms.reviewer: meolsen, chiragpa, joharder, pram, vijayrod, jamote, ramankum, xinyuyuan, aksstoragedev, cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-azure-storage-issues
---
# Troubleshoot common Bring Your Own Key (BYOK) issues

This article discusses troubleshooting methods for the most common Bring Your Own Key (BYOK) issues on Microsoft Azure Kubernetes Service (AKS).

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Troubleshooting checklist

### Step 1: Register a preview feature to enable BYOK on an ephemeral OS disk

To register the preview feature that enables BYOK on an ephemeral operating system (OS) disk (`Microsoft.ContainerService/EnableBYOKOnEphemeralOSDiskPreview`), run the [az feature register](/cli/azure/feature#az-feature-register) and [az feature show](/cli/azure/feature#az-feature-show) commands. For instructions, see [Register customer-managed key (preview) feature](/azure/aks/azure-disk-customer-managed-keys#register-customer-managed-key-preview-feature).

### Step 2: Create a cluster that uses BYOK on an ephemeral OS disk

To create an AKS cluster that uses BYOK on an ephemeral OS disk, run the [az aks create](/cli/azure/aks#az-aks-create) command. For instructions, see [Create a new AKS cluster and encrypt the OS disk](/azure/aks/azure-disk-customer-managed-keys#create-a-new-aks-cluster-and-encrypt-the-os-disk).

> [!NOTE]  
> If you don't specify the `--node-osdisk-type` parameter in the `az aks create` command, the default OS disk type for the node is `Ephemeral` only if the current virtual machine (VM) size supports ephemeral OS disks. For more information, see [Ephemeral OS disks for Azure VMs](/azure/virtual-machines/ephemeral-os-disks).

## Cause 1: Can't enable purge protection in the key vault

If you receive a `CreateVMSSAgentPoolFailed` error code and a `KeyVaultNotPurgeProtectionEnabled` error subcode, the creation of an agent pool for a virtual machine scale set failed because you didn't enable purge protection when you created the key vault.

### Solution 1: Enable purge protection when you create the key vault

Run the [az keyvault create][az-keyvault-create] command again, and specify a value of `true` for the `--enable-purge-protection` parameter. For instructions, see [Create an Azure Key Vault instance][create-key-vault-instance].

## Cause 2: Key vault and disk are in different regions when agent pool creation fails for a virtual machine scale set

If you receive a `CreateVMSSAgentPoolFailed` error code and a `KeyVaultAndDiskInDifferentRegions` error subcode, the key vault and the disk encryption set are located in different regions. The key vault and disk encryption set must be in the same region.

### Solution 2: Use the same region as for the disk when you create the key vault

Run the [az keyvault create][az-keyvault-create] command again, and make sure that the value that you specify in the `--location` parameter is the same region that you used for the disk encryption set. For instructions, see [Create an Azure Key Vault instance][create-key-vault-instance].

## Cause 3: Disk encryption set isn't granted

If you delete the disk encryption set permission for the key vault, the AKS cluster node won't run. In this situation, you receive the following error message in the disk encryption set page of the Azure portal:

> To associate a disk, image, or snapshot with this disk encryption set, you must grant permissions to the key vault.

### Solution 3: Update the security policy settings

Update the security policy settings again by running the [az keyvault set-policy](/cli/azure/keyvault#az-keyvault-set-policy) command. For instructions, see [Grant the DiskEncryptionSet access to key vault](/azure/aks/azure-disk-customer-managed-keys#grant-the-diskencryptionset-access-to-key-vault).

## Reference

- [Bring your own keys (BYOK) with Azure disks in Azure Kubernetes Service (AKS)](/azure/aks/azure-disk-customer-managed-keys)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[az-keyvault-create]: /cli/azure/keyvault#az-keyvault-create
[create-key-vault-instance]: /azure/aks/azure-disk-customer-managed-keys#create-an-azure-key-vault-instance
