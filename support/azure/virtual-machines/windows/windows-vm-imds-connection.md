---
title: Azure Instance Metadata Service Connection Issues
description: Azure Instance Metadata Service Connection Issues
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure Instance Metadata Service Connection Issues

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

> [!NOTE]
> The new [Azure Instance Metadata Service Troubleshooting Tool](windows-vm-imds-tool.md) Run Command is now available to make diagnosing this scenario easier.

The Azure Instance Metadata Service (IMDS) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). You can only access it from within the VM. Communication between the VM and IMDS never leaves the host. HTTP clients must bypass web proxies within the VM when querying IMDS. IMDS IP address (`169.254.169.254`) must be handled in the same manner as the `168.63.129.16` IP address. For additional information, read about the [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)


## Symptom
The Azure Virtual Machine cannot establish a connection with the Azure Instance Metadata Service (IMDS) endpoint. 

* Applications/Clients dependent on the IMDS Service to be functioning are not working as expected
* Windows Server 2022/2025 Azure Edition [activation watermark continues to be displayed](./activation-watermark-appears.md)
* Extended Security Updates for Windows EOS versions may not install or function correctly


### How to determine if the VM guest OS can successfully communicate with IMDS

Run the following PowerShell script depending on your version of PowerShell to check if the metadata is received from IMDS.

- **PowerShell 6 and later versions**

  ```powershell
  Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri 
  http://169.254.169.254/metadata/attested/document?api-version=2020-09-01
   | Format-List * | Out-File "IMDSResponse1.txt"
  ```

If you get a successful response, you'll see the metadata information from the VM, such as the following output:

 ```output
 compute                                                                                                                                                                  
 -------                                                                                                                                                                  
 @{azEnvironment=AzurePublicCloud; customData=; evictionPolicy=; isHostCompatibilityLayerVm=true; licenseType=; location=eastus; name=testWs; offer=WindowsServer; ...
 ```

## Cause 
The Azure VM can't establish a connection with the [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service) endpoint `169.254.169.254`, which is essential for obtaining the activation token.

The connection to the IMDS wire server is blocked somewhere, and access to it needs to be allowed.

To determine if the VM guest OS can successfully communicate with IMDS, run the tool mentioned above or the following PowerShell script to check if the metadata is received from IMDS. Additional information can be obtained here 

PowerShell 6 and later versions
```
Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri "http://169.254.169.254/metadata/instance?api-version=2025-04-07" | ConvertTo-Json -Depth 64
```

*-NoProxy requires PowerShell V6 or greater. See our samples repository for examples with older PowerShell versions.*

If not, it means that the connection to the IMDS wire server is blocked somewhere, and access to it needs to be allowed. 


# Resolution
### Bypass web proxies within the VM

> [!NOTE]
> Run the [IMDSCertCheck](windows-vm-imds-tool.md) to diagnose any known isses.


> [!NOTE]
> `168.63.129.16` is a Microsoft-owned virtual public IP address that's used for communicating with Azure resources.

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

1. To view the IP configuration of your VM, run the [ipconfig](/windows-server/administration/windows-commands/ipconfig) command:

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

1. Check whether the MAC and primary private IP addresses that Azure uses for the VM match the MAC address and the primary private IP address that the guest OS of the VM actually uses (the addresses that you found in the earlier step). To determine what Azure uses as the MAC address, you use Azure CLI. To determine what Azure uses as the primary private IP address, you examine the network configuration in the Azure portal.

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


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
