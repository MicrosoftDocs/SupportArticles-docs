---
title: How to update third-party server configuration
description: Provides a method to update the third-party server configuration.
ms.date: 05/30/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: toddfous, v-kainawroth, v-weizhu
---
# How to update third-party server configuration

The server side must be able to accept connections that have certain headers. Depending on the `Access-Control-Allow-Headers` configuration on the server side, it's often necessary to extend the server-side list by manually adding the `Request-Id`, `Request-Context`, and `traceparent` (W3C distributed header) headers. For example, the configuration might resemble the following text:

`Access-Control-Allow-Headers: Request-Id, traceparent, Request-Context, <your header>`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
