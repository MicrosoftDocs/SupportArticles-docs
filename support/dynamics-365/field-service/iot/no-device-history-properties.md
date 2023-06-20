---
title: No records after pulling IoT device data
description: Resolve missing data from IoT devices in Field Service by setting Azure IoT Hub pricing and scale tier to S1-Standard.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 06/15/2023
---

# No records after pulling IoT device data

This article helps resolve issues with missing history data from IoT devices in Dynamics 365 Field Service.

## Symptoms

After pulling device data, there are no records in a device's data history, or no data in the device reported properties.

## Resolution

The main reason that pull device data fails for successfully registered devices is because the Azure IoT Hub pricing and scale tier is not set to **S1-Standard**.

To change the pricing and scale tier, go to the Azure portal, find your IoT Hub resource, and set pricing and scale tier to **S1-Standard**.
