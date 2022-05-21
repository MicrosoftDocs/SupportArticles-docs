---
title: Azure Serial Console | Microsoft Docs
description: The Azure Serial Console allows you to connect to your VM when SSH or RDP are not available.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.devlang: na
ms.topic: article
ms.tgt_pltfrm: vm
ms.workload: infrastructure-services
ms.date: 05/09/2022
ms.author: genli
---

# Azure Serial Console

The Serial Console in the Azure portal provides access to a text-based console for virtual machines (VMs) and virtual machine scale set instances running either Linux or Windows. This serial connection connects to the ttyS0 or COM1 serial port of the VM or virtual machine scale set instance, providing access independent of the network or operating system state. The serial console can only be accessed by using the Azure portal and is allowed only for those users who have an access role of Contributor or higher to the VM or virtual machine scale set.

Serial Console works in the same manner for VMs and virtual machine scale set instances. In this doc, all mentions to VMs will implicitly include virtual machine scale set instances unless otherwise stated.

Serial Console is generally available in global Azure regions and in public preview in Azure Government. It is not yet available in the Azure China cloud.

## Prerequisites to access the Azure Serial Console

To access the Serial Console on your VM or virtual machine scale set instance, you will need the following:

- Boot diagnostics must be enabled for the VM
- A user account that uses password authentication must exist within the VM. You can create a password-based user with the [reset password](/azure/virtual-machines/extensions/vmaccess#reset-password) function of the VM access extension. Select **Reset password** from the **Help** section.
- The Azure account accessing Serial Console must have [Virtual Machine Contributor role](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) for both the VM and the [boot diagnostics](boot-diagnostics.md) storage account
- Classic deployments aren't supported. Your VM or virtual machine scale set instance must use the Azure Resource Manager deployment model.
- Serial Console is not supported when the storage account has firewall enabled.
- Serial Console is not supported when the storage account has **Allow storage account key access** disabled.

> [!NOTE]
> Serial Console is currently incompatible with a managed boot diagnostics storage account. To use Serial Console, ensure that you are using a custom storage account that is in the same region as your VM and accessible from all networks. You can find the setting in the **Networking** section of the storage account **Overview** page.

## Get started with the Serial Console

The Serial Console for VMs and virtual machine scale set is accessible only through the Azure portal:

### Serial Console for Virtual Machines

Serial Console for VMs is as straightforward as clicking on **Serial console** within the **Help** section in the Azure portal.

  1. Open the [Azure portal](https://portal.azure.com).

  1. Navigate to **All resources** and select a Virtual Machine. The overview page for the VM opens.

  1. Scroll down to the **Help** section and select **Serial console**. A new pane with the serial console opens and starts the connection.

     :::image type="content" source="media/serial-console-overview/connect-vm.gif" alt-text="Animated GIF shows process of starting the connection to the serial console for VM.":::

### Serial Console for Virtual Machine Scale Sets

Serial Console is available for virtual machine scale sets, accessible on each instance within the scale set. You will have to navigate to the individual instance of a virtual machine scale set before seeing the **Serial console** button. If your virtual machine scale set does not have boot diagnostics enabled, ensure you update your virtual machine scale set model to enable boot diagnostics, and then upgrade all instances to the new model in order to access serial console.

  1. Open the [Azure portal](https://portal.azure.com).

  1. Navigate to **All resources** and select a Virtual Machine Scale Set. The overview page for the virtual machine scale set opens.

  1. Navigate to **Instances**

  1. Select a virtual machine scale set instance

  1. From the **Help** section, select **Serial console**. A new pane with the serial console opens and starts the connection.

     :::image type="content" source="media/serial-console-overview/connect-vm-scale-sets.gif" alt-text="Animated GIF shows process of starting the connection to the serial console for VM Scale Sets.":::

### TLS 1.2 in Serial Console

Serial Console uses TLS 1.2 end-to-end to secure all communication within the service. Serial Console has a dependency on a user-managed boot diagnostics storage account, and TLS 1.2 must be configured separately for the storage account. Instructions to do so are located [here](/azure/storage/common/transport-layer-security-configure-minimum-version).

## Advanced uses for Serial Console

Aside from console access to your VM, you can also use the Azure Serial Console for the following:

- Sending a [system request command to your VM](./serial-console-nmi-sysrq.md)
- Sending a [non-maskable interrupt to your VM](./serial-console-nmi-sysrq.md)
- Gracefully [rebooting or forcefully power-cycling your VM](./serial-console-power-options.md)

## Next steps

Additional Serial Console documentation is available in the sidebar.

- More information is available for [Serial Console for Linux VMs](./serial-console-linux.md).
- More information is available for [Serial Console for Windows VMs](./serial-console-windows.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
