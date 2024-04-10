---
title: Failed to get Request-Context correlation header error
description: Provides strategies to help fix an issue that involves Azure Monitor Application Insights for webpages.
ms.date: 05/30/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: toddfous, v-kainawroth, v-weizhu
---
# Failed to get Request-Context correlation header as it may be not included in the response or not accessible error

The `correlationHeaderExcludedDomains` configuration property is an exclude list that disables correlation headers for specific domains. This option is useful if you include headers that cause the request to fail or not to be sent because of third-party server configuration. This property supports wildcards. Therefore, you can specify a value such as `*.queue.core.windows.net`. Avoid adding the application domain to this property because this stops the SDK from including the required distributed tracing `Request-Id`, `Request-Context`, and `traceparent` headers as part of the request.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]