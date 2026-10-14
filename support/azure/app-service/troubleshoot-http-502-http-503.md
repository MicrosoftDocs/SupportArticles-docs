---
title: Troubleshoot "HTTP 502" and "HTTP 503" errors
description: Troubleshoot HTTP 502 Bad Gateway and HTTP 503 Service Unavailable errors in Azure App Service. Learn how to diagnose, mitigate, and resolve app issues.
tags: top-support-issue
keywords: HTTP 502 bad gateway, HTTP 503 service unavailable, HTTP error 503, HTTP error 502
ms.assetid: 51cd331a-a3fa-438f-90ef-385e755e50d5
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: azure-app-service
ms.date: 08/21/2026
ms.author: kaushika
author: kaushika-msft
ms.reviewer: msangapu, kaushika
ms.custom: sap:Networking
#customer intent: As an app developer, I need to troubleshoot common errors if they occur using tools provided by Azure App Service.
---
# Troubleshoot "HTTP 502" and "HTTP 503" errors in Azure App Service

## Summary

You might see "HTTP 502 Bad Gateway" and "HTTP 503 Service Unavailable" errors when you open an app that you host in [Azure App Service](/azure/app-service/overview). This article helps you troubleshoot these errors.

These errors often happen because of an application-level problem, such as:

"HTTP 502" and "HTTP 503" errors can be caused by:

- Requests take a long time.
- The app uses high memory or CPU.
- An exception prevents the app from responding.

Troubleshooting involves three tasks, in sequential order:

1. [Observe and monitor application behavior](#observe-and-monitor-application-behavior)
1. [Collect data](#collect-data)
1. [Mitigate the problem](#mitigate-the-problem)

App Service gives you options for each task.

## Observe and monitor application behavior

App Service provides several ways to observe app behavior.

### Track service health

Azure publicizes service interruptions and performance degradations in App Service. You can track the health of the service in the [Azure portal](https://portal.azure.com/). For more information, see [View service health notifications from the Azure portal](/azure/service-health/service-notifications-old).

### Monitor your app

Monitor your app to find out if it's having any problems. On the Azure portal page for your app, select **Monitoring** > **Metrics**. The **Metric** dropdown menu shows you the metrics that you can add.

Some of the metrics that you can monitor for your app are:

- Average memory working set
- CPU time
- Memory working set
- Requests

:::image type="content" source="./media/web-troubleshoot-http-502-503/1-monitor-metrics.png" alt-text="Screenshot of metric options for monitoring an app in the Azure portal." lightbox="./media/web-troubleshoot-http-502-503/1-monitor-metrics.png":::

For more information, see:

- [Azure App Service quotas and metrics](/azure/app-service/web-sites-monitor)
- [What are Azure Monitor alerts?](/azure/azure-monitor/alerts/alerts-overview)

## Collect data

Collect data by using diagnostics or the Kudu debug console.

### Use the diagnostics feature

App Service provides an intelligent and interactive experience to help you troubleshoot your app, with no configuration required. The diagnostics feature can discover a problem and guide you to the right information for troubleshooting and resolution.

To access App Service diagnostics, go to your App Service app or App Service Environment in the [Azure portal](https://portal.azure.com). On the left menu, select **Diagnose and solve problems**.

### Use the Kudu debug console

App Service includes a console that you can use for debugging, exploring, and uploading files. It also provides JSON endpoints that you can use to get information about your environment. This console is part of the Kudu dashboard for your app.

In the Azure portal, go to your app. In the left menu, select **Development Tools** > **Advanced Tools**. Select **Go** to open Kudu in a new browser window.

By default, your app domain includes these elements: `<app-name>`-`<random-hash>`.`<region>`. You can also access the dashboard by going to the link `https://<app-name>-<random-hash>.scm.<region>.azurewebsites.net/`.  To get the random hash and region values, in your app **Overview**, copy **Default domain**.

Kudu provides:

- Environment settings for your application.
- A log stream.
- A diagnostic dump.
- The debug console, in which you can run PowerShell cmdlets and basic DOS commands.

If your application throws first-chance exceptions, you can use Kudu and the Sysinternals tool ProcDump to create memory dumps. These memory dumps are snapshots of the process and can help you troubleshoot more complicated problems with your app.

For more information about features available in Kudu, see the Apps on Azure Blog post
[Kudu Dashboard explained - WordPress on App Service](https://techcommunity.microsoft.com/blog/appsonazureblog/kudu-dashboard-explained---wordpress-on-app-service/4030035).

## Mitigate the problem

Consider these options to address these issues.

### Scale the app

In App Service, for increased performance and throughput, you can adjust the scale at which you run your application. Scaling up an app involves two related actions:

- Changing your App Service plan to a higher pricing tier
- Configuring certain settings after you switch to a higher pricing tier

For more information on scaling, see [Scale an app in Azure App Service](/azure/app-service/manage-scale-up).

You can also choose to run your application on more than one instance. This choice provides you with more processing capability and also gives you some fault tolerance. If the process goes down on one instance, the other instance continues to serve requests.

You can set the scaling to be manual or automatic.

### Use auto-healing

Auto-healing recycles the worker process for your app based on settings that you choose. The settings include configuration changes, requests, memory-based limits, or the time needed to execute a request.

Most of the time, recycling the process is the fastest way to recover from a problem. Though you can always restart the app directly in the Azure portal, auto-healing can do it automatically for you. All you need to do is add some triggers in the root `Web.config` file for your app. These settings work in the same way even if your application isn't a .NET one.

For more information, see [Azure App Service diagnostics overview](/azure/app-service/overview-diagnostics#auto-healing).

### Restart the app

Restarting your app is often the simplest way to recover from one-time problems. On the [Azure portal](https://portal.azure.com/) page for your app, you can stop or restart your app.

:::image type="content" source="./media/web-troubleshoot-http-502-503/2-restart.png" alt-text="Screenshot of the stop and restart options for an app in the Azure portal." lightbox="./media/web-troubleshoot-http-502-503/2-restart.png":::

You can also manage your app by using Azure PowerShell. For more information, see
[Manage Azure resources by using Azure PowerShell](/azure/azure-resource-manager/management/manage-resources-powershell).

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
