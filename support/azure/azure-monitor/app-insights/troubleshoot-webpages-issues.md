---
title: Troubleshoot Application Insights JavaScript SDK for webpages
description: Provides strategies to fix issues that involve Azure Application Insights JavaScript SDK for webpages.
ms.date: 06/07/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: javascript
ms.custom: devx-track-js
ms.reviewer: mmcc, toddfous, aaronmax, v-weizhu
---
# Troubleshoot Application Insights JavaScript SDK for webpages

The article explains certain issues involving [Application Insights JavaScript SDK for webpages](/azure/azure-monitor/app/javascript) and offers strategies to help fix these issues.

## I'm getting an error message of "Failed to get Request-Context correlation header as it may be not included in the response or not accessible"

The `correlationHeaderExcludedDomains` configuration property is an exclude list that disables correlation headers for specific domains. This option is useful if you include headers that cause the request to fail or not to be sent because of third-party server configuration. This property supports wildcards. Therefore, you can specify a value such as `*.queue.core.windows.net`. Avoid adding the application domain to this property because this stops the SDK from including the required distributed tracing `Request-Id`, `Request-Context`, and `traceparent` headers as part of the request.

## I'm not sure how to update my third-party server configuration

The server side must be able to accept connections that have certain headers. Depending on the `Access-Control-Allow-Headers` configuration on the server side, it's often necessary to extend the server-side list by manually adding the `Request-Id`, `Request-Context`, and `traceparent` (W3C distributed header) headers. For example, the configuration might resemble the following text:

`Access-Control-Allow-Headers: Request-Id, traceparent, Request-Context, <your-header1>, ...`

## I'm receiving duplicate telemetry data from the Application Insights JavaScript SDK

If the SDK reports correlation recursively, enable the configuration setting of `excludeRequestFromAutoTrackingPatterns` to exclude the duplicate data. This scenario can occur if you use connection strings. The syntax for the configuration setting is `excludeRequestFromAutoTrackingPatterns: [<endpointUrl>]`.

## Connectivity issues occur between your application host and the ingestion service

Application Insights SDKs and agents send telemetry to get ingested as REST calls to our ingestion endpoints. To test connectivity from your web server or application host device to the ingestion service endpoints, use raw REST clients from PowerShell or [curl](https://curl.se/docs/manpage.html) commands. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](investigate-missing-telemetry.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
