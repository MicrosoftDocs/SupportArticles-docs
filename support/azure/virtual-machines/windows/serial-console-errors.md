---
title: Azure Serial Console errors
description: Common errors within the Azure Serial Console
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.tgt_pltfrm: vm
ms.workload: infrastructure-services
ms.date: 10/16/2025
ms.author: jarrettr
ms.custom: sap:Cannot connect to my VM
---

# Common errors within the Azure Serial Console

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

This article lists common error messages that you might see within the Azure Serial Console, and provides steps to mitigate the errors.

> [!NOTE]
> - The service URL of the Serial Console is changed from `*.console.azure.com` to `*.serialconsole.azure.com`.
>
> - If you receive a "Web socket is closed or couldn't be opened" error message, add `*.serialconsole.azure.com` to your firewall allow list.

## Common errors

Error                             |   Mitigation
:---------------------------------|:--------------------------------------------|
"Azure Serial Console requires boot diagnostics to be enabled. Click here to configure boot diagnostics for your virtual machine." | Make sure that the virtual machine (VM) or VM scale set has [boot diagnostics](boot-diagnostics.md) enabled. If you use the Serial Console on a VM scale set instance, make sure that your instance has the latest model.
"Azure Serial Console requires a virtual machine to be running. Use the Start button to start your virtual machine."  | The VM Scale Sets instance must be in a started state to access the Serial Console (your VM must not be stopped or deallocated). Make sure that your VM or VM Scale Sets instance is running, and then try again.
"Azure Serial Console is not enabled for this subscription, contact your subscription administrator to enable." | The Azure Serial Console can be disabled at a subscription level. If you're a subscription administrator, you can [enable and disable the Azure Serial Console](./serial-console-enable-disable.md). If you aren't a subscription administrator, contact your subscription administrator for the next steps.
A "Forbidden" response was encountered when accessing this VM's boot diagnostic storage account. | There's a known issue where Azure Serial Console might fail to connect when a custom boot diagnostics storage account has firewall restrictions when using the [az serial-console](/cli/azure/serial-console) command. To avoid connectivity issues, use Serial Console in the Azure Portal.
You don't have the required permissions to use this VM with the serial console. Ensure you have at least Virtual Machine Contributor role permissions.| Serial console access requires that you have contributor level access on your VM or VM scale set. For more information, see the [Azure Serial Console](serial-console-overview.md) overview page.
The storage account '' used for boot diagnostics on this VM couldn't be found. Verify that boot diagnostics is enabled for this VM, this storage account hasn't been deleted, and you have access to this storage account. | Double check that you didn't delete the boot diagnostics storage account for your VM or VM scale set.
The serial console connection to the VM encountered an error: 'Bad Request' (400) | This error can occur if your boot diagnostics URI is incorrect. For example, "http://" instead of "https://" is used. To fix the URI, run the following command: `az vm boot-diagnostics enable --name vmName --resource-group rgName --storage https://<storageAccountUri>.blob.core.windows.net/`.
You don't have the required permissions to write to the boot diagnostics storage account for this VM. Ensure you have at least VM Contributor permissions | Serial console access requires contributor level access on the boot diagnostics storage account. For more information, see the [Azure Serial Console](serial-console-overview.md) overview page.
Unable to determine the resource group for the boot diagnostics storage account *&lt;STORAGEACCOUNTNAME&gt;*. Verify that boot diagnostics is enabled for this VM and you have access to this storage account. | Serial console access requires contributor level access on the boot diagnostics storage account. For more information, see the [Azure Serial Console](serial-console-overview.md) overview page.
Provisioning for this VM isn't done. Please ensure the VM is fully deployed and retry the serial console connection. | Your VM or VM scale set might still be provisioning. Wait for some time, and then try again.
Web socket is closed or couldn't be opened. | You might have to add firewall access to `*.serialconsole.azure.com`. A more detailed but longer approach is to allow firewall access to the [Microsoft Azure Datacenter IP ranges](https://www.microsoft.com/download/details.aspx?id=41653). These ranges change regularly.
Serial console doesn't work with a storage account using Azure Data Lake Storage Gen2 with hierarchical namespaces. | This issue affects hierarchical namespaces. Make sure that your VM boot diagnostics storage account isn't created by using Azure Data Lake Storage Gen2. This option can be set only during storage account creation. To mitigate this issue, you might have to create a separate boot diagnostics storage account without having Azure Data Lake Storage Gen2 enabled.
The serial console connection to the VM encountered an error: 'Forbidden'(SubscriptionNotEnabled) - Subscription name undefined, id \<subscription id> is in non-Enabled state undefined | This issue might occur if the subscription in which a user creates their Cloud Shell storage account is disabled. To mitigate this issue, open the Cloud Shell and [perform the necessary steps](/azure/cloud-shell/persisting-shell-storage#unmount-clouddrive-1) to reprovision a backing storage account for the Cloud Shell in the current subscription.
Azure Serial Console requests result in the error "Sorry, the serial console was unable to connect to the VM because the service didn't respond in a timely manner." | In rare circumstances, a communication failure might prevent the Azure node from correctly applying a boot diagnostics configuration. To resolve this issue, [try to reapply the VM state](vm-stuck-in-failed-state.md#resolution) in the Azure portal.
The serial console successfully connects to the VM, but no output is displayed, and user input is unresponsive. | Serial Console and logs might not be available after you run a live migration for Generation 2 VMs by having Trusted Launch and Secure Boot enabled. To resolve this issue, run a guest OS restart.
The serial console shows the error message: **Another connection is currently in progress to this VM. Please wait and retry the request.** | This message indicates that another user might have Serial Console open in the VM. If this situation isn't true, try to restore Azure Serial Console access by disabling and re-enabling boot diagnostics.
At Windows VM, after to connect to Serial Console and, at SAC, you try to open a command prompt session (by running the `cmd` command) it shows the error: **Unable to launch a Command Prompt. The service responsible for launching Command Prompt channels has not yet registered. This may be because the service is not yet started, is disabled by the administrator, is malfunctioning or is unresponsive.** | This may indicate that the service `Special Administration Console Helper (sacsvr)` service is disabled. Go to windows services and ensure that service's startup is set as `Automatic` and it starts successfully.

## Next steps

* Learn more about the [Azure Serial Console for Linux VMs](../linux/serial-console-linux.md)
* Learn more about the [Azure Serial Console for Windows VMs](./serial-console-windows.md)

 
