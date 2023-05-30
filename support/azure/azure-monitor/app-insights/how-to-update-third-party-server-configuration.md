---
title: How to update third-party server configuration
description: Provides a method to update the third-party server configuration.
ms.date: 05/30/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: toddfous, v-kainawroth
author: AmandaAZ
ms.author: v-weizhu
---
# How to update third-party server configuration

The server side needs to be able to accept connections with those headers present. Depending on the `Access-Control-Allow-Headers` configuration on the server side, it's often necessary to extend the server-side list by manually adding `Request-Id`, `Request-Context`, and `traceparent` (W3C distributed header).

`Access-Control-Allow-Headers: Request-Id, traceparent, Request-Context, <your header>`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
