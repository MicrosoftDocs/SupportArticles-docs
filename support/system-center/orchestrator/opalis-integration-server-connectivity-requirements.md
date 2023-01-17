---
title: Opalis Integration Server connectivity requirements
description: Describes the connectivity requirements for the various Opalis Integration Server components to interact with each other.
ms.date: 08/04/2020
ms.reviewer: jfanjoy
---
# Overview of Opalis Integration Server connectivity requirements

This article outlines the connectivity requirements for the various Opalis Integration Server components to interact with each other. If firewalls exist between the various components, rules may need to be introduced in your environment in order to allow the components to communicate.

_Original product version:_ &nbsp; System Center Orchestrator  
_Original KB number:_ &nbsp; 2299893

The core components of an Opalis Integration Server implementation are:

- Microsoft SQL Server
- Opalis Integration Server Management Server
- Opalis Integration Server Action Server
- Opalis Integration Server Client
- Opalis Integration Server Operator Console
- Opalis Integration Server Remote Trigger

## Microsoft SQL Server

The configured TCP port for the desired Microsoft SQL Server instance must be accessible to the following Opalis Integration Server components:

- Opalis Integration Server Management Server
- Opalis Integration Server Action Server
- Opalis Integration Server Operator Console

By default, Microsoft SQL Server's default instance listens on TCP port 1433. However, this can be changed by following the instructions in [Configure a Server to Listen on a Specific TCP Port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port).

## Opalis Integration Server Management Server

The Opalis Integration Server Management Server is a DCOM server that's exposed through the normal Windows Remote Procedure Call (RPC) interface. This will require that TCP port 135 and dynamic ephemeral ports are accessible by the following Opalis Integration Server components:

- Opalis Integration Server Client

RPC can be configured to limit the number of ephemeral ports that are exposed for the purposes of working with firewalls by following the instructions in [How to configure RPC dynamic port allocation to work with firewalls](https://support.microsoft.com/kb/154596).

## Opalis Integration Server Operator Console

The Opalis Integration Server Operator Console is a web server that by default listens on TCP port 5314 that must be accessible by the following Opalis Integration Server components:

- Opalis Integration Server Remote Trigger
- Web clients (such as Microsoft Internet Explorer)

## Deploying Opalis Integration Server components

Using the Opalis Integration Server Deployment Manager that's installed with the Opalis Integration Server Management Server requires the ability to access the computer where the Opalis Integration Server component(s) are to be installed via SMB/CIFS. As a result, TCP ports 135, 139 and 445 must be accessible on the target computer from the Opalis Integration Server Management Server.
