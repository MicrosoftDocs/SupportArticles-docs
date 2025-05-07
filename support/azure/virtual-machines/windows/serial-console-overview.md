---
title: Azure Serial Console
description: The Azure Serial Console allows you to connect to your VM when SSH or RDP are not available.
services: virtual-machines
documentationcenter: ''
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.topic: article
ms.tgt_pltfrm: vm
ms.workload: infrastructure-services
ms.date: 04/22/2024
ms.reviewer: mbifeld, v-weizhu
ms.custom: sap:VM Admin - Windows (Guest OS)
---

# Azure Serial Console

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

[!INCLUDE [Feedback](../../../includes/feedback.md)]

Serial Console in the Azure portal provides access to a text-based console for virtual machines (VMs) and virtual machine scale set instances running either Linux or Windows. Serial Console connects to the ttyS0 or COM1 serial port of the VM or virtual machine scale set instance, providing access independent of the network state. The serial console can be accessed by using the Azure portal or [Azure CLI](/cli/azure/serial-console) and is allowed only for those users who have an access role of Contributor or higher to the VM or virtual machine scale set.

Serial Console works in the same manner for VMs and virtual machine scale set instances. In this doc, all mentions to VMs will implicitly include virtual machine scale set instances unless otherwise stated.

## Regions

Serial Console is available in the following regions:

- Australia Central
- Australia East
- Brazil South
- Brazil Southeast
- Canada Central
- Canada East
- Central India
- Central US
- Central US EUAP
- China East 3
- China North 3
- East Asia
- East US 2 EUAP
- East US 2
- France Central
- France South
- Germany North
- Germany West Central
- Israel Central
- Italy North
- Japan East
- Japan West
- Korea Central
- Korea South
- North Europe
- Norway East
- Norway West
- Poland Central
- Qatar Central
- South Africa North
- South Africa West
- Southeast Asia
- South India
- Sweden Central
- Sweden South
- Switzerland North
- Switzerland West
- UAE Central
- UAE North
- UK South
- UK West
- West Central US
- West Europe
- West US 2
- US Gov Arizona
- US Gov Virginia

## Prerequisites to access the Azure Serial Console

To access the Serial Console on your VM or virtual machine scale set instance, you will need the following:

- Boot diagnostics must be enabled for the VM
- A user account that uses password authentication must exist within the VM. You can create a password-based user with the [reset password](/azure/virtual-machines/extensions/vmaccess#reset-password) function of the VM access extension. Select **Reset password** from the **Help** section.
- The Azure account accessing Serial Console must have [Virtual Machine Contributor role](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) for both the VM and the [boot diagnostics](boot-diagnostics.md) storage account
- Classic deployments aren't supported. Your VM or virtual machine scale set instance must use the Azure Resource Manager deployment model.
- Serial Console is not supported when the storage account has **Allow storage account key access** disabled.

> [!IMPORTANT]
> Serial Console is now compatible with [managed boot diagnostics storage accounts](boot-diagnostics.md) and custom storage account firewalls.

## Get started with Serial Console

Serial Console for VMs and virtual machine scale set is accessible through the Azure portal or [Azure CLI](/cli/azure/serial-console).

### Access Serial Console for Virtual Machines via Azure portal

Serial Console for VMs is as straightforward as clicking on **Serial console** within the **Help** section in the Azure portal.

1. Open the [Azure portal](https://portal.azure.com).

1. Navigate to **All resources** and select a Virtual Machine. The overview page for the VM opens.

1. Scroll down to the **Help** section and select **Serial console**. A new pane with the serial console opens and starts the connection.

   :::image type="content" source="media/serial-console-overview/connect-vm.gif" alt-text="Animated GIF shows process of starting the connection to the serial console for VM.":::

### Access Serial Console for Virtual Machine Scale Sets via Azure portal

Serial Console is available for virtual machine scale sets, accessible on each instance within the scale set. You will have to navigate to the individual instance of a virtual machine scale set before seeing the **Serial console** button. If your virtual machine scale set does not have boot diagnostics enabled, ensure you update your virtual machine scale set model to enable boot diagnostics, and then upgrade all instances to the new model in order to access serial console.

1. Open the [Azure portal](https://portal.azure.com).

1. Navigate to **All resources** and select a Virtual Machine Scale Set. The overview page for the virtual machine scale set opens.

1. Navigate to **Instances**.

1. Select a virtual machine scale set instance.

1. From the **Help** section, select **Serial console**. A new pane with the serial console opens and starts the connection.

   :::image type="content" source="media/serial-console-overview/connect-vm-scale-sets.gif" alt-text="Animated GIF shows process of starting the connection to the serial console for VM Scale Sets.":::

### Access Serial Console via Azure CLI

For using Azure CLI to connect to the Serial Console of a virtual machine or virtual machine scale set instance that runs Linux or Windows, see [az serial-console](/cli/azure/serial-console#az-serial-console-connect).

If you don't have Azure CLI installed, install it by using the instructions in [How to install the Azure CLI](/cli/azure/install-azure-cli).

> [!NOTE]
> The serial-console extension will automatically install the first time you run an `az serial-console` command. If you have already installed the serial-console extension, ensure that you have the latest version by running the `az extension add --name serial-console --upgrade` command.

### TLS 1.2 in Serial Console

Serial Console uses TLS 1.2 end-to-end to secure all communication within the service. Serial Console has a dependency on a user-managed boot diagnostics storage account, and TLS 1.2 must be configured separately for the storage account. Instructions to do so are located [here](/azure/storage/common/transport-layer-security-configure-minimum-version).

## Advanced uses for Serial Console

Aside from console access to your VM, you can also use the Azure Serial Console for the following:

- Sending a [system request command to your VM](../linux/serial-console-nmi-sysrq.md)
- Sending a [non-maskable interrupt to your VM](../linux/serial-console-nmi-sysrq.md)
- Gracefully [rebooting or forcefully power-cycling your VM](serial-console-power-options.md)

## Next steps

Additional Serial Console documentation is available in the sidebar.

- More information is available for [Serial Console for Linux VMs](../linux/serial-console-linux.md).
- More information is available for [Serial Console for Windows VMs](serial-console-windows.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
