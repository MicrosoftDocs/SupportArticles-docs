---
title: No records after pulling IoT device data
description: Resolves missing data from IoT devices in Dynamics 365 Field Service by setting Azure IoT Hub pricing and scale tier to S1-Standard.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 10/07/2023
---
# No records after pulling IoT device data in Dynamics 365 Field Service

This article helps resolve issues with missing history data from the Internet of Things (IoT) devices in Microsoft Dynamics 365 Field Service.

## Symptoms

After pulling device data, there are no records in a device's data history, or no data in the device reported properties.

## Resolution

The main reason that pull device data fails for successfully registered devices is because the Azure IoT Hub pricing and scale tier isn't set to **S1-Standard**.

To change the pricing and scale tier, go to the [Azure portal](https://portal.azure.com/), find your IoT Hub resource, and set pricing and scale tier to **S1-Standard**.
