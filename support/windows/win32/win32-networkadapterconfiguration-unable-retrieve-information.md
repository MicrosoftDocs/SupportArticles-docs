---
title: Win32_NetworkAdapterConfiguration class is unable to retrieve information
description: This article provides a resolution for the problem where he Win32_NetworkAdapterConfiguration class is unable to retrieve information about PPPoE (Point-to-point protocol over Ethernet) and VPN (Virtual Private Network).
ms.date: 12/19/2023
ms.custom: sap:other
ms.reviewer: koichm
ms.topic: troubleshooting
ms.subservice: networking-dev
---

# The Win32_NetworkAdapterConfiguration class is unable to retrieve information about PPPoE (Point-to-point protocol over Ethernet) and VPN (Virtual Private Network)

This article helps you resolve the problem where he `Win32_NetworkAdapterConfiguration` class is unable to retrieve information about PPPoE (Point-to-point protocol over Ethernet) and VPN (Virtual Private Network).

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 2549091

## Symptoms

On Windows Vista and later, the `Win32_NetworkAdapterConfiguration` class is unable to retrieve information about a PPPoE connection and VPN connection.

If a program is designed to get the information about the dial-up connection or a virtual private network by using the `Win32_NetworkAdapterConfiguration` class on Windows XP, it may not work on Windows Vista and later.

For more information about the `Win32_NetworkAdapterConfiguration` class, see [Win32_NetworkAdapterConfiguration class](/windows/win32/cimwin32prov/win32-networkadapterconfiguration).

## Cause

On Windows Vista and later, the `Win32_NetworkAdapterConfiguration` class does not create an instance for a PPPoE connection or VPN connection.
Microsoft has confirmed that this to be a problem in our product.

## Resolution

On Windows Vista and later, you can retrieve almost the same information as the `Win32_NetworkAdapterConfigurationthe` class does regarding a PPPoE connection or VPN connection by using either of the following methods.
It would be highly appreciated if you consider that either of the following method is acceptable.

1. Use the .NET Framework `NetworkInterface` class.

    Use the `NetworkInterface.GetAllNetworkInterfaces` method to get a `NetworkInterface` array. Then, go through the `NetworkInterface` array to find a `NetworkInterface` instance that has the `NetworkInterface.NetworkInterfaceType` property set as Ppp. Each value of a PPPoE or VPN connection can be retrieved by referencing each property that this instance has.

    For more information on the `NetworkInterface` class or the sample code for this, see  [NetworkInterface Class](/dotnet/api/system.net.networkinformation.networkinterface).

    For more information on each property of the `NetworkInterface` class, see [NetworkInterface Class](/dotnet/api/system.net.networkinformation.networkinterface).

2. Use the `GetAdaptersAddresses` API.

    Use the `GetAdaptersAddresses` API to get the `IP_ADAPTER_ADDRESSES` structure. Then, go through the linked list of `IP_ADAPTER_ADDRESSES` structures to find an element that has the `IfType` member set as `IF_TYPE_PPP`. Each value of a PPPoE or VPN connection can be retrieved by referencing each member of the element.

    For more information on the `GetAdaptersAddresses` API or the sample code for this, see [GetAdaptersAddresses function (iphlpapi.h)](/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersaddresses).

    For more information on each member of the `IP_ADAPTER_ADDRESSES` structure, see  [IP_ADAPTER_ADDRESSES_LH structure (iptypes.h)](/windows/win32/api/iptypes/ns-iptypes-ip_adapter_addresses_lh).

## Steps to reproduce

```vb
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery _("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
```
