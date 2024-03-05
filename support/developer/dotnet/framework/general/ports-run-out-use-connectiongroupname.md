---
title: Ports run out when using ConnectionGroupName
description: When you use a unique ConnectionGroup property of the System.Net.HttpWebRequest class of the .NET Framework 2.0 or 4.0, you may run out of available ports. Provides a resolution for this problem.
ms.date: 05/08/2020
ms.reviewer: pphadke, chrross
---
# You may run out of available ports when using the ConnectionGroupName property of the System.Net.HttpWebRequest class of the .NET Framework 2.0 or 4.0

This article helps you resolve the problem where you might run out of available ports when using the `ConnectionGroupName` property of the `System.Net.HttpWebRequest` class in Microsoft .NET Framework 2.0 or 4.0.

_Original product version:_ &nbsp; Microsoft .NET Framework 2.0, 4.0  
_Original KB number:_ &nbsp; 2551125

## Symptoms

You're using the `System.Net.HttpWebRequest` class in your application based on the .NET Framework 2.0 or 4.0. When making the HTTP request, you set the `ConnectionGroupName` property of the class to a unique name each time you use the class.

If you constantly keep sending requests to the SAME server with a unique `ConnectionGroupName` value set on the outgoing requests each time, and you don't allow the underlying `System.Net.ServicePoint` object associated with the requests to remain idle for the allowed idle time, you'll notice that the port usage from your application grows constantly and never drops.

This causes the underlying `System.Net.ServicePoint` object associated with the `HttpWebRequest` to create unique `ConnectionGroup`(s) and it ends up creating new `System.Net.Connection` for each such `ConnectionGroup`. These underlying `System.Net.Connection` objects are each associated with a unique winsock socket handle reference that remain open in the process until the `System.Net.ServicePoint` object is given a chance to remain idle for a finite amount of time. The default value of this time is 100 seconds and is governed by the `ServicePointManager.MaxServicePointIdleTime` property.

If the `ServicePoint` object is never kept idle and if it keeps creating new `ConnectionGroup`(s) and hence an underlying `System.Net.Connection` object, you'll notice that your application will soon run out of available socket space or port numbers. The immediate effect of this issue is that your application will no longer be able to create new `Connection` objects and start throwing an exception that says **An operation on a socket could not be performed because the system lacked sufficient buffer space or because a queue was full** which corresponds with the winsock error 10055 = WSAENOBUFS.

If you capture a hang dump file of your process during this symptom, you'll see many `System.Net.Sockets.Socket` objects, `System.Net.ConnectionGroup` objects and `System.Net.Connection` objects present in the dump file that have not been cleaned up by the garbage collector.

For example:

```console
0:000> !dumpheap -type System.Net.Sockets.Socket -stat
total Sock_Count objects
Statistics:
    MT     Count     TotalSize Class Name
<<MT>>     Sock_Count <<Size>> System.Net.Sockets.Socket
Total Sock_Count objects
0:000> !dumpheap -type System.Net.ConnectionGroup -stat
total Group_Count objects
Statistics:
    MT     Count TotalSize Class Name
<<MT>>     Group_Count <<Size>> System.Net.ConnectionGroup
Total Group_Count objects
0:000> !dumpheap -type System.Net.Connection -stat
total Conn_Count objects
Statistics:
    MT     Count TotalSize Class Name
<<MT>>     Conn_Count <<Size>> System.Net.Connection
Total Conn_Count objects
```

Where *Sock_Count*, *Group_Count* and *Conn_Count* is the count of the `Socket` objects, `ConnectionGroup` objects and the `Connection` objects respectively and will usually be a large number in thousands.

## Cause

The constant use of the same `ServicePoint` object to create unique `ConnectionGroup`(s) never allows the `ServicePoint` to remain idle, which causes the `ServicePoint` to never get a chance to clean up the underlying `System.Net.Connection` objects that have been idle for more than the allocated time (default 100 seconds).

Each `Connection` or `Socket` reserves a local port number, and when you reach the system limit (default 5000), you won't be able to make additional connections.

## Resolution

If you are running into this type of issue where you see many `System.Net.Connection` objects because of a constant creation of unique `ConnectionGroupName` property of the `HttpWebRequest` class, it's recommended that you limit the number of `ConnectionGroup`(s) to a limited number to prevent running out of available ports. Limiting the number of `ConnectionGroup`(s) will ensure that the maximum number of `Connections` that are being opened is restricted and doesn't increase beyond the available bounds.

Another alternative to prevent running into this scenario is to disable the HTTP Keep-Alive behavior of the `HttpWebRequest` class by setting the `KeepAlive` property to false. Disabling the HTTP Keep-Alive behavior will ensure that the underlying connection is closed once a request is serviced, which ensures that the socket reference is released immediately. This will in turn, clean up the `System.Net.Connection` and the `System.Net.Sockets.Socket` reference and not be dependent on the `ServicePoint` to have its idle timer expire.

You can also call the `System.Net.ServicePoint.CloseConnectionGroup` function periodically from your application that will release any old `Connection` or `Socket` references immediately. To use this function however, you will:

1. Need to retrieve the `ServicePoint` object associated with your current web server name.

2. Once you retrieve the `ServicePoint` object, call the `CloseConnectionGroup` function of the retrieved `ServicePoint` object and pass the names of whichever `ConnectionGroupName` you've created so far in your application and need to be cleaned up.

You can use the following code as an example:

```csharp
void CloseIdleConnectionGroups(String[] strGroups, String strURL)
{
    try
    {
        System.Net.ServicePoint oSP = System.Net.ServicePointManager.FindServicePoint(new Uri(strURL));

        foreach (String strGroup in strGroups)
        {
            oSP.CloseConnectionGroup(strGroup);
        }
    }
    catch (Exception oEx)
    {
        // handle the exception
    }
}
```

## References

- [HttpWebRequest.ConnectionGroupName Property](/dotnet/api/system.net.httpwebrequest.connectiongroupname?&view=netcore-3.1&preserve-view=true)

- [ServicePointManager.MaxServicePointIdleTime Property](/dotnet/api/system.net.servicepointmanager.maxservicepointidletime?&view=netcore-3.1&preserve-view=true)

- [HttpWebRequest Class](/dotnet/api/system.net.httpwebrequest?&view=netcore-3.1&preserve-view=true)

- [HttpWebRequest.KeepAlive Property](/dotnet/api/system.net.httpwebrequest.keepalive?&view=netcore-3.1&preserve-view=true)

- [ServicePoint.CloseConnectionGroup(String) Method](/dotnet/api/system.net.servicepoint.closeconnectiongroup?&view=netcore-3.1&preserve-view=true)

- [When you try to connect from TCP ports greater than 5000, you receive the error 'WSAENOBUFS (10055)'](https://support.microsoft.com/help/196271)
