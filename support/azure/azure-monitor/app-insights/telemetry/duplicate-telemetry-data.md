---
title: Receive duplicate telemetry data from Application Insights JavaScript SDK
description: Offers strategies to help fix an issue where you receive duplicate telemetry data from Application Insights JavaScript SDK.
ms.date: 06/24/2024
ms.service: azure-monitor
ms.reviewer: toddfous, v-kainawroth, v-weizhu
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
---
# Receive duplicate telemetry data from Application Insights JavaScript SDK

[!INCLUDE [Azure Help Support](../../../../includes/azure/application-insights-sdk-support.md)]

If the SDK reports correlation recursively, enable the configuration setting of `excludeRequestFromAutoTrackingPatterns` to exclude the duplicate data. This scenario can occur when you use connection strings. The syntax for the configuration setting is `excludeRequestFromAutoTrackingPatterns: [<endpointUrl>]`.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
