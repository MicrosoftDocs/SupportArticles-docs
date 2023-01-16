---
title: Use session request types to control access
description: This article describes how to use session request types to control access to TN3270 sessions.
ms.date: 10/13/2020
ms.custom: sap:Network integration (SNA gateway)
ms.topic: how-to
---
# Use session request types to control access to TN3270 sessions

This article describes how to use session request types to control access to TN3270 sessions.

_Original product version:_ &nbsp; TN3270 server  
_Original KB number:_ &nbsp; 259910

## Summary

You can control the access to TN3270 resources (LUs and/or Pools) when you configure which TCP/IP addresses, subnets, or workstation names that have access to the resources.

An alternative method is available that allows administrators to set up a "default" TN3270 resource for TN3270 clients, while they control access to the resource without the use of the methods described in the referenced article.

## More information

The TN3270 server, included with SNA Server, supports the following two types of session requests:

- Generic
- Specific

If a TN3270 client specifies a blank device name, the TN3270 server views this as a generic request. Generic session requests are satisfied by any of the display LUs/Pools that are assigned to the TN3270 server as generic displays. LUs/Pools configured to be generic displays constitute the TN3270 server's default pool of display LUs/Pools. Resources assigned to the TN3270 server are configured as generic resources by default.

Display LUs/Pools assigned to the TN3270 server can be configured as "specific displays." Resources configured as "specific" are accessed by TN3270 clients that explicitly request the resources by name.

ITN3270 clients that specify an invalid TN3270 LU/Pool name cannot connect to any TN3270 session. The TN3270 clients that specify an invalid TN3270 LU/Pool name cannot connect to any TN3270 session.

> [!NOTE]
> This information also applies to printer sessions assigned to the TN3270 server. Printers can be "associated printers." Associated printers are print sessions associated with a display session. (This means that a TN3270 client is allocated the print session at the same time it is allocated the display session.)

Configuring TN3270 LUs/Pools as specific or generic to control access is used in environments where some TN3270 clients (for example, managed clients) require the use of specific TN3270 resources, while other clients (for example, unmanaged clients), should connect to "default" TN3270 resources.

The following is a method to configure TN3270 resources to control access though the use of specific and generic LU types:

- Assign the managed users' resources to the TN3270 server as "specific displays," either individually assigned or grouped together into pools of interchangeable resources. The managed users' TN3270 emulators are configured to specify their required device name (for example, LU/Pool name).

- Assign the unmanaged users' resources to the TN3270 server as "generic displays" (for example, the Default Pool). Unmanaged users who do not know or care which resource they should use, can leave the device name blank in their TN3270 emulator when connecting to the TN3270 server.TN3270 clients that enter an invalid device name are not allowed access to any TN3270 resources.

TN3270 clients that enter a valid device name are allowed access to the specified TN3270 resource whether the resource is configured as specific or generic. TN3270 clients can access generic resources either when entering a valid device name or when leaving the device name blank.

The following steps describe how to check or change the session type for TN3270 sessions:

1. Open the SNA Server Manager.
2. Select the TN3270 folder under the appropriate SNA Server.
3. Right-click, and then select Properties on a resource assigned to the TN3270 server.
4. Select the TN3270 tab.
5. Select the appropriate display or printer type in the Type section of the TN3270 session properties.
