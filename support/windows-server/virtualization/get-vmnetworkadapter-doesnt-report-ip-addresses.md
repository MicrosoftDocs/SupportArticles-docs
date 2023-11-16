---
title: Get-VMNetworkAdapter command does not report IP addresses
description: Describes a problem in which the output of the `Get-VMNetworkAdapter` command doesn't contain the IP addresses that are associated with the specified adapter.
ms.date: 05/05/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:virtual-machine-state, csstroubleshoot
ms.technology: hyper-v
keywords: Get-VMNetworkAdapter
---

# Get-VMNetworkAdapter command doesn't report IP addresses

This article describes a problem in which the output of the `Get-VMNetworkAdapter` command doesn't contain the IP addresses that are associated with the specified adapter.

_Applies to:_ &nbsp; Windows Server (all versions)

## Symptoms

You run the [:::no-loc text="Get-VMNetworkAdapter":::](/powershell/module/hyper-v/get-vmnetworkadapter) PowerShell command at a command prompt on a virtual machine. For example, you run the following command:

```powershell
PS C:\> Get-VMNetworkAdapter -VMName clu3vm1
```

The command output resembles the following:

```output
Name            IsManagementOs VMName  SwitchName MacAddress   Status IPAddresses
----            -------------- ------  ---------- ----------   ------ -----------
Network Adapter False          CLU3VM1 Public     00155D081704 {Ok}   {}
```

Instead of containing the expected data, the **:::no-loc text="IPAddress":::** column of the table is empty.

To troubleshoot this problem, first verify that the Key-Value Pair Exchange Integration Service is enabled. To do this, run the following command:

```powershell
PS C:\> (Get-VM -VMName clu3vm1).VMIntegrationService
```

```output
VMName  Name                    Enabled PrimaryStatusDescription SecondaryStatusDescription
------  ----                    ------- ------------------------ --------------------------
CLU3VM1 Guest Service Interface False   OK
CLU3VM1 Heartbeat               True    OK                       OK
CLU3VM1 Key-Value Pair Exchange True    OK
CLU3VM1 Shutdown                True    OK
CLU3VM1 Time Synchronization    True    OK
CLU3VM1 VSS                     True    OK
```

If the Key-Value Pair Exchange service isn't enabled, enable it, and then run `Get-VMNetworkAdapter` again. If the IP address information is still missing, and the service is enabled, the `NetTCPIP` WMI provider is probably missing from the virtual machine. At the command prompt, run the `Get-WmiObject` command on the `Root\\Standardcimv2` namespace, as follows:

```powershell
PS C:\> Get-WmiObject -Namespace "root\standardcimv2" -Class __Win32Provider | select __NAMESPACE, Name
```

The output resembles the following example. Notice that `ROOT\Standardcimv2 NetTCPIP` is missing.

```output
__NAMESPACE        Name
-----------        ----
ROOT\Standardcimv2 NetEventPacketCapture
ROOT\Standardcimv2 MSFT_Printer
ROOT\Standardcimv2 NetTtCim
ROOT\Standardcimv2 MsNetImPlatform
ROOT\Standardcimv2 NetDaCim
ROOT\Standardcimv2 NlmCim
ROOT\Standardcimv2 netnat
ROOT\Standardcimv2 wfascim
ROOT\Standardcimv2 NetSwitchTeam
ROOT\Standardcimv2 NetAdapterCim
ROOT\Standardcimv2 dnsclientcim
ROOT\Standardcimv2 NetQosCim
ROOT\Standardcimv2 NetPeerDist
ROOT\Standardcimv2 NetNcCim 
```

Additionally, use `Get-WmiObject` to view the attributes of the [:::no-loc text="MSFT_NetIPInterfaceAdapter":::](/previous-versions/windows/desktop/nettcpipprov/msft-netipinterfaceadapter) class, as follows:

```powershell
PS C:\> Get-WmiObject -Namespace "root\standardcimv2" -Class "MSFT_NetIPInterfaceAdapter"
```

Instead of the response that you expect, the output that resembles the following example:

```output
Get-WmiObject : Invalid class "MSFT_NetIPInterfaceAdapter"
At line:1 char:1
+ Get-WmiObject -Namespace "root\Standardcimv2" -Class "MSFT_NetIPInter ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidType: (:) [Get-WmiObject], ManagementException
    + FullyQualifiedErrorId : GetWMIManagementException,Microsoft.PowerShell.Commands.GetWmiObjectCommand
```

## Cause

The [:::no-loc text="NetTCPIP":::](/powershell/module/nettcpip) WMI provider isn't installed in the guest operating system (the virtual machine).

## Resolution

On the virtual machine, open an elevated Command Prompt window, and then change to the :::no-loc text="%SystemRoot%\\System32\\wbem"::: folder. At the command prompt, run the following commands:

```console
C:\Windows\System32\wbem>regsvr32.exe NetTCPIP.dll

C:\Windows\System32\wbem>mofcomp.exe NetTCPIP.mof
```

You should see the following output:

```output
Microsoft (R) MOF Compiler Version 10.0.14393.0
Copyright (c) Microsoft Corp. 1997-2006. All rights reserved.
Parsing MOF file: NetTCPIP.mof
MOF file has been successfully parsed
Storing data in the repository...
Done!
```
