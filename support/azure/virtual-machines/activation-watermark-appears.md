---
title: Windows activation watermark continues to be displayed
description: Learn how to resolve a scenario in which a Windows activation watermark continues to be displayed on Azure virtual machines.
author: cwhitley-MSFT
ms.author: cwhitley
ms.reviewer: scotro, scottmca, kimberj, jdickson, shache, v-naqviadil, v-leedennis
ms.date: 03/18/2024
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure administrator, I want to learn how to resolve the appearance of an "Activate Windows" watermark so that I can successfully use Windows on my Azure virtual machine.
---
# Windows activation watermark continues to be displayed

This document discusses how to resolve the continued presence of a Windows activation watermark on Microsoft Azure virtual machines.

*Applies to:*&nbsp; Windows Server 2022 and later versions

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli-windows)

## Symptoms

When you use an Azure virtual machine (VM) that runs Windows, you encounter the following symptoms:

- You see a watermark on the desktop that contains the following message:

  > Activate Windows. Go to Settings to activate Windows.

  This watermark indicates that the Windows activation status isn't genuine.

- When you open the **Settings** app and select **System** > **Activation**, the **Application state** field indicates an activation failure.

- When you open an elevated Command Prompt window and run the following [slmgr.vbs volume activation script](/windows-server/get-started/activation-slmgr-vbs-options), the output shows that Key Management Services (KMS) activation is successful:

  ```cmd
  cscript c:\windows\system32\slmgr.vbs /dlv
  ```

## Cause

This issue might occur if the Azure VM can't connect to the Azure Instance Metadata Service (IMDS) endpoint that's used to obtain the activation token for Windows.

## Solution

[IMDS](/azure/virtual-machines/instance-metadata-service) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). The IMDS endpoint is accessible from within the virtual machine only at the following URI: `http://169.254.169.254/metadata/instance`. Communication between the VM and IMDS never leaves the host. Have your HTTP clients bypass web proxies within the VM while they query IMDS. Also, make sure that the clients treat the `169.254.169.254` IP address in the same manner as they treat the [168.63.129.16 IP address](/azure/virtual-network/what-is-ip-address-168-63-129-16). To verify that this direct network connection exists, follow these steps.

> [!NOTE]
> `168.63.129.16` is a Microsoft-owned virtual public IP address that's used for communicating with Azure resources.

1. To verify that the Azure VM can reach the IMDS endpoint, open a PowerShell console from within the VM, and then run the following [Invoke-RestMethod](/powershell/module/microsoft.powershell.utility/invoke-restmethod) cmdlet to request metadata from the IMDS endpoint URI:

   ```powershell-interactive
   $params = @{
       Uri = "http://169.254.169.254/metadata/instance?api-version=2020-09-01"
       Headers = @{"Metadata" = "true"}
       Method = "Get"
   }
   Invoke-RestMethod @params | ConvertTo-Json
   ```

   If the cmdlet is successful, you should see a JSON response that shows the metadata of the VM. (The cmdlet output should resemble the JSON response that's shown in [Access Azure Instance Metadata Service](/azure/virtual-machines/instance-metadata-service#access-azure-instance-metadata-service).) Otherwise, the cmdlet output displays an "Unable to connect to the remote server" error message.

1. To view the local routing table on your VM, run the [route print][route-command] command:

   ```powershell-interactive
   route print
   ```

1. To locate the routing entry for the IMDS target, go to the `Active Routes` section of the `IPv4 Route Table` output, and then find the row that contains the `169.254.169.254` IP address in the `Network Destination` column.

   | Network Destination | Netmask         | Gateway     | Interface       | Metric |
   |--------------------:|----------------:|------------:|----------------:|-------:|
   | 0.0.0.0             | 0.0.0.0         | 172.16.69.1 | 172.16.69.7     | 10     |
   | 127.0.0.0           | 255.0.0.0       | On-link     | 127.0.0.1       | 331    |
   | 127.0.0.1           | 255.255.255.255 | On-link     | 127.0.0.1       | 331    |
   | 127.255.255.255     | 255.255.255.255 | On-link     | 127.0.0.1       | 331    |
   | 168.63.129.16       | 255.255.255.255 | 172.16.69.1 | 172.16.69.7     | 11     |
   | **169.254.169.254** | 255.255.255.255 | 172.16.69.1 | **172.16.69.7** | 11     |
   | ...                 | ...             | ...         | ...             | ...    |

   In the sample route table output, the IMDS target entry is in the last row, and the corresponding network interface is the value in the `Interface` column within that row. (In this example, the network interface is `172.16.69.7`.)

1. To view the IP configuration of your VM, run the following [ipconfig](/windows-server/administration/windows-commands/ipconfig) command:

     ```powershell-interactive
     ipconfig /all
     ```

1. In the ipconfig command output, find the IP configuration in which the `IPv4 Address` field matches the network interface value of the IMDS entry (`172.16.69.7`):

     ```output
     ...
     Ethernet adapter Ethernet:

     Connection-specific DNS Suffix  . : xic3mnxjiefupcwr1mcs1rjiqa.cx.internal.cloudapp.net
     Description . . . . . . . . . . . : Microsoft Hyper-V Network Adapter
     Physical Address. . . . . . . . . : 00-0D-3A-E5-1C-C0
     DHCP Enabled. . . . . . . . . . . : Yes
     Autoconfiguration Enabled . . . . : Yes
     Link-local IPv6 Address . . . . . : fe80::3166:ce5a:2bd5:a6d1%3(Preferred)
     IPv4 Address. . . . . . . . . . . : 172.16.69.7(Preferred)
     Subnet Mask . . . . . . . . . . . : 255.255.255.0
     ...
     ```

   In the sample ipconfig output, the IP configuration that contains the network interface value of the IMDS entry is `Ethernet adapter Ethernet`.

1. In the IP configuration that you located, copy the Media Access Control (MAC) address and the primary private IP address that the VM uses. The MAC address is shown in the `Physical Address` field, and the primary private IP address is shown in the `IPv4 Address` field. In this example, the MAC address and the primary private IP address are `00-0D-3A-E5-1C-C0` and `172.16.69.7`, respectively.

1. Check whether the MAC and primary private IP addresses that Azure uses for the VM match the MAC address and the primary private IP address that the guest operating system (OS) of the VM actually uses (the addresses that you found in the earlier step). To determine what Azure uses as the MAC address, you use Azure CLI. To determine what Azure uses as the primary private IP address, you examine the network configuration in the Azure portal.

   - Find the MAC address (by using Azure CLI in a PowerShell script)

     Run the following PowerShell script that invokes Azure CLI commands. This script invokes the [az vm nic list](/cli/azure/vm/nic#az-vm-nic-list) command to collect the names of the network interfaces on your VM. Then, it invokes the [az vm nic show](/cli/azure/vm/nic#az-vm-nic-show) command to display the name of each network interface, whether that network interface is the primary network interface (`True` or `False`), and the MAC address of the network interface:

     > [!NOTE]
     > In the commands, "nic" represents the network interface, not a network interface card.

     ```powershell-interactive
     # Placeholder variable definitions
     $ResourceGroup = "<resource-group-name>"
     $VmName = "<virtual-machine-name>"

     # Code
     $NicNames = az vm nic list --resource-group $ResourceGroup --vm-name $VmName |
         ConvertFrom-Json | Foreach-Object { $_.id.Split('/')[-1] }
     foreach($NicName in $NicNames)
     {
         az vm nic show --resource-group $ResourceGroup --vm-name $VmName --nic $NicName |
             ConvertFrom-Json | Format-Table -Property name, primary, macAddress
     }
     ```

     ```output
     name       primary macAddress
     ----       ------- ----------
     wintest767    True 00-0D-3A-E5-1C-C0
     ```

   - Find the primary private IP address (by using the Azure portal):

     1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machines**.

     1. In the list of VMs, select the name of your VM.

     1. On the **Properties** tab of your VM **Overview** page, locate the **Networking** heading.

     1. In the **Private IP address** field, copy the displayed IPv4 address.

1. If the MAC addresses or the primary private IP addresses aren't identical between Azure and the VM guest OS, use various [route][route-command] commands to update the routing table so that the primary network interface and IP address are targeted.

## More information

- [Troubleshoot Azure Windows virtual machine activation problems](./troubleshoot-activation-problems.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[route-command]: /windows-server/administration/windows-commands/route_ws2008
