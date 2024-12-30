---
title: Reset the network interface for Azure Linux VM
description: This article describes how to reset the network interface for Azure Linux VM.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.custom: sap:Cannot connect to my VM, devx-track-azurecli, linux-related-content
ms.workload: infrastructure-services
ms.date: 09/19/2024
ms.author: tibasham
---
# Reset the network interface for Azure Linux VM

**Applies to:** :heavy_check_mark: Linux VMs

This article shows how to reset the network interface for Azure Linux Virtual Machine (VM) to resolve issues when you can't connect to an Azure Linux VM after:

- You disable the default network interface (NIC).
- You manually set a static IP for the NIC.

The following article also introduces how to view and change settings for a NIC, which might help you:

[Create, change, or delete a network interface](/azure/virtual-network/virtual-network-network-interface)

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

## Reset the NIC using Azure portal, Azure PowerShell or Azure CLI

> [!NOTE]
> We recommend using the [az vm repair reset-nic](/cli/azure/vm/repair#az-vm-repair-reset-nic) command to reset the NIC. To run this command, see the following "Azure CLI" tab.

### [Portal](#tab/azure-portal)

1. Go to the [Azure portal](https://portal.azure.com/).
2. Select the affected Virtual Machine.
3. Select **Networking** and then select the network interface of the VM.

    :::image type="content" source="media/reset-network-interface-azure-linux-vm/select-network-interface-vm.png" alt-text="Screenshot of the Network Interface VM selection under Networking." border="false":::

4. Select **IP configurations**.
5. Select the IP.
6. If the **Private IP assignment** isn't set to **Static**, change it to **Static**.
7. Change the **IP address** to another IP address that is available in the Subnet.
8. The virtual machine restarts to initialize the new NIC to the system.
9. Try to sign in to your machine using secure shell (SSH). If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

### [Azure PowerShell](#tab/azure-powershell)

1. Make sure that you have [the latest Azure PowerShell](/powershell/azure/) installed.
2. Open an elevated Azure PowerShell session. Run the following commands:

    ```powershell
    #Set the variables 
    $SubscriptionID = "<Subscription ID>"​
    $ResourceGroup = "<Resource Group>"
    $NetInter="<The Network interface of the VM>"
    $VNET = "<Virtual network>"
    $subnet= "<The virtual network subnet>"
    $PrivateIP = "<New Private IP>"

    #You can ignore the publicIP variable if the VM does not have a public IP associated.
    $publicIP =Get-AzPublicIpAddress -Name <the public IP name> -ResourceGroupName  $ResourceGroup
 
    #Log in to the subscription​ 
    Add-AzAccount
    Select-AzSubscription -SubscriptionId $SubscriptionId 
        
    #Check whether the new IP address is available in the virtual network.
    Get-AzVirtualNetwork -Name $VNET -ResourceGroupName $ResourceGroup | Test-AzPrivateIPAddressAvailability -IPAddress $PrivateIP
    
    #Add/Change static IP. This process will change MAC address
    $vnet = Get-AzVirtualNetwork -Name $VNET -ResourceGroupName $ResourceGroup

    $subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnet -VirtualNetwork $vnet

    $nic = Get-AzNetworkInterface -Name  $NetInter -ResourceGroupName  $ResourceGroup
    
    #Remove the PublicIpAddress parameter if the VM does not have a public IP.
    $nic | Set-AzNetworkInterfaceIpConfig -Name ipconfig1 -PrivateIpAddress $PrivateIP -Subnet $subnet -PublicIpAddress $publicIP -Primary

    $nic | Set-AzNetworkInterface
    ```
2. The virtual machine restarts to initialize the new NIC to the system.
3. Try to use SSH to connect to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

### [Azure CLI](#tab/azure-cli)

1. Launch [Azure Cloud Shell](/azure/cloud-shell/overview) from the top navigation of the Azure portal. 
2. Run the following commands:

    ```azurecli-interactive
    az vm repair reset-nic -g MyResourceGroup -n vmName --subscription subscriptionId --yes
    ```

    Or 
   
   ```azurecli-interactive
   #Log in to the subscription  

   az login 
   
   az account set --subscription 
   
   #Check whether the new IP address is available in the virtual network.
   
   az network vnet check-ip-address -g MyResourceGroup -n MyVnet --ip-address 10.0.0.4 
   
   #Add/Change static IP. This process won't change MAC address 
   
   az network nic ip-config update -g MyResourceGroup --nic-name MyNic -n MyIpConfig --private-ip-address 10.0.0.9 
   ```

3. Try to use SSH to connect to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
