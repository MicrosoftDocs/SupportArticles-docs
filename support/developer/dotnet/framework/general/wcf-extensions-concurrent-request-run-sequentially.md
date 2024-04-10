---
title: WCF extensions force concurrent operations to run sequentially
description: This article describes a .NET Framework-based problem in which custom WCF extensions force concurrent operations to run sequentially. Therefore, you may experience client time-outs or long latency periods. Provides a resolution.
ms.date: 05/08/2020
ms.reviewer: amymcel, mconnew
---
# Custom WCF extensions force concurrent operations to run sequentially

This article describes that you may experience client time-outs or long latency periods because custom WCF extensions force concurrent operations to run sequentially, and provides a resolution.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 2907010

## Symptoms

Consider the following scenario:

- You have the Windows Communication Foundation (WCF) service configured to handle multiple concurrent requests.
- You have custom implementations of any of the following WCF extensions:
  - `ServiceAuthenticationManager`
  - `ServiceAuthorizationManager`
  - `IDispatchMessageInspector`
  - `IDispatchOperationSelector`

- These implementations are computationally expensive, or they occasionally incur long latency periods.
- Concurrent service operations seem to run sequentially, or clients time out.

If you have experienced client time-outs or long response times that appear unrelated to the server's load in this scenario, you may be using these custom WCF extensions in a way that triggers this issue.

Additionally, you may experience a situation in which one request delays other requests. Then, many requests may finish suddenly before another request again delays other requests. You can view this behavior by using the `ServiceModelService` Calls Per Second counter in Performance Monitor. When this behavior occurs, the count may drop to zero while the extension code runs, even with multiple concurrent requests outstanding. When the extension code returns control to WCF, the counter returns to its typical level until the next delay in the extension code again drops it to zero.

## Cause

This problem occurs because WCF invokes these specific extensibility points synchronously, early in the message-handling pipeline. Delays in these extensibility points can block that pipeline. This prevents concurrent execution of service operations. Messages that are received during this time are queued but not serviced until after those extensibility points return control to WCF.

This causes the service operations to run one at a time, not at the same time. Each request waits in line for the previous one to finish executing those extensibility points. If the latency is high enough, the latest requests may time out while they wait for the earlier requests to finish.

Here are the specific extensibility methods that are affected:

- Microsoft .NET Framework 4.5 and .NET Framework 4.0:
  - `ServiceAuthenticationManager.Authenticate()`
- .NET Framework .NET Framework 4.5, .NET Framework 4.0, .NET Framework 3.5, and .NET Framework 3.0:
  - `ServiceAuthorizationManager.CheckAccessCore()`
  - `IDispatchMessageFormatter.AfterReceiveRequest()`
  - `IDispatchOperationSelector.SelectOperation()`

## Resolution

To resolve this problem, use one of the following methods:

- Minimize the latency of these extensibility points.
- Move the high-latency overhead elsewhere in the pipeline.
- Use a different WCF binding.

There are some common practices that could lead to high latency from these extensibility points:

- Accessing a database, especially on another tier
- Invoking other services on another tier
- Using a large volume of memory or threads
- Doing computationally expensive work

If this high-latency work is required, it should be moved out of these extensibility points. For example, if this work is performed inside the service operation itself, it will let multiple operations run at the same time.

This behavior may also depend on the capabilities of the binding that's used for the endpoint. For example, `BasicHttpBinding` exhibits this behavior, whereas `WsHttpBinding` doesn't.

## References

- [ServiceAuthenticationManager class](/dotnet/api/system.servicemodel.serviceauthenticationmanager?&view=netframework-4.8&preserve-view=true)

- [ServiceAuthorizationManager class](/dotnet/api/system.servicemodel.serviceauthorizationmanager?&view=netframework-4.8&preserve-view=true)

- [IDispatchMessageInspector interface](/dotnet/api/system.servicemodel.dispatcher.idispatchmessageinspector?&view=netframework-4.8&preserve-view=true)

- [IDispatchOperationSelector interface](/dotnet/api/system.servicemodel.dispatcher.idispatchoperationselector?&view=netframework-4.8&preserve-view=true)

- [ConcurrencyMode property](/dotnet/api/system.servicemodel.servicebehaviorattribute.concurrencymode?&view=netframework-4.8&preserve-view=true)

- [BasicHttpBinding class](/dotnet/api/system.servicemodel.basichttpbinding?&view=dotnet-plat-ext-3.1&preserve-view=true)

- [WSHttpBinding class](/dotnet/api/system.servicemodel.wshttpbinding?&view=dotnet-plat-ext-3.1&preserve-view=true)

- [WCF performance counters](/dotnet/framework/wcf/diagnostics/performance-counters/)
