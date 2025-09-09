---
title: How to reset network interface for Azure Windows VM
description: Shows how to reset network interface for Azure Windows VM.
services: virtual-machines, azure-resource-manager
author: JarrettRenshaw
manager: dcscontentpm
tags: top-support-issue, azure-resource-manager
ms.custom: sap:Cannot connect to my VM, devx-track-azurepowershell
ms.service: azure-virtual-machines
ms.collection: windows
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 09/19/2024
ms.author: jarrettr
---
# How to reset network interface for Azure Windows VM

**Applies to:** :heavy_check_mark: Windows VMs

This article shows how to reset the network interface for Azure Windows VM to resolve issues when you can't connect to Microsoft Azure Windows Virtual Machine (VM) after:

* You disable the default Network Interface (NIC).
* You manually set a static IP for the NIC.

The following article also introduces how to view and change settings for a NIC, which might help you:

[Create, change, or delete a network interface](/azure/virtual-network/virtual-network-network-interface)

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

## Reset the NIC using Azure portal, Azure PowerShell or Azure CLI

> [!NOTE]
> We recommend using the [az vm repair reset-nic](/cli/azure/vm/repair#az-vm-repair-reset-nic) command to reset the NIC. To run this command, see the following "Azure CLI" tab.

### [Portal](#tab/azure-portal)

1. Go to the [Azure portal](https://ms.portal.azure.com).
2. Select the affected Virtual Machine.
3. Select **Networking** and then select the network Interface of the VM.

    :::image type="content" source="media/reset-network-interface/select-vm-network-interface.png" alt-text="Screenshot shows the Network interface location." border="false":::

4. Select **IP configurations**.
5. Select the IP.
6. If the **Private IP assignment**  isn't  **Static**, change it to **Static**.
7. Change the **IP address** to another IP address that is available in the Subnet.
8. The virtual machine restarts to initialize the new NIC to the system.
9. Try to use RDP to connect to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

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
3. Try to use RDP to connect to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

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

3. Try to use RDP to connect to your machine. If successful, you can change the Private IP address back to the original if you would like. Otherwise, you can keep it.

---

## Delete the unavailable NICs

After you can remote desktop to the machine, you must delete the old NICs to avoid the potential problem:

1. Open Device Manager.
2. Select **View** > **Show hidden devices**.
3. Select **Network Adapters**.
4. Check for the adapters named as "Microsoft Hyper-V Network Adapter".
5. You might see an unavailable adapter that is grayed out. Right-click the adapter and then select Uninstall.

    :::image type="content" source="media/reset-network-interface/network-adapter.png" alt-text="Screenshot shows network adapters in which Microsoft Hyper-V Network Adapter is greyed." border="false":::

    > [!NOTE]
    > Only uninstall the unavailable adapters that have the name "Microsoft Hyper-V Network Adapter". If you uninstall any of the other hidden adapters, it could cause additional issues.

6. Now all unavailable adapters should be cleared of your system.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
