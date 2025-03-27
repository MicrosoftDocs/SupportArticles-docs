---
title: Troubleshoot Slow Page Response and Hangs 
description: This article helps you troubleshoot slow page response and hang issues.
ms.date: 03/25/2025
ms.custom: sap:Site Behavior and Performance\Slow page response
ms.reviewer: khgupta, v-sidong
---
# Troubleshoot slow page response and hangs

_Applies to:_ &nbsp; Internet Information Services (IIS), ASP.NET, ASP.NET Core

This article provides guidance on how to collect and analyze data to troubleshoot slow page response and hang issues.

## Determine the correct troubleshooting guide

Page slowness and hangs might be accompanied by one or more of the following conditions. It's important to identify these conditions so that you can focus your troubleshooting accordingly. Determine which of these conditions most closely describes the issue you're troubleshooting, and follow the appropriate troubleshooting guide.  

- Slowness or hang only, and CPU and memory usage are normal

  [Troubleshoot slow page response and hangs](slow-page-response-hangs.md)

- Slowness or hang accompanied by high CPU

  - Focus on slowness - [Troubleshoot slow page response and hangs](slow-page-response-hangs.md)
  - Focus on high CPU - [Troubleshooting High CPU in an IIS application pool](troubleshoot-high-cpu-in-iis-app-pool.md)

- Slowness or hang accompanied by high memory

  - Focus on slowness - [Troubleshoot slow page response and hangs](slow-page-response-hangs.md)
  - Focus on high memory - [Overview of high memory consumption issues](high-memory-consumption-issues-overview.md)

- Slowness or hang accompanied by both high memory and high CPU

  When all three conditions are present, use [Overview of high memory consumption issues](high-memory-consumption-issues-overview.md). This is because usually high CPU in these cases is due to high memory, and when both memory and CPU are high, this would cause slowness.  

- High CPU only

  [Troubleshooting High CPU in an IIS application pool](troubleshoot-high-cpu-in-iis-app-pool.md)

- High memory only

  [Overview of high memory consumption issues](high-memory-consumption-issues-overview.md)

## Data collection

Here's a list of useful data to collect for a slow page response or hang situation. Not all of these data is required for each issue. You can collect data depending on the situation.

- [IIS Log Catcher data](#iis-log-catcher)
  - [IIS and ASP.NET configuration files](#configuration-files)  
  - [IIS web logs (W3SVC logs)](#iis-web-logs-w3svc-logs)
  - [Event logs (system, application, and security)](#windows-system-application-and-security-event-logs)
- [Fiddler trace or Microsoft Edge HAR trace](#fiddler-tool-trace-or-microsoft-edge-har-trace)
- [Failed Request Trace (FREB) logs](#failed-request-trace-freb-logs)
- [Full user-mode process dumps](/windows-hardware/drivers/debugger/user-mode-dump-files#full-user-mode-dumps)
- [Other data](#other-data)
- [Time trigger amount](#time-trigger-amount)
- [Generate memory dumps manually using DebugDiag](#generate-memory-dumps-manually-using-debugdiag)
- [Configure FREB to trigger memory dumps using ProcDump.exe](#configure-freb-to-trigger-memory-dumps-using-procdumpexe)

### IIS Log Catcher

IIS Log Catcher collects various historical logs and configuration data at one time, including the IIS web logs, which are particularly useful for diagnosing slow page response issues. It also collects all the `.config` files, which can help to provide an understanding on the different web applications on the server and how they're configured. If FREB logging is already configured, FREB logs are also included with IIS Log Catcher data. IIS Log Catcher also collects the System and Application event logs.

Download the [IIS Log Catcher](https://github.com/NL-Cristi/LogCatcher) tool and use it to collect data by following the [directions](https://github.com/NL-Cristi/LogCatcher/blob/master/Docs/RunFirstTime.md).

#### Configuration files

**applicationhost.config** and **web.config** are collected as part of the IIS Log Catcher data. These files are useful for understanding the configuration of IIS and the individual web applications on the server.

If the IIS Log Catcher tool doesn't automatically collect the configuration files, you need to collect them manually.

The **applicationhost.config** file is located at **c:\\windows\\system32\\inetsrv\\config\\**. The **web.config** files are in the root directory of each application. For example, for the Default Web Site's application, the **web.config** file is in **c:\\inetpub\\wwwroot**. The root directories for applications might be anywhere on the file system. To identify the root directory of a specific site, check the **applicationhost.config** file for the **site** and its **physicalPath** attribute or review the settings in the IIS Manager.

#### IIS web logs (W3SVC logs)

Collect IIS logs from a time during which the slowness occurs. This can be helpful in confirming that the time-taken field reflects the slowness. It can also help to narrow down the page or pages that are responding slowly.

If the IIS Log Catcher tool doesn't automatically collect the web logs, you need to collect them manually.

By default, these logs are in **c:\\inetpub\\logs\\logfiles**. Each site has its own directory named **W3SVC#** where the **#** is the **SiteID**. However, the log location is customizable. To find the custom log locations, you might need to review the **applicationhost.config** file for the **logFile** and **directory** settings that specify where the logs are stored.

#### Windows System, Application, and Security event logs

These are collected as part of the IIS Log Catcher data. Although the event logs aren't typically used when troubleshooting slow page response and hangs, it's the best practice to continue collecting them as they might be used later on in troubleshooting.

If the IIS Log Catcher tool doesn't automatically collect event logs, you need to collect them manually.

Collect event logs directly from the Event Viewer. Save them as `.evtx` files and view them in Event Viewer on your own server.

### Fiddler tool trace or Microsoft Edge HAR trace

The timeline view in these traces might be able to help you narrow down which page or pages in the web application are slow. This helps collect FREB logs of only slow pages.

[Fiddler Classic](https://www.telerik.com/fiddler/fiddler-classic) is a third-party browser extension that acts as a proxy for your browser. Fiddler begins collecting data as soon as it's opened. To collect traces of SSL encrypted requests using Fiddler Classic, follow these steps:

1. Download and install [Fiddler Classic](https://www.telerik.com/fiddler/fiddler-classic).
1. Open Fiddler Classic, select **Tools** > **Options** > **HTTPS**, and select both the **Capture HTTPS CONNECTs** and **Decrypt HTTPS traffic** checkbox.
1. Select **OK**.
1. Reproduce the slowness while running Fiddler.
1. Select **File** > **Save** > **All Sessions** to save all sessions as a `.saz` file.  

Microsoft Edge or Chrome browsers can collect HAR traces directly. To collect HAR traces, follow these steps:

1. Open your browser and select <kbd>F12</kbd> to open Developer Tools.
1. Select **Network** > **Preserve log**.
1. Reproduce the slowness issue.
1. Select **Export HAR** to save the trace as a `.HAR` file. `.HAR` files can be imported into Microsoft Edge or Chrome for later review.

### Failed Request Trace (FREB) logs

FREB logs can help identify what IIS module takes the longest to process the request. It can identify the slowness in authentication or in the application code itself.

Failed Request Tracing is an IIS module. It's available for use when the Tracing module is installed. Tracing can be installed from the Server Manager or by running the following PowerShell command:  

```powershell
Add-WindowsFeature -Name Web-Http-Tracing 
```

Before configuring a FREB rule, inspect the W3SVC logs to identify requests that take a long time to complete. Identify individual page requests that are slow using the `cs-uri-stem` and the `time-taken` fields.

- If you can identify a few specific pages that are slow, [create a FREB rule](../health-diagnostic-performance/troubleshoot-arr-using-frt-rules.md#step-1-configure-failed-request-tracing-rules) for the specific page or pages. If creating the rule for a specific page, don't use time taken in the FREB rule. Instead, use the status code from the W3SVC logs.

- If you can't identify a specific page to create the FREB rule, you can use all content and [specify a time taken in the FREB rule](#detailed-steps-for-collecting-freb-logs-based-on-time-taken) instead, which gives you logs of all requests that take more than the specified time to complete.

  > [!NOTE]
  > This method might give you false positives. Also note that when creating FREB logs based on time taken, the log ends when the request reaches the specified time taken. If the specified time is too short, you aren't able to identify where the slowness occurs.

#### The issue is ongoing, easy to reproduce, or frequent

> [!NOTE]
> FREB logs triggered by some status code rule provide a view of all modules that occur along the IIS pipeline throughout a request lifetime, along with the time each module takes.
>
> FREB logs triggered by a specific time taken value rule (for example, 20 seconds) only show information up to that value, which means anything that this request goes through beyond this time won't be available in the log.

- If the response is received after some delay (for example, 30 seconds), follow these steps to diagnose the issue:

  1. Check the status code of the received response.

     Use browser developer tools or IIS logs to determine the status code of the delayed response.

  1. [Configure FREBs](troubleshoot-http-error-code.md#steps-to-capture-freb-logs) based on the status code in step 1.
  1. View the generated FREBs to understand which module causes the slowness.

     If you aren't familiar with how to interpret FREBs, see [Reading a FREB log, a Failed Request Tracing: IIS request processing pipeline execution](https://techcommunity.microsoft.com/blog/iis-support-blog/reading-a-freb-log-a-failed-request-tracing-iis-request-processing-pipeline-exec/1349639).

  If you find that some third-party module is causing the slowness, contact the third-party to investigate the problem. However, if the slowness is due to your application code, you need to collect memory dumps for further investigation.

- If no response is received at all (complete hang) or received after a very long time, follow these steps to diagnose the issue:

  1. [Configure FREBs based on a specific time taken rule](#detailed-steps-for-collecting-freb-logs-based-on-time-taken).

     The time threshold you set for FREB logs should be higher than what is considered normal or acceptable time for the response. if you know that it's normal and expected for a response to take 10 seconds, configure FREBs a higher number like 20 seconds or 30 seconds.

  1. Proceed with the same analysis steps as mentioned above.

#### The issue is intermittent or hard to reproduce

If an issue is intermittent or hard to reproduce, waiting for it to happen again just to collect FREB logs can be inefficient. It might take weeks or months for the issue to reoccur, and if FREB logs are insufficient, you need to wait again to collect memory dumps. To avoid this delay, it's recommended to generate memory dumps during the first occurrence of the issue.

If requests normally take milliseconds but occasionally take 1 or a few seconds, investigating this slowness can be challenging. Generating memory dumps during such slow periods might not be practical because:

- Debuggers add overhead, which might contribute to the slowness to some degree.
- The original slowness and the overhead might overlap.
- Generating multiple memory dumps within a request lifetime might not be possible in the first place.

You can [use PerfView to collect ETW traces](troubleshoot-http-error-code.md#steps-to-capture-a-perfview-trace-and-dumps) instead. However, you might still be very limited in investigation if the time is too distributed instead of being concentrated on a specific operation.

Always check IIS logs for very slow requests and troubleshoot them, as this might indirectly solve shorter slowness issues.

#### Detailed steps for collecting FREB logs based on time taken

> [!IMPORTANT]
> To configure FREB logs, make sure the **Tracing** role service is installed for IIS.

To install the **Tracing** role service for IIS, follow these steps:

[!INCLUDE [Install the Tracing role service](../../../../includes/enable-tracing-role.md)]

Once the **Tracing** role service is installed, follow these steps to capture FREB:

1. Open the **Run** command window.
1. Launch **inetmgr**.
1. In IIS Manager, under the **Connections** pane, expand the machine name, expand **Sites**, and then select the target website.

   :::image type="content" source="media/slow-page-response-hangs/iis-connection-site-target-website.png" alt-text="Screenshot of the target website in IIS manager.":::

1. Double-click **Failed Request Tracing Rules**.

   :::image type="content" source="media/slow-page-response-hangs/default-web-site-home.png" alt-text="Screenshot of the Default Web Site Home.":::

1. In the **Actions** pane, select **Add**.
1. In the **Add Failed Request Tracing Rule** wizard, on the **Specify Content to Trace** page, select **All content** > **Next**.

   :::image type="content" source="media/slow-page-response-hangs/add-failed-request-tracing-rule.png" alt-text="Screenshot of the Specify Content to Trace page in the Add Failed Request Tracing Rule window.":::

1. On the **Define Trace Conditions** page, update the **Time taken** field as per the time that you're noticing the request or page is taking and select **Next**.

   For example, if the request, usually takes less than a second, but now it's taking 20 seconds, type **20** in the **Time Taken** field.

1. On the **Select Trace Providers** page, under **Providers**, select all the checkboxes. Under **Areas**, make sure all the checkboxes are selected for each provider. Under **Verbosity**, select **Verbose**. Select **Finish**.

1. Enable **Failed Request Tracing** for the site and configure the Log File Directory:

   1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
   1. In the **Actions** pane, under **Configure**, select **Failed Request Tracing**.

      :::image type="content" source="media/slow-page-response-hangs/configure-failed-request-tracing.png" alt-text="Screenshot of the Failed Request Tracing option.":::

   1. In the **Edit Web Site Failed Request Tracing Settings** dialog, select the **Enable** checkbox, set the **Directory** field to **%SystemDrive%\inetpub\logs\FailedReqLogFiles**, and set **Maximum number of trace files** to **1000**.

      :::image type="content" source="media/slow-page-response-hangs/edit-website-failed-request-tracing-settings.png" alt-text="Screenshot of the Edit Web Site Failed Request Tracing Settings window.":::

   1. Select **OK**.

### Full user-mode process dump

A series of process dumps (2-4) taken when requests are slow or hung might tell you which method call in the application is slow. It might also indicate delays in remote requests to remote web services or back-end databases.

#### The issue is easy to reproduce

If the issue can be reproduced or currently occurs, you can capture several manual dumps of the worker process hosting the app pool.

Try to space dumps about 30 seconds apart, but be mindful of the total slowness. If the total period of slowness is shorter (for example, 20 to 30 seconds total), space dumps closer together to fit at least two dumps inside the slow period.

Optionally, ProcDump can be used, especially when you can't install DebugDiag on the server or installation requires it.

If the issue is more intermittent, consider capturing both FREB traces and dumps. Or if using ProcDump is easier, follow the steps in the [Configure FREB to trigger memory dumps using ProcDump.exe](#configure-freb-to-trigger-memory-dumps-using-procdumpexe) section (set up FREB for time taken rather than status code).

#### Issue isn't easily reproduced

If the issue isn't easily reproduced, you can use FREB Rule to generate dumps based on time taken. For more information, see [Using FREB to generate a dump on a long running request](https://techcommunity.microsoft.com/blog/iis-support-blog/using-freb-to-generate-a-dump-on-a-long-running-request/891467).

> [!IMPORTANT]
> When setting up FREB for time taken, adjust the time taken trigger depending on how slow responses are. This ensures only problematic requests are captured and minimizes false positives.

#### Deadlock detected hangs

> [!CAUTION]
>
> - If slowness is accompanied by high CPU, avoid collecting logs when CPU usage is extremely high (for example, >=95), as this might cause the server to hang or fail to collect logs due to insufficient CPU resources.
>
> - If collecting logs manually, make sure CPU usage is lower than the threshold to facilitate RDP access to the server. If needed, try recycling the application pool before logs collection, but be aware of the impact on existing requests and explain that to customers.
>
> - If CPU reaches such a value within a few seconds after recycling, consider reducing the load against the process (whether it's a load test or production load).
>
> - Similarly, if slowness is accompanied by high memory, try to avoid collecting memory dumps at high **w3wp.exe** memory consumption like >10GB if possible (or high total server memory consumption > 95%). If issues can be reproduced at lower memory, consider recycling app pool or reducing load if that helps as mentioned.
>
> - Don't use Task Manager to collect dumps. Although sometimes the generated dumps are useful, in many cases they aren't. More specialized tools like DebugDiag and Procdump have a better understanding of managed code and can provide more detailed information specifically related to ASP.NET applications. In addition, these two tools take care of the process bitness and you don't have to worry. Whereas in task manager, if task manager 64-bit process is used to generate dumps of a 32-bit process, or vice versa, the dumps are useless.

### Other data  

Collect the following data options if needed:

- PerfView traces

  PerfView can help isolate slow performance issues within the web application itself. PerfView traces are collected during a time of slowness. These traces show the individual methods or functions that are slow.  

- Network traces

  Network traces are helpful when tracking slow page response and hangs associated with network issues.

- Performance Monitor log

  PerfMon Logging is helpful when tracking slow page response and hangs associated with high CPU or high memory usage.

### Time trigger amount

To solve the issue, it's crucial to determine the appropriate time value that triggers the generation of memory dumps.

This involves understanding the response times from your Internet Information Services (IIS) logs during periods when the issue was present and when it wasn't.

To identify appropriate time trigger, follow these steps:

1. Review IIS logs:

   Analyze your IIS logs over various time ranges to observe the response times. Identify what the expected response time is under normal circumstances.

1. Identify response time differences:

   When the issue occurs, note the minimum, maximum, and most frequent response times.

1. Set a triggering goal:

   Aim to generate at least two consecutive memory dumps during the period when the slow request is active.

   For instance, if it's typical for a response to take 10 seconds, focus on response times that exceed this duration. If an issue causes the response time to extend to 60 seconds or more, capture memory dumps at intervals such as 30, 40, and 50 seconds.

1. Avoid false positives:

   It's important not to initiate a memory dump at slightly higher times like 11 or 12 seconds, as this might lead to false positives. The goal is to capture the dumps during the problematic period without prematurely concluding the request.

1. Identify the timing of dumps:

   Make sure that dumps aren't triggered at the very end of the request's lifetime, as the request might complete before subsequent dumps are generated.

1. Evaluate most frequent slow responses:

   If the slowest response time doesn't frequently occur, focus on the most common slow response time observed in the IIS logs.

> [!NOTE]
>
> - You might need multiple attempts to get a good set of memory dumps that are useful.
> - Make sure you have enough space on the drive you select for holding the generated memory dumps. Each memory dump is the same size as the process at the time of generation. So, for example, if the size of the process is 1GB at the time of memory dump generation, then generating three dumps requires 4GB of space.

### Generate memory dumps manually using DebugDiag

If you can trigger the slow request and know how long to pause before starting the generation of memory dumps, follow these steps.

If you can't trigger the request (for example, the client is a mobile app, you don't have access to it, and the issue can't be just reproduced from browser), but by some means know when the issue occurs, follow these steps to confirm slowness:

1. Follow these steps to enable the Request Monitor:

   1. Open Server Manager.
   1. Select **Manage** in the top-right corner and select **Add Roles and Features** > **Next**.
   1. In the **Add Roles and Features Wizard** window, select **Role-based or feature-based installation** > **Next**.
   1. Choose the server you want to configure from the server pool.
   1. In the **Select server roles** section, expand **Web Server (IIS)** > **Web Server** > **Health and Diagnostics**.
   1. Under **Health and Diagnostics**, select the **Request Monitor** checkbox.
   1. Select **Next** > **Next** > **Install** to enable the Request Monitor feature.

  After the installation is complete, you might need to restart IIS. You can restart it by opening a command prompt and typing **iisreset.exe**.

1. Open IIS Manager and select the server name on the left.
1. Double-click **Worker Processes**.
1. Double-click the application pool in question and select the **Time Elapsed** column.

For more information, see [Using RSCA to help you understand what your IIS server requests are doing](https://techcommunity.microsoft.com/blog/iis-support-blog/using-rsca-to-help-you-understand-what-your-iis-server-requests-are-doing/773904).

If the slowness is confirmed, take the memory dumps manually. However, this doesn't guarantee that the dumps contain the same problematic request during its lifetime and hence multiple attempts might be needed if dumps are taken manually (even when automated, sometimes multiple attempts are needed).

To take the memory dumps manually, follow these steps:

1. Download and install [Debug Diagnostic Tool v2 Update 3.2](https://www.microsoft.com/download/details.aspx?id=103453).
1. When a memory leak occurs, open **DebugDiag 2 Collection** from the **Start** menu:  

   :::image type="content" source="media/slow-page-response-hangs/debugdiag-2-collection.png" alt-text="Screenshot of DebugDiag 2 Collection.":::

   > [!NOTE]
   > If you need to change the path where dumps are generated, select **Tools** > **Options And Settings** > **Manual Userdump Save Folder** to change it.
1. Select the **Processes** tab.
1. Locate the **w3wp** process with the **Process ID** column of the application in question.  
   [!INCLUDE [How to get actual PID](../../../../includes/how-get-pid.md)]
1. Right-click the **w3wp** process, select **Create Userdump Series**, and set the following options (adjust the numbers as needed). Don't select **Save & Close**.  

   :::image type="content" source="media/slow-page-response-hangs/configure-userdump-series.png" alt-text="Screenshot of Configure UserDump Series.":::

1. Reproduce the slowness and select **Save & Close** when the requests are slow.

   If you don't know how to reproduce the slowness and it occurs quickly and frequently, wait for the slowness to begin before selecting **Save & Close**. Dumps begin collecting as soon as **Save & Close** is selected.

### Configure FREB to trigger memory dumps using ProcDump.exe

This section provides step-by-step instructions on how to configure Failed Request Tracing Rules (FREB) to trigger memory dumps using **ProcDump.exe**. This approach is particularly useful when you can't install certain applications like DebugDiag on the server.

Follow these steps to configure FREB to run a custom action, like **ProcDump.exe**, to generate memory dumps when specific rules are met.

1. [Configure FREBs on the appropriate request time value](#detailed-steps-for-collecting-freb-logs-based-on-time-taken). Make sure to set a time-taken rule instead of a status code.

1. Follow these steps to enable custom actions:

   1. Open IIS Manager and select the server name on the left side of the screen.
   1. Double-click the **Configuration Editor** icon.
   1. Navigate to the **applicationHost/sites** section, and then select the **…** (ellipsis) button.

      :::image type="content" source="media/slow-page-response-hangs/configuration-editor-applicationhost-sites.png" alt-text="Screenshot of Configuration Editor.":::

   1. Select the site to which you have already added the Failed Tracing Rule.

      :::image type="content" source="media/slow-page-response-hangs/collection-editor-applicationhost-sites.png" alt-text="Screenshot of Collection Editor." lightbox="media/slow-page-response-hangs/collection-editor-applicationhost-sites.png":::
   1. Set **customActionsEnabled** to **True**.
   1. Download [ProcDump](/sysinternals/downloads/procdump) and copy the executable to the **C:\\procDump** path. Create a directory named **myDumps** under the **C:\\** drive.

      > [!WARNING]
      > You have to place the ProcDump tool in a folder path that doesn't contain whitespaces. Otherwise, it's impossible to execute ProcDump via FREB. For example, **C:\procDump** is a good path folder while **C:\Process Dump** isn't.

1. Specify the custom action for ProcDump:

   1. Specify the action at either the server or site level and select the **…** button as shown in the following screenshot:

      :::image type="content" source="media/slow-page-response-hangs/configuration-editor-webserver.png" alt-text="Screenshot of Configuration Editor at the server level.":::

   1. Select the **Add** link under the **Action** pane and fill in the properties as shown in the following screenshot:

      :::image type="content" source="media/slow-page-response-hangs/collection-editor-webserver-tracing.png" alt-text="Screenshot of properties in Collection Editor." lightbox="media/slow-page-response-hangs/collection-editor-webserver-tracing.png":::

      - **CustomActionExe**: Set the value to the path of the ProcDump executable.
      - **customActionParams**: Set the value to `-accepteula -ma %1% C:\myDumps -n 3`.

        This command generates three consecutive dumps, spaced by 10 seconds. If you need to change the spacing, add `-s` followed by the number of seconds.

## Data analysis

This section provides guidance on how to use various tools to analyze data for diagnosing and troubleshooting slow page response and hang issues in IIS.

### IIS web logs (W3SVC logs)

When you analyze W3SVC logs, there are a couple of goals.

- Verify that requests are executing slowly. Review the time-taken values to confirm how long requests are taking to execute.
- Identify which pages are executing slowly. In conjunction with time-taken, use the `cs-uri-stem` values to identify slow pages by name.

The time-taken is logged in milliseconds. 1000 milliseconds = 1 second. When looking for requests that take more than 30 seconds to complete, look for time-taken values that are greater than 30,000 milliseconds.

There are two tools to analyze W3SVC logs, [Excel](#analyze-a-single-w3svc-log-using-excel) and [Log Parser 2.2](#analyze-multiple-w3svc-logs-using-log-parser).

#### Analyze a single W3SVC log using Excel

To analyze a single W3SVC log using Excel, follow these steps:

1. Open W3SVC logs in Excel.
1. Select and delete the top three rows (all should start with a **#** sign). Make sure to keep the row that begins with **#Fields**.
1. Select the column **A**. From the **Data** ribbon, select **Text to Columns**.
1. In **Convert Text to Columns Wizard**, select **Delimited** > **Next**.
1. In **Delimiters**, select the **Space** checkbox and clear any other checks, and then select **Finish**.
1. Select the cell **A1**, right-click it, and select **Delete** from the context menu.
1. When prompted, select **Shift cells left**.
1. Select row **1**. From the **Data** ribbon, select **Filter**.

Now, you can use the filters for time-taken to identify all the requests greater than the desired number of seconds.

#### Analyze multiple W3SVC logs using Log Parser

If you have multiple logs to analyze or a single log file that is too large to be opened by Excel, consider using [Log Parser 2.2 (Microsoft Download Center)](https://www.microsoft.com/download/details.aspx?id=24659&lc=1033&msockid=1ba22fab7f2c669415273d557e9b670c). It's a powerful tool that allows you to run SQL styled queries to extract data from various types of log files, including W3SVC logs.

To use Log Parser 2.2, follow these steps:

1. Download and install [Log Parser 2.2 (Microsoft Download Center)](https://www.microsoft.com/download/details.aspx?id=24659&lc=1033&msockid=1ba22fab7f2c669415273d557e9b670c).
1. Open Command Prompt and navigate to the Log Parser installation directory.
1. Run queries in the **Command Prompt** window. Here are some query examples:

   - Top Requested Pages

     ```cmd
     "C:\Program Files (x86)\Log Parser 2.2\logparser.exe" -i:W3C -o:CSV "SELECT TOP 100 cs-uri-stem as URL-Requested, COUNT(*) AS Num-Requests, MAX(time-taken) As Max-Time-Taken, MIN(time-taken) As Min-Time-Taken, Avg(time-taken) As Average-Time-Taken FROM *.log GROUP BY URL-Requested ORDER By Num-Requests DESC" -q:ON > Top100Pages.csv 
     ```

   - Slowest Pages

     ```cmd
     REM "C:\Program Files (x86)\Log Parser 2.2\logparser.exe" -i:W3C -o:CSV "SELECT TOP 25 cs-uri-stem as URL-Requested, COUNT(*) AS Num-Requests, MAX(time-taken) As Max-Time-Taken, MIN(time-taken) As Min-Time-Taken, Avg(time-taken) As Average-Time-Taken FROM *.log GROUP BY URL-Requested ORDER By Average-Time-Taken DESC" -q:ON > Slowest25Pages.csv 
     ```

   - ALL Requests over 15 Seconds

     ```cmd
     REM "C:\Program Files (x86)\Log Parser 2.2\logparser.exe" -i:W3C -o:W3C "SELECT * FROM *.log WHERE Time-Taken > 14999 ORDER BY Time-Taken DESC" -q:ON > LongRunningRequests.log 
     ```

### Fiddler traces or HAR traces from Microsoft Edge or Chrome

[Fiddler Classic](https://www.telerik.com/fiddler/fiddler-classic) has a couple of options for viewing performance information. After collecting a trace in Fiddler, you review the `.saz` file in Fiddler. There are two relevant tabs in Fiddler. The first is the **Statistics** tab. Select multiple requests (or frames) in a trace, and the **Statistics** tab provides some performance statistics in a simple summary page.

The second Fiddler tab for troubleshooting performance issues is the **Timeline** tab. Selecting the **Timeline** tab and multiple requests (or frames) in a trace, you're presented with a bar graph depicting how long it takes for the client to receive responses for each request.

F12 Developer Tools are built into both Microsoft Edge and Chrome. In instances where it's not possible to install Fiddler Classic, these tools might already be available to the customer for troubleshooting. The F12 Developer Tools are similar to Fiddler as they provide a client-side view of requests being made. Developer Tools HAR files show a timeline across the top of the Network report, which gives a visual representation of the time the browser waits for individual requests. The HAR file also shows a **TIME** column to help identify slow requests.

### Failed Request Trace (FREB) logs

FREB traces are `.xml` files, and formatted by the `.xsl` stylesheet in the FREB log directory. For more information on how to read a FREB log, see [Reading a FREB log, a Failed Request Tracing: IIS request processing pipeline execution](https://techcommunity.microsoft.com/blog/iis-support-blog/reading-a-freb-log-a-failed-request-tracing-iis-request-processing-pipeline-exec/1349639).

### Full memory dumps

The DebugDiag 2 Analysis application can analyze dumps for either hangs or performance issues.

To analyze a single dump in a hang situation, follow these steps:

1. Use the **Add Data Files** button to load a dump into DebugDiag 2 Analysis.  
1. Select **CrashHangAnalysis**.
1. Select **Start Analysis**.
1. When DebugDiag completes its analysis, a report opens in Microsoft Edge.

To analyze a series of dumps in a performance issue, follow these steps:

1. Use the **Add Data Files** button to add multiple dumps of the same process  
1. Select **PerfAnalysis**.
1. Select **Start Analysis**.
1. When DebugDiag completes its analysis, a report opens in Microsoft Edge.

It's simpler and more understandable to run only one type of analysis rule at a time.

> [!NOTE]
> If a more detailed analysis is needed, use [WinDbg](/windows-hardware/drivers/debuggercmds/windbg-overview) to review dumps.

