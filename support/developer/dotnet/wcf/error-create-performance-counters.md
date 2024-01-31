---
title: Error when you create performance counters
description: This article provides resolutions for the error that occurs when you configure the WCF service to publish performance counters.
ms.date: 08/24/2020
ms.reviewer: amymcel
---
# Error when you create performance counters by using WCF service

This article helps you resolve the error that occurs when you configure the Windows Communication Foundation (WCF) service to publish performance counters.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 3058669

## Symptoms  

When you configure the WCF service to publish performance counters, some or all performance counters do not appear in the Performance Monitor (PerfMon) user interface. Additionally, you receive the following error message in the *svclog* file:

> Loading performance counters for the service failed. Performance counters will not be available for this service.

You can also receive the following warning message in the *svclog* file:

> Performance counter instance names may not be unique.

## Cause

This issue occurs because WCF uses the combination of service name, contract name, operation name, and URI as the instance name of the performance counter that it creates. When the name reaches a certain length, it is shortened by replacing a part of the name with a short hash value. When operation names are similar enough and have conflicting shortened hash values, WCF mistakenly tries to create two counter instances with the same instance name. This leads to an error in creating performance counters, and WCF does not provide performance counter information for that service.

## Resolution

There are two ways to resolve this issue:

- [Option one](#option-one) requires changing service, contract, or operation names to make sure that the counter instance names will not conflict. 
- [Option two](#option-two) does not require changing names. But it is available only for applications that are running the .NET Framework 4.6 or later versions, and it requires the user who hosts the service to have the permissions that are described in [Option two](#option-two).

## Option one

You can change the name of the service, contract, or operation to be either short enough or different enough. The instance name for an operation counter is `(ServiceName).(ContractName).(OperationName)@(first endpoint listener address)`. To avoid conflict, make sure that the name is shorter than 64 characters, or no operations in the service start with the same 13 characters.  
For example, assume that you have a service called `Service`, with a contract called `IService` and operations called `MyOperationName1` and `MyOperationName2` that are hosted at `http://mybusinessaddress.com/endpoint`. The counter instance names before shortening would be `Service.IService.MyOperationName1@http://mybusinessaddress.com/endpoint` and `Service.IService.MyOperationName2@http://mybusinessaddress.com/endpoint`. Both are shortened to `Service.IServi91.MyOperationNa78@39mybusinessaddress.com/endpoint`, and that causes a conflict. You could avoid this conflict by changing the operation names so that they do not start with the same 13 characters (for example, `OperationName1` and `MyOperationName2`). You could also avoid it by shortening another piece of the name, such as hosting the service at `http://mybusinessaddress.com/e`, to keep the instance name at 64 characters. In this manner, the counter instance name will not be shortened.

## Option two

When your application is running the .NET Framework 4.6 or later versions, you can enable a setting in WCF to make sure that the instance names are unique by appending a longer hash to the end of one instance name. You must do both of the following:

- Add the following line to the `appSettings` in your configuration file:

    ```xml
    <appSettings>
       <add key="wcf:ensureUniquePerformanceCounterInstanceNames" value="true" />
    </appSettings>
    ```

- Make sure that the user who hosts the service is either an administrator or a member of the Performance Monitor Users Windows user group.

> [!NOTE]
> The user who needs these permissions is hosting the WCF service. For example, in self-host scenarios, it is the user who is running the service. If the service is hosted through IIS, it is the [ApplicationPoolIdentity](https://www.iis.net/learn/manage/configuring-security/application-pool-identities)  user that has to be added to the user group.

When the `appSetting` is enabled and the user who hosts the service is not an administrator or in the user group that is described previously, WCF will ignore this setting, and emit the following warning in the *svclog* file:

> Performance counter instance names may not be unique

## More information

- [WCF Performance Counters](/dotnet/framework/wcf/diagnostics/performance-counters/)

- [Configuring Tracing](/dotnet/framework/wcf/diagnostics/tracing/configuring-tracing)
