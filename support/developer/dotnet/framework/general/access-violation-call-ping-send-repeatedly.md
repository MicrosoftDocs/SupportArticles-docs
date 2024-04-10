---
title: Access Violation when you call Ping.send
description: Describes a problem where Access Violation Exception may be thrown when you call the Ping.send method repeatedly. Provides workarounds.
ms.date: 03/23/2020
ms.reviewer: tomioy
---
# Access Violation exception may be thrown when you call the Ping.send method repeatedly

This article provides information about resolving a problem where an unexpected runtime error or **Access Violation** exception may be thrown when you call the `Ping.send` method repeatedly.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2533627

## Symptoms

When you create and destroy a `Ping` class object repeatedly, this may result in an unexpected runtime error such as **Access Violation** exception depending on the application configuration or when the `System.Net.NetworkInformation.Ping.Send` method is called.

For more information about the `Ping` class, see [Ping Class](/dotnet/api/system.net.networkinformation.ping?&view=netframework-4.8&preserve-view=true).

## Cause

When an application creates and destroys a `Ping` object repeatedly, some objects that are internally retained by the `Ping` class are recognized as a not referred object, that's then destroyed by the garbage collection mechanism. This may cause an unexpected runtime error or **Access Violation** exception depending on the implementation of the application or the timing of the `Ping.Send` method being called.

For example, with the implementation described below, it's likely that the runtime error occurs.

```csharp
static void Pinger()
{
    while(true)
    {
        System.Net.NetworkInformation.Ping objping = new System.Net.NetworkInformation.Ping();
        System.Net.NetworkInformation.PingReply objPingReply;
        objPingReply = objping.Send('127.0.0.1');
    }
}
```

You can work around this problem by using either of the following options.

## Workaround 1: Use the GC.KeepAlive method

Use `GC.KeepAlive` to tell the garbage collector not to destroy a `Ping` class object.

This prevents the `Ping` class and any class objects that it internally retains from being destroyed by the garbage collector until `GC.KeepAlive` exists. As a result, the cause of the problem is eliminated and the **Access Violation** exception can be avoided.

```csharp
static void Pinger()
{
    while(true)
    {
        System.Net.NetworkInformation.Ping objping = new System.Net.NetworkInformation.Ping(); 
        System.Net.NetworkInformation.PingReply objPingReply;
        objPingReply = objping.Send('127.0.0.1');
        GC.KeepAlive(objping);
    }
}
```

For more information about the `GC.KeepAlive` method, see [GC.KeepAlive(Object) Method](/dotnet/api/system.gc.keepalive?&view=netframework-4.8&preserve-view=true).

## Workaround 2: Change the implementation

Change the implementation so that it doesn't create and destroy a `Ping` class object repeatedly. To do this, create a single `Ping` class object outside a loop, and keep using the single object. This prevents a `Ping` class object from being created and destroyed repeatedly.

For example, write the code as below:

```csharp
static void Pinger()
{
    System.Net.NetworkInformation.Ping objping = new System.Net.NetworkInformation.Ping();
    System.Net.NetworkInformation.PingReply objPingReply;
    while(true)
    {
        objPingReply = objping.Send('127.0.0.1');
    }
}
```

## Workaround 3: Use .NET Framework 4.0

This problem doesn't occur with .NET Framework 4.0. We recommend updating your Visual Studio 2010 system so that you can use .NET Framework 4.0.
