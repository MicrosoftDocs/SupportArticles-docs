---
title: Web apps performance, availability, and application issues - Azure App Service
description: Troubleshoot Azure App Service performance issues, high CPU or memory usage, availability, logs, and failed requests. Explore answers and diagnostic steps.
author: kaushika-msft
ms.author: kaushika
ms.service: azure-app-service
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 08/26/2026
ms.reviewer: toan, shrahman, kaushika
ms.custom: sap:Availability, Performance, and Application Issues
---
# Web apps performance, availability, and application issues for Azure App Service

> [!NOTE]
> Some of the following guidelines might only work on Windows App Service or Linux App Service. For example, Linux App Service runs in 64-bit mode by default.

## Summary

This article answers frequently asked questions (FAQ) about application performance issues for the [web apps feature of Azure App Service](https://azure.microsoft.com/services/app-service/web/).

## Where can I learn more about quotas and limits for various App Service plans?

For information about quotas and limits, see [App Service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).

## My App Service plan displays CPU or memory usage even when all web apps are stopped

App Service requires continuous system processes that handle several platform operations and features, such as security updates, availability of the SCM (Kudu) console, application monitoring, authentication, and many other web app features.

System processes run on App Service plans even if there are no web apps running or if the App Service plan contains no web apps.

The platform processes consume a minimum amount of resources (such as CPU, memory, and disk space), and you should account for these resources during the capacity planning, monitoring, and auto-scaling trigger configuration of an App Service plan.

## My app performance is slow

Multiple factors might contribute to slow app performance. For detailed troubleshooting steps, see [Troubleshoot slow web app performance](/azure/app-service/troubleshoot-performance-degradation).

> [!TIP]
> - Enable the **Always On** setting under **Configuration** > **General settings** to keep your app warm and avoid cold starts. This setting helps reduce delay after idle time, especially in Basic and higher plans.
> - Configure a Health check path to monitor app health and automatically replace unresponsive instances. This configuration helps maintain availability and performance. For more information, see [Monitor App Service instances by using Health check](/azure/app-service/monitor-instances-health-check).

## How do I troubleshoot high CPU consumption?

In some high CPU consumption scenarios, your app might truly require more computing resources. In that case, consider scaling to a higher service tier so the application gets all the resources it needs. Other times, high CPU consumption might be caused by a bad loop or by a coding practice. Getting insight into what's triggering increased CPU consumption is a two-part process. First, create a process dump, and then analyze the process dump. For more information, see [Capture and analyze a dump file for high CPU consumption for Web Apps](/archive/blogs/asiatech/how-to-capture-dump-when-intermittent-high-cpu-happens-on-azure-web-app).

## How do I troubleshoot high memory consumption?

In some high memory consumption scenarios, your app might truly require more computing resources. In that case, consider scaling to a higher service tier so the application gets all the resources it needs. Other times, a bug in the code might cause a memory leak. A coding practice might also increase memory consumption. Getting insight into what's triggering high memory consumption is a two-part process. First, create a process dump, and then analyze the process dump. Crash Diagnoser from the Azure Site Extension Gallery can efficiently perform both these steps. For more information, see [Capture and analyze a dump file for intermittent high memory for Web Apps](/archive/blogs/asiatech/how-to-capture-and-analyze-dump-for-intermittent-high-memory-on-azure-web-app).

## How do I automate App Service web apps by using PowerShell?

You can use PowerShell cmdlets to manage and maintain App Service web apps. See [Automate web apps hosted in Azure App Service by using PowerShell](/archive/blogs/puneetgupta/automating-webapps-hosted-in-azure-app-service-through-powershell-arm-way) for more information on how to use Azure Resource Manager-based PowerShell cmdlets to automate common tasks.

> [!NOTE]
> For current automation scripts, use the latest [Az.Websites](/powershell/module/az.websites) module. The older `AzureRM` module is deprecated.

## I need to gather information to troubleshoot my web app

### View a web app's event logs

To view a web app's event logs, follow these steps:

1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
2. In the menu, select **Debug Console** > **CMD**.
3. Select the **LogFiles** folder.
4. To view event logs, select the pencil icon next to **eventlog.xml**.
5. To download the logs, run the PowerShell cmdlet `Save-AzureWebSiteLog -Name webappname`.

### Capture a user-mode memory dump of a web app

To capture a user-mode memory dump of a web app, follow these steps:

1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
2. Select the **Process Explorer** menu.
3. Right-click the **w3wp.exe** process or your WebJob process.
4. Select **Download Memory Dump** > **Full Dump**.

### View process-level info for a web app

You have two options for viewing process-level information for your web app:

- In the [Azure portal](https://portal.azure.com):
    1. Open the **Process Explorer** for the web app.
    2. To see the details, select the **w3wp.exe** process.

- In the Kudu console:
    1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
    2. Select the **Process Explorer** menu.
    3. For the **w3wp.exe** process, select **Properties**.

### I can't find my log files in the folder structure of my web app when using the local cache feature of App Service

If you use the local cache feature of App Service, it affects the folder structure of the LogFiles and Data folders for your App Service instance. When local cache is used, the system creates subfolders in the storage LogFiles and Data folders. The subfolders use the naming pattern "unique identifier" plus time stamp. Each subfolder corresponds to a virtual machine (VM) instance in which the web app is running or has run.

To determine whether you're using local cache, check your App Service **Application settings** tab. If the system uses local cache, the app setting `WEBSITE_LOCAL_CACHE_OPTION` is set to `Always`.

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

12. To download the failed request traces, in the Azure portal, go to your website.
13. Select **Tools** > **Kudu** > **Go**.
14. In the menu, select **Debug Console** > **CMD**.
15. Select the **LogFiles** folder, and then select the folder with a name that starts with **W3SVC**.
16. To see the XML file, select the pencil icon.

## Additional recommendations for performance and resilience

- Use Application Insights and Azure Monitor for full-stack observability of your App Service app, including telemetry, dependency tracing, and live metrics.

- If you're deploying in regions that support availability zones, consider enabling zone redundancy to enhance resilience during regional outages. For more information, see [Reliability in Azure App Service](/azure/reliability/reliability-app-service).

- App Service undergoes routine maintenance to ensure platform reliability. For more control over update behavior, especially in App Service Environment v3, configure upgrade preference. For more information, see [Routine (planned) maintenance for Azure App Service](/azure/app-service/routine-maintenance).