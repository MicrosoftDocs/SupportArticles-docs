---
title: Troubleshoot Application Insights Autoinstrumentation
description: Provides troubleshooting help for problems in autoinstrumentation in Application Insights.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-monitor
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
ms.reviewer: matthofa, v-nawrothkai, v-ryanberg
ms.date: 10/14/2025
---
# Troubleshoot Application Insights autoinstrumentation

This article helps you troubleshoot problems that affect autoinstrumentation in Application Insights.

> [!NOTE]
> Autoinstrumentation was known as *codeless attach* before October 2021.

## Telemetry data isn't reported after you enable autoinstrumentation

If you enabled Application Insights autoinstrumentation for your app service but don't see telemetry data reported, review the common scenarios in the following sections.

### The Application Insights SDK was previously installed

Autoinstrumentation fails if .NET and .NET Core apps already have the Application Insights SDK installed.

To be able to autoinstrument your app, remove the Application Insights SDK.

### An app was published by using an unsupported version of .NET or .NET Core

Verify that a supported version of .NET or .NET Core was used to build and publish applications.

To determine whether your version is supported, see the following .NET or .NET Core documentation:

- [Application monitoring for Azure App Service and ASP.NET](/azure/azure-monitor/app/azure-web-apps-net#application-monitoring-for-azure-app-service-and-aspnet)
- [Application monitoring for Azure App Service and ASP.NET Core](/azure/azure-monitor/app/azure-web-apps-net-core#application-monitoring-for-azure-app-service-and-aspnet-core)

### Autoinstrumentation fails when .NET Core Hosting Startup assemblies are overridden

ASP.NET Core autoinstrumentation on Azure App Service uses the `ASPNETCORE_HOSTINGSTARTUPASSEMBLIES` mechanism to load the Application Insights startup bootstrapper at runtime. If an application explicitly configures hosting startup assemblies (for example, with `WebHostDefaults.HostingStartupAssembliesKey`), that configuration overrides the App Service environment settings.

When this occurs and `Microsoft.ApplicationInsights.StartupBootstrapper` is not included, the Application Insights agent can't attach and telemetry isn't collected even though Application Insights appears enabled in the Azure portal.

To resolve this, remove custom hosting startup configuration or ensure `Microsoft.ApplicationInsights.StartupBootstrapper` is explicitly included in the configured hosting startup assemblies. If you intend to control startup assemblies programmatically, host configuration takes precedence over the `ASPNETCORE_HOSTINGSTARTUPASSEMBLIES` environment variable. For more information, see [Use hosting startup assemblies in ASP.NET Core](/aspnet/core/fundamentals/host/platform-specific-configuration?view=aspnetcore-8.0#specify-the-hosting-startup-assembly).

### A diagnostics library is detected

Autoinstrumentation fails if it detects the following libraries:

- `System.Diagnostics.DiagnosticSource`
- `Microsoft.AspNet.TelemetryCorrelation`
- `Microsoft.ApplicationInsights`

For autoinstrumentation to work successfully, these libraries must be removed.

## You encounter SDK problems after you enable autoinstrumentation

If you encounter problems that are caused by the Application Insights SDK itself after you enable autoinstrumentation, collect self-diagnostic logs to diagnose the problems. For more information, see [How to collect self-diagnostic logs for Application Insights SDKs](enable-self-diagnostics.md).

## Trouble deploying the Application Insights Monitoring Agent extension for VMs and virtual machine scale sets

> [!NOTE]
> These troubleshooting tips apply to .NET applications.

If you have trouble deploying the extension, review the execution output that the extension logs to files in the following directories:

```Windows
C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.Diagnostics.ApplicationMonitoringWindows\<version>\
```

If your extension deployed successfully but you're unable to see telemetry, it could be one of the following issues covered in [Agent troubleshooting](../agent/status-monitor-v2-troubleshoot.md#known-issues):

- Conflicting dynamic link libraries (DLLs) in an app's bin directory.
- Conflict with IIS shared configuration.

## Issues with Java app running on Azure Functions

### Slow startup times

Your Java functions might have slow startup times if you adopted this feature before February 2023. From the function app **Overview** pane, go to **Configuration** in the navigation menu. Then, select **Application settings** and use the following steps to fix the issue.

### [Windows](#tab/windows)

1. Check to see if the following settings exist and remove them:

    ```
    XDT_MicrosoftApplicationInsights_Java -> 1
    ApplicationInsightsAgent_EXTENSION_VERSION -> ~2
    ```

2. Enable the latest version by adding this setting:

    ```
    APPLICATIONINSIGHTS_ENABLE_AGENT: true
    ```

### [Linux Dedicated/Premium](#tab/linux)

1. Check to see if the following settings exist and remove them:

    ```
    ApplicationInsightsAgent_EXTENSION_VERSION -> ~3
    ```

1. Enable the latest version by adding this setting:

    ```
    APPLICATIONINSIGHTS_ENABLE_AGENT: true
    ```

---

### Duplicate logs

If you're using `log4j` or `logback` for console logging, distributed tracing for Java Functions creates duplicate logs. These duplicate logs are then sent to Application Insights. To avoid this behavior, use the following workarounds.

#### Log4j

Add the following filter to your log4j.xml:

```xml
<Filters>
  <ThresholdFilter level="ALL" onMatch="DENY" onMismatch="NEUTRAL"/>
</Filters>
```

Example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">
  <Appenders>
    <Console name="Console" target="SYSTEM_OUT">
      <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
      <Filters>
        <ThresholdFilter level="ALL" onMatch="DENY" onMismatch="NEUTRAL"/>
      </Filters>
    </Console>
  </Appenders>
  <Loggers>
    <Root level="error">
      <AppenderRef ref="Console"/>
    </Root>
  </Loggers>
</Configuration>
```

#### Logback

Add the following filter to your logback.xml: 

```xml
<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
  <level>OFF</level>
</filter>  
```

Example:

```xml
<configuration debug="true">
  <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
    <!-- encoders are  by default assigned the type
         ch.qos.logback.classic.encoder.PatternLayoutEncoder -->
    <encoder>
      <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} -%kvp- %msg%n</pattern>
      <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>OFF</level>
      </filter>  
    </encoder>
  </appender>
  <root level="debug">
    <appender-ref ref="STDOUT" />
  </root>
</configuration>
```

## More information

If you have additional questions about Application Insights autoinstrumentation, you can post them on our [Microsoft Q&A question page](/answers/topics/azure-monitor.html).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
