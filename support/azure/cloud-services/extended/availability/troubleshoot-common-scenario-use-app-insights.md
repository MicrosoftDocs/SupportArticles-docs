---
title: Troubleshoot common Cloud Service Application issues with Application Insights
description: Describes common scenarios that use Application Insights to troubleshoot Cloud Service Application issues.
ms.date: 04/01/2024
ms.reviewer: patcatun
author: JerryZhangMS
ms.author: genli
ms.service: azure-cloud-services-extended-support
ms.custom: sap:Service Availability and Performance
---

# Troubleshoot Cloud Service app with Application Insights - common scenarios

When Azure Cloud Service is used to host a website or proceed with a data process, it's recommended to integrate a log system to collect more detailed information and log records. Application Insights is designed for this purpose. This document provides common scenarios where we can benefit from integrating  Application Insights with Cloud Service.  

To learn more about using Application Insights with Cloud Service, see [feature overview](troubleshoot-with-app-insights-features-overview.md).

## Diagnostic setting and Application Insights

When Application Insights is enabled on Cloud Service, Diagnostic setting must be enabled at the same time. Some metrics data and logs that are collected by Diagnostic setting will be sent to Application Insights. For more information, see [Set up diagnostics for Azure Cloud Services](/visualstudio/azure/vs-azure-tools-diagnostics-for-cloud-services-and-virtual-machines).

When Diagnostic setting is enabled, the **performance counters** setting works differently on Web Role and Worker Role.

### For Web Role

The following nine metrics have data that will be automatically collected even if the performance counter is disabled in Diagnostic setting. Data from these nine metrics is saved in the **performanceCounter** table of Application Insights. Other metrics, such as `\Process(w3wp)\% Processor Time`, will be saved on the **customMetrics** table when the performance counter is enabled.

```Output
\Process(??APP_WIN32_PROC??)\% Processor Time  

\Memory\Available Bytes  

.NET CLR Exceptions(??APP_CLR_PROC??)# # of Exceps Thrown / sec

\Process(??APP_WIN32_PROC??)\Private Bytes  

\Process(??APP_WIN32_PROC??)\IO Data Bytes/sec  

\Processor(_Total)%  Processor time  

\ASP.NET Applications(??APP_W3SVC_PROC??)\Requests/sec  

\ASP.NET Applications(??APP_W3SVC_PROC??)\Request Execution Time  

\SP.NET Applications(??APP_W3SVC_PROC??)\Requests In Application Queue  
```
### For Worker Role

If the performance counter is disabled in Diagnostic setting, there will be no performance metrics data automatically collected and saved in Application Insights.

### For both Web Role and Worker Role

The HeartBeatState metric data is always saved in Application Insights automatically. This metric is used to identify whether the instance is still healthy at the server level. It will be triggered every 15 minutes and saved into the **customMetrics** table. The other performance metric data need to be manually enabled in the performance counter in Diagnostic setting.

> [!IMPORTANT]
> Application Insights will generate records only when there's real data collected. If a Web Role never receives a request, a Worker Role doesn't read or write data from or into a disk. If the amount of data IO is quite low, it's possible that Application Insights won't record any information.

The following table shows the mapping between the options in Diagnostic setting and table names in Application Insights logs:

| Table in Application Insights | Logs in Diagnostic setting |
| ----------- | ----------- |
| traces      | Application logs     |
| traces   | ETW logs       |
| traces   |  Infrastructure logs   |
| traces/custom events   |  Windows Event logs       |
| Custom metrics   |  performance counters        |

## Advanced way to use Application Insights with Cloud Service

There are several common advanced ways to use Application Insights with Cloud Service. For example, users can use Azure Application Insights SDK in a Cloud Service project to generate or modify the data saved into Application Insights.

### Add custom log

To add a custom log to your application, follow these steps:

1. Right-click the role project and select **Manage NuGet Packages**.
2. Make sure that Microsoft.ApplicationInsights is installed.

    :::image type="content" source="./media/troubleshoot-common-scenario-use-app-insights/install-package.png" alt-text="Screenshot shows the installed Microsoft ApplicationInsights package.":::

3. Add the Application Insights configuration into the *.cscfg* and *.csdef* files.

    > [!NOTE]
    > - Technical support for instrumentation key-based global ingestion will end on March 31, 2025. It's recommended to use the connection string instead of connecting to Application Insights before that date. For more information, see [Transition to using connection strings for data ingestion by 31 March 2025](https://azure.microsoft.com/updates/technical-support-for-instrumentation-key-based-global-ingestion-in-application-insights-will-end-on-31-march-2025/).
    > - When Application Insights is linked with a Cloud Service project, `APPINSIGHTS_INSTRUMENTATIONKEY` is automatically added. For more information, see [Troubleshoot Cloud Services app with Application Insights - features overview](troubleshoot-with-app-insights-features-overview.md).

    Here's an example of the *.csdef* file:

    ```xml
    <ConfigurationSettings>
      <Setting name="APPLICATIONINSIGHTS_CONNECTION_STRING" />
      <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" />
    </ConfigurationSettings>
    ```

   Here's an example of the *.cscfg* file:

   ```xml
   <ConfigurationSettings>
        <Setting name="APPINSIGHTS_INSTRUMENTATIONKEY" value="{Instrumentation_key}" />
        <Setting name="APPLICATIONINSIGHTS_CONNECTION_STRING" value="{Connection_String}" />
    </ConfigurationSettings>
    ```

    The connection string can be found on the overview page of Application Insights. For more information, see [Migrate from Application Insights instrumentation keys to connection strings](/azure/azure-monitor/app/migrate-from-instrumentation-keys-to-connection-strings).

4. Add the following code in the startup function of your role. The startup function of Web Role is `Application_Start()` in *Global.asax*. For Worker Role, it's `OnStart()` in *WorkerRoleName.cs*.

    ```csharp
    TelemetryConfiguration.Active.ConnectionString = RoleEnvironment.GetConfigurationSettingValue("APPLICATIONINSIGHTS_CONNECTION_STRING"); 
    ```
5. Create a telemetry client and record the log context:

    ```csharp
    using Microsoft.ApplicationInsights; 
    TelemetryClient ai = new TelemetryClient(); 
    ai.TrackTrace("The custom log context"); 
    ```

    Besides the trace log, you can also use the following method to record the handled exceptions:

    ```csharp
     ai.TrackException(exception);
    ```
### Record the running Worker Role application as a request

By design, the request of Web Role is automatically marked with a unique ID in Cloud Service to identify the correlation. In Worker Role, there isn't such a system. But it's possible to simulate the result of the Worker Role application progress as a request and record this request into Application Insights. So you can simplify the way to check the working status of the application in Worker Role. The following is a Worker Role application example.

This worker role will keep adding trace logs into Application Insights every 30 seconds. But logs won't always be added successfully because there's one changing bool variable selected to make the Run function return a handled exception in every two loops. The trace log recorded into Application Insights will contain the timestamp, a fully random GUID, as a correlation ID to identify the relationship between the request record and other records. Every loop is considered a request, so it will generate a record of the request with the start timestamp, the duration, the success status, the response code (200 for success and 500 for exception), and the correlation ID.

Only the [Duration and Success statuses](/azure/azure-monitor/app/data-model-request-telemetry) are necessary for generating a request record. The other information is kept in the request record because:

- The start timestamp and response code can make it a real request, and different response codes (for example, 400 and 500 for failed requests) can help when the user wants to identify different failure reasons.

- If the application uses multiple threads, there can be trace logs, exceptions, and request records of different threads at the same moment, which will cause the user to be unable to track them by timestamp. A correlation ID used through all steps is important. According to the document, the ID of a request should be globally unique. To make sure the example works perfectly, we should add a function to verify if a newly generated random GUID is already used by any request records in Application Insights (this isn't implemented in the following example code).

```csharp
using Microsoft.WindowsAzure.ServiceRuntime;
using System;
using System.Diagnostics;
using Microsoft.ApplicationInsights; //Import the Application Insight SDK
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.ApplicationInsights.DataContracts;

namespace Worker Role1
{
    public class Worker Role : RoleEntryPoint
    {
        private TelemetryClient ai = new TelemetryClient(); //Define a private TelemetryClient
        private bool select = true;
        private int a = 0;
        private int b;
        private volatile bool onStopCalled = false;
        private volatile bool returnedFromRunMethod = false;
        private Stopwatch requestTimer;
        private bool requestResult;

        public override void Run()
        {
            ai.TrackTrace("Worker Role1 is running AI");

            var request = new RequestTelemetry(); // Generate a RequestTelemetry. Once it's created, all the changes should be saved into this RequestTelemetry and SDK will save this RequestTelemetry into Application Insight.

            while (true)
            {
                request.Name = "A test request";  //the following three lines configure the Name, Id and StartTime property of the request.
                request.Id = Guid.NewGuid().ToString();
                request.StartTime = DateTimeOffset.UtcNow;

                ai.TrackTrace("New cycle. AI " + DateTimeOffset.UtcNow.ToString() + " " + request.Id);

                requestTimer = Stopwatch.StartNew();

                try
                {
                    if (onStopCalled == true)
                    {
                        ai.TrackTrace("Onstopcalled Worker Role AI");
                        returnedFromRunMethod = true;
                        return;
                    }

                    if (select == true)
                    {
                        select = false;
                        b = 100 / a;
                    }
                    else
                    {
                        select = true;
                        b = 100 / 10;
                    }
                    ai.TrackTrace("normal Worker Role AI " + DateTimeOffset.UtcNow.ToString() + " " + request.Id);
                    requestResult = true;
                }
                catch (Exception ex) // Pay attention to the way that saves the custom Trace log and Exception. The unique specific ID will be helpful for us to track the request workflow in Application Insight if your application is multi thread.
                {
                    ai.TrackTrace("Exception Worker Role AI " + DateTimeOffset.UtcNow.ToString() + " " + request.Id); 
                    ai.TrackException(ex, new Dictionary<string, string>() { { "id", request.Id } });
                    requestResult = false;
                }

                request.Success = requestResult; //The following codes set Success, Duration and ResponseCode property of the request, then save it into Application Insight.
                request.Duration = requestTimer.Elapsed;
                request.ResponseCode = requestResult ? "200" : "500";
                ai.TrackRequest(request);

                System.Threading.Thread.Sleep(30*1000);
            }
        }

        public override bool OnStart()
        {
            TelemetryConfiguration.Active.InstrumentationKey = RoleEnvironment.GetConfigurationSettingValue("APPINSIGHTS_INSTRUMENTATIONKEY");

            bool result = base.OnStart();

            return result;
        }

        public override void OnStop()
        {
            onStopCalled = true;

            while (returnedFromRunMethod == false)
            {
                System.Threading.Thread.Sleep(1000);
            }
        }
    }
}
```
> [!NOTE]
> You can also do the same thing by using custom telemetry. For more information, see the [Work Role code sample](https://github.com/wuping2004/CloudServiceSample/tree/add-cpp-sdk/Samples/AzureEmailService/WorkerRoleA).

### Check the failed request and related exception of Web Role

For failed requests in Web Role, the unhandled exception and the handled exception (which is in the try function) with `ai.TrackException` are automatically collected in the exception table.

To find the exception records in the Application Insights instance, you can use one of the following methods:
#### View the Failures page in the Azure portal

1. Go to the Azure portal, select the Application insights instance, and then select **Failures**.
2. Locate the failed request in the **Operations** tab by adjusting the time range and selecting the corresponding operation.
3. Select the operation name. The failed requests with a specific exception type or response code will be listed automatically.

#### Query Logs in the Azure portal

The second method uses the **Logs** option of Application Insights. This method is more complicated, but it allows you to use more custom filters to look for specific types of exceptions. It also provides more details that will not be displayed on the Failures page.
 
By design, the request of Web Role is automatically marked with a unique ID in Cloud Service to identify the correlation. To find the ID of the requests, follow these steps:

1. Locate the failed request in the requests table and record its ID:

   ```kusto
   requests
   | where resultCode == "500"
   ```
2. Find the exception with the same ID in the exceptions table:

   ```kusto
   exceptions
   | where operation_ParentId == "8d1adf11abf73c42"
   ```
Tracking exceptions based on a failed request is helpful when troubleshooting an intermittent failure issue since it contains the complete CallStack of that request.
### Check the failed request and related exception for Worker Role

Since the unhandled exception of Worker Role may cause the whole application to experience downtime, it's recommended to handle all the exceptions in Worker Role. That means that it should include the `try` function. For the handled exceptions in Web Role, `ai.TrackException` is needed to record the exceptions in Application Insights.

The steps to check the exception in Worker Role are similar to the ones in Web Role. The only difference is that there isn't a built-in system to record the exceptions automatically, so some extra codes are needed to archive the goal.

Here are some possible situations:

- Worker Role doesn't include a system for recording custom requests. The only data that can be used to track the relationship between the exception record and real operation in the application is the timestamp. 

    In this situation, checking the Failures page is still possible, but you need to switch to the Exceptions page and check the timestamp manually. You can also check the accuracy of the data on the Logs page. The following is an example query to check exceptions between a specific time range.
    ```kusto
    exceptions 
    | where timestamp between (datetime(2022-05-11 00:00) .. datetime(2022-05-13 00:00)) 
    ```
- Worker Role includes a system to record custom requests with custom ID, but it's not included in the exception record. It will be the same as the previous situation.
- Worker Role includes a system to record custom requests with a custom ID, and it's included in the exception record, such as line 62 in the example. The way to record the function of the Worker Role application as a request will be the same as the situation of Web Role. You can check the **Failures** page or **Logs** page to find the related requests and exceptions. The query used in the Logs page will be:

    ```kusto
    requests 
    | where success == False 
    ```
    ```kusto
    exceptions 
    | where * contains "<request ID>" 
    ```

## Common scenarios and guidelines

This section looks at several common scenarios and the related guidelines for using Application Insights to meet the requirements.

### Monitor the Memory and Request status of a Web Role

To monitor the Memory and Request status of the Web Role in Cloud Service, you just need to enable Application Insights on the role you want to collect metrics data from. Then it will automatically collect data for the Memory usage and Request status of the Web Role.

To see the collected data, it's recommended to use the **Metrics** page of Application Insights. For more information, see [System performance counters in Application Insights](/azure/azure-monitor/app/performance-counters).

Like Web Role, it's also possible to monitor the memory and request status of Worker Role, but there are some limitations:

1. For Worker Role, the memory metrics data won't be automatically collected by default. To monitor the memory status, you need to enable the `\Memory\Available MBytes` from Performance Counters of Diagnostic setting. The collected data will be in the `custommetrics` table of the Logs page.

   :::image type="content" source="./media/troubleshoot-common-scenario-use-app-insights/enable-performance-counters.png" alt-text="Screenshot shows how to enable performance counters in Visual Studio.":::

1. To view the metrics chart for the collected memory data, go to the **Metrics** page in Application Insights, select **Log-based metrics** in Metric Namespace, and **Available Memory** under **Performance** in Metric. The chart will display the Available Memory for the selected time range. The dotted line in the chart means that the data isn't accurate enough to generate the data, or the data is missing during that time range. From the Logs, the interval for collecting the Memory data is about three minutes. In the chart above, since the time range is set to Last hour, the time difference between every two points will be less than three minutes, so the collected data won't be accurate enough. Thus, it's a dotted line.

    :::image type="content" source="./media/troubleshoot-common-scenario-use-app-insights/view-memory-chart.png" alt-text="Screenshot shows how to memory chart in the Azure portal.":::

### Troubleshoot performance issues such as slow response time

For example, when a Cloud Service Web Role receives a request, it needs to get some data from a remote server, such as SQL Database, then generate the data on a web page and return it to the user. Imagine that this progress is much slower than expected but still successful. It's reasonable that the user wants to clarify whether most of the time spent is during the communication with SQL Database or during the progress inside the Cloud Service. For that, it will need the user to add some extra custom logs to record the timestamp of each step, such as the start of the progress, the start of the communication with SQL Database, the end of the communication with SQL Database, and the end of generating the webpage, and so on.

1. For both Worker Role and Web Role, it's recommended to save a trace log at each starting step in the process. For example, in the above example codes, it's possible to add a trace log at the following points when:

    - The WebRole receives the request.
    - The WebRole starts to build communication with SQL server.
    - The WebRole receives the data returned by SQL server and starts generating the webpage.
    - The WebRole generates the webpage and returns it to user.

1. If the main process is the application in Worker Role, record the functions of the Worker Role application as a request to add a custom correlation ID into the custom request record and exception record.

Once the logic is implemented, you can check the requests on the **Performance** page of Application Insights and focus on the request durations by following:

1. Select an operation that you want to check.
1. Scale the duration distribution chart to the longest duration part.
1. Select **Drill into samples**.
1. Select a request as an example and get the built-in or custom ID of this request.

If the system isn't overly complicated, the time spent by different steps will be displayed in the End-to-end transaction chart. If the system is complicated or we're using a custom ID that causes it to be unable to display the data in the chart, use the following query to get all related trace logs containing the same correlation ID:

```Kusto
traces
| where * contains "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" 
```

This way, it's possible for you to calculate the difference between every trace log to get the time spent by every step.

### Troubleshoot performance issues such as high CPU/Memory of Worker Role

Sometimes you will need to identify issues such as Worker Role consuming very high CPU/Memory. The only thing that can be observed from outside of Cloud Service is that Worker Role is consuming too much CPU/Memory, but you have no idea what exactly is happening in this instance.

To troubleshoot this kind of issue, there are two steps:

Add a custom log to track every step the Worker Role application will do. This is very important because this step enables you to identify if the application is still running well and to compare the time spent in each step with the normal situation. This can help you to identify whether the application is affected by the high CPU/Memory issue. For information about how to add a custom log system, refer to [add custom log](#add-custom-log).

To capture the dump file. Here are some tips:

You can use a remote desktop to connect to the instance having high CPU/Memory issues and verify which process is consuming most of the CPU/Memory. If the process is WaWorkerHost, it means the application is consuming excessive CPU/Memory.

If the instances are having high CPU/Memory issues and the application is experiencing low-performance but hasn't crashed, then you can try to use a remote desktop to connect to the instance and capture a dump file. You can use [procdumps](/sysinternals/downloads/procdump) to capture a dump file when the CPU consumed by the WaWorkerHost process is higher than 85% for at least three seconds. Five dump files will be captured and saved into the `c:\procdumps` directory.

```console
 procdump.exe -accepteula -c 85 -s 3 -n 5 WaWorkerHost.exe c:\procdumps
```

In the Diagnostic setting page of Cloud Service, you can also set the crash dump file auto-generation. For more information, see [Set up diagnostics for Azure Cloud Services and virtual machines](/visualstudio/azure/vs-azure-tools-diagnostics-for-cloud-services-and-virtual-machines?toc=%2Fazure%2Fcloud-services%2Ftoc.json&view=vs-2022#crash-dumps&preserve-view=true).
