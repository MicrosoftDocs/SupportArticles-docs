---
title: Performance issues when you call web services
description: This article provides help to solve the performance issues that occur when you make calls to web services from an ASP.NET application.
ms.date: 07/28/2020
ms.reviewer: tferrand, aaronba
ms.custom: sap:Performance
---
# Performance issues when you make calls to web services from an ASP.NET application

This article provides help to solve the performance issues that occur when you make calls to web services from a Microsoft ASP.NET application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 821268

## Symptoms

When you make calls to web services from an ASP.NET application, you may experience contention, poor performance, and deadlocks. Clients may report that requests stop responding or take a long time to execute. If a deadlock is suspected, the worker process may be recycled.

You may receive the following exception error message when you make a call to the `HttpWebRequest.GetResponse` method:

> "System.InvalidOperationException: There were not enough free threads in the ThreadPool object to complete the operation."

You may also receive the following exception error message in the browser:

> "HttpException (0x80004005): Request timed out."

> [!NOTE]
> This article also applies to applications that make `HttpWebRequest` requests directly.

## Cause

This problem might occur because ASP.NET limits the number of worker threads and completion port threads that a call can use to execute requests.

Typically, a call to a web service uses one worker thread to execute the code that sends the request and one completion port thread to receive the callback from the web service. However, if the request is redirected or requires authentication, the call may use as many as two worker threads and two completion port threads. So, you can exhaust the managed `ThreadPool` when multiple web service calls occur at the same time.

For example, suppose that the `ThreadPool` is limited to 10 worker threads and that all 10 worker threads are currently executing code that is waiting for a callback to execute. The callback can never execute, because any work items that are queued to the `ThreadPool` are blocked until a thread becomes available.

Another potential source of contention is the `maxconnection` parameter that the `System.Net` namespace uses to limit the number of connections. Generally, this limit works as expected. However, if many applications try to make many requests to a single IP address at the same time, threads may have to wait for an available connection.

## Resolution

To resolve these problems, you can tune the following parameters in the *Machine.config* file to best fit your situation:

- `maxWorkerThreads`
- `minWorkerThreads`
- `maxIoThreads`
- `minFreeThreads`
- `minLocalRequestFreeThreads`
- `maxconnection`
- `executionTimeout`

To successfully resolve these problems, take the following actions:

- Limit the number of ASP.NET requests that can execute at the same time to approximately 12 per CPU.
- Permit web service callbacks to freely use threads in the `ThreadPool`.
- Select an appropriate value for the `maxconnections` parameter. Base your selection on the number of IP addresses and AppDomains that are used.

> [!NOTE]
> The recommendation to limit the number of ASP.NET requests to 12 per CPU is a little arbitrary. However, this limit has proved to work well for most applications.

### MaxWorkerThreads and maxIoThreads

ASP.NET uses the following two configuration settings to limit the maximum number of worker threads and completion threads that are used:

```xml
<processModel maxWorkerThreads="20" maxIoThreads="20">
```

The `maxWorkerThreads` parameter and the `maxIoThreads` parameter are implicitly multiplied by the number of CPUs. For example, if you have two processors, the maximum number of worker threads is 2 \* `maxWorkerThreads`.

### MinFreeThreads and minLocalRequestFreeThreads

ASP.NET also contains the following configuration settings that determine how many worker threads and completion port threads must be available to start a remote request or a local request:

```xml
<httpRuntime minFreeThreads="8" minLocalRequestFreeThreads="8">
```

If there are not sufficient threads available, the request is queued until sufficient threads are free to make the request. So, ASP.NET will not execute more than the following number of requests at the same time:

(`maxWorkerThreads` \* number of CPUs) - `minFreeThreads`

> [!NOTE]
> The `minFreeThreads` parameter and the `minLocalRequestFreeThreads` parameter are not implicitly multiplied by the number of CPUs.

### MinWorkerThreads

ASP.NET also contains the following configuration setting that determines how many worker threads may be made available immediately to service a remote request.

```xml
<processModel minWorkerThreads="1">
```

Threads that are controlled by this setting can be created at a much faster rate than worker threads that are created from the Common Language Runtime (CLR)'s default thread-tuning capabilities.

This setting enables ASP.NET to service requests that may be suddenly filling the ASP.NET request queue due to a slow-down on a back-end server, a sudden burst of requests from the client end, or something similar that would cause a sudden rise in the number of requests in the queue.

The default value for the `minWorkerThreads` parameter is 1. We recommend that you set the value for the `minWorkerThreads` parameter to the following value:

`minWorkerThreads` = `maxWorkerThreads` / 2

By default, the `minWorkerThreads` parameter is not present in either the *Web.config* file or the *Machine.config* file. This setting is implicitly multiplied by the number of CPUs.

### Maxconnection

The `maxconnection` parameter determines how many connections can be made to a specific IP address. The parameter appears as follows:

```xml
<connectionManagement>
    <add address="*" maxconnection="2">
    <add address="http://65.53.32.230" maxconnection="12">
</connectionManagement>
```

If the application's code references the application by hostname instead of IP address, the parameter should appear as follows:

```xml
<connectionManagement>
    <add address="*" maxconnection="2">
    <add address="http://hostname" maxconnection="12">
</connectionManagement>
```

Finally, if the application is hosted on a port other than 80, the parameter has to include the non-standard port in the URL, similar to the below:

```xml
<connectionManagement>
    <add address="*" maxconnection="2">
    <add address="http://hostname:8080" maxconnection="12">
</connectionManagement>
```

The settings for the parameters that are discussed earlier in this article are all at the process level. However, the `maxconnection` parameter setting applies to the AppDomain level. By default, because this setting applies to the AppDomain level, you can create a maximum of two connections to a specific IP address from each AppDomain in your process.

### ExecutionTimeout

ASP.NET uses the following configuration setting to limit the request execution time:

```xml
<httpRuntime executionTimeout="90"/>
```

You can also set this limit by using the `Server.ScriptTimeout` property.

> [!NOTE]
> If you increase the value of the `executionTimeout` parameter, you may also have to modify the `processModel` `responseDeadlockInterval` parameter setting.

### Recommendations

The settings that are recommended in this section may not work for all applications. However, the following additional information may help you to make the appropriate adjustments.

If you are making one web service call to a single IP address from each ASPX page, Microsoft recommends that you use the following configuration settings:

- Set the values of the `maxWorkerThreads` parameter and the `maxIoThreads` parameter to **100**.
- Set the value of the `maxconnection` parameter to **12\*N** (where *N* is the number of CPUs that you have).
- Set the values of the `minFreeThreads` parameter to **88\*N** and the `minLocalRequestFreeThreads` parameter to **76\*N**.
- Set the value of `minWorkerThreads` to **50**. Remember, `minWorkerThreads` is not in the configuration file by default. You must add it.

Some of these recommendations involve a simple formula that involves the number of CPUs on a server. The variable that represents the number of CPUs in the formulas is *N*.

For these settings, if you have hyperthreading enabled, you must use the number of logical CPUs instead of the number of physical CPUs. For example, if you have a four-processor server with hyperthreading enabled, then the value of *N* in the formulas will be *8* instead of *4*.

> [!NOTE]
> When you use this configuration, you can execute a maximum of 12 ASP.NET requests per CPU at the same time because 100-88=12. Therefore, at least *88\*N* worker threads and *88\*N* completion port threads are available for other uses (such as for the web service callbacks).

For example, you have a server with four processors and hyperthreading enabled. Based on these formulas, you would use the following values for the configuration settings that are mentioned in this article.

```xml
<system.web>
    <processModel maxWorkerThreads="100" maxIoThreads="100" minWorkerThreads="50"/>
    <httpRuntime minFreeThreads="704" minLocalRequestFreeThreads="608"/>
</system.web>
<system.net>
    <connectionManagement>
        <add address="[ProvideIPHere]" maxconnection="96"/>
    </connectionManagement>
</system.net>
```

Also, when you use this configuration, 12 connections are available per CPU per IP address for each AppDomain. Therefore, in the following scenario, very little contention occurs when requests are waiting for connections, and the `ThreadPool` is not exhausted:

- The web hosts only one application (AppDomain).
- Each request for an ASPX page makes one web service request.
- All requests are to the same IP address.

However, when you use this configuration, scenarios that involve one of the below will probably use too many connections:

- Requests are to multiple IP addresses.
- Requests are redirected (302 status code).
- Requests require authentication.
- Requests are made from multiple AppDomains.

In these scenarios, it is a good idea to use a lower value for the `maxconnection` parameter and higher values for the `minFreeThreads` parameter and the `minLocalRequestFreeThreads` parameter.

## More information

For more information, see [Improving ASP.NET Performance](/previous-versions/msp-n-p/ff647787(v=pandp.10)).

If you are experiencing poor performance and contention on IIS together with ASP.NET, go to the following Microsoft blogs:

- [Thomas Marquardt's Blog](/archive/blogs/tmarq/)

- [WebTopics](/archive/blogs/webtopics/)
