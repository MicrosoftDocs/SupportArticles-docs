---
title: Failed to get Request-Context correlation header error
description: Resolves an error that occurs when you use Application Insights for webpages.
ms.date: 05/10/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: toddfous, v-kainawroth
author: AmandaAZ
ms.author: v-weizhu
---
# Failed to get Request-Context correlation header as it may be not included in the response or not accessible

The `correlationHeaderExcludedDomains` configuration property is an exclude list that disables correlation headers for specific domains. This option is useful when including those headers would cause the request to fail or not be sent because of third-party server configuration. This property supports wildcards. An example would be `*.queue.core.windows.net`, as seen in the [code sample](/azure/azure-monitor/app/javascript#enable-distributed-tracing). Adding the application domain to this property should be avoided because it stops the SDK from including the required distributed tracing `Request-Id`, `Request-Context`, and `traceparent` headers as part of the request.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]