--- 
title: Troubleshoot problems with Azure Application Insights Profiler
description: This article presents troubleshooting steps and information to help developers enable and use Application Insights Profiler.
ms.date: 6/17/2022
author: kelleyguiney22
ms.author: v-kegui
editor: v-jsitser
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to know how to troubleshoot various problems enabling or viewing the Application Insights Profiler so I can use it effectively.  
---

# Troubleshoot problems enabling or viewing Azure Application Insights Profiler

This article provides troubleshooting steps and information to help you enable and use Application Insights Profiler.

## General troubleshooting

### Profiler endpoints

Currently the only regions that require endpoint modifications are [Azure Government](/azure/azure-government/compare-azure-government-global-azure#application-insights) and [Azure China](/azure/china/resources-developer-guide).

|App setting    | US government cloud | China cloud |
|---------------|---------------------|-------------|
|`ApplicationInsightsProfilerEndpoint`         | `https://profiler.monitor.azure.us`    | `https://profiler.monitor.azure.cn` |
|`ApplicationInsightsEndpoint` | `https://dc.applicationinsights.us` | `https://dc.applicationinsights.azure.cn` |

### Profiler uploads

Azure Application Insights Profiler collects data for two minutes each hour. It can also collect data when you select the **Profile Now** button in the **Configure Application Insights Profiler** pane.

> [!NOTE]
> The profiling data is uploaded only when it can be attached to a request that occurred while Profiler was running.

Profiler writes trace messages and custom events to your Application Insights resource. You can use these events to see how Profiler is running. Search for trace messages and custom events sent by Profiler to your Application Insights resource. You can use this search string to find the relevant data:

> `stopprofiler OR startprofiler OR upload OR ServiceProfilerSample`

The following image displays two examples of searches from two AI resources:

* At the left, the application isn't receiving requests while Profiler is running. The message explains that the upload was canceled because of inactivity.

* At the right, Profiler started and sent custom events when it detected requests that happened while Profiler was running. If the `ServiceProfilerSample` custom event is displayed, it means that a profile was captured and is available in the **Application Insights Performance** pane.

If no records are displayed, Profiler isn't running. To troubleshoot, see the troubleshooting sections for your specific app type in this article.  

:::image type="content" source="./media/profiler-troubleshooting/profiler-search-telemetry.png" alt-text="Screenshot of two examples of Profiler telemetry search results." lightbox="./media/profiler-troubleshooting/profiler-search-telemetry.png":::

### Other things to check

* Make sure that your app is running on .NET Framework 4.6.

* If your web app is an ASP.NET Core application, make sure it's running on at least ASP.NET Core [LTS](https://dotnet.microsoft.com/platform/support/policy/dotnet-core).

* If the data you're trying to view is older than a couple of weeks, try limiting your time filter and try again. Traces are deleted after seven days.

* Make sure that proxies or a firewall haven't blocked access to https://gateway.azureserviceprofiler.net.

* If you're using the free or shared app service plan (which don't support Profiler), try scaling up to one of the basic plans so that Profiler starts to work.

### Double-counting in parallel threads

In some cases, the total time metric in the stack viewer is more than the duration of the request.

This situation might occur when two or more parallel threads are associated with a request. In that case, the total thread time is more than the elapsed time.

One thread might be waiting on the other to be completed. The viewer tries to detect this situation and omits the uninteresting wait. It errs on the side of displaying too much information instead of omitting what might be critical information.

When you see parallel threads in your traces, determine which threads are waiting so that you can identify the hot path for the request.

Usually, the thread that quickly goes into a wait state is simply waiting on the other threads. Concentrate on the other threads, and ignore the time in the waiting threads.

### Error report in the profile viewer

Submit a support ticket in the portal. Be sure to include the correlation ID from the error message.

## Troubleshoot Profiler on Azure App Service

For Profiler to work properly, make sure that you've met the following requirements:

* Your web app service plan must be Basic tier or higher.
* Your web app must have Application Insights enabled.
* Your web app must have the following app settings:

  |App setting    | Value    |
  |---------------|----------|
  |`APPINSIGHTS_INSTRUMENTATIONKEY`         | iKey for your Application Insights resource    |
  |`APPINSIGHTS_PROFILERFEATURE_VERSION` | 1.0.0 |
  |`DiagnosticServices_EXTENSION_VERSION` | ~3 |

* The **ApplicationInsightsProfiler3** webjob must be running. To check the webjob:

   1. Go to [Kudu](/archive/blogs/cdndevs/the-kudu-debug-console-azure-websites-best-kept-secret).
   1. In the **Tools** menu, select **WebJobs Dashboard**.  
      The **WebJobs** pane opens. 

      :::image type="content" source="./media/profiler-troubleshooting/profiler-webjob.png" alt-text="Screenshot of the WebJobs pane, which displays the name, status, and last run time of jobs." lightbox="./media/profiler-troubleshooting/profiler-webjob.png":::

   1. To view the details of the webjob, including the log, select the **ApplicationInsightsProfiler3** link.  
     The **Continuous WebJob Details** pane opens.

      :::image type="content" source="./media/profiler-troubleshooting/profiler-webjob-log.png" alt-text="Screenshot of the Continuous WebJob Details pane." lightbox="./media/profiler-troubleshooting/profiler-webjob-log.png":::

If Profiler isn't working for you, you can download the log and send it to our team for assistance at serviceprofilerhelp@microsoft.com.

### Diagnostic Services site extension status page

If Profiler was enabled through the [Application Insights pane](/azure/azure-monitor/app/profiler) in the portal, it was enabled by the Diagnostic Services site extension.

> [!NOTE]
> Codeless installation of Application Insights Profiler follows the .NET Core support policy.
> For more information about supported runtimes, see [.NET Core Support Policy](https://dotnet.microsoft.com/platform/support/policy/dotnet-core).

You can check the status page of this extension by going to the following URL:
`https://{site-name}.scm.azurewebsites.net/DiagnosticServices`.

> [!NOTE]
> The domain of the status page link will vary depending on the cloud.
> This domain will be the same as the Kudu management site for App Service.

This status page shows the installation state of the Profiler and Snapshot Collector agents. If there was an unexpected error, the status page will display it and include information about how to fix it.

You can use the Kudu management site for App Service to get the base URL of this status page. Follow these steps: 

1. In the [Azure portal](https://portal.azure.com), open your App Service application.
2. Select **Advanced Tools**, or search for **Kudu**.
3. Select **Go**.
4. Once you're on the Kudu management site, append `/DiagnosticServices` to the URL, and then press Enter.

The URL will be in a `https://<kudu-url>/DiagnosticServices` format. It'll display a status page similar to the page below:

:::image type="content" source="./media/profiler-troubleshooting/status-page.png" alt-text="Screenshot of the Diagnostic Services status page." lightbox="./media/profiler-troubleshooting/status-page.png":::

### Manual installation

When you configure Profiler, updates are made to the web app's settings. If your environment requires it, you can apply the updates manually. An example might be that your application is running in a Web Apps environment for Power Apps. To apply updates manually, follow these steps:

1. In the **Web App Control** pane, open **Settings**.

1. Set **.NET Framework version** to **v4.6**.

1. Set **Always On** to **On**.
1. Create these app settings:

   |App setting    | Value    |
   |---------------|----------|
   |`APPINSIGHTS_INSTRUMENTATIONKEY`         | iKey for your Application Insights resource    |
   |`APPINSIGHTS_PROFILERFEATURE_VERSION` | 1.0.0 |
   |`DiagnosticServices_EXTENSION_VERSION` | ~3 |

### Too many active profiling sessions

You can enable Profiler on a maximum of four web apps that are running in the same service plan. If there are more than four web apps, Profiler might return a "Microsoft.ServiceProfiler.Exceptions.TooManyETWSessionException" error. To resolve this error, move some web apps to a different service plan.

### Deployment error: Directory Not Empty 'D:\\home\\site\\wwwroot\\App_Data\\jobs'

If you're redeploying your web app to a Web Apps resource with Profiler enabled, you might see the following error message:

> Directory Not Empty 'D:\\home\\site\\wwwroot\\App_Data\\jobs'

This error occurs if you run Web Deploy from scripts or from the Azure Pipelines. The solution is to add the following deployment parameters to the Web Deploy task:

> `-skip:Directory='.*\App_Data\jobs\continuous\ApplicationInsightsProfiler.*'`  
> `-skip:skipAction=Delete,objectname='dirPath',absolutepath='.*\App_Data\jobs\continuous$'`  
> `-skip:skipAction=Delete,objectname='dirPath',absolutepath='.*\App_Data\jobs$'`  
> `-skip:skipAction=Delete,objectname='dirPath',absolutepath='.*\App_Data$'`

These parameters delete the folder that's used by Application Insights Profiler and unblock the redeploy process. They don't affect the Profiler instance that's currently running.

### Is Application Insights Profiler running?

Profiler runs as a continuous webjob in the web app. You can open the web app resource in the [Azure portal](https://portal.azure.com). In the **WebJobs** pane, check the status of **ApplicationInsightsProfiler**. If it isn't running, open **Logs** to get more information.

## Troubleshoot VMs and cloud services

>[!NOTE]
>**The bug in the profiler that ships in the Windows Azure Diagnostics extension (WAD) for Cloud Services has been fixed.** The latest version of WAD (1.12.2.0) for Cloud Services works with all recent versions of the App Insights SDK. Cloud Service hosts will upgrade WAD automatically, but it isn't immediate. To force an upgrade, you can redeploy your service or reboot the node.

### Profiler configuration

To check whether Profiler is configured correctly by Azure Diagnostics, follow these steps:

1. Verify that the content of the Azure Diagnostics configuration deployed is what you expect.

1. Make sure that Azure Diagnostics passes the proper iKey on the Profiler command line.

1. Check the Profiler log file to see whether Profiler ran but returned an error.

### Azure Diagnostics configuration settings

To check the settings that were used to configure Azure Diagnostics:

1. Sign in to the virtual machine (VM), and then open the log file at this location. The plug-in version may be newer on your machine.

   | Component | Location of the log file |
   | --------- | ------------------------ |
   | VMs | *c:\WindowsAzure\logs\Plugins\Microsoft.Azure.Diagnostics.PaaSDiagnostics\1.11.3.12\DiagnosticsPlugin.log* |
   | Cloud Services | *c:\logs\Plugins\Microsoft.Azure.Diagnostics.PaaSDiagnostics\1.11.3.12\DiagnosticsPlugin.log* |

1. In the log file, search for the **WadCfg** string to find the settings that were passed to the VM to configure Azure Diagnostics. You can check to see whether the iKey used by the Profiler sink is correct.

1. Check the command line that's used to start Profiler. The arguments that are used to launch Profiler are in the following file. (The drive could be *c:* or *d:*, and the directory may be hidden.)

   | Component | Location of the command-line argument file |
   | --------- | ------------------------------------------ |
   | VMs | *c:\ProgramData\ApplicationInsightsProfiler\config.json* |
   | Cloud Services | *d:\ProgramData\ApplicationInsightsProfiler\config.json* |

1. Make sure that the iKey on the Profiler command line is correct. 

1. Using the path found in the preceding *config.json* file, check the Profiler log file, called *Bootstrap\<N>.log*. It displays the debug information that indicates the settings that Profiler is using. It also displays status and error messages from Profiler.  

   | Component | Directory of the Profiler log file |
   | --------- | ---------------------------------- |
   | VMs | *c:\WindowsAzure\Logs\Plugins\Microsoft.Azure.Diagnostics.IaaSDiagnostics\1.17.0.6\ApplicationInsightsProfiler* |
   | Cloud Services | *c:\Logs\Plugins\Microsoft.Azure.Diagnostics.IaaSDiagnostics\1.17.0.6\ApplicationInsightsProfiler* |

   If Profiler is running while your application is receiving requests, the following message is displayed:
   
   > Activity detected from iKey

   When the trace is being uploaded, the following message is displayed:
   
   > Start to upload trace

## Edit network proxy or firewall rules

If your application connects to the Internet via a proxy or a firewall, you might need to update the rules to communicate with the Profiler service.

The IPs used by Application Insights Profiler are included in the Azure Monitor service tag. For more information, see [Service Tags documentation](/azure/virtual-network/service-tags-overview).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]