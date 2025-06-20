---
title: Troubleshoot Application Insights JavaScript SDK for webpages
description: Provides strategies to fix issues that involve Azure Application Insights JavaScript SDK for webpages.
ms.date: 06/24/2024
ms.service: azure-monitor
ms.devlang: javascript
ms.custom: sap:"Missing or Incorrect data after enabling Application Insights in Azure Portal", devx-track-js
ms.reviewer: mmcc, toddfous, aaronmax, v-weizhu
---
# Troubleshoot Application Insights JavaScript SDK for webpages

The article explains certain issues that involve [Application Insights JavaScript SDK for webpages](/azure/azure-monitor/app/javascript) and offers strategies to help fix these issues.

[!INCLUDE [Azure Help Support](../../../../includes/azure/application-insights-sdk-support.md)]

## I'm seeing a "0" value recorded for page views in Application Insights

This is by design when instrumenting Single Page Applications (SPA). See the following [GitHub issue](https://github.com/microsoft/ApplicationInsights-JS/issues/1139). 

Use any of the following workarounds, as appropriate: 

- Manually calculate the duration between different route changes in the app, and feed that duration value into the trackPageView() method. See details [here](https://github.com/microsoft/ApplicationInsights-JS/issues/1139#issuecomment-566169033).
- Use the startTrackPageView() and stopTrackPageView() methods as timers to calculate page load durations. See details [here](https://microsoft.github.io/ApplicationInsights-JS/webSdk/applicationinsights-web/classes/ApplicationInsights.html#startTrackPage).
- Use sample app duration measuring for the SPA app. See details [here](https://github.com/microsoft/applicationinsights-react-js?tab=readme-ov-file#example-of-measuring-page-duration-in-an-spa).
- Manually set an overridePageViewDuration value. See details [here](https://github.com/microsoft/ApplicationInsights-JS#:~:text=overridePageViewDuration).

## I'm getting the following error message: "Failed to get Request-Context correlation header as it may be not included in the response or not accessible"

The `correlationHeaderExcludedDomains` configuration property is an exclude list that disables correlation headers for specific domains. This option is useful if you include headers that cause the request to fail or not to be sent because of a third-party server configuration. This property supports wildcards. Therefore, you can specify a value such as `*.queue.core.windows.net`. Avoid adding the application domain to this property because doing this stops the SDK from including the required distributed tracing headers, `Request-Id`, `Request-Context`, and `traceparent`, as part of the request.

## I'm not sure how to update my third-party server configuration

The server side must be able to accept connections that have certain headers. Depending on the `Access-Control-Allow-Headers` configuration on the server side, it's often necessary to extend the server-side list by manually adding the `Request-Id`, `Request-Context`, and `traceparent` (W3C distributed header) headers. For example, the configuration might resemble the following text:

`Access-Control-Allow-Headers: Request-Id, traceparent, Request-Context, <your-header1>, ...`

## I'm receiving duplicate telemetry data from the Application Insights JavaScript SDK

If the SDK reports correlation recursively, enable the configuration setting of `excludeRequestFromAutoTrackingPatterns` to exclude the duplicate data. This scenario might occur if you use connection strings. The syntax for the configuration setting is `excludeRequestFromAutoTrackingPatterns: [<endpointUrl>]`.

## I'm experiencing connectivity issues between my application host and the ingestion service

Application Insights SDKs and agents send telemetry to get ingested as REST calls to our ingestion endpoints. To test connectivity from your web server or application host device to the ingestion service endpoints, use raw REST clients from PowerShell or [curl](https://curl.se/docs/manpage.html) commands. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](../investigate-missing-telemetry.md).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
