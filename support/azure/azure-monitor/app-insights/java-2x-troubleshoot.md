---
title: Troubleshoot Application Insights in a Java web project
description: Learn how to troubleshooting issues that occur when you monitor live Java apps with Application Insights.
ms.topic: conceptual
ms.date: 06/22/2022
editor: v-jsitser
ms.reviewer: aaronmax, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: java
ms.custom: devx-track-java
#Customer intent: As an Application Insights user working in a Java web project, I want to know how to monitor live Java apps with Application Insights, and troubleshoot any problems that might arise so I can use Application Insights effectively.
---

# Troubleshoot Azure Application Insights in a Java web project

This article provides troubleshooting solutions to common issues in a Q&A format for Application Insights Java 2.x.

> [!CAUTION]
> This document applies to Application Insights Java 2.x, which is no longer recommended.
>
> Documentation for the latest version can be found at [Application Insights Java 3.x](/azure/azure-monitor/app/java-in-process-agent).

Questions or problems with [Azure Application Insights in Java](/azure/azure-monitor/app/java-2x-get-started)? Here are some tips.

## Build errors

#### In Eclipse or Intellij Idea, when I add the Application Insights SDK via Maven or Gradle, I get build or checksum validation errors

If the dependency **\<version>** element is using a pattern that contains wildcard characters (for example, `<version>[2.0,)</version>` in Maven or `version:'2.+'` in Gradle), try specifying a specific version instead, like `2.6.4`.

## No data

#### I added Application Insights successfully and ran my app, but I've never seen data in the portal

* Wait about a minute, and then select **Refresh**. The charts refresh themselves periodically, but you can also refresh manually. The refresh interval depends on the time range of the chart.
* Make sure you've defined an instrumentation key in the *ApplicationInsights.xml* file (in the resources folder in your project), or configured one as an environment variable.
* Verify that there's no `<DisableTelemetry>true</DisableTelemetry>` node in the XML file.
* If necessary, open TCP ports 80 and 443 in your firewall for outgoing traffic to `dc.services.visualstudio.com`. See the [full list of firewall exceptions](/azure/azure-monitor/app/ip-addresses).
* In the Microsoft Azure start board, look at the service status map. If there are some alert indications, wait until they've returned to **OK**, and then close and reopen your Application Insights application blade.
* [Turn on logging](/azure/azure-monitor/app/java-2x-troubleshoot#debug-data-from-the-sdk) by adding an **\<SDKLogger>** element under the root node in the *ApplicationInsights.xml* file (in the resources folder in your project). Then check for entries prefaced with `AI: INFO/WARN/ERROR` for any suspicious logs.
* Make sure that the correct *ApplicationInsights.xml* file has been successfully loaded by the Java SDK. Check the console's output messages for a "Configuration file has been successfully found" statement.
* If the config file isn't found, check the output messages to see where the config file is being searched for. Make sure that the *ApplicationInsights.xml* is located in one of those search locations. As a rule of thumb, you can place the config file near the Application Insights SDK JARs. For example, in Tomcat, the folder would be *WEB-INF/classes*. During development, you can place *ApplicationInsights.xml* in the resources folder of your web project.
* Check the [GitHub issues page](https://github.com/microsoft/ApplicationInsights-Java/issues) for known issues with the SDK.

* Be sure to use same version of Application Insights core, web, agent, and logging appenders to avoid any version conflict issues.

> [!NOTE] 
> This article was recently updated to use the term *Azure Monitor logs* instead of *Log Analytics*. Log data is still stored in a Log Analytics workspace, and it's still collected and analyzed by the same Log Analytics service. We're updating the terminology to better reflect the role of [logs in Azure Monitor](/azure/azure-monitor/logs/data-platform-logs). See [Azure Monitor terminology changes](/azure/azure-monitor/terminology) for details.

#### I used to see data, but it's stopped

* Have you hit your monthly quota of data points? Open **Settings** > **Quota and Pricing** to find out. If so, you can upgrade your plan, or pay for more capacity. For more information, see the [pricing scheme](https://azure.microsoft.com/pricing/details/monitor/).

* Have you recently upgraded your SDK? Make sure that only Unique SDK jars are present inside the project directory. There shouldn't be two different versions of the SDK present.

* Are you looking at the correct AI resource? Be sure to match the iKey of your application to the resource where you're expecting telemetry. They should be the same.

#### I don't see all the data I'm expecting

* Open the **Usage and estimated cost** page and check to see whether [sampling](/azure/azure-monitor/app/sampling) is in operation. (100% transmission means that sampling isn't in operation.) The Application Insights service can be set to accept only a fraction of the telemetry that arrives from your app. That setting helps you stay within your monthly quota of telemetry.

* Do you have SDK Sampling turned on? If yes, data would be sampled at the rate specified for all the applicable types.

* Are you running an older version of Java SDK? Starting with version 2.0.1, we've introduced a fault tolerance mechanism to handle intermittent network and backend failures as well as data persistence on local drives.
* Check to see if excessive telemetry has caused throttling. If you turn on INFO logging, you'll see an "App is throttled" log message. Our current limit is about 32,000 telemetry items per second.

#### Java Agent can't capture dependency data

* Have you [configured the Java agent](/azure/azure-monitor/app/java-2x-agent#configure-the-agent)?
* Make sure both the Java agent jar file and the *AI-Agent.xml* file are placed in the same folder.

* Make sure that the dependency you're trying to auto-collect is supported for auto collection. Currently we only support MySQL, Microsoft SQL Server, Oracle DB, and Azure Cache for Redis dependency collection.

## No usage data

#### I see data about requests and response times, but no page view, browser, or user data

You successfully set up your app to send telemetry from the server. Now your next step is to [set up your web pages to send telemetry from the web browser](/azure/azure-monitor/app/javascript).

Alternatively, if your client is an app in a [phone or other device](/azure/azure-monitor/app/platforms), you can send telemetry from there.

Use the same instrumentation key to set up both your client and server telemetry. The data will appear in the same Application Insights resource, and you'll be able to correlate events from the client and server.

## Disable telemetry

#### How can I disable telemetry collection?

Follow one of these solutions:

* Disable collection in code:

  ```java
  TelemetryConfiguration config = TelemetryConfiguration.getActive();
  config.setTrackingIsDisabled(true);
  ```

* Update *ApplicationInsights.xml* (in the resources folder in your project). Add the following XML element under the root node:

  ```xml
  <DisableTelemetry>true</DisableTelemetry>
  ```

  If you use the XML method, you have to restart the application when you change the value.

## Change the target

#### How can I change which Azure resource my project sends data to?

* [Get the instrumentation key of the new resource](/azure/azure-monitor/app/java-2x-get-started#get-an-application-insights-instrumentation-key).
* If you added Application Insights to your project using the Azure Toolkit for Eclipse, right-click your web project, select **Azure** > **Configure Application Insights**, and then change the key.

* If you've configured the instrumentation key as an environment variable, be sure to update the value of the environment variable with the new iKey.

* Otherwise, update the key in *ApplicationInsights.xml* in the resources folder for your project.

## Debug data from the SDK

### How can I find out what the SDK is doing?

To get more information about what's happening in the API, add the **\<SDKLogger>** element within the root node of the *ApplicationInsights.xml* configuration file.

#### ApplicationInsights.xml

In the **\<SDKLogger>** element, you can also instruct the logger to output to a file:

```xml
<SDKLogger type="FILE"><!-- or "CONSOLE" to print to stderr -->
    <Level>TRACE</Level>
    <UniquePrefix>AI</UniquePrefix>
    <BaseFolderPath>C:/agent/AISDK</BaseFolderPath>
</SDKLogger>
```

#### Spring Boot starter

To enable SDK logging with spring boot apps using the Application Insights Spring Boot starter, add the following lines to the *application.properties* file:

> `azure.application-insights.logger.type=file`  
> `azure.application-insights.logger.base-folder-path=C:/agent/AISDK`  
> `azure.application-insights.logger.level=trace`  

Alternatively, you can print to the standard error stream:

> `azure.application-insights.logger.type=console`  
> `azure.application-insights.logger.level=trace`  

#### Java agent

To enable JVM agent logging, [update the AI-Agent.xml file](/azure/azure-monitor/app/java-2x-agent):

```xml
<AgentLogger type="FILE"><!-- or "CONSOLE" to print to stderr -->
    <Level>TRACE</Level>
    <UniquePrefix>AI</UniquePrefix>
    <BaseFolderPath>C:/agent/AIAGENT</BaseFolderPath>
</AgentLogger>
```

#### Java command line properties

**Since version 2.4.0**

To enable logging by using command-line options instead of changing configuration files, run the following command:

```console
java -Dapplicationinsights.logger.file.level=trace \
    -Dapplicationinsights.logger.file.uniquePrefix=AI \
    -Dapplicationinsights.logger.baseFolderPath="C:/my/log/dir" \
    -jar MyApp.jar
```

Or, run the following command to print to the standard error stream:

```console
java -Dapplicationinsights.logger.console.level=trace -jar MyApp.jar
```

## The Azure start screen

#### I'm looking at the Azure portal. Does the map tell me something about my app?

No, it shows the health of Azure servers around the world.

#### How do I find data about my app from the Azure start board (home screen)?

Assuming you [set up your app for Application Insights](/azure/azure-monitor/app/java-2x-get-started), select **Browse** > **Application Insights**, and then select the app resource you created for your app. To get there faster in the future, pin your app to the start board.

## Intranet servers

#### Can I monitor a server on my intranet?

Yes, provided your server can send telemetry to the Application Insights portal through the public internet.

You may need to [open some outgoing ports in your server's firewall](/azure/azure-monitor/app/ip-addresses#outgoing-ports)
to allow the SDK to send data to the portal.

## Data retention

#### How long is data retained in the portal? Is it secure?

See [Data retention and privacy](/azure/azure-monitor/app/data-retention-privacy).

## Debug logging

Application Insights uses `org.apache.http`. This namespace is relocated within Application Insights core jars under the namespace `com.microsoft.applicationinsights.core.dependencies.http`. This relocation enables Application Insights to handle scenarios where different versions of the same `org.apache.http` exist in one code base.

>[!NOTE]
>If you enable `DEBUG`-level logging for all namespaces in the app, it will be honored by all executing modules (including `org.apache.http` renamed as `com.microsoft.applicationinsights.core.dependencies.http`). Application Insights won't be able to apply filtering for these calls because the log call is being made by the Apache library. `DEBUG`-level logging produces a considerable amount of log data, and it isn't recommended for live production instances.

## Next steps

#### I set up Application Insights for my Java server app. What else can I do?

* [Monitor availability of your web pages](/azure/azure-monitor/app/monitor-web-app-availability)

* [Monitor web page usage](/azure/azure-monitor/app/javascript)

* [Track usage and diagnose issues in your device apps](/azure/azure-monitor/app/platforms)

* [Write code to track usage of your app](/azure/azure-monitor/app/api-custom-events-metrics)

* [Capture diagnostic logs](/azure/azure-monitor/app/java-2x-trace-logs)

## Get help

* [Stack Overflow](https://stackoverflow.com/questions/tagged/azure-application-insights)

* [File an issue on GitHub](https://github.com/microsoft/ApplicationInsights-Java/issues)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
