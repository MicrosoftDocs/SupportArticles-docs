---
title: SocketException when WCF use connection pooling
description: This article describes you receive a SocketException when Windows Communication Foundation application uses connection pooling.
ms.date: 08/24/2020
ms.reviewer: broder, jasonpa
ms.topic: article
---
# You receive a SocketException when using WCF connection pooling

This article describes you receive a `SocketException` when Windows Communication Foundation (WCF) application uses connection pooling.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2607014

## Summary

A WCF application that uses connection pooling may experience socket exceptions when connections are returned to the connection pool. If you turn on WCF tracing, you will see an event similar to the following:

```xml
<TraceRecord xmlns="[https://schemas.microsoft.com/2004/10/E2ETraceEvent/TraceRecord](https://schemas.microsoft.com/2004/10/e2etraceevent/tracerecord)" Severity="Information">
   <TraceIdentifier>http://msdn.microsoft.com/en-US/library/System.ServiceModel.Channels.ConnectionPoolIdleTimeoutReached.aspx</TraceIdentifier>
   <Description>A connection has exceeded the idle timeout of this connection pool (00:02:00) and been closed.</Description>
   <AppDomain>/LM/W3SVC/1/ROOT/QSPolicy-1-129558237523483320</AppDomain>
   <Source>System.ServiceModel.Channels.IdlingCommunicationPool`2+IdleTimeoutEndpointConnectionPool+IdleTimeoutIdleConnectionPool[System.String,System.ServiceModel.Channels.IConnection]/5317080</Source>
</TraceRecord>
```

## More information

When a WCF client tries to open a new connection the `System.ServiceModel` code attempts to get a connection from the connection pool. In some cases, the connection pool connection may have timed out. A graceful exit is attempted by trying to read from the connection. If the WCF server connection has timed out and its connection reset, then when the WCF client tries to read from the connection it will get an error and a `SocketException` is raised. This `SocketException` is raised in `Sytem.Net` code and is handled by the `System.ServiceModel` code. The client connection is then closed. Because this exception is handled in the `System.ServiceModel` code and does not get rethrown back to application code this exception can be ignored.

If you attach a debugger and break when the  gets raised, you will observer a managed call stack similar to the following:

> 0:040> !clrstack
OS Thread Id: 0x16a8 (40)
ESP EIP
1df4dc98 76e1c83b [HelperMethodFrame: 1df4dc98]
1df4dd3c 6de87ada System.Net.Sockets.Socket.BeginReceive(Byte[], Int32, Int32, System.Net.Sockets.SocketFlags, System.AsyncCallback, System.Object)
1df4dd68 6986ea7e System.ServiceModel.Channels.SocketConnection.BeginReadCore(Int32, Int32, System.TimeSpan, System.Threading.WaitCallback, System.Object)
1df4dde0 6986de7d System.ServiceModel.Channels.SocketConnection.CloseAsyncAndLinger()
1df4de2c 6986eea4 System.ServiceModel.Channels.SocketConnection.Close(System.TimeSpan, Boolean)
1df4de84 6984e721 System.ServiceModel.Channels.BufferedConnection.Close(System.TimeSpan, Boolean)
1df4dec4 69855cb8 System.ServiceModel.Channels.ConnectionPool.CloseItemAsync(System.ServiceModel.Channels.IConnection, System.TimeSpan)
1df4ded4 697f0be8 System.ServiceModel.Channels.IdlingCommunicationPool`2+IdleTimeoutEndpointConnectionPool[[System.__Canon, mscorlib],[System.__Canon, mscorlib]].CloseItemAsync(System.__Canon, System.TimeSpan)
1df4def0 697f095c System.ServiceModel.Channels.CommunicationPool`2+EndpointConnectionPool[[System.__Canon, mscorlib],[System.__Canon, mscorlib]].CloseIdleConnection(System.__Canon, System.TimeSpan)
1df4df34 69c44ddd System.ServiceModel.Channels.CommunicationPool`2+EndpointConnectionPool[[System.__Canon, mscorlib],[System.__Canon, mscorlib]].TakeConnection(System.TimeSpan)
1df4dfa0 6918280b System.ServiceModel.Channels.ConnectionPoolHelper.EstablishConnection(System.TimeSpan)
1df4e054 69182607 System.ServiceModel.Channels.ClientFramingDuplexSessionChannel.OnOpen(System.TimeSpan)
1df4e098 690f1c16 System.ServiceModel.Channels.CommunicationObject.Open(System.TimeSpan)
1df4e0dc 691923f2 System.ServiceModel.Channels.ServiceChannel.OnOpen(System.TimeSpan)
1df4e0f0 690f1c16 System.ServiceModel.Channels.CommunicationObject.Open(System.TimeSpan)
1df4e134 690f1af2 System.ServiceModel.Channels.CommunicationObject.Open()
