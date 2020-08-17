---
title: Socket.Select doesn't block as expected
description: The Socket.Select method of the .NET 2.0 framework returns immediately and doesn't block as expected when an infinite timeout value of -1 is specified.
ms.date: 06/17/2020
ms.prod-support-area-path: 
ms.reviewer: chrross, dshulman
---
# The Socket.Select method returns immediately and doesn't block as expected when an infinite timeout value of -1 is specified

This article helps you resolve the problem that the `Socket.Select` method of the Microsoft .NET 2.0 framework returns immediately and doesn't block as expected when an infinite timeout value of `-1` is specified.

_Original product version:_ &nbsp; .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2615314

## Symptoms

You're developing a sockets-based application by using the `System.Net.Sockets.Socket.Select` method. When you provide an infinite value for the timeout by specifying a value `-1`, you'll experience that the `Socket.Select` call returns immediately and doesn't block as expected. It occurs even if there are no sockets that meet the requested criteria of read, write, or error. This issue only happens for applications based on the .NET 2.0 framework.

If you target this same application to run with the .NET 4.0 framework, the `Socket.Select` call behaves as expected when the timeout parameter is set to `-1` indicating an infinite timeout.

## Cause

It happens because when the timeout is set to `-1`, the `Socket.Select` method of the .NET 2.0 framework doesn't correctly disable the timeout when calling into the Winsock `select` function. The .NET 4.0 version of the `Socket.Select` method has however been changed to behave as expected.

## Resolution

To work around this problem, applications that are targeted to run with the .NET 2.0 framework are recommended to set a high value of a timeout such as `System.Int32.MaxValue` to mimic an infinite timeout.

Applications that are targeted to run with the .NET 4.0 framework don't need to use the workaround and can continue to use a value of `-1` to indicate an infinite timeout and behave as expected.

## References

[Socket.Select(IList, IList, IList, Int32) Method](/dotnet/api/system.net.sockets.socket.select)
