---
title: Reset the network interface for Azure Linux VM
description: This article describes how to reset the network interface for Azure Linux VM
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.custom: devx-track-azurecli, linux-related-content
ms.workload: infrastructure-services
ms.date: 07/19/2021
ms.author: tibasham
---
# Reset the network interface for Azure Linux VM

This article shows how to reset the network interface for Azure Linux Virtual Machine (VM) to resolve issues when you can't connect to an Azure Linux VM after:

- You disable the default network interface (NIC).
- You manually set a static IP for the NIC.

If your Azure issue isn't addressed in this article, visit the Azure forums on [MSDN and Stack Overflow](https://azure.microsoft.com/support/forums/). You can post your issue in these forums, or post to [@AzureSupport on Twitter](https://twitter.com/AzureSupport). You also can submit an Azure support request.

To submit a support request, go to the [Azure support page](https://azure.microsoft.com/support/options/) and select **Get support**.

## Reset network interface

### For VMs deployed in Resource group model

1. Go to the [Azure portal](https://portal.azure.com/).
1. Select the affected Virtual Machine.
1. Select **Networking** and then select the network interface of the VM.

    :::image type="content" source="media/reset-network-interface-azure-linux-vm/select-network-interface-vm.png" alt-text="Screenshot of the Network Interface VM selection under Networking." border="false":::

1. Select **IP configurations**.
1. Select the IP.
1. If the **Private IP assignment** isn't set to **Static**, change it to **Static**.
1. Change the **IP address** to another IP address that is available in the Subnet.
1. The virtual machine will restart to initialize the new NIC to the system.
1. Try to log into your machine using secure shell (SSH). If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

## Use Azure CLI

1. Make sure that you have installed the latest [Azure command-line interface (CLI)](/cli/azure/install-azure-cli).

1. Open [Azure Cloud Shell](/azure/cloud-shell/overview) or preferred shell. Run the following commands:

   ```azurecli
   #Log in to the subscription  

   az login 
   
   az account set --subscription 
   
   #Check whether the new IP address is available in the virtual network.
   
   az network vnet check-ip-address -g MyResourceGroup -n MyVnet --ip-address 10.0.0.4 
   
   #Add/Change static IP. This process won't change MAC address 
   
   az network nic ip-config update -g MyResourceGroup --nic-name MyNic -n MyIpConfig --private-ip-address 10.0.0.9 
   ```

1. Try to SSH to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

## For Classic VMs

> [!IMPORTANT]
> Classic VMs will be retired on March 1, 2023.
>
> If you use IaaS resources from ASM, please complete your migration by March 1, 2023. We encourage you to make the switch sooner to take advantage of the many feature enhancements in Azure Resource Manager.
>
> For more information, see Migrate your IaaS resources to Azure Resource Manager by March 1, 2023.

To reset network interface, follow these steps:

### Use Azure portal

1. Go to the [Azure portal](https://portal.azure.com/).
1. Select **Virtual Machines (Classic)**.
1. Select the affected Virtual Machine.
1. Select **IP addresses**.
1. If the **Private IP assignment** isn't set to **Static**, change it to **Static**.
1. Change the **IP address** to another IP address that is available in the Subnet.
1. Select **Save**.

   The virtual machine will restart to initialize the new NIC to the system.

1. Try to SSH to your machine. If successful, you can choose to revert the Private IP address back to the original.

### Manually fix the IP address in the Guest OS

#### Common steps

1. Log on to the VM through the [Azure Serial Console](serial-console-linux.md) with root or a user with sudo access. If logged in as a regular user, run `sudo -i` to work as root.
1. Confirm that the VM has a  NIC, and that it doesn't currently have an IPv4 address assigned to it, or that it has a different IPv4 address than the private IP address shown under Networking in the [Azure portal](https://portal.azure.com/).

   Write down the ethernet address:

   `ip address show dev eth0`

   Example output for no IPv4 address:

   :::image type="content" source="media/reset-network-interface-azure-linux-vm/text-output-terminal-window-no-ip4.png" alt-text="Screenshot of the text output in a terminal window where there is no IPv4 address.":::

   Example output with an IPv4 address:

   :::image type="content" source="media/reset-network-interface-azure-linux-vm/text-output-terminal-window-with-ip4.png" alt-text="Screenshot of the text output in a terminal window where there is an IPv4 address.":::

   Example of a private IP address within Networking in the Azure portal.

   :::image type="content" source="media/reset-network-interface-azure-linux-vm/azure-portal-private-ip-address.png" alt-text="Screenshot shows the private IP address under Networking in the Azure portal.":::

If the IPv4 addresses aren't the same, the interface configuration file may need to be fixed:

### RedHat and Centos

The interface configuration is stored in */etc/sysconfig/network-scripts/ifcfg-eth0*. On a standard setup it'll contain output similar to the following code:

```output
# Created by cloud-init on instance boot automatically, don't edit.
# 
BOOTPROTO=dhcp 
DEVICE=eth0 
HWADDR=00:0d:3a:11:22:33 
ONBOOT=yes 
STARTMODE=auto 
TYPE=Ethernet 
USERCTL=no 
```

Changes to these fields, or adding other configuration options which are commonly used on-premises, may prevent the configuration from working on Azure. Check the configuration file and correct it with a text editor if any of the following situations occur:

- The MAC address setting doesn't match the address collected in step 2.

  :::image type="content" source="media/reset-network-interface-azure-linux-vm/text-output-terminal-mac-no-match.png" alt-text="Screenshot of the text output in a terminal window where the MAC address setting doesn't match the address collected in step 2.":::

- The boot protocol has been set to something other than *dhcp*,  and a static IP address is configured.

  :::image type="content" source="media/reset-network-interface-azure-linux-vm/text-output-terminal-static-ip-configured.png" alt-text="Screenshot of the text output in a terminal window where the boot protocol has been set to something other than dhcp, and a static IP address is configured.":::

Once these details have been corrected, restart the VM with networking configured correctly.

### RHEL 8, Ubuntu, Debian

These Linux distributions use `cloud-init`, and the issue should be resolved on the next reboot of the VM. If a reboot doesn't fix the issue, try any of the previously listed methods.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
