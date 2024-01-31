---
title: Windows Connection Manager disconnects WLAN
description: This article describes an issue in which the WLAN is disconnected if a VPN connection is established.
ms.date: 10/19/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
ms.subservice: networking
---
# Windows Connection Manager disconnects WLAN if a VPN connection is established

This article provides a resolution for the issue that Windows Connection Manager disconnects WLAN if a VPN connection is established.

_Applies to:_ &nbsp; Windows 8 Pro  
_Original KB number:_ &nbsp; 2919900

## Symptom

Consider the following scenario:  

- You start a Windows 8 client. It connects automatically to a WLAN.
- You establish a Virtual Private Network (VPN) connection on the Windows 8 client.
- About 20 seconds after the VPN tunnel is established successfully, the WLAN connection is disconnected.

## Cause

This issue occurs because the VPN Adapter is registered as an Ethernet adapter.

To check this, open registry editor, and then browse to this key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\xxxx`

`"*IfType"=dword:00000006 ==> IF_TYPE_ETHERNET_CSMACD`

> [!Note]  
> xxxx corresponds to the number below that you can find the name of your VPN Adapter. If the value for IfType equals to 6, the Adapter is considered an Ethernet Adapter.

Starting with Windows 8, the WCMSVC (Windows Connection Manager) disconnects the WLAN connection because an Ethernet Adapter is seen as more reliable and provides better performance compared to a WLAN connection. These items are taken into account during the decision:

- Adapter type, Ethernet, wireless, virtual
- Does an adapter hold the default gateway and default route?
- Does Network Connectivity Status Indicator (NCSI) probe that the adapter is successfully connected to the Internet?
- Is the client's domain reachable on the adapter?

## Resolution

Configure the Windows Connection Manager GPO to "Disabled" by using Group Policy or locally.

1. Open Local Group Policy Editor, and then go to Computer Configuration\Administrative Templates\Network\Windows Connection Manager
2. Change the Setting of **Minimize the number of simultaneous connections to the Internet or a Windows Domain** to "disabled"

## More information

Alternatively you could change the IfType of the VPN interface to a value different from Ethernet.  

> [!NOTE]
> Changing this setting may have some side effects on the functionality of the VPN Adapter. Contact the manufacturer of the VPN Client to get more information.

The values for different Adapter types can be found here:  
[https://msdn.microsoft.com/library/aa814491(VS.85).aspx](https://msdn.microsoft.com/library/aa814491%28vs.85%29.aspx)  
[https://msdn.microsoft.com/library/windows/hardware/ff565767(v=vs.85).aspx](https://msdn.microsoft.com/library/windows/hardware/ff565767%28v=vs.85%29.aspx)  

Suitable values for VPN adapters are:

`IF_TYPE_PROP_VIRTUAL 53 (0x35) Proprietary virtual/internal`

`IF_TYPE_TUNNEL 131 (0x83) Encapsulation interface`
