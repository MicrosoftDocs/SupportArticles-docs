---
title: IoT Edge modules data is aggregated in charts
description: Find out why charts show aggregated telemetry data for IoT Edge modules in Connected Field Service.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 06/15/2023
---

# IoT Edge modules data is aggregated in charts

This article informs about a limitation with IoT Edge modules data in Dynamics 365 Field Service.

## Symptoms

Charts show aggregated telemetry data for IoT Edge modules when using IoT Hub as IoT provider.

## Resolution

It's a known limitation. Currently, the Connected Field Service implementation with IoT Hub doesn't support splitting out telemetry data for IoT Edge modules.
