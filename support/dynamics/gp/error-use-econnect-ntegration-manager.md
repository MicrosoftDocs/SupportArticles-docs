---
title: Error when you use eConnect in Integration Manager
description: This article provides a resolution for a problem that occurs when you use eConnect for Dynamics GP 2010 or the eConnect destination adapter in Integration Manager.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message (There was an error writing to the pipe: The pipe is being closed) occurs on eConnect for Microsoft Dynamics GP 2010

This article helps you resolve the problem that occurs when you use eConnect for Dynamics GP 2010 or the eConnect destination adapter in Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2539263

## Symptoms

You may receive the following error message intermittently when you use eConnect for Dynamics GP 2010 or the eConnect destination adapter in Integration Manager:

> There was an error writing to the pipe: The pipe is being closed.

## Cause

The eConnect for Microsoft Dynamics GP 2010 Integration Service is a WCF service. A connection can remain inactive, during which no application messages are received, before it is dropped after 10 minutes. This is by default.

## Resolution

Add receiveTimeout="infinite"  to the Microsoft.Dynamics.GP.eConnect.Service.exe.config file for the eConnect Integration service. The binding section should resemble this:

```xml
<binding name="eConnectNamedPipeConfig" closeTimeout="00:10:00" sendTimeout="00:10:00" receiveTimeout ="infinite" transferMode="Buffered" hostNameComparisonMode="StrongWildcard" maxBufferPoolSize="2147483647" maxBufferSize="2147483647" maxReceivedMessageSize="2147483647"><readerQuotas maxDepth="60" maxStringContentLength="2147483647"maxArrayLength="2147483647" maxBytesPerRead="2147483647" maxNameTableCharCount="2147483647" /><security mode="Transport"><transport protectionLevel="EncryptAndSign" /></security>
</binding>
```

## More information

[Binding.ReceiveTimeout Property](/dotnet/api/system.servicemodel.channels.binding.receivetimeout)
