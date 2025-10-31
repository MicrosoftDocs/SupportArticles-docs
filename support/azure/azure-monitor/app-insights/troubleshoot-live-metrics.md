---
title: Troubleshoot Live Metrics Issues
description: Provides general recommendations and specific suggestions for live metrics issues.
ms.date: 10/09/2025
ms.service: azure-monitor
ms.custom: Application Insights portal experiences
---
# Troubleshoot Live Metrics issues

This article discusses common troubleshooting scenarios for the [live metrics](/azure/azure-monitor/app/live-stream) experience in Application Insights.

## Missing live metrics data

The live metrics experience uses different endpoints than other Application Insights telemetry. Make sure [live metrics endpoints and outgoing ports](/azure/azure-monitor/fundamentals/azure-monitor-network-access) are open in the firewall of your servers.

As described in the [Azure TLS 1.2 migration announcement](https://azure.microsoft.com/updates/azuretls12/), live metrics now only support TLS 1.2. If you're using an older version of TLS, the live metrics pane doesn't display any data. For applications based on .NET Framework 4.5.1, see [Enable Transport Layer Security (TLS) 1.2 on clients - Configuration Manager](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#bkmk_net) to support the newer TLS version.

Validate Application Insights is enabled and your app is using a recent version of the [Azure Monitor OpenTelemetry Distro](/azure/azure-monitor/app/opentelemetry-enable). If you're using the.NET Classic API, install the [Application Insights](https://www.nuget.org/packages/Microsoft.ApplicationInsights.AspNetCore) NuGet package.

## Authorize connected servers: This option will not be available

We strongly discourage the use of unsecured channels.

If you choose to try custom filters without setting up an authenticated channel, you have to authorize connected servers in every new session or when new servers come online. Further, the use of unsecured channels will be automatically disabled after six months.

A dialog will display a warning, "You can stream metrics and events with custom filters, which are sent back to your app. Avoid entering potentially sensitive information (such as customer ID), until you set up an authenticated channel. However, if you recognize and trust all servers below, you can try custom filters without authentication. This option will not be available after ##/##/####. Servers connected without authentication:"

To fix this warning, see [Secure the control channel](/azure/azure-monitor/app/live-stream#secure-the-control-channel).

## Low number of monitored server instances

The number of monitored server instances displayed by live metrics might be lower than the actual number of instances allocated for the application. This mismatch is because many modern web servers unload applications that don't receive requests over a period of time to conserve resources. Because live metrics only count servers that are currently running the application, servers that have already unloaded the process aren't included in that total.

## Missing configuration for .NET

1. Verify that you're using the latest version of the NuGet package [Microsoft.ApplicationInsights.PerfCounterCollector](https://www.nuget.org/packages/Microsoft.ApplicationInsights.PerfCounterCollector).

1. Edit the `ApplicationInsights.config` file:

    * Verify that the connection string points to the Application Insights resource you're using.
    * Locate the `QuickPulseTelemetryModule` configuration option. If it isn't there, add it.
    * Locate the `QuickPulseTelemetryProcessor` configuration option. If it isn't there, add it.

    ```xml
    <TelemetryModules>
    <Add Type="Microsoft.ApplicationInsights.Extensibility.PerfCounterCollector.
    QuickPulse.QuickPulseTelemetryModule, Microsoft.AI.PerfCounterCollector"/>
    </TelemetryModules>
    
    <TelemetryProcessors>
    <Add Type="Microsoft.ApplicationInsights.Extensibility.PerfCounterCollector.
    QuickPulse.QuickPulseTelemetryProcessor, Microsoft.AI.PerfCounterCollector"/>
    </TelemetryProcessors>
    ```

1. Restart the application.

## "Data is temporarily inaccessible" status message

When navigating to live metrics, you can see a banner with the status message: "Data is temporarily inaccessible. The updates on our status are posted here https://aka.ms/aistatus"

Follow the link to the *Azure status* page and check if there's an activate outage affecting Application Insights. Verify that firewalls and browser extensions aren't blocking access to live metrics if an outage isn't occurring. For example, some popular ad-blocker extensions block connections to `*.monitor.azure.com`. In order to use the full capabilities of live metrics, either disable the ad-blocker extension or add an exclusion rule for the domain `*.livediagnostics.monitor.azure.com` to your ad-blocker, firewall, etc.

## Unexpected large number of requests to livediagnostics.monitor.azure.com

Application Insights SDKs use a REST API to communicate with QuickPulse endpoints, which provide live metrics for your web application. By default, the SDKs poll the endpoints once every five seconds to check if you're viewing the live metrics pane in the Azure portal.

If you open live metrics, the SDKs switch to a higher frequency mode and send new metrics to QuickPulse every second. This allows you to monitor and diagnose your live application with 1-second latency, but also generates more network traffic. To restore normal flow of traffic, naviage away from the live metrics pane.

> [!NOTE]
> The REST API calls made by the SDKs to QuickPulse endpoints aren't tracked by Application Insights and don't affect your dependency calls or other metrics. However, you may see them in other network monitoring tools.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
