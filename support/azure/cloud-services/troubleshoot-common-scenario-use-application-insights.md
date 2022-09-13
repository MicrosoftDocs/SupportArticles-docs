---
title: Troubleshoot common Cloud Service Application issues with Application Insights
description: Describes common Cloud Service Application issues.
ms.reviewer: patcatun
author: genlin
ms.author: genli
ms.service: cloud-services
---
# Troubleshoot common Cloud Service Application issues with Application Insights

When Azure Cloud Service is used to host a website or proceed with a data process, it's recommended to integrate a log system to collect more detailed information and log records. Application Insights service is designed for this purpose. This document provides common scenarios where we can benefit from application insights integration with Cloud Service.  

For basic knowledge of using Application Insights with Cloud Service, see [feature overview](link).

## Diagnostic setting and Application Insights

When Application Insights is enabled on Cloud Service, the Diagnostic setting must be enabled at the same time. Some metrics data and logs that are collected by Diagnostic will be sent to Application Insights. For more information, see https://docs.microsoft.com/en-us/visualstudio/azure/vs-azure-tools-diagnostics-for-cloud-services-and-virtual-machines?toc=%2Fazure%2Fcloud-services%2Ftoc.json&view=vs-2022#to-view-cloud-service-diagnostics-data

When the Diagnostic setting is enabled, the **performance counters** setting works differently on Web Role and Worker Role:

### For Web Role

The following nine metrics data will be automatically collected even if the performance counter is disabled in Diagnostic Setting. Data from these nine metrics is saved in the **performanceCounter** table of Application Insights. Other metrics, such as `\Process(w3wp)\% Processor Time`, will be saved on the **customMetrics** table when the performance counter is enabled.

```
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

If the performance counter is disabled in Diagnostic Setting, there will be no performance metrics data automatically collected and saved in Application Insights.

### For both Web Role and Worker Role

The HeartBeatState metric data is always saved into Application Insights automatically. This metric is used to identify whether the instance is still healthy at the server level. It will be triggered every 15 minutes and saved into the **customMetrics** table. The other performance metric data need to be manually enabled in the performance counter in Diagnostic Setting.

> [!IMPORTANT]
> Application Insights will generate records only when there's real data collected. If a Web Role never receives a request, a Worker Role doesn't read or write data from or into a disk. If the amount of data IO is quite low, it's possible that Application Insights won't record any information.

The following table shows the mapping between the options in Diagnostic Setting and table names in Application Insights logs:

| Table in Application insights | logs in Diagnostic setting |
| ----------- | ----------- |
| traces      | Application logs     |
| traces   | ETW logs       |
| traces   |  Infrastructure logs   |
| traces/custom events   |  Windows Event logs       |
| Custom metrics   |  performance counters        |

## Advanced way to use Application Insights with Cloud Service

There are several common advanced ways to use Application Insights with Cloud Service. For example, you can use Azure Application Insights SDK in a Cloud Service project to generate or modify the data saved into Application Insights.

### Add custom log

To add a custom log into your application, follow these steps:

1. Right-click the role project and select **Manage NuGet Packages**.
2. Make sure that Microsoft.ApplicationInsights is installed.
3. Add the following code in the startup function of your role. The startup function of Web Role can normally be `Application_Start()` in Global.asax. For Worker Role, it can be `OnStart()` in WorkerRoleName.cs.

    ```C#
    TelemetryConfiguration.Active.InstrumentationKey = RoleEnvironment.GetConfigurationSettingValue("APPINSIGHTS_INSTRUMENTATIONKEY"); 
    ```
4. Create a telemetry client and record the log context:

    ```C#
    using Microsoft.ApplicationInsights; 
    TelemetryClient ai = new TelemetryClient(); 
    ai.TrackTrace("The custom log context"); 
    ```

    Besides the trace log, we can also use the following method to record the handled exceptions:

    ```c#
     ai.TrackException(exception);
    ```
### Record the running Worker Role application as a request

By design, the request of Web Role is automatically marked with a unique ID in Cloud service to identify the correlation. In Worker Role, there isn't such a system. But it's possible to simulate the result of the Worker Role application progress as a request and record this request into Application Insights. So you can simplify the way to check the working status of the application in Worker Role. The following is a Worker Role application example. 

This worker role will keep adding trace logs into Application Insights every 30 seconds. But logs won't always be added successfully because there's one changing bool variable selected to make the Run function return a handled exception in every two loops. The trace log recorded into Application Insights will contain the timestamp, a fully random GUID, as a correlation ID to identify the relationship between the request record and other records. Every loop is considered a request, so it will generate a record of the request with the start timestamp, the duration, the success status, the response code (200 for success and 500 for exception), and the correlation ID.

According to the [document](https://docs.microsoft.com/azure/azure-monitor/app/data-model-request-telemetry), only Duration and Success status are necessary for generating a request record. The reason why the other information is kept in the request record is:

- The start timestamp and response code can make it a real request, and different response codes (for example, 400 and 500 for failed requests) can help when the user wants to identify different failure reasons. 

- If the application uses multiple threads, there can be trace logs, exceptions, and request records of different threads at the same moment, and this will cause the user to be unable to track them by timestamp. A correlation ID used through all steps will be important. According to the document, the ID of a request should be globally unique. To make sure the example works perfectly, we should add a function to verify if a newly generated random GUID is already used by any request records in Application Insights (this isn't implemented in the following example code). 

```C#
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

                request.Success = requestResult; // the following codes set Success, Duration and ResponseCode property of the request, then save it into Application Insight.
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
> [!NOTE ]
> You can also do the same thing by using custom telemetry. For more information, see the [official example](https://github.com/MohanGsk/ApplicationInsights-Home/tree/master/Samples/AzureEmailService/WorkerRoleA).
 
Pay attention to the specific lines in the above example project that are necessary to record requests in Application Insight:

- Line 4 to 6 are to import the Application Insight SDK
- Line 12 is to define a private TelemetryClient
- Line 25 is to generate a RequestTelemetry. Once it's created, all the changes should be saved into this RequestTelemetry, and SDK will save this RequestTelemetry into Application Insight.
- Line 29 to 31 are to configure the Name, ID, and StartTime property of the request.
- Line 66 to 69 are to set Success, Duration, and ResponseCode property of the request, then save it into Application Insight.

Except for the above necessary steps, you need to pay attention to how to save the custom Trace log and Exception, such as lines 61 and 62. If your application uses multiple threads, the unique specific ID will be helpful for us to track the request workflow in Application Insights.

- Start timestamp and response code can make it as a real request and different response code, for example 400 and 500 for failed requests, can help when user wants to identify different failure reasons.

For failed requests in Web Role, the unhandled exception and the handled exception (which is in the try function) with `ai.TrackException` are automatically collected in the exception table. 

For the example exception in the screenshot, if there isn't `ai.TrackException` in line 47, the exception is considered a handled exception, but it won't be recorded into Application Insight.

To find the exception records in the Application Insights instances, you can use one of the following methods:

#### View the Failures page in the Azure portal

1. Go to the Azure portal, select the Application insights instance, and then select **Failures**.
2. Locate the failed request in the **Operations** tab by adjusting the time range and selecting the corresponding operation.
3. Select the operation name. The failed requests with a specific exception type or response code will be listed automatically. For more information, see [Part1]

#### Query Logs in the Azure portal

The second method uses the **Logs** option of Application Insights. This method is more complicated, but it allows you to use more custom filters to look for specific types of exceptions. It also provides more details that will not be displayed in the Failures page.
 
By design, the request of Web Role is automatically marked with a unique ID in Cloud Service to identify the correlation. The only point is how we can find them in Application Insight.
 
The steps will be:

1.    Locate the failed request in requests table and record its ID:
    ```
    requests
    | where resultCode == "500"
    ```
     
2.    Find the exception with same ID in exceptions table:

    ```
    exceptions
    | where operation_ParentId == "8d1adf11abf73c42"
    ```

The way of tracking exceptions based on a failed request will be helpful when you want to troubleshoot an intermittent failure issue since it will contain the complete CallStack of that request.
 
### Check the failed request and related exception for Worker Role

Since the unhandled exception of Worker Role may cause the whole application downtime, it is recommended to handle all the exceptions in Worker Role that means that it should be included by `try` function. As Web Role, to the handled exceptions, `ai.TrackException` is needed to record the exceptions into Application Insights.

Steps to check the exception in Worker Role is similar to the Web Role. The only difference is that there isn't a built-in system to record the exceptions automatically, so some extra codes are needed to archive the goal.

Here are multiple possible situations:

- Worker Role doesn't include a system of recording custom requests, the only data that can be used to track the relationship between exception record and real operation in application is the timestamp. 

  In this situation, the way of checking Failures page is still possible for user to use, but it's needed to switch to Exceptions page and check the timestamp manually.  The way to check accurate data in Logs page can also be used. The following is an example query to check exceptions between a specific time range.

    ```
    exceptions 
    | where timestamp between (datetime(2022-05-11 00:00) .. datetime(2022-05-13 00:00)) 
    ```
- WorkerRole includes a system to record custom requests with custom ID, but it's not included in the exception record. It will be the same as situation 1.
- WorkerRole includes a system to record custom requests with custom ID, and it's included in the exception record, such as the line 62 of the example. The way to record the function of WorkerRole application as request, it will be the same as situation of WebRole.Y ou can check the **Failures** page or **Logs** page to find the related requests and exceptions. The query used in Logs page will be like:

    ```
    requests 
    | where success == False 
    ```
    ```
    exceptions 
    | where * contains "<request ID>" 
    ```

## Common scenarios and guidelines

In this part, there will be several common scenarios and the related guidelines about how to use Application Insights to meet the requirements.

### Monitor the Memory and Request status of a Web Role

To monitor the Memory and Request status of the Web Role in Cloud Service, you just need to enable Application Insights on the role that you wants to collect metrics data from. Then It will automatically collect data for Memory usage and request status of the Web Role.

To see the collected data, it's recommended to use the Metrics page of the Application Insights. Under Application Insight standard metrics as Metric Namespace, there's Available memory under Server part for the memory. Also there are Server requests under Server part, Failed requests and exceptions under Failure part or some other metric type to monitor the request status.

To monitor the Memory and Request status for the Web Role in Cloud Service, you just need to enable Application Insights on the role that you wants to collect metrics data from. Then It will automatically collect data for Memory usage and request status of the Web Role.

To see the collected data, it's recommended to use the **Metrics** page of the Application Insights. For more information, see [System performance counters in Application Insights](https://docs.microsoft.com/azure/azure-monitor/app/performance-counters).

Like WebRole, it's also possible to monitor the memory and request status of the WorkerRole but there will be some extra limitations:

Like Web Role, it's also possible to monitor the memory and request status of the Worker Role but there will be some limitations:

1. For Worker Role, the memory metrics data won't be automatically collected by default. To monitor the memory status, you need to enable the `\Memory\Available MBytes` from Performance Counters of Diagnostic Setting. The collected data will be in the `custommetrics` table of Logs page.
1. To view the metrics chart of the collected memory data, go to the **Metrics** page in Application Insights, select **Log-based metrics** in Metric Namespace and **Available Memory** under **Performance** in Metric. The chart of the Available Memory of selected time range will be displayed.

- The dotted line in the chart means that the data isn't accurate enough to generate the data or the data is missed during that time range. From the Logs, the interval of collecting the Memory data is about 3 minutes. In the chart above, since the time range is set to Last hour, the time difference between every two points will be less than 3 minutes so the collected data won't be accurate enough. Thus, it's dotted line.
- The unit of the data is billion.

For example, when a Cloud Service Web Role receives a request, it needs to get some data from a remote server, such as SQL Database, then generate the data into a web page and return it to the user. Imagine that this progress is much slower than expected but still successful, it's reasonable that user wants to clarify whether most of time spent is during the communication with SQL Database or during the progress inside the Cloud Service. For that, it will need user to add some extra custom log to record the timestamp of each step, such as start of the progress, start of the communication with SQL Database, end of the communication with SQL Database and end of generating the webpage etc.

For example, when a Cloud Service WebRole receives a request, it needs to get some data from a remote server, such as SQL Database, then generate the data into a web page and return it to the user. Imagine that this progress is much slower than expected but still successful, it's reasonable that user wants to clarify whether most of time spent is during the communication with SQL Database or during the progress inside the Cloud Service. For that, it will need user to add some extra custom log to record the timestamp of each step, such as start of the progress, start of the communication with SQL Database, end of the communication with SQL Database and end of generating the webpage etc.

1. For both Worker Role and Web Role, it's recommended to save trace log at every process start step. For example, in the above example codes, it's possible to add trace log at following points when:

1. For both WorkerRole and WebRole, please check previous part. The way to add custom log to save custom trace log into Application Insights. It's recommended to save trace log at every process start step. For example, in the above example scenario, it's possible to add trace log at following points when:

2. If the main process is the application in Worker Role, record the functions of Worker Role application as request to add custom correlation ID into custom request record and exception record. 

Once the logic is implemented, you can check the requests in the **Performance** page of Application Insights and focus on the request durations by following:

1. Select a operation which you want to check.
1. Scale the duration distribution chart to the longest duration part
1. Select **Drill into samples**.
1. Select a request as example and get the built-in or custom ID of this request.

If the system isn't quite complicated, the time spent by different steps will be displayed in the End-to-end transaction chart. If the system is complicated or we're using a custom ID which causes it unable to display the data in chart, use following query to get all related trace logs containing same correlation ID:

```
traces
| where * contains "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" 
```
By this way, it's possible for user to calculate the difference between every trace log to get the time spent by every step.

By this way, it's possible for you to calculate the difference between every trace log to get the time spent by every step.

### Troubleshoot performance issues such as high CPU/Memory of Worker Role

Sometimes you will need to identify issues such as a Worker Role consuming very high CPU/Memory. The only thing which can be observed from outside of the Cloud Service is that the Worker Role is consuming much CPU/Memory but you has no idea what exactly is happening in the instance.

To troubleshoot such issues, there will be mainly two steps:

Add a custom log to track every step which the Worker Role application will do. This is very important because this step enables you to identify if the application is still running well and to compare the time spent in each step with the normal situation. This can help you to identify whether the application is affected by the high CPU/Memory issue. About how to add custom log system, please kindly refer to [add custom log](#add-custom-log).

Capture the dump file. Here are some tips:

User can RDP into the instance having high CPU/Memory issue and verify which process is consuming most of the CPU/Memory. If it's WaWorkerHost, then it means that it's the application itself consuming so much CPU/Memory.

If the instances are having high CPU/Memory and the application is just with low-performance but not crashed, then you can try to RDP into the instance and capture a dump file for this. For more details about how to capture the dump file, please kindly refer to this document. For example, you can use following command to capture a dump file when the CPU consumed by WaWorkerHost is higher than 85 for at least 3 seconds. Five dump files will be captured and saved into `c:\procdumps` directory.

```
 procdump.exe -accepteula -c 85 -s 3 -n 5 WaWorkerHost.exe c:\procdumps
```
In the diagnostic setting page of Cloud Service, you can also set the crash dump file auto-generation. For more details of this part, please refer to this document.