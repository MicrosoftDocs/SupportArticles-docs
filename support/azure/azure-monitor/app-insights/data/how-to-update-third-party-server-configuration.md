---
title: How to update third-party server configuration
description: Provides a method to update the third-party server configuration.
ms.date: 06/24/2024
ms.service: azure-monitor
ms.reviewer: toddfous, v-kainawroth, v-weizhu
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
---
# How to update third-party server configuration

[!INCLUDE [Azure Help Support](../../../../includes/azure/application-insights-sdk-support.md)]

The server side must be able to accept connections that have certain headers. Depending on the `Access-Control-Allow-Headers` configuration on the server side, it's often necessary to extend the server-side list by manually adding the `Request-Id`, `Request-Context`, and `traceparent` (W3C distributed header) headers. For example, the configuration might resemble the following text:

`Access-Control-Allow-Headers: Request-Id, traceparent, Request-Context, <your header>`.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
