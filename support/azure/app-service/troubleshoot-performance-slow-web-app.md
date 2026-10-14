---
title: Troubleshoot slow web app performance in Azure App Service
description: Slow web app performance in Azure App Service often traces back to code, CPU, memory, or database issues. Learn how to diagnose and fix each cause.
tags: top-support-issue
keywords: web app performance, slow app, app slow
ms.assetid: b8783c10-3a4a-4dd6-af8c-856baafbdde5
ms.topic: troubleshooting
ms.date: 08/25/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kamils, amehrot, kaushika
ms.service: azure-app-service
ms.custom:
 - sap:Availability, Performance, and Application Issues, build-2025
 - sfi-ropc-nochange
# Customer intent: As a developer, I want to learn strategies for troubleshooting slow app performance so that I can take steps to mitigate the issue.
---
# Troubleshoot slow web app performance in Azure App Service

## Summary

This article helps you diagnose and resolve slow web app performance in [Azure App Service](/azure/app-service/overview) on Windows.

## Symptoms

You experience one or more of the following symptoms:

- Web app pages load slowly or time out
- HTTP requests take longer than expected to complete
- Users report intermittent slowness or unresponsiveness
- Response times increase after a deployment, scaling event, or infrastructure change

## Prerequisites

Before you begin, make sure you have:

- Access to the Azure portal with at least **Contributor** role on the App Service resource
- Access to **Diagnose and solve problems** in the Azure portal for your App Service
- (Optional) An [Application Insights](/azure/azure-monitor/app/app-insights-overview) resource connected to your app

## Initial analysis: Check for platform-level issues

Before investigating application code, rule out Azure platform events and resource contention that cause transient slowness. Use the following steps to check for platform-level issues:

1. In the [Azure portal](https://portal.azure.com), go to your App Service.
1. In the menu, select **Diagnose and solve problems**.
1. In the search box, type **Web App Slow** and select the detector.
1. Review the observations. Look for signals in these categories:
   - **Availability and Performance** — response time trends and availability percentages
   - **Worker Process Events** — recent app restarts, crashes, or recycles
   - **Instance Allocation Events** — whether the app moved between instances (update domain walk, virtual machine (VM) failover)
   - **Platform Observations** — storage volume failovers or known service events

If the detector reports a platform-level event (storage failover, update domain walk, planned maintenance) that coincides with the slowness window, the issue is likely transient. Consider enabling [Health check](/azure/app-service/monitor-instances-health-check) to automatically remove unhealthy instances from the load balancer rotation.

> [!NOTE]
> Storage volume failovers are brief (typically seconds to minutes) and self-resolving. Running on multiple instances reduces the impact by keeping healthy instances available during a failover.

Check whether multiple apps share the same App Service plan. If the plan hosts many apps, resource contention between them can cause slowness even when no single app appears to be consuming excessive resources. In the Azure portal, go to your App Service plan and select **Apps** to see all apps on the plan. If density is high, consider moving these apps to separate plans.

If you don't find any platform issues, identify the root cause in your application.

## Cause 1: Application code inefficiency

> [!NOTE]
> This cause is the most common reason for slow response times in web applications.

Slow response times most frequently occur because of inefficient application code. Common inefficiencies include:

- Blocking synchronous operations, such as synchronous I/O or thread-blocking calls
- Inefficient in-memory data processing, such as using in-memory session with large datasets
- Excessive or unoptimized calls to remote dependencies, including databases, caches, and external APIs
- Unhandled exceptions that increase per-request processing time
- Missing connection pooling or reuse of expensive resources

### Solution

#### 1. Identify the slow component by using Application Insights Profiler

Application Insights Profiler captures detailed execution traces and shows which lines of code consume the most time. 

To use the profiler:

1. In the Azure portal, go to your App Service.
1. In the menu, in **Settings**, select **Application Insights**.
1. Enable **Application Insights** if it's not already enabled, and then select **View Application Insights data**.
1. In **Application Insights**, select **Performance** from the menu.
1. Select **Profiler**, and then review the captured traces during the slow period.
1. Look for long-running operations, blocked threads, or synchronous waits.

For detailed instructions, see [Enable the .NET Profiler for Azure App Service apps in Windows](/azure/azure-monitor/profiler/profiler).

#### 2. Enable Failed Request Tracing for slow requests

Failed Request Tracing logs detailed timing breakdowns per Internet Information Services (IIS) handler and helps you identify where time is spent in the request pipeline.

To enable Failed Request Tracing:

1. In the Azure portal, go to your App Service.
2. In the menu, select **App Service logs**.
3. Set **Failed Request Tracing** to **On**, and then select **Save**.
4. To capture requests that take more than 30 seconds, add the following code to your app's `web.config`:

   ```xml
   <system.webServer>
     <tracing>
       <traceFailedRequests>
         <remove path="*" />
         <add path="*">
           <traceAreas>
             <add provider="ASP" verbosity="Verbose" />
             <add provider="ASPNET" areas="Infrastructure,Module,Page,AppServices" verbosity="Verbose" />
             <add provider="ISAPI Extension" verbosity="Verbose" />
             <add provider="WWW Server" areas="Authentication,Security,Filter,StaticFile,CGI,Compression,Cache,RequestNotifications,Module,FastCGI" verbosity="Verbose" />
           </traceAreas>
           <failureDefinitions timeTaken="00:00:30" statusCodes="200-999" />
         </add>
       </traceFailedRequests>
     </tracing>
   </system.webServer>
   ```

5. After reproducing the issue, download the Failed Request Tracing logs from the Kudu console at `https://<your-app>.scm.azurewebsites.net` under **LogFiles** > **W3SVC\***.

#### 3. Review application code for common anti-patterns

Based on case analysis, the most frequently identified code issues include:

- **Blocking calls**: Replace synchronous calls with `async` or `await` patterns to free threads during input/output (I/O) waits.
- **In-memory session with large data**: Store large session objects in a distributed cache (Redis) rather than in-process memory.
- **Missing connection pooling**: Reuse `HttpClient`, `SqlConnection`, and similar expensive resources by using singleton patterns rather than creating new instances per request.
- **Synchronous telemetry writes**: If you use Application Insights SDK, use asynchronous telemetry channels to avoid blocking request threads.

#### 4. Scale up or scale out as a short-term mitigation

While you investigate the root cause, scaling can provide mitigation.

To scale up, run the following command in Azure CLI:

```azurecli
az appservice plan update --name <plan-name> --resource-group <resource-group> --sku P2V3
```

To scale out, run the following command in Azure CLI:

```azurecli
az appservice plan update --name <plan-name> --resource-group <resource-group> --number-of-workers 3
```

> [!TIP]
> For production apps, enable [Autoscale](/azure/azure-monitor/autoscale/autoscale-get-started) on the App Service Plan to respond automatically to traffic spikes.

## Cause 2: High CPU utilization

When application code consumes excessive CPU cycles, such as tight loops, heavy serialization, expensive regular expressions, or sitemap and report generation, all requests compete for CPU time. This competition causes slowness for all processes.

### Diagnose high CPU utilization

To determine whether high CPU is the cause of slowness, check the CPU metrics for your App Service plan:

1. In the Azure portal, go to your App Service.
1. In the menu, in **Monitoring**, select **Metrics**.
1. Add the **CPU Time** and **CPU Percentage** metrics for the App Service plan.
1. Check whether CPU spikes correlate with the reported slow periods.

> [!NOTE]
> Use **Diagnose and solve problems** > **High CPU Analysis** for an automated assessment.

### Solution

#### 1. Collect a memory dump or profiler trace during high CPU

From the Kudu console (`https://<your-app>.scm.azurewebsites.net`), follow these steps to collect a memory dump or profiler trace:

1. Select **Process Explorer**.
1. Right-click the **w3wp.exe** process.
1. Select **Download Memory Dump** > **Full Dump** (for analysis with WinDbg or PerfView), or select the **Collect IIS Events** checkbox and then select **Start Profiling** to capture a profiling trace.
1. Reproduce the slow behavior, then stop profiling.
1. Analyze the `.diagsession` file in Visual Studio or PerfView to identify the CPU-intensive code path.

#### 2. Address common high-CPU causes

Review your application code for the following common causes of high CPU:

- **Sitemap or report generation**: Pre-generate and cache responses rather than computing on every request.
- **Heavy regex**: Precompile regex patterns by using `Regex.CompileToAssembly` or cache compiled instances.
- **Loop-heavy operations**: Profile to identify hot loops and optimize the algorithm.

#### 3. Check for a spike in request volume

Before assuming a code issue, verify whether slowness correlates with a traffic spike. In **Diagnose and solve problems**, review the **HTTP Requests Analysis** detector or check the **Requests** metric under **Monitoring** > **Metrics**. Compare current request volume against the baseline. If traffic significantly increased, scale out to add more instances or enable [Autoscale](/azure/azure-monitor/autoscale/autoscale-get-started) to handle traffic spikes automatically.

#### 4. Remove unhealthy instances if only one instance is slow

If only one of multiple instances exhibits high CPU, follow these steps to remove the unhealthy instance from rotation:

1. In **Diagnose and solve problems**, note the affected instance name.
1. In the Azure portal, go to your App Service plan.
1. Select **Scale out (App Service Plan)** and reduce worker count temporarily to cycle out the affected instance.

## Cause 3: High memory usage and memory leaks

When the worker process accumulates memory over time (memory leak) or allocates large objects under load, the .NET runtime spends increasing time in garbage collection, causing intermittent slowness. Auto-heal might restart the process periodically, causing brief response spikes after each recycle.

### Diagnose high memory usage

To determine whether high memory usage is the cause of slowness, check the memory metrics for your App Service plan:

1. In the Azure portal, go to your App Service.
1. In **Monitoring** > **Metrics**, add the **Memory working set** and **Average memory working set** metrics.
1. Look for a steadily growing memory trend that drops sharply (indicating a process recycle).

### Solution

#### 1. Collect a memory dump for analysis

From the Kudu console (`https://<your-app>.scm.azurewebsites.net`), follow these steps to collect a memory dump for analysis:

1. Select **Process Explorer**.
1. Right-click the **w3wp.exe** process.
1. Select **Download Memory Dump** > **Full Dump**.
1. Analyze the dump by using Visual Studio's memory diagnostic tools to identify objects that the app unexpectedly retains.

#### 2. Configure auto-heal to recycle the process on memory thresholds

Auto-heal recycles the worker process when it exceeds a memory threshold, which reduces the duration of degraded performance.

To configure auto-heal:

1. In the Azure portal, go to your App Service.
1. In the menu, in **Diagnose and solve problems**, search for **Auto-heal**.
1. Configure a memory-based trigger (for example, recycle when private bytes exceed 1.5 GB).
1. Select **Save**.

Alternatively, configure auto-heal by using `web.config`:

```xml
<system.webServer>
  <monitoring>
    <triggers>
      <privateBytesInKB>1500000</privateBytesInKB>
    </triggers>
    <actions value="Recycle" />
  </monitoring>
</system.webServer>
```

> [!NOTE]
> Auto-heal treats the symptom. Use the memory dump analysis to identify and fix the underlying memory leak in the application code.

#### 3. Scale up if the instance size is too small for the app's working set

If memory usage is high even without a leak (the app genuinely needs more RAM), run the following command in Azure CLI to scale up to a larger plan:

```azurecli
az appservice plan update --name <plan-name> --resource-group <resource-group> --sku P3V3
```

## Cause 4: Slow or inefficient database queries

Slow database queries are a leading cause of high response times. Azure SQL Database bottlenecks identified in cases include missing indexes, queries returning large result sets, blocking and deadlocks, and cross-region latency between the app and the database.

### Diagnose database latency

If you enable Application Insights, go to **Performance** > **Dependencies** to see response times for each outbound database call. Slow dependency calls that point to your SQL server confirm this is the cause.

### Solution

#### 1. Check for cross-region latency

Ensure your Azure SQL Database is in the **same region** as your App Service. Cross-region calls add tens to hundreds of milliseconds per query.

Run the following commands in Azure CLI:

```azurecli
# Check your App Service region
az webapp show --name <app-name> --resource-group <rg> --query location

# Check your SQL Server region
az sql server show --name <sql-server> --resource-group <rg> --query location
```

If the regions differ, consider geo-replication or migrating the database to the same region.

#### 2. Identify and optimize slow queries

To identify slow queries, use the following steps:

1. In the [Azure portal](https://portal.azure.com), go to your Azure SQL Database.
1. In the menu, select **Query Performance Insight**.
1. Review the top CPU-consuming and longest-running queries.
1. Select **Tuning Recommendations** for automated index suggestions.

For queries returning large datasets, add appropriate indexes and use pagination (`OFFSET`,`FETCH`, or `ROW_NUMBER()`).

#### 3. Increase the database connection pool size

If Application Insights shows many short-duration, high-frequency database calls that correlate with slowness, the connection pool might be exhausted.

For .NET apps, use the following command to set the connection pool size in the connection string:

```xml
Server=tcp:<server>.database.windows.net;Database=<db>;User ID=<user>;Password=<password>;
Connection Timeout=30;Min Pool Size=5;Max Pool Size=100;
```

#### 4. Use Query Store to identify regressions

If query performance degraded after a migration or schema change, perform the following steps to identify regressions:

1. In your Azure SQL Database, go to **Query Store** > **Regressed Queries**.
1. Compare execution plans before and after the regression event.
1. Force the previous plan if the new plan is suboptimal by running the following command:

   ```sql
   EXEC sp_query_store_force_plan @query_id = <id>, @plan_id = <id>;
   ```

## Cause 5: External dependency latency

When the web app calls external services (like Redis cache, on-premises APIs, non-Microsoft HTTP endpoints, and Azure Service Bus), slowness or unavailability of those services directly causes request slowness.

### Diagnose dependency latency

In Application Insights, go to **Performance** > **Dependencies** and check the response time for each external call. Alternatively, enable [Dependency Tracking](/azure/azure-monitor/app/asp-net-dependencies) if not already configured.

### Solution

#### 1. Add timeouts and circuit breakers

Ensure all outbound calls have explicit timeouts. Without a timeout, a slow or unavailable dependency blocks the request thread indefinitely.

To set timeouts for HTTP and Redis calls, use the following code snippets:

```csharp
// HttpClient with timeout
var client = new HttpClient { Timeout = TimeSpan.FromSeconds(10) };

// Redis with ConnectTimeout and SyncTimeout
var options = ConfigurationOptions.Parse(connectionString);
options.ConnectTimeout = 5000;
options.SyncTimeout = 3000;
```

Consider implementing the [Circuit Breaker pattern](/azure/architecture/patterns/circuit-breaker) by using a library such as Polly to fail fast when a dependency is consistently slow.

#### 2. For Redis timeout exceptions

Redis `TimeoutException` errors typically indicate the client is exhausting its connection pool or the Redis server is under memory pressure.

To mitigate Redis timeouts:

- Scale up the Azure Cache for Redis tier if server-side CPU or memory is high.
- Use `StackExchange.Redis` with connection multiplexing (a single shared `ConnectionMultiplexer` instance per app).
- Review the `ThreadPool` settings. Starvation of .NET thread pool threads causes Redis connection waits.

#### 3. For on-premises backend slowness

If the app connects to an on-premises server through [Hybrid Connections](/azure/app-service/app-service-hybrid-connections) or a virtual private network (VPN), investigate network latency:

- Check firewall inspection policies on the on-premises side.
- Review Domain Name System (DNS) resolution times for the on-premises hostname.
- Compare round-trip times from the app to the on-premises endpoint versus Azure-hosted alternatives.

#### 4. For Service Bus authentication failures causing slowness

If Service Bus or another Azure messaging service returns authentication errors that trigger retry loops, perform the following checks:

- Verify that the managed identity or service principal credentials the app uses are valid and not expired.
- Check Service Bus connection strings or role-based access control (RBAC) role assignments.
- Restart any dependent virtual machines (VMs) or services that manage authentication tokens if they become stale.

## Cause 6: SNAT port exhaustion

App Service apps share a pool of outbound Source Network Address Translation (SNAT) ports for connections to external endpoints. When the app makes a high volume of outbound connections (to SQL, REST APIs, storage, and so on) without properly closing them, it exhausts SNAT ports. This exhaustion causes new outbound connections to fail or be severely delayed.

> [!IMPORTANT]
> In slow-response scenarios, SNAT port exhaustion is most often a *symptom* of slow backend responses or connection leaks rather than the root cause itself. If backend dependencies respond slowly, connections stay open longer and consume SNAT ports. Confirm that all backend dependencies are responding normally before attributing slowness to SNAT exhaustion.

### Diagnose SNAT port exhaustion

To diagnose SNAT port exhaustion, follow these steps:

1. In the Azure portal, go to your App Service.
1. Select **Diagnose and solve problems**.
1. Search for **SNAT Port Exhaustion** and run the detector.
1. Confirm SNAT exhaustion before taking action. SNAT port problems rarely cause slowness unless all backend dependencies are responding normally.

You can also check outbound connection metrics by running the following command in Azure CLI:

```azurecli
az monitor metrics list --resource <app-service-resource-id> \
  --metric "SnatPortUtilization" --interval PT1M
```

### Solution

#### 1. Use VNet Integration with private endpoints (recommended)

Virtual network (VNet) integration routes outbound traffic through your VNet, where private endpoints eliminate SNAT entirely for supported Azure services (Azure SQL, Azure Storage, Service Bus, and more).

1. In the Azure portal, go to your App Service.
1. Select **Networking** > **VNet Integration** > **Add VNet Integration**.
1. Select your VNet and a delegated subnet (at least `/26`).
1. Create private endpoints for your dependent Azure services (like Azure SQL, Azure Storage, and Service Bus).

For step-by-step configuration, see [Integrate your app with an Azure virtual network](/azure/app-service/overview-vnet-integration).

#### 2. Ensure outbound connections are properly closed

Verify that you dispose `HttpClient`, `SqlConnection`, `SocketsHttpHandler`, and similar resources after use or reuse them through shared instances. Connection leaks are the most common trigger for SNAT exhaustion.

To ensure proper connection reuse, use the following code snippets:

```csharp
// BAD: creates a new connection per request
using (var client = new HttpClient())
{
    await client.GetAsync(url);
}

// GOOD: reuse a single instance (register as singleton in DI)
private static readonly HttpClient _client = new HttpClient();
```

#### 3. Scale out to distribute outbound connections

Adding more instances reduces the per-instance outbound connection load.

Run the following command in Azure CLI to scale out your App Service plan:

```azurecli
az appservice plan update --name <plan-name> --resource-group <rg> --number-of-workers 4
```

## Cause 7: Cold starts after scaling or maintenance events

When App Service scales out, performs an update domain walk (platform update), or moves to a new VM instance, the worker process on the new instance starts cold. Applications that perform heavy initialization work (like loading configuration, warming up caches, and compiling Razor views) experience slow first requests on new instances, which can appear as intermittent user-facing slowness.

### Solution

#### 1. Enable Always On

Always On sends a ping to the default page every five minutes, keeping the worker process active and preventing idle timeouts.

To enable Always On:

1. In the Azure portal, go to your App Service.
1. Select **Configuration** > **General settings**.
1. Set **Always On** to **On**.
1. Select **Save**.

> [!NOTE]
> Always On is available on the Basic tier and higher. It's not available on the Free or Shared tiers.

#### 2. Configure application initialization (warm-up URL)

For advanced warm-up (like preloading caches and compiling views), configure `applicationInitialization` in `web.config` by running a warm-up URL before the app starts serving production traffic:

```xml
<system.webServer>
  <applicationInitialization doAppInitAfterRestart="true" skipManagedModules="false">
    <add initializationPage="/healthcheck" hostName="<your-app>.azurewebsites.net" />
  </applicationInitialization>
</system.webServer>
```

This configuration ensures IIS waits for the warm-up URL to return HTTP 200 before routing production traffic to a new instance.

#### 3. Use automatic scaling or prewarming with scaling rules

Configure autoscale rules to scale out proactively based on schedule or metrics, giving new instances time to warm up before peak traffic.

Run the following command in Azure CLI to create an autoscale rule for your App Service plan:

```azurecli
az monitor autoscale create \
  --resource-group <rg> \
  --resource <plan-id> \
  --resource-type Microsoft.Web/serverFarms \
  --name myAutoscale \
  --min-count 2 --max-count 10 --count 2
```

#### 4. Check for application crash loops

Frequent application crashes or recycles can also cause repeated cold starts, distinct from scaling or maintenance events. Each crash triggers a full process restart, which adds initialization overhead.

To diagnose application crash loops:

1. In **Diagnose and solve problems**, search for **Application Crashes** or review the **Worker Process Events** detector.
1. Look for a pattern of repeated crashes followed by restarts.
1. If crash loops are detected, investigate the crash cause (unhandled exceptions, out-of-memory conditions) rather than focusing on cold start mitigations.

## Cause 8: Disk space exhaustion from log or profiler files

When diagnostic profiler files, application log files, or temporary files accumulate and fill the app's local storage allocation, the app can slow down significantly or fail to process requests. This problem usually occurs when the Application Insights Profiler or crash diagnostics tools run continuously.

### Diagnose disk space problems

To check for disk space problems:

1. In the Azure portal, go to your App Service.
1. Select **Diagnose and solve problems** > **Best Practices for Availability & Performance**.
1. Check for **Disk Usage** warnings.

From the Kudu console (`https://<your-app>.scm.azurewebsites.net`):

1. Select **Debug Console** > **CMD**.
1. Go to the **LogFiles** and **Temp** directories and check for large or numerous files.

### Solution

#### 1. Restart the app to clear temporary files

Restarting the app service clears temporary diagnostic files that accumulate on the local disk.

Run the following command in Azure CLI:

```azurecli
az webapp restart --name <app-name> --resource-group <rg>
```

#### 2. Delete large log files through the Kudu console

Use the Kudu console to delete old log files that you no longer need:

1. Go to `https://<your-app>.scm.azurewebsites.net`.
1. Select **Debug Console** > **CMD**.
1. Go to **LogFiles** and delete old files that you no longer need.

#### 3. Disable continuous profiling when you're not actively troubleshooting

If you configure Application Insights Profiler to run continuously, switch it to **On demand** mode.

To change the profiling mode:

1. In Application Insights, select **Performance** > **Profiler** > **Settings**.
1. Set the profiling mode to **On demand** rather than **Always On**.
1. Select **Save**.

#### 4. Configure auto-heal to recycle on slow requests

Auto-heal can recycle the app process before disk exhaustion causes full failure.

To configure auto-heal for slow requests:

1. In **Diagnose and solve problems**, search for **Auto-heal**.
1. Configure a **Slow Requests** trigger (for example, recycle if more than 20 requests take over 30 seconds).
1. Select **Save**.

## References

- [Application performance FAQs for Web Apps in Azure](/troubleshoot/azure/app-service/web-apps-performance-faqs)
- [Enable diagnostic logging for apps in Azure App Service](/azure/app-service/troubleshoot-diagnostic-logs)
- [Enable Application Insights Profiler for .NET apps on Windows](/azure/azure-monitor/profiler/profiler)
- [Scale up an app in Azure App Service](/azure/app-service/manage-scale-up)
- [Integrate your app with an Azure virtual network](/azure/app-service/overview-vnet-integration)
- [Monitor App Service instances using Health check](/azure/app-service/monitor-instances-health-check)
- [Auto-Healing Azure Web Sites](https://azure.microsoft.com/blog/auto-healing-windows-azure-web-sites/)
- [Troubleshooting intermittent outbound connection errors in Azure App Service](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors)
- [Tutorial: Run a load test to identify performance bottlenecks in a web app](/azure/app-testing/load-testing/tutorial-identify-bottlenecks-azure-portal)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
