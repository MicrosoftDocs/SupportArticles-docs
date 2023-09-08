--- 
title: Troubleshoot problems with Azure Application Insights Profiler
description: This article presents troubleshooting steps and information to help developers enable and use Application Insights Profiler.
ms.date: 07/25/2023
ms.reviewer: v-leedennis, aaronmax, cweining, v-jsitser, hannahhunter, ryankahng, v-weizhu
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to know how to troubleshoot various problems enabling or viewing Application Insights Profiler so I can use it effectively.  
---
# Troubleshoot Application Insights Profiler

This article provides troubleshooting steps and information for using Azure Application Insights Profiler.

## Make sure you use the appropriate Profiler endpoint

Currently, the only regions that require endpoint modifications are [Azure Government](/azure/azure-government/compare-azure-government-global-azure#application-insights) and [Azure China](/azure/china/resources-developer-guide).

|App setting    | US Government Cloud | China Cloud |
|---------------|---------------------|-------------|
|ApplicationInsightsProfilerEndpoint         | `https://profiler.monitor.azure.us`    | `https://profiler.monitor.azure.cn` |
|ApplicationInsightsEndpoint | `https://dc.applicationinsights.us` | `https://dc.applicationinsights.azure.cn` |

## Make sure your app runs on right version

Profiler is supported on the [.NET Framework later than version 4.6.2](https://dotnet.microsoft.com/download/dotnet-framework).

If your web app is an ASP.NET Core application, it must be run on the [latest supported ASP.NET Core runtime](https://dotnet.microsoft.com/download/dotnet/6.0).

## Make sure you use right Azure service plan

Profiler isn't currently supported on free or shared app service plans. Upgrade to one of the basic plans for Profiler to start working.

> [!NOTE]
> The Azure Functions consumption plan isn't supported. For more information, see [Profile live Azure Functions app with Application Insights](/azure/azure-monitor/profiler/profiler-azure-functions).

## Make sure you search for Profiler data within right timeframe

If the data you try to view is older than a couple of weeks, try limiting your time filter and try again. Traces are deleted after seven days.

## Make sure you can access the gateway

Check that proxies or a firewall isn't blocking your access to `https://gateway.azureserviceprofiler.net`.

## Make sure the Profiler is running or hasn't timed out

Profiling data is uploaded only when it can be attached to a request that happens while Profiler is running. The Profiler collects data for two minutes each hour. You can also trigger the Profiler by [starting a profiling session](/azure/azure-monitor/profiler/profiler-settings#profile-now).

Profiler writes trace messages and custom events to your Application Insights resource. You can use these events to see how Profiler is running.

To search for trace messages and custom events that Profiler sends to your Application Insights resource, follow these steps:

1. In your Application Insights resource, select **Search** from the top menu bar.

   :::image type="content" source="media/profiler-troubleshooting/search-trace-messages.png" alt-text="Screenshot of selecting the search button from the Application Insights resource.":::

1. Use the search string `stopprofiler OR startprofiler OR upload OR ServiceProfilerSample` to find the relevant data.

   :::image type="content" source="media/profiler-troubleshooting/search-results.png" alt-text="Screenshot of the search results from the aforementioned search string.":::

   The search results above include two examples of searches from two AI resources:

   - If the application doesn't receive requests while Profiler is running, the message explains that the upload is canceled because of no activity.

   - Profiler starts and sends custom events when it detects requests that happens while Profiler is running. If the `ServiceProfilerSample` custom event is displayed, it means that a profile is captured and is available in the **Application Insights Performance** pane.

   If no records are displayed, Profiler isn't running or has timed out. Make sure you've [enabled Profiler on your Azure service](/azure/azure-monitor/profiler/profiler).  

## Double counting in parallel threads

When two or more parallel threads are associated with a request, the total time metric in the stack viewer may be more than the duration of the request. In that case, the total thread time is more than the actual elapsed time.

For example, one thread might be waiting on the other to be completed. The viewer tries to detect this situation and omits this wait. In this case, it may display excessive information instead of ignoring potentially critical information.

When you see parallel threads in your traces, determine which threads are waiting so that you can identify the hot path for the request. Usually, the thread that quickly goes into a wait state is simply waiting on the other threads. Concentrate on the other threads, and ignore the time in the waiting threads.

## Troubleshoot Profiler on your specific Azure service

### Azure App Service

For Profiler to work properly, make sure the following things:

- Your web app has [Application Insights enabled](/azure/azure-monitor/profiler/profiler) with the [right settings](/azure/azure-monitor/profiler/profiler#for-application-insights-and-app-service-in-different-subscriptions).

- The ApplicationInsightsProfiler3 webjob is running. To check the webjob, follow these steps:

   1. [Access the Kudu service](https://github.com/projectkudu/kudu/wiki/Accessing-the-kudu-service).

        In the Azure portal, go to your App Service. Select **Advanced Tools** from the left side menu and then select **Go**.

   1. In the top menu, select **Tools** > **WebJobs dashboard**. The **WebJobs** pane opens. 

      If **ApplicationInsightsProfiler3** doesn't show up, restart your App Service application.

      :::image type="content" source="media/profiler-troubleshooting/profiler-web-job.png" alt-text="Screenshot of the WebJobs pane, which displays the name, status, and last run time of jobs.":::

   1. To view the details of the webjob, including the log, select the **ApplicationInsightsProfiler3** link. The **Continuous WebJob Details** pane opens.

      :::image type="content" source="media/profiler-troubleshooting/profiler-web-job-log.png" alt-text="Screenshot of the Continuous WebJob Details pane.":::

If Profiler still isn't working for you, you can download the log and [submit an Azure support ticket](https://azure.microsoft.com/support/).

#### Check the Diagnostic Services site extension's status page

If Profiler is enabled through the [Application Insights pane](/azure/azure-monitor/profiler/profiler) in the Azure portal, it is enabled by the Diagnostic Services site extension. You can check the status page of this extension by going to the URL `https://<site-name>.scm.azurewebsites.net/DiagnosticServices`.

> [!NOTE]
> The domain of the status page link will vary depending on the cloud. This domain will be the same as the Kudu management site for App Service.

The status page shows the installation state of the Profiler and [Snapshot Debugger](/azure/azure-monitor/snapshot-debugger/snapshot-debugger) agents. If there's an unexpected error, the status page will be displayed and show how to fix the error.

You can use the Kudu management site for App Service to get the base URL of this status page. To do this, follow these steps:

1. Open your App Service application from the Azure portal.
2. Select **Advanced Tools** > **Go**.
3. Once on the Kudu management site, append `/DiagnosticServices` to the URL and press <kbd>Enter</kbd>.

    It will end like this: `https://<kudu-url>/DiagnosticServices`. It will display a status page similar to the following:

    :::image type="content" source="media/profiler-troubleshooting/status-page.png" alt-text="Screenshot of the Diagnostic Services Status Page.":::

> [!NOTE]
> Codeless installation of Application Insights Profiler follows the .NET Core support policy. For more information about supported runtimes, see [.NET Core Support Policy](https://dotnet.microsoft.com/platform/support/policy/dotnet-core).

#### Manual installation

When you configure Profiler, updates are applied to the web app's settings. If necessary, you can [apply the updates manually](/azure/azure-monitor/profiler/profiler#verify-always-on-setting-is-enabled).

#### Too many active profiling sessions

You can enable Profiler on a maximum of four Web Apps that are running in the same service plan. If you have more than four Web Apps, Profiler might throw the following error:

> Microsoft.ServiceProfiler.Exceptions.TooManyETWSessionException

To solve it, move some web apps to a different service plan.

#### Deployment error: Directory Not Empty 'D:\\home\\site\\wwwroot\\App_Data\\jobs'

If you redeploy your web app to a Web Apps resource with Profiler enabled, you might see the following message:

> Directory Not Empty 'D:\\home\\site\\wwwroot\\App_Data\\jobs'

This error occurs if you run Web Deploy from scripts or Azure Pipelines. To resolve this issue, add the following deployment parameters to the Web Deploy task:

- `-skip:Directory='.*\\App_Data\\jobs\\continuous\\ApplicationInsightsProfiler.*'`
- `-skip:skipAction=Delete,objectname='dirPath',absolutepath='.*\\App_Data\\jobs\\continuous$'`

- `-skip:skipAction=Delete,objectname='dirPath',absolutepath='.*\\App_Data\\jobs$'`

- `-skip:skipAction=Delete,objectname='dirPath',absolutepath='.*\\App_Data$'`

These parameters delete the folder used by Application Insights Profiler and unblock the redeploy process. They don't affect the Profiler instance that's currently running.

#### Is the Profiler running?

Profiler runs as a continuous webjob in the web app. You can open the web app resource in the Azure portal. In the **WebJobs** pane, check the status of ApplicationInsightsProfiler. If it isn't running, open **Logs** to get more information.

### Virtual machines and Cloud Services

To see whether Profiler is configured correctly by Azure Diagnostics, follow these steps:

1. Verify that the content of the deployed Azure Diagnostics configuration is what you expect.

1. Make sure the Azure Diagnostics passes the proper `iKey` on the Profiler command line.

1. Check the Profiler log file to see whether Profiler ran but returned an error.

To check the settings that is used to configure Azure Diagnostics, follow these steps:

1. Sign in to the virtual machine.

1. Open the log file at this location. The plugin version may be newer on your machine.

    - For VMs:

        *C:\WindowsAzure\logs\Plugins\Microsoft.Azure.Diagnostics.PaaSDiagnostics\1.11.3.12\DiagnosticsPlugin.log*

    - For Cloud Services:

        *C:\logs\Plugins\Microsoft.Azure.Diagnostics.PaaSDiagnostics\1.11.3.12\DiagnosticsPlugin.log*

1. In the file, search for the string `WadCfg` to find the settings that are passed to the VM to configure Azure Diagnostics.

1. Check whether the `iKey` used by the Profiler is correct.

1. Check the command line that's used to start Profiler. The arguments that are used to launch Profiler are in the following file (the drive could be `C` or `D` and the directory may be hidden):

    - For VMs:

        *C:\ProgramData\ApplicationInsightsProfiler\config.json*

    - For Cloud Services:

        *D:\ProgramData\ApplicationInsightsProfiler\config.json*

1. Make sure the `iKey` on the Profiler command line is correct.

1. Using the path found in the preceding *config.json* file, check the Profiler log file, called *BootstrapN.log*. It displays the following information:
   - The debug information that indicates the settings that Profiler is using.
   - Status and error messages from Profiler.  

    You can find the file from the following directions:

    - For VMs:

        *C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.Diagnostics.IaaSDiagnostics\1.17.0.6\ApplicationInsightsProfiler*

    - For Cloud Services:

        *C:\Logs\Plugins\Microsoft.Azure.Diagnostics.IaaSDiagnostics\1.17.0.6\ApplicationInsightsProfiler*

1. If Profiler is running while your application is receiving requests, the "Activity detected from iKey" message is displayed.

1. When the trace is uploaded, the "Start to upload trace" message is displayed.

### Edit network proxy or firewall rules

If your application connects to the internet via a proxy or a firewall, you may need to update the rules to communicate with the Profiler service.

The IPs used by Application Insights Profiler are included in the Azure Monitor service tag. For more information, see [Service Tags documentation](/azure/virtual-network/service-tags-overview).

## If all else fails

Submit a support ticket in the Azure portal. Include the correlation ID from the error message.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
