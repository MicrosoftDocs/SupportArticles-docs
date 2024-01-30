---
title: Error when WCF service use net.tcp activation
description: This article provides resolutions for the error that occurs when Windows Communication Foundation service use net.tcp activation.
ms.date: 08/25/2020
---
# Error when Windows Communication Foundation service use net.tcp activation

This article helps you resolve the error that occurs when Windows Communication Foundation service use net.tcp activation.

_Original product version:_ &nbsp; .NET Framework, Windows Communication Foundation  
_Original KB number:_ &nbsp; 2026177

## Symptoms

Consider the following scenario in Microsoft .NET Framework:

- You run a Windows Communication Foundation (WCF) service with net.tcp activation.

- If the service takes longer than one minute to process a request from a client application, the following error is logged:  

    > Log Name: System  
    Source: SMSvcHost 3.0.0.0  
    Date:  
    Event ID: 8  
    Task Category: Sharing Service  
    Level: Error  
    Keywords: Classic
    User: LOCAL SERVICE
    Computer:
    Description: An error occurred while dispatching a duplicated socket: this handle is now leaked in the process.
    ID: 2620
    Source: System.ServiceModel.Activation.TcpWorkerProcess/33156464
    Exception: System.TimeoutException: This request operation sent to did not receive a reply within the configured timeout (00:01:00).
    The time allotted to this operation may have been a portion of a longer timeout.
    This may be because the service is still processing the operation or because the service was unable to send a reply message.
    Please consider increasing the operation timeout (by casting the channel/proxy to IContextChannel and setting the OperationTimeout property) and ensure that the service is able to connect to the client.

## Cause

This issue occurs because the SmSvcHost.exe process of the Net.TCP Port Sharing Service times out after one minute. The internal timeout value is one minute. When a request is sent to the service, the SmSvcHost.exe process creates a pipe binding to register new channels to communicate with the W3wp.exe process of Internet Information Services (IIS). The process requires one minute to create the pipe binding. Therefore, the process times out. The timeout can result from either of these conditions:

- High CPU: The CPU is near full utilization for an extended period of time. Hence, the target service isn't able to process requests fast enough.  

- Service Throttling: The Service is hitting a throttle inside of service model.  

- Service initialization takes longer than 1 minute.

## Resolution

- High CPU: The CPU is near full utilization for an extended period of time. Hence, the target service isn't able to process requests fast enough.  
Resolution: You need to modify your code, or add resources to prevent the high CPU condition.

- Service Throttling: The Service is hitting a throttle inside of service model.  
Resolution: Turn on warning/error traces for the target service to identify this problem. If your solution has multiple sessions active, or multiple concurrent calls, modify either the `MaxConcurrentSessions` `or MaxConcurrentCalls` to reduce the load.

- Service initialization takes longer than 1 minute.  
Resolution: Monitor your traces to see whether the Service application initialization is taking longer than one minute. See whether it's possible to modify the initialization logic to reduce this time, or use the Auto Start feature to initialize the service prior to the first client call.

## More information

- [Configure Auto-Start Using IIS Manager](/previous-versions/appfabric/ee677285(v=azure.10))

- [Configure Automatic Startup for an Application Pool (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772112(v=ws.10))
