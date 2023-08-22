---
title: Self-diagnostics for Application Insights SDKs
description: Introduces how to collect self-diagnostic logs for some Application Insights SDKs.
ms.reviewer: v-weizhu
ms.topic: how-to
ms.service: azure-monitor
ms.subservice: application-insights
ms.date: 05/29/2023
---
# How to collect self-diagnostic logs for Application Insights SDKs

When you instrument an application via Application Insights auto-instrumentation or manual instrumentation with an Application Insights SDK, you may encounter issues with the Application Insights SDK itself. In this scenario, diagnostic logs of the Application Insights SDK are needed to spot and diagnose issues with Application Insights.

This article introduces how to collect self-diagnostic logs for the following Application Insights SDKs:

- [Application Insights .NET/.NET Core Framework SDK](#application-insights-netnet-core-framework-sdk)
- [Application Insights Java 2.x](#application-insights-java-2x)
- [Application Insights Java 3.x](#application-insights-java-3x)

## Application Insights .NET/.NET Core Framework SDK

From version 2.18.0-beta2 of the Application Insights .NET/.NET Core Framework SDK, the "self-diagnostics" feature is shipped to capture logs from the SDK itself and write them to a log file in a specified directory.

### Self-diagnostics configuration

Configure self-diagnostics by using a file named *ApplicationInsightsDiagnostics.json* that has the following content:

```json
{
    "LogDirectory": "<LogDirectory>",
    "FileSize": <FileSize>,
    "LogLevel": "<LogLevel>"
}
```

> [!NOTE]
>
> - The configuration file for self-diagnostics must have valid parameters for the Application Insights .NET/.NET Core Framework SDK to parse. If the file is invalid or malformed, the SDK will ignore it, and self-diagnostics won't be enabled. However, this won't affect the normal functioning of the monitored application.
> - This configuration file must be no more than 4 kilobytes (KB). Otherwise, only the first 4 KB of content will be read.
> - The Application Insights .NET/.NET Core Framework SDK will attempt to read the configuration file every 10 seconds and create or circularly overwrite the log file.

Here are some explanations for the configuration parameters:

|Configuration parameters|Description|
|---|---|
|`LogDirectory`|The directory where the log file is stored. It can be an absolute path or a relative path to the current working directory of the web application. This log file is named as *YearMonthDay-HourMinuteSecond.ExecutableName.ProcessId.log*, for example, *20220307-193542.w3wp.exe.7692.log*. The file name starts with the timestamp that's generated when the file is created.|
|`FileSize`|A positive integer that specifies the log file size in KB. This value must be between 1 megabyte (MB) and 128 MB (inclusive), or it will be rounded to the closest upper or lower limit. The log file won't exceed this configured max size.|
|`LogLevel`|The level of the events to be captured. This value must match one of the fields of the `EventLevel`. Lower severity levels include higher severity levels (for example, `Warning` includes the `Error` and `Critical` levels).|

### Self-diagnostics for a web application

To enable self-diagnostics, go to the current working directory of the web application and create the *ApplicationInsightsDiagnostics.json* configuration file.

To disable self-diagnostics, delete the configuration file. Even while the web application is running, you can enable or disable self-diagnostics without the need to restart the application.

In most cases, you could drop the file along with your application. Here are two ways to find the current working directory:

- In Windows, use Process Explorer.

    Open Process Explorer, select the process, and open the **Properties** dialog box. Find **Current directory** under **Image File**.

- Call the `GetCurrentDirectory` and `AppContext.BaseDirectory` methods to get the current working directory.

### Self-diagnostics for App Service Web App in Windows

1. Go to the App Service Web App from the Azure portal.
2. Go to the Kudu page by selecting **Advanced Tools** > **Go**.
3. In the Kudu dashboard, select **Debug console** > **CMD**.
4. Navigate to the directory where the App Service Web App is, such as *D:\home\site\wwwroot*.
5. Use the "**+**" symbol at the top of the Kudu dashboard to create a new file in the *wwwroot* folder and name it to *ApplicationInsightsDiagnostics.json*.

    The *ApplicationInsightsDiagnostics.json* file needs to be placed in the *\<drive>:\home\site\wwwroot* folder. Not all App Service Web Apps reside on the same drive. Some can be on the C: drive, and some might be on the D: drive. To find it, check the **Site folder** and **Temp folder** fields from the default Kudu page.

    :::image type="content" source="media/enable-self-diagnostics/kudu-dashboard.png" alt-text="Screenshot that shows the 'Site folder' and 'Temp folder' fields.":::

6. Edit and add the following configuration to the *ApplicationInsightsDiagnostics.json* file:

    ```json
    {
        "LogDirectory": "<drive>:\home\site\wwwroot",
        "FileSize": 5120,
        "LogLevel": "Verbose"
    }
    ```

    > [!NOTE]
    > The `LogDirectory` parameter should be set to a location under *\<drive>:\home* for easy access, but other locations are valid if there's enough access.

7. Save the file.

    After 10 seconds, a new log file, such as *20220307-193542.w3wp.exe.7692.log*, will show up in the *wwwroot* folder.

8. Delete the configuration file or rename it to *ApplicationInsightsDiagnostics.bak*.

    After 10 seconds, the logging will stop.

### Self-diagnostics for App Service Web App in Linux

1. On your local computer, create a file and name it to *ApplicationInsightsDiagnostics.json*.
2. Edit the file and add the following content:

    ```json
    {
        "LogDirectory": ".",
        "FileSize": 5120,
        "LogLevel": "Verbose"
    } 
    ```

3. Save the file.
4. Go to the App Service Web App from the Azure portal.
5. Go to the Kudu page by selecting **Advanced Tools** > **Go**.
6. When the browser session starts up, add `/newui` to the end of the URL. The URL in the browser should look like `https://<appname>.scm.azurewebsites.net/newui`.
7. Press <kbd>Enter</kbd>. The Kudu page with the new UI will open.
8. In the left menu, select **File Manager**.
9. Select the *Site* folder and then select the *wwwroot* folder.
10. Drag and drop the *ApplicationInsightsDiagnostics.json* file into the *wwwroot* folder.

    After 10 seconds, a new log file will show up in the *wwwroot* folder, for example, *20220307-193542.w3wp.exe.7692.log*.

11. Delete the configuration file or rename it to *ApplicationInsightsDiagnostics.bak*.

    After 10 seconds, the logging will stop.

## Application Insights Java 2.x

You can collect diagnostics logs for the Application Insights Java 2.6 or an earlier version. To do this, add an `<SDKLogger>` element under the root node of the *ApplicationInsights.xml* configuration file (in the resources folder in your project). In the `<SDKLogger>` element, you can instruct the logger to output to a file.

Here's an example of the *ApplicationInsights.xml* file:

```xml
<SDKLogger type="FILE"><!-- or "CONSOLE" to print to stderr -->
    <Level>TRACE</Level>
    <UniquePrefix>AI</UniquePrefix>
    <BaseFolderPath>C:/agent/AISDK</BaseFolderPath>
</SDKLogger>
```

For more information, see [Troubleshoot Azure Application Insights in a Java web project](java-2x-troubleshoot.md#no-data).

## Application Insights Java 3.x

You can collect diagnostics logs for Application Insights Java 3.x by using the "self-diagnostics" functionality. To do this, see [Self-diagnostics](/azure/azure-monitor/app/java-standalone-config#self-diagnostics).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
