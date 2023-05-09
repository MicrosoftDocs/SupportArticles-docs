---
title: Troubleshoot Code Optimizations (Preview)
description: This article provides troubleshooting steps and information for using Azure Application Insights Code Optimizations 
author: rkahng 
ms.author: ryankahng 
ms.service: azure-monitor
ms.subservice: optimization-insights
ms.topic: troubleshooting
ms.date: 05/05/2023
---

# Troubleshoot Code Optimizations (Preview)

This article provides troubleshooting steps and information for using Azure Application Insights Code Optimizations.

## Ensure your app is connected to an Application Insights resource

[Create an Application Insights resource](/azure/azure-monitor/app/create-workspace-resource) and verify that it's connected to the correct app.

## Verify that Application Insights Profiler is enabled

[Enable Application Insights Profiler](/azure/azure-monitor/profiler/profiler-overview).

## Confirm Application Insights Profiler is collecting profiles

In addition to enabling Application Insights Profiler, you should also make sure profiles are uploaded. Navigate to Application Insights Profiler from the **Performance** page in your Application Insights resource. If nothing shows up under **Recent profiling sessions**, visit this page for troubleshooting: [Troubleshoot Application Insights Profiler](/troubleshoot/azure/azure-monitor/app-insights/profiler-troubleshooting).

:::image type="content" source="./media/profiler-troubleshooting/performance-page.png" alt-text="Screenshot that shows how to navigate to the app insights profiler.":::

:::image type="content" source="./media/profiler-troubleshooting/profiling-sessions.png" alt-text="Screenshot of the profiling sessions page.":::
## Keep checking back

If you meet all the requirements listed above, keep checking back for insights. Meanwhile, the service continues to analyze your profiles and provide insights as soon as it detects any issues in your code. After you enable the Application Insights Profiler, it may take a few hours for you to generate profiles and for the service to analyze them.

## Contact us for help

If you have questions or need help, you can [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

