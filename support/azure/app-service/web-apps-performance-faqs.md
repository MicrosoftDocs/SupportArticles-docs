---
title: Azure App Service FAQ - Availability, Performance, and Application Issues
description: Get answers to frequently asked questions about availability, performance, and application issues in Azure App Service.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-app-service
ms.date: 04/15/2025
ms.reviewer: toan, shrahman
ms.custom: sap:Availability, Performance, and Application Issues
---
# Application performance FAQs for Web Apps in Azure

> [!NOTE]
> Some of the following guidelines might only work on Windows or Linux App Services. For example, Linux App Services run in 64-bit mode by default.

This article answers common questions about availability, performance, and troubleshooting application issues in the [Web Apps feature of Azure App Service](https://azure.microsoft.com/services/app-service/web/). Use this guide to quickly resolve problems and optimize your app’s reliability.

## Where can I learn more about quotas and limits for various App Service plans?

For information about quotas and limits, see [App Service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).

## My App Service Plan displaying CPU/Memory usage even when all Web Apps are stopped

Azure App Service requires continuous system processes that handle several platform operations and features, such as security updates, availability of the SCM console, application monitoring, authentication, and many other vital features of your Web App.

System processes will run on App Service Plans even if there are no Web Apps running or if the App Service Plan contains no Web Apps.

The platform processes will consume a minimum amount of resources (such as CPU, Memory and Disk space), and the same should be accounted during the capacity planning, monitoring, and auto-scaling trigger configuration of an App Service Plan.

## My app perfromance is slow

Multiple factors might contribute to slow app performance. For detailed troubleshooting steps, see [Troubleshoot slow web app performance](/azure/app-service/troubleshoot-performance-degradation).

> [!TIP]
> - Enable the **Always On** setting under **Configuration** > **General settings** to keep your app warm and avoid cold starts. This helps reduce delay after idle time, especially in Basic and higher plans.
> - Configure a Health check path to monitor app health and automatically replace unresponsive instances. This helps maintain availability and performance. For more information, see [Monitor App Service instances by using Health check](/azure/app-service/monitor-instances-health-check).

## How do I troubleshoot high CPU consumption?

In some high CPU-consumption scenarios, your app might truly require more computing resources. In that case, consider scaling to a higher service tier so the application gets all the resources it needs. Other times, high CPU consumption might be caused by a bad loop or by a coding practice. Getting insight into what's triggering increased CPU consumption is a two-part process. First, create a process dump, and then analyze the process dump. For more information, see [Capture and analyze a dump file for high CPU consumption for Web Apps](/archive/blogs/asiatech/how-to-capture-dump-when-intermittent-high-cpu-happens-on-azure-web-app).

## How do I troubleshoot high memory consumption?

In some high memory-consumption scenarios, your app might truly require more computing resources. In that case, consider scaling to a higher service tier so the application gets all the resources it needs. Other times, a bug in the code might cause a memory leak. A coding practice might also increase memory consumption. Getting insight into what's triggering high memory consumption is a two-part process. First, create a process dump, and then analyze the process dump. Crash Diagnoser from the Azure Site Extension Gallery can efficiently perform both these steps. For more information, see [Capture and analyze a dump file for intermittent high memory for Web Apps](/archive/blogs/asiatech/how-to-capture-and-analyze-dump-for-intermittent-high-memory-on-azure-web-app).

## How do I automate App Service web apps by using PowerShell?

You can use PowerShell cmdlets to manage and maintain App Service web apps. In our blog post [Automate web apps hosted in Azure App Service by using PowerShell](/archive/blogs/puneetgupta/automating-webapps-hosted-in-azure-app-service-through-powershell-arm-way), we describe how to use Azure Resource Manager-based PowerShell cmdlets to automate common tasks.

> [!NOTE]
> For current automation scripts, use the latest [Az.Websites](/powershell/module/az.websites) module. The older `AzureRM` module is deprecated.

## I need to gather information to troubleshoot my web app

### To view a web app's event logs
1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
2. In the menu, select **Debug Console** > **CMD**.
3. Select the **LogFiles** folder.
4. To view event logs, select the pencil icon next to **eventlog.xml**.
5. To download the logs, run the PowerShell cmdlet `Save-AzureWebSiteLog -Name webappname`.

### To capture a user-mode memory dump of a web app
1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
2. Select the **Process Explorer** menu.
3. Right-click the **w3wp.exe** process or your WebJob process.
4. Select **Download Memory Dump** > **Full Dump**.

### How to view process-level info for a web app

You have two options for viewing process-level information for your web app:

- In the Azure portal:
    1. Open the **Process Explorer** for the web app.
    2. To see the details, select the **w3wp.exe** process.
- In the Kudu console:
    1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
    2. Select the **Process Explorer** menu.
    3. For the **w3wp.exe** process, select **Properties**.

### I can't find my log files in the folder structure of my web app when using the Local Cache feature of App Service
If you use the Local Cache feature of App Service, the folder structure of the LogFiles and Data folders for your App Service instance are affected. When Local Cache is used, subfolders are created in the storage LogFiles and Data folders. The subfolders use the naming pattern "unique identifier" + time stamp. Each subfolder corresponds to a VM instance in which the web app is running or has run.

To determine whether you're using Local Cache, check your App Service **Application settings** tab. If Local Cache is being used, the app setting `WEBSITE_LOCAL_CACHE_OPTION` is set to `Always`.

### To turn on failed request tracing

To turn on failed request tracing, follow these steps:

1. In the Azure portal, go to your web app.
2. Select **All Settings** > **Diagnostics Logs**.
3. For **Failed Request Tracing**, select **On**.
4. Select **Save**.
5. On the web app blade, select **Tools**.
6. Select **Visual Studio Online**.
7. If the setting isn't **On**, select **On**.
8. Select **Go**.
9. Select **Web.config**.
10. In system.webServer, add the following configuration (to capture a specific URL):

    ```xml
    <system.webServer>
    <tracing> <traceFailedRequests>
    <remove path="*api*" />
    <add path="*api*">
    <traceAreas>
    <add provider="ASP" verbosity="Verbose" />
    <add provider="ASPNET" areas="Infrastructure,Module,Page,AppServices" verbosity="Verbose" />
    <add provider="ISAPI Extension" verbosity="Verbose" />
    <add provider="WWW Server" areas="Authentication,Security,Filter,StaticFile,CGI,Compression, Cache,RequestNotifications,Module,FastCGI" verbosity="Verbose" />
    </traceAreas>
    <failureDefinitions statusCodes="200-999" />
    </add> </traceFailedRequests>
    </tracing>
    ```

11. To troubleshoot slow-performance issues, add this configuration (if the capturing request is taking more than 30 seconds):

    ```xml
    <system.webServer>
    <tracing> <traceFailedRequests>
    <remove path="*" />
    <add path="*">
    <traceAreas> <add provider="ASP" verbosity="Verbose" />
    <add provider="ASPNET" areas="Infrastructure,Module,Page,AppServices" verbosity="Verbose" />
    <add provider="ISAPI Extension" verbosity="Verbose" />
    <add provider="WWW Server" areas="Authentication,Security,Filter,StaticFile,CGI,Compression, Cache,RequestNotifications,Module,FastCGI" verbosity="Verbose" />
    </traceAreas>
    <failureDefinitions timeTaken="00:00:30" statusCodes="200-999" />
    </add> </traceFailedRequests>
    </tracing>
    ```

12. To download the failed request traces, in the [portal](https://portal.azure.com), go to your website.
13. Select **Tools** > **Kudu** > **Go**.
14. In the menu, select **Debug Console** > **CMD**.
15. Select the **LogFiles** folder, and then select the folder with a name that starts with **W3SVC**.
16. To see the XML file, select the pencil icon.

## Additional recommendations for performance and resiliency

- Use Application Insights and Azure Monitor for full-stack observability of your App Service app, including telemetry, dependency tracing, and live metrics.

- If you're deploying in regions that support availability zones, consider enabling zone redundancy to enhance resiliency during regional outages. For more information, see [Reliability in Azure App Service](/azure/reliability/reliability-app-service).

- App Service undergoes routine maintenance to ensure platform reliability. For more control over update behavior, especially in App Service Environment v3, configure upgrade preference.  For more information, see [Routine (planned) maintenance for Azure App Service](/azure/app-service/routine-maintenance).
