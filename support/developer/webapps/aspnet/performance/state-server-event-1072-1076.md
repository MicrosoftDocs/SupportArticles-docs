---
title: Event ID 1072 or 1076 on state servers
description: This article provides resolutions for the state server log Event ID 1072 or 1076.
ms.date: 03/25/2020
ms.custom: sap:Performance
ms.reviewer: V-KIMWA, VENKATC
---
# State server logs Event ID 1072 or Event ID 1076

This article helps you resolve the problem where log Events ID 1072 or 1076 on State servers.

_Original product version:_ &nbsp; Microsoft .NET Framework  
_Original KB number:_ &nbsp; 308097

## Symptoms

One of the events below appears in the Application Event log of the state server computer when using the state server mode of Session state in ASP.NET. This happens when either the Web server or the computer running the state server is under high stress.

> Event Type:Error  
> Event Source:ASP.NET 1.0.3306.0  
> Event Category:None  
> Event ID:1072  
> Date:9/12/2001  
> Time:4:00:25 PM  
> User:N/A  
> Computer: *ComputerName*  
> Description:  
> An error occurred in while processing a request in state server. Major callstack: EndOfRequest. Error code: 0x80072746

> [!NOTE]
> The version of the .NET Framework that is mentioned in the previous event message is a pre-release version of the .NET Framework 1.0.  

> Event Type:Error  
> Event Source:ASP.NET 1.0.3306.0  
> Event Category:None  
> Event ID:1076  
> Date:9/12/2001  
> Time:4:02:05 PM  
> User:N/A  
> Computer: *ComputerName*  
> Description:  
> The state server has closed an expired TCP/IP connection. The IP address of the client is 127.0.0.1. The expired Read operation began at 09/12/2001 16:02:00.

> [!NOTE]
> The version of the .NET Framework that is mentioned in the previous event message is a pre-release version of the .NET Framework 1.0.

> Event Type: Error  
> Event Source: ASP.NET 1.1.4322.0  
> Event Category: None  
> Event ID: 1078  
> Date: 10/6/2005  
> Time: 11:03:47 AM  
> User: N/A  
> Computer: *ComputerName*  
> The state server has closed an expired TCP/IP connection. The IP address of the client is 127.0.0.1. The expired Read operation began at 10/06/2005 11:03:25.

## Cause

When using the state server mode of Session state in ASP.NET, the ASP.NET Web server process in the Web server communicates with the state server by using WinSocket over Transmission Control Protocol/Internet Protocol (TCP/IP). By default, the Web server process sets the time-out value of all send and receive TCP/IP operations to 10 seconds. Similarly, the state server also times out all send and receive TCP/IP operations after 10 seconds.

However, if the Web server or the state server is under high CPU utilization (close to 100 percent), a TCP/IP operation can take more than 10 seconds and thus is canceled before completion. As a result, one of the above-mentioned events is logged, and the originating client request fails. The state server logs event ID 1072 if the ASP.NET Web server process times out a TCP/IP operation. If the state server times out a TCP/IP operation, the state server logs event ID 1076.

## Resolution

To modify the TCP/IP operation time-out value for the ASP.NET Web server process, change the following attribute in the *Machine.config* file (or specify the following attribute in the *Web.config* file for any Web application).

```xml
 <sessionState
    stateNetworkTimeout="10"
 />
```

Here's how to modify the TCP/IP operation time-out value for the state server:

1. Stop the ASP.NET state server service.
2. Select **Start**, select **Run**, type *Regedt32.exe*, and then select **OK** to start Registry Editor.
3. Locate the following key in the registry:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\aspnet_state\Parameter`
4. Add a DWORD value that is named *SocketTimeout*. Set a positive integer to represent the new TCP/IP timeout in seconds.
5. Quit the Registry Editor.
6. Restart the ASP.NET state server service.

For users who experience the problems that are mentioned in the [Symptoms](#symptoms) section, use these methods to increase the time-out values on the state server and on all Web servers to 20 seconds.

> [!NOTE]
> If the state server isn't running when you increase the time-out values on the Web server, the client request times out after *n* seconds, where *n* equals a new timeout value, instead of the default 10 seconds.
