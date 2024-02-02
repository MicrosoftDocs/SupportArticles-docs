---
title: IoT Edge module data is aggregated in charts
description: Finds out why charts show aggregated telemetry data for IoT Edge modules in Dynamics 365 Connected Field Service.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 10/19/2023
---
# IoT Edge module data is aggregated in charts in Dynamics 365 Field Service

This article discusses a limitation with the Internet of Things (IoT) Edge module data in Microsoft Dynamics 365 Field Service.

## Symptoms

Charts show aggregated telemetry data for IoT Edge modules when using Azure IoT Hub as an [IoT provider](/dynamics365/field-service/cfs-provider-iot-hub).

## More information

It's a known limitation. Currently, the [Connected Field Service implementation with Azure IoT Hub](/dynamics365/field-service/installation-setup-iothub) doesn't support splitting out telemetry data for IoT Edge modules.
