---
title: Cannot use different credentials for a network share
description: Describes an issue in which you receive error messages when you try to use user credentials to connect to a network share from a Windows-based computer. Workarounds are provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# The network folder specified is currently mapped using a different user name and password error

This article provides workarounds to solve the error messages that occur when you try to use different user credentials to connect to the other network share.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 938120

## Symptoms

Consider the following scenario:

- You have a Windows-based computer.
- There are two network shares on a remote server.
- You use user credentials to connect to one of the network shares. Then, you try to use different user credentials to connect to the other network share.

In this scenario, you receive this error message:

> The network folder specified is currently mapped using a different user name and password. To connect using a different user name and password, first disconnect any existing mappings to this network share.

If you select **OK** in response to the error message, you receive the following error message:

> Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again.

## Status

This behavior is by design.

## Workaround 1

Use the IP address of the remote server when you try to connect to the network share.

## Workaround 2

Create a different Domain Name System (DNS) alias for the remote server, and then use this alias to connect to the network share.

After you use one of these methods, you can use different user credentials to connect to the network share. In this situation, the computer behaves as if it is connecting to a different server.
