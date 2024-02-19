---
title: Verify 6to4 adapter for DirectAccess server troubleshooting
description: This article dicsusses how to verify 6to4 adapter for DirectAccess server troubleshooting.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# Troubleshoot DirectAccess server console: 6to4

DirectAccess uses IPv6 transition protocols to enable clients to connect to the DirectAccess server when both the clients and server are communicating through the IPv4 protocol. If the DirectAccess server is in a perimeter or DMZ network behind an NAT device, only the IP-HTTPS IPv6 transition protocol is used. If the DirectAccess server is edge-facing and has public IPv4 addresses assigned to the external interface, the 6to4 and Teredo IPv6 transition protocols are also supported.

## Verify 6to4 adapter status

Typical errors about 6to4 that are reported on the console might indicate that forwarding or advertising isn't enabled. If you aren't using 6to4, these errors should only be graphical without any effect on the deployment.

The following command provides information about the interfaces and their indexes:

```console
netsh int ipv6 show int
```

See the second line, **Idx - 14**.

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

The following command provides the configuration for the 6to4 adapter.

```console
netsh int ipv6 show int "int idx for 6to4 Adapter"
```

See the second line, **Forwarding: disabled**.

```output
Interface 6to4 Parameters 
Forwarding: disabled 
Advertising: enabled 
Neighbor Discovery: enabled 
Neighbor Unreachability Detection: enabled 
Router Discovery: enabled
```

## Enable IPv6 forwarding or advertising

After you have information about the index, run the following command to enable forwarding:

```console
netsh int ipv6 set int 14 forwarding=enabled 
```

If you see that advertising is disabled, run the following command to enable it:

```console
netsh int ipv6 set int 14 forwarding=enabled
```
