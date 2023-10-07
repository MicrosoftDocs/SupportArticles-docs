---
title: IoT Edge modules data is aggregated in charts
description: Find out why charts show aggregated telemetry data for IoT Edge modules in Dynamics 365 Connected Field Service.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 10/07/2023
---
# IoT Edge modules data is aggregated in charts

This article informs about a limitation with the Internet of Things (IoT) Edge modules data in Microsoft Dynamics 365 Field Service.

## Symptoms

Charts show aggregated telemetry data for IoT Edge modules when using Azure IoT Hub as an [IoT provider](/dynamics365/field-service/cfs-provider-iot-hub).

## Resolution

It's a known limitation. Currently, the [Connected Field Service implementation with Azure IoT Hub](/dynamics365/field-service/installation-setup-iothub) doesn't support splitting out telemetry data for IoT Edge modules.
