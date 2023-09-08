---
title: Receive duplicate telemetry data from Application Insights JavaScript SDK
description: Offers strategies to help fix an issue where you receive duplicate telemetry data from Application Insights JavaScript SDK.
ms.date: 05/30/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: toddfous, v-kainawroth, v-weizhu
---
# Receive duplicate telemetry data from Application Insights JavaScript SDK

If the SDK reports correlation recursively, enable the configuration setting of `excludeRequestFromAutoTrackingPatterns` to exclude the duplicate data. This scenario can occur when you use connection strings. The syntax for the configuration setting is `excludeRequestFromAutoTrackingPatterns: [<endpointUrl>]`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
