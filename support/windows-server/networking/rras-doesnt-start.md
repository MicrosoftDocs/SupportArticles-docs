---
title: Routing and Remote Access service doesn't start when there's no network connectivity
description: Describes that the Routing and Remote Access service doesn't start if there's no network connectivity.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, aanandr
ms.custom:
- sap:network connectivity and file sharing\remote access (vpn,rras,cmak and aovpn)
- pcy:WinComm Networking
---
# The Routing and Remote Access service doesn't start when there's no network connectivity

This article provides a solution to an issue where the Routing and Remote Access service (RRAS) doesn't start when there's no network connectivity.

_Original KB number:_ &nbsp; 973990

## Symptoms

On a Windows system, the Routing and Remote Access service (RRAS - service name: RemoteAccess) doesn't start when there's no network connectivity. For example, RemoteAccess doesn't start when all wired network connectivity is unplugged or when wireless connectivity is shut off.

Additionally, you can't create new incoming connections when there's no network connectivity. This is because incoming connections require that RemoteAccess is started.

## Cause

When RemoteAccess starts, it tries to initialize certain functions in Internet Authentication Service (IAS) for authentication. The IAS initialization fails when there's no network connectivity. Therefore, RemoteAccess doesn't start. IAS initialization failure is by design when there is no network connectivity. Then, you see the behavior that is mentioned in the [Symptoms](#symptoms) section.  
That behaviour is independent from the installation of the Network Policy Server (NPS), the successor of IAS.

## Workaround

To start RemoteAccess to create a new incoming connection, your computer needs to be connected to a network. After RemoteAccess starts, you can still create a new incoming connection after you disconnect from the network.

To check the status of RemoteAccess, check the state of the RemoteAccess service (Routing and Remote Access) under the **Services** tab in Windows Task Manager.

## Status

This behavior is by design.
The RemoteAccess service is disabled on Windows server and client versions by default.
