---
title: WCF service may scale up slowly under load
description: This article provides resolutions for the error that occurs where WCF service may scale up slowly under load.
ms.date: 08/24/2020
ms.reviewer: davidlam, smason
---
# WCF service may scale up slowly under load

This article helps you resolve the error that occurs where Windows Communication Foundation (WCF) service may scale up slowly under load.

_Original product version:_ &nbsp; Windows Communication Foundation  
_Original KB number:_ &nbsp; 2538826

## Symptoms

When your WCF service receives a burst of requests, the default .NET I/O Completion Port (IOCP) thread pool may not scale up as quickly as desired and your WCF response time will increase as a result. Depending on the execution time and number of requests received, you may notice the WCF execution-time increase linearly by approximately 500 ms for each request received until the process has created sufficient IOCP threads to service the requests or sustain the incoming load. The problem is more evident in services with longer execution times. The IOCP thread pool scalability problem is not typically observed upon the initial loading of the process.

## Cause

Three variables that have an impact on your WCF service ability to scale up at nearly the same rate as incoming requests.

1. WCF Throttling

2. .NET CLR `Threadpool.GetMinThreads` value

3. .NET CLR IOCP thread pool bug where IOCP threads are no longer created in a pattern corresponding to the incoming request volume prior to the `Threadpool.GetMinThreads` throttling value.

This article describes how to resolve the problem with the .NET IOCP Thread pool, #3. If you have throttling issues due to WCF throttling or the `GetMinThreads` value, this solution will not avoid those throttles. See the [More information](#more-information) section below for guidance in identifying your scenario. The IOCP thread creation bug should be addressed in the next post 4.0 release of the .NET Framework. This scalability problem does not exist in the .NET CLR Worker thread pool.

## Resolution

By moving the WCF service execution to another thread pool, you may incur a small amount of overhead implementing this solution. Performance results will vary per WCF Service. Test each WCF Service for individual results.

> [!NOTE]
> Apply this solution when using a WCF Listener which does not block the incoming thread while waiting on the WCF service code to complete.

| WCF Listener| Recommended solution |
|---|---|
|HTTP Sync Module (Default in 3.x) - used in Integrated Application Pool|Switch to the Async handler and then apply the solution in this article or alternatively use a Private Thread pool. (see links following this table)|
|HTTP Async Module (Default in 4.x) - used in Integrated Application Pool|Apply the code solution in this article.|
|ISAPI - used in Classic Mode Application Pool|Apply Private Thread pool. (see links following this table)|
|`tcp.Net`|Apply the code solution in this article.|
  
If you are unable to apply the solution in this article following the above table, an example using a private thread pool can be found in an MSDN article: [Foundations: Synchronization Contexts in WCF](/archive/msdn-magazine/2007/november/foundations-synchronization-contexts-in-wcf).

Steps to implement this solution that will execute the WCF service on the .NET CLR Worker thread pool:

1. WCF throttling thresholds should high enough to handle anticipated burst volume within acceptable response times.

2. If you use one of the .NET CLR default thread pools, Worker or IOCP for your WCF service, you must ensure the minimum thread count (value where thread creation throttling begins) to a number you anticipate to execute concurrently.

3. Implement the following code in your service that will then execute your WCF service on the .NET CLR Worker thread pool.

    This class is used to move the execution to the .NET CLR Worker thread pool.

    ```csharp
    public class WorkerThreadPoolSynchronizer : SynchronizationContext
    {
        public override void Post(SendOrPostCallback d, object state)
        {
         // WCF almost always uses Post
            ThreadPool.QueueUserWorkItem(new WaitCallback(d), state);
        }

        public override void Send(SendOrPostCallback d, object state)
        {
         // Only the peer channel in WCF uses Send
            d(state);
        }
    }
    ```

    Next we need to create a custom attribute class.

    ```csharp
    [AttributeUsage(AttributeTargets.Class)]
    public class WorkerThreadPoolBehaviorAttribute : Attribute, IContractBehavior
    {
        private static WorkerThreadPoolSynchronizer synchronizer = new WorkerThreadPoolSynchronizer();

        void IContractBehavior.AddBindingParameters(ContractDescription contractDescription, ServiceEndpoint endpoint, BindingParameterCollection bindingParameters)
        {
        }

        void IContractBehavior.ApplyClientBehavior(ContractDescription contractDescription, ServiceEndpoint endpoint, ClientRuntime clientRuntime)
        {
        }

        void IContractBehavior.ApplyDispatchBehavior(ContractDescription contractDescription, ServiceEndpoint endpoint, DispatchRuntime dispatchRuntime)
        {
        dispatchRuntime.SynchronizationContext = synchronizer;
        }

        void IContractBehavior.Validate(ContractDescription contractDescription, ServiceEndpoint endpoint)
        {
        }
    }
    ```

    Now to apply the custom attribute to your WCF service. Example:

    ```csharp
    [WorkerThreadPoolBehavior]
    public class Service1 : IService1
    {
        public string GetData(int value)
        {
            int iSleepSec = (value * 1000);
            System.Threading.Thread.Sleep(iSleepSec);
            return string.Format("You slept for: {0} seconds", value);
        }
    }
    ```

## More information

WCF uses the .NET CLR IOCP thread pool for executing your WCF service code. The problem is encountered when the .NET CLR IOCP thread pool enters a state where it cannot create threads quickly enough to immediately handle a burst of requests. The response time increases unexpectedly as new threads are created at a rate of 1 per 500 ms.

The problem may become more evident if your WCF service uses a technology that also utilizes the .NET CLR IOCP thread pool. For example, the Windows Server AppFabric Cache Client leverages this thread pool to a small extent.

If you are not hitting the WCF throttling limits described earlier, the following information will help you determine if you are experiencing the problem with the .NET CLR IOCP thread pool.

The .NET CLR thread pools use a value to determine when to begin throttling the creation of threads. This setting can be determined by calling the [ThreadPool.GetMinThreads(Int32, Int32) Method](/dotnet/api/system.threading.threadpool.getminthreads) or when analyzing a process dump using the !SOS debugger extension [SOS.dll (SOS debugging extension)](/dotnet/framework/tools/sos-dll-sos-debugging-extension).

> 0:000> !C:\windows\Microsoft.NET\Framework64\v4.0.30319\sos.threadpool  
CPU utilization: 0%  
Worker Thread: Total: 16 Running: 0 Idle: 16 MaxLimit: 250 MinLimit: 125  
Work Request in Queue: 0  
Number of Timers: 35  
Completion Port Thread:Total: 26 Free: 0 MaxFree: 16 CurrentLimit: 28 MaxLimit: 1000 MinLimit: 125

The observed problem is when the .NET CLR IOCP thread pool enters a condition where a new thread is only created every 500 ms (two per second) prior to the thread pool MinLimit value for the thread pool. Other expected factors that can also contribute to a thread creation delay would be memory pressure or high CPU.

Monitor the process hosting your WCF service. If you notice a problem scaling up threads prior to the minimum thresholds you have set, you may be encountering the problem with the .NET CLR IOCP thread pool. To determine if this is the case, Performance should be used to monitor the process thread creation rate in comparison to the incoming request rate. To accomplish this, log or view the following performance counters (below is an example for an IIS (WAS) hosted WCF 4.0 service using an HTTP binding):

|Counter|Instance(s)|
|---|---|
|Process / Thread Count|All W3WP(x) instances|
|HTTP Service Request Queues / Arrival Rate|<ApplicationPool Hosting the WCF Service(s)>|
|ASP.NET Apps v(4 or 2) / Requests Executing|<WCF Application Instance(s)>|
|ASP.NET Apps v(4 or 2) / Request Execution Time|<WCF Application Instance(s)>|
  
You can use the WCF performance counters if you have them enabled as well:

[WCF Performance Counters](/dotnet/framework/wcf/diagnostics/performance-counters/)

It is normal to see a slowly increasing thread count when the arrival rate (client requests pattern) is following the same pattern. It is only when there is an immediate spike of incoming requests and the thread count slowly increases at a rate of two threads per second while the WCF response time increases that a problem exists.

This screenshot shows a worker process that after some time has encountered the .NET IOCP thread pool scalability issue. When the process first started, the IOCP threads are normally created in parallel to the incoming request load. In this AppPool (W3WP.EXE), there were two WCF services running. One service was using the default .NET IOCP thread pool that received a burst of 100 requests at 10:22:14 and again at 10:23:34. The second WCF service was using the above workaround to execute on the .NET Worker thread pool and received a burst of 100 requests at 10:22:54. After entering this state, a process recycle is required to restore the IOCP thread pool to a working, scalable state.

:::image type="content" source="./media/wcf-service-scale-up-slowly/performance-monitor.jpg" alt-text="Screenshot shows the worker process after encountering thread pool scalability.":::
