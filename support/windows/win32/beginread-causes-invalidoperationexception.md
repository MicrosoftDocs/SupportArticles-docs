---
title: BeginRead method causes exception
description: Lists the behavior that the NetworkStream.BeginRead method causes the InvalidOperationException exception.
ms.date: 03/12/2020
ms.custom: sap:Networking development
ms.reviewer: koichm
ms.technology: windows-dev-apps-networking-dev
---
# The BeginRead method causes the InvalidOperationException

This article helps you resolve the problem where the `NetworkStream.BeginRead` method causes the `InvalidOperationException` exception.

_Original product version:_ &nbsp; Microsoft .NET Framework  
_Original KB number:_ &nbsp; 2501751

## Symptoms

When a single `NetworkStream` object is used by multiple threads at the same time, calling the `BeginRead` method may cause the `InvalidOperationException` exception to be thrown.

## Cause

When a call to the `NetworkStream.close` method or `NetworkStream.Dispose` method of a `NetworkStream` object is being made, an attempt to call the `NetworkStream.BeginRead` method of the same `NetworkStream` object from another thread may throw the `InvalidOperationException` exception.

## Resolution

When `InvalidOperationException` is thrown, destroy the `NetworkStream` object.

## More information

It is by design behavior. For more information on the `NetworkStream.BeginRead` method, see [NetworkStream.BeginRead(Byte[], Int32, Int32, AsyncCallback, Object) Method](/dotnet/api/system.net.sockets.networkstream.beginread).
