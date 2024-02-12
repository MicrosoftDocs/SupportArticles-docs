---
title: RemotingException when using binary format
description: Works around a problem in which a RemotingException exception occurs when .NET Remoting receives a binary formatted custom message.
ms.date: 05/08/2020
ms.reviewer: zhenlwa
---
# RemotingException is thrown when .NET Remoting receives a binary formatted custom message

This article resolves RemotingException that the sending application receives when Microsoft .NET Remoting receives a binary formatted custom message.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 2935795

## Symptoms

Consider the following scenario:

- You use Microsoft .NET Remoting to establish communication between applications.
- You use binary format to serialize the messages.
- An application sends a custom message type that's derived from the `MarshalByRefObject` object.

In this scenario, the sending application receives a `RemotingException` exception. This exception contains a `NotSupportedException` inner exception and the link `https://go.microsoft.com/fwlink/?linkid=390633`.

## Cause

This issue occurs because .NET Remoting rejects custom messages that are derived from the `MarshalByRefObject` when you use binary format. This is default behavior for the following versions of the Microsoft .NET Framework:

- .NET Framework 1.1
- .NET Framework 2.0
- .NET Framework 3.0
- .NET Framework 3.5
- .NET Framework 4.0
- .NET Framework 4.5

## Workaround

To configure .NET Remoting in order to accept custom `MarshalByRefObject` messages, follow these steps:

1. When you call `ChannelServices.RegisterChannel()` function, set the `ensureSecurity` argument to `true`. This makes sure that your remoting channel is secure.
2. Set the value of `microsoft:Remoting:AllowTransparentProxyMessage` key to `true` in the *Web.config* file or *App.config* file of the application that receives this custom message, as in the following example:

```xml
<configuration>
    <appSettings>
        <add key="microsoft:Remoting:AllowTransparentProxyMessage" value="true"/>
    </appSettings>
</configuration>
```

> [!NOTE]  
> If this `<appSettings>` configuration is absent or if it contains a value other than `true`, .NET Remoting will use the default behavior and throw a `RemotingException` when this kind of message is received.

## References

- [\<appSettings> Element](/previous-versions/dotnet/netframework-1.1/aa903313(v=vs.71))

- [The appSettings element (General Settings schema)](/previous-versions/dotnet/netframework-4.0/ms228154(v=vs.100))

- [Summary for the RegisterChannel method](/dotnet/api/system.runtime.remoting.channels.channelservices.registerchannel?&view=netframework-4.8&preserve-view=true)

- [Authentication with the HTTP Channel](/previous-versions/dotnet/netframework-4.0/36tfwzb0(v=vs.100))

- [Authentication with the TCP Channel](/previous-versions/dotnet/netframework-4.0/59hafwyt(v=vs.100))

- [Authentication with the IPC Channel](/previous-versions/dotnet/netframework-4.0/ms172351(v=vs.100))
