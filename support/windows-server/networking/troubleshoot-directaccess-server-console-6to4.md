---
title: Verify 6to4 adapter for DirectAccess server troubleshooting
description: This article introduces how to verify 6to4 adapter for DirectAccess server troubleshooting.
ms.date: 01/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: asvaidya, anupamk
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DirectAccess Server console: 6to4

DirectAccess uses IPv6 transition protocols to enable clients to connect to the DirectAccess server when both are located on the IPv4 Internet. When the DirectAccess server is in a perimeter or DMZ network behind a NAT device, only the IP-HTTPS IPv6 transition protocol is used. When the DirectAccess server is edge facing with public IPv4 addresses assigned to the external interface, the 6to4 and Teredo IPv6 transition protocols are also supported.

## Verify 6to4 adapter status for troubleshooting

Typical errors on the console about 6to4 can say that forwarding or advertising isn't enabled. If you aren't using 6to4, these errors should only be graphical without any impact on the deployment.

The following command provides you with information of the interfaces and their index.

```console
netsh int ipv6 show int
```

See the second line, **Idx** 14.

```output
Idx       Met          MTU          State                 Name 
---   ----------   ----------   ------------   --------------------------- 
1        50        4294967295      connected   Loopback Pseudo-Interface 1 
14       45              1280      connected                  6TO4 Adapter 
15        5              1280      connected       isatap.{Interface Guid} 
16        5              1280      connected      isatap.{{Interface Guid}
17       50              1280      connected              IPHTTPSInterface 
12        5              1500      connected                      Internal 
13        5              1500      connected                      External
```

The following command shows you the configuration for 6to4 adapter.

```console
netsh int ipv6 show int "int idx for 6to4 Adapter"
```

See the second line **Forwarding: disabled**.

```output
Interface 6to4 Parameters 
Forwarding: disabled 
Advertising: enabled 
Neighbor Discovery: enabled 
Neighbor Unreachability Detection: enabled 
Router Discovery: enabled
```

## Enable IPv6 forwarding or advertising

Once we have the information on the index, we execute the following command to enable the forwarding.

```console
netsh int ipv6 set int 14 forwarding=enabled 
```

If you see advertising disabled, then you can issue the following command to enable advertising:

```console
netsh int ipv6 set int 14 forwarding=enabled
```
