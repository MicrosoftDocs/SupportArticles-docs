---
title: Repair a Windows VM by using the Azure Virtual Machine repair commands | Microsoft Docs
description: This article details how to use Azure VM repair commands to connect the disk to another Windows VM to fix any errors, then rebuild your original VM.
services: virtual-machines
documentationcenter: ''
author: v-miegge
manager: dcscontentpm
editor: ''
tags: virtual-machines
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.devlang: azurecli
ms.date: 09/10/2019
ms.author: v-miegge

---

# Repair a Windows VM by using the Azure Virtual Machine repair commands

If your Windows virtual machine (VM) in Azure encounters a boot or disk error, you may need to perform mitigation on the disk itself. A common example would be a failed application update that prevents the VM from being able to boot successfully. This article details how to use Azure VM repair commands to connect the disk to another Windows VM to fix any errors, then rebuild your original VM.

> [!IMPORTANT]
> * The scripts in this article only apply to the VMs that use [Azure Resource Manager](/azure/azure-resource-manager/management/overview).
> * Outbound connectivity from the VM (port 443) is required for the script to run.
> * Only one script may run at a time.
> * A running script cannot be canceled.
> * The maximum time a script can run is 90 minutes, after which it will time out.
> * For VMs using Azure Disk Encryption, only managed disks encrypted with single pass encryption (with or without KEK) are supported.


## Repair process overview

You can now use Azure VM repair commands to change the OS disk for a VM, and you no longer need to delete and recreate the VM.

Follow these steps to troubleshoot the VM issue:

1. Launch Azure Cloud Shell
2. Run az extension add/update.
3. Run az vm repair create.
4. Run az vm repair run, or perform mitigation steps.
5. Run az vm repair restore.

For additional documentation and instructions, see [az vm repair](/cli/azure/ext/vm-repair/vm/repair).

## Repair process example

1. Launch Azure Cloud Shell

   The Azure Cloud Shell is a free interactive shell that you can use to run the steps in this article. It includes common Azure tools preinstalled and configured to use with your account.

   To open the Cloud Shell, select **Try it** from the upper-right corner of a code block. You can also open Cloud Shell in a separate browser tab by visiting [https://shell.azure.com](https://shell.azure.com).

   Select **Copy** to copy the blocks of code, then paste the code into the Cloud Shell, and select **Enter** to run it.

   If you prefer to install and use the CLI locally, this quickstart requires Azure CLI version 2.0.30 or later. Run ``az --version`` to find the version. If you need to install or upgrade your Azure CLI, see [Install Azure CLI](/cli/azure/install-azure-cli).
   
   If you need to login to Cloud Shell with a different account than you are currently logged in to the Azure portal with you can use ``az login`` [az login reference](/cli/azure/reference-index#az-login&preserve-view=true).  To switch between subscriptions associated with your account you can use ``az account set --subscription`` [az account set reference](/cli/azure/account#az-account-set&preserve-view=true).

2. If this is the first time you have used the `az vm repair` commands, add the vm-repair CLI extension.

   ```azurecli-interactive
   az extension add -n vm-repair
   ```

   If you have previously used the `az vm repair` commands, apply any updates to the vm-repair extension.

   ```azurecli-interactive
   az extension update -n vm-repair
   ```

3. Run `az vm repair create`. This command will create a copy of the OS disk for the non-functional VM, create a repair VM in a new Resource Group, and attach the OS disk copy.  The repair VM will be the same size and region as the non-functional VM specified. The Resource Group and VM name used in all steps will be for the non-functional VM. If your VM is using Azure Disk Encryption the command will attempt to unlock the encrypted disk so that it is accessible when attached to the repair VM.

   ```azurecli-interactive
   az vm repair create -g MyResourceGroup -n myVM --repair-username username --repair-password 'password!234' --verbose
   ```

4. Run `az vm repair run`. This command will run the specified repair script on the attached disk via the repair VM. If the troubleshooting guide you are using specified a run-id please use it here, otherwise you can use `az vm repair list-scripts` to see available repair scripts. The Resource Group and VM name used here are for the non-functional VM used in step 3. Additional information about the repair scripts can be found in the [repair script library](https://github.com/Azure/repair-script-library).

   ```azurecli-interactive
   az vm repair run -g MyResourceGroup -n MyVM --run-on-repair --run-id win-hello-world --verbose
   ```
   
   Optionally you can perform any needed manual mitigation steps using the repair VM, then proceed to step 5.

5. Run `az vm repair restore`. This command will swap the repaired OS disk with the original OS disk of the VM. The Resource Group and VM name used here are for the non-functional VM used in step 3.

   ```azurecli-interactive
   az vm repair restore -g MyResourceGroup -n MyVM --verbose
   ```

## Verify and enable boot diagnostics

The following example enables the diagnostic extension on the VM named ``myVMDeployed`` in the resource group named ``myResourceGroup``:

Azure CLI

```azurecli-interactive
az vm boot-diagnostics enable --name myVMDeployed --resource-group myResourceGroup --storage https://mystor.blob.core.windows.net/
```

## Next steps

* If you are having issues connecting to your VM, see [Troubleshoot RDP connections to an Azure VM](./troubleshoot-rdp-connection.md).
* For issues with accessing applications running on your VM, see [Troubleshoot application connectivity issues on virtual machines in Azure](./troubleshoot-app-connection.md).
* For more information about using Resource Manager, see [Azure Resource Manager overview](/azure/azure-resource-manager/management/overview).
