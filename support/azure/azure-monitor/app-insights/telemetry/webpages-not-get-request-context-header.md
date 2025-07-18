---
title: Failed to get Request-Context correlation header error
description: Provides strategies to help fix an issue that involves Azure Monitor Application Insights for webpages.
ms.date: 06/24/2024
ms.service: azure-monitor
ms.reviewer: toddfous, v-kainawroth, v-weizhu
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
---
# Failed to get Request-Context correlation header as it may be not included in the response or not accessible error

[!INCLUDE [Azure Help Support](../../../../includes/azure/application-insights-sdk-support.md)]

The `correlationHeaderExcludedDomains` configuration property is an exclude list that disables correlation headers for specific domains. This option is useful if you include headers that cause the request to fail or not to be sent because of third-party server configuration. This property supports wildcards. Therefore, you can specify a value such as `*.queue.core.windows.net`. Avoid adding the application domain to this property because this stops the SDK from including the required distributed tracing `Request-Id`, `Request-Context`, and `traceparent` headers as part of the request.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
