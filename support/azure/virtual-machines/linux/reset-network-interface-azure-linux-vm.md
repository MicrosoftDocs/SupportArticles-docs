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
ms.date: 09/11/2024
ms.author: tibasham
---
# Reset the network interface for Azure Linux VM

**Applies to:** :heavy_check_mark: Linux VMs

This article shows how to reset the network interface for Azure Linux Virtual Machine (VM) to resolve issues when you can't connect to an Azure Linux VM after:

- You disable the default network interface (NIC).
- You manually set a static IP for the NIC.

If your Azure issue isn't addressed in this article, visit the Azure forums on [MSDN and Stack Overflow](https://azure.microsoft.com/support/forums/). You can post your issue in these forums, or post to [@AzureSupport on Twitter](https://twitter.com/AzureSupport). You also can submit an Azure support request.

To submit a support request, go to the [Azure support page](https://azure.microsoft.com/support/options/) and select **Get support**.

To reset the network interface, use the Azure portal, Azure PowerShell or Azure CLI:

## [Portal](#tab/azure-portal)

1. Go to the [Azure portal](https://portal.azure.com/).
2. Select the affected Virtual Machine.
3. Select **Networking** and then select the network interface of the VM.

    :::image type="content" source="media/reset-network-interface-azure-linux-vm/select-network-interface-vm.png" alt-text="Screenshot of the Network Interface VM selection under Networking." border="false":::

4. Select **IP configurations**.
5. Select the IP.
6. If the **Private IP assignment** isn't set to **Static**, change it to **Static**.
7. Change the **IP address** to another IP address that is available in the Subnet.
8. The virtual machine will restart to initialize the new NIC to the system.
9. Try to log into your machine using secure shell (SSH). If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

## [PowerShell](#tab/azure-powershell)

1. Make sure that you have [the latest Azure PowerShell](/powershell/azure/) installed.
2. Open an elevated Azure PowerShell session (Run as administrator). Run the following commands:

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
2. The virtual machine will restart to initialize the new NIC to the system.
3. Try to SSH to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

## [Azure CLI](#tab/azure-cli)

1. Make sure that you have installed the latest [Azure command-line interface (CLI)](/cli/azure/install-azure-cli).

2. Open [Azure Cloud Shell](/azure/cloud-shell/overview) or preferred shell. Run the following commands:

   ```azurecli-interactive
   #Log in to the subscription  

   az login 
   
   az account set --subscription 
   
   #Check whether the new IP address is available in the virtual network.
   
   az network vnet check-ip-address -g MyResourceGroup -n MyVnet --ip-address 10.0.0.4 
   
   #Add/Change static IP. This process won't change MAC address 
   
   az network nic ip-config update -g MyResourceGroup --nic-name MyNic -n MyIpConfig --private-ip-address 10.0.0.9 
   ```

3. Try to SSH to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
