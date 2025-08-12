---
title: Azure Serial Console errors
description: Common errors within the Azure Serial Console
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.topic: article
ms.tgt_pltfrm: vm
ms.workload: infrastructure-services
ms.date: 07/29/2025
ms.author: jarrettr
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# Common errors within the Azure Serial Console

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

List of known errors within the Azure Serial Console and mitigation steps.

> [!NOTE]
> The service URLs of Serial Console were changed from `*.console.azure.com` to `*.serialconsole.azure.com`.
> If you receive the "Web socket is closed or couldn't be opened" error, add `*.serialconsole.azure.com` to your firewall allow list.


## Common errors

Error                             |   Mitigation
:---------------------------------|:--------------------------------------------|
"Azure Serial Console requires boot diagnostics to be enabled. Click here to configure boot diagnostics for your virtual machine." | Ensure that the virtual machine (VM) or virtual machine scale set has [boot diagnostics](boot-diagnostics.md) enabled. When using serial console on a virtual machine scale set instance, ensure that your instance has the latest model.
"Azure Serial Console requires a virtual machine to be running. Use the Start button to start your virtual machine."  | The VM or virtual machine scale set instance must be in a started state to access the serial console (your VM must not be stopped or deallocated). Ensure your VM or virtual machine scale set instance is running and try again.
"Azure Serial Console is not enabled for this subscription, contact your subscription administrator to enable." | The Azure Serial Console can be disabled at a subscription level. If you're a subscription administrator, you may [enable and disable the Azure Serial Console](./serial-console-enable-disable.md). If you aren't a subscription administrator, you should reach out to your subscription administrator for next steps.
A "Forbidden" response was encountered when accessing this VM's boot diagnostic storage account. | There is a known issue where Azure Serial Console might fail to connect when a custom boot diagnostics storage account has firewall restrictions. This issue occurs because Azure Serial Console runs in Microsoft's internal tenant, and firewall rules on the customer-managed storage account might block its access, even with correct permissions. To avoid connectivity issues, [switch to managed boot diagnostics](boot-diagnostics.md#enable-boot-diagnostics-on-existing-virtual-machine) (recommended) or remove the firewall on the custom boot diagnostics storage account.
You don't have the required permissions to use this VM with the serial console. Ensure you have at least Virtual Machine Contributor role permissions.| The serial console access requires you to have contributor level access on your VM or virtual machine scale set. For more information, see the [overview page](serial-console-overview.md).
The storage account '' used for boot diagnostics on this VM couldn't be found. Verify that boot diagnostics is enabled for this VM, this storage account has not been deleted, and you have access to this storage account. | Double check that you have not deleted the boot diagnostics storage account for your VM or virtual machine scale set
The serial console connection to the VM encountered an error: 'Bad Request' (400) | This can happen if your boot diagnostics URI is incorrect. For example, "http://" was used instead of "https://". The boot diagnostics URI can be fixed with this command: `az vm boot-diagnostics enable --name vmName --resource-group rgName --storage https://<storageAccountUri>.blob.core.windows.net/`
You don't have the required permissions to write to the boot diagnostics storage account for this VM. Ensure you have at least VM Contributor permissions | Serial console access requires contributor level access on the boot diagnostics storage account. For more information, see the [overview page](serial-console-overview.md).
Unable to determine the resource group for the boot diagnostics storage account *&lt;STORAGEACCOUNTNAME&gt;*. Verify that boot diagnostics is enabled for this VM and you have access to this storage account. | Serial console access requires contributor level access on the boot diagnostics storage account. For more information, see the [overview page](serial-console-overview.md).
Provisioning for this VM isn't done. Please ensure the VM is fully deployed and retry the serial console connection. | Your VM or virtual machine scale set may still be provisioning. Wait some time and try again.
Web socket is closed or couldn't be opened. | You may need to add firewall access to `*.serialconsole.azure.com`. A more detailed but longer approach is to allow firewall access to the [Microsoft Azure Datacenter IP ranges](https://www.microsoft.com/download/details.aspx?id=41653), which change fairly regularly.
Serial console does not work with a storage account using Azure Data Lake Storage Gen2 with hierarchical namespaces. | This is an issue with hierarchical namespaces. Ensure that your VM's boot diagnostics storage account is not created using Azure Data Lake Storage Gen2. This option can only be set upon storage account creation. You may have to create a separate boot diagnostics storage account without Azure Data Lake Storage Gen2 enabled to mitigate this issue.
The serial console connection to the VM encountered an error: 'Forbidden'(SubscriptionNotEnabled) - Subscription name undefined, id \<subscription id> is in non-Enabled state undefined | This issue may occur if the subscription that a user has created their Cloud Shell storage account in has been disabled. To mitigate, launch Cloud Shell and [perform the steps necessary](/azure/cloud-shell/persisting-shell-storage#unmount-clouddrive-1) to reprovision a backing storage account for Cloud Shell in the current subscription.
Azure Serial Console requests result in the error "Sorry, the serial console was unable to connect to the VM because the service did not respond in a timely manner." | In rare circumstances, communication failure may prevent the Azure node from properly applying boot diagnostics configuration. [Reapplying the virtual machine state](vm-stuck-in-failed-state.md#resolution) in the Azure portal may resolve this issue.
The serial console successfully connects to the VM, but no output is displayed, and user input is unresponsive. | Serial console and logs might not be available after live migration for Generation 2 VMs with Trusted Launch and Secure Boot enabled. To resolve this issue, a guest OS reboot is required.
The serial console shows the error message: **Another connection is currently in progress to this VM. Please wait and retry the request.** | This error indicates that another user might have the serial console open in the VM. If this is not the case, the easiest way is to disable and re-enable boot diagnostics to restore Azure Serial Console access.

## Next steps

* Learn more about the [Azure Serial Console for Linux VMs](../linux/serial-console-linux.md)
* Learn more about the [Azure Serial Console for Windows VMs](./serial-console-windows.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
