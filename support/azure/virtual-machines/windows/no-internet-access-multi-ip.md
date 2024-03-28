---
title: No Internet access from Azure Windows VM that has multiple IP addresses
description: Fixes an issue in which Azure Windows virtual machines that have multiple IP addresses cannot connect to the Internet or Azure services.
ms.date: 04/15/2022
ms.reviewer: chadmat
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
---
# No Internet access from Azure Windows VM that has multiple IP addresses

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4040882

## Symptoms

In Microsoft Azure, you set multiple IP addresses in the network interface of an Azure Windows virtual machine. After you make the settings, the virtual machine cannot connect to the Internet or to Azure services, such as Azure Backup.

## Cause

This issue occurs because Windows selects the lowest numerical IP address as the primary IP address regardless of the address settings in the Azure portal.

For example, in the Azure portal settings for a Windows virtual machine, you set 10.0.0.10 as the primary IP address and 10.0.0.7 as the secondary IP address. In this situation, Windows selects 10.0.0.7 as primary IP address.

This behavior blocks connectivity because only the IP address that is set as primary in the Azure portal is allowed to connect to the Internet and Azure services.

## Resolution

To resolve the issue, run the following Windows PowerShell commands to change the primary IP address of the Windows virtual machine:

```powershell
$primaryIP = "<Primary IP address that you set in Azure portal>"
$netInterface = "<NIC name>"
[array]$IPs = Get-NetIPAddress -InterfaceAlias $netInterface | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.IPAddress -ne $primaryIP}
Set-NetIPAddress -IPAddress $primaryIP -InterfaceAlias $netInterface -SkipAsSource $false
Set-NetIPAddress -IPAddress $IPs.IPAddress -InterfaceAlias $netInterface -SkipAsSource $true
```

For Linux VMs with multiple IP addresses, follow the steps in [Add IP addresses to a Linux VM operating system](/azure/virtual-network/ip-services/virtual-network-multiple-ip-addresses-portal#linux-ubuntu-1416).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
