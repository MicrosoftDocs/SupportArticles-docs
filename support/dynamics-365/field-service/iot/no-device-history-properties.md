---
title: No records after pulling IoT device data
description: Resolves issues with missing data from IoT devices in Dynamics 365 Field Service by setting the Azure IoT Hub pricing and scale tier to S1-Standard.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 10/19/2023
---
# No records after pulling IoT device data in Dynamics 365 Field Service

This article helps resolve issues with historical data loss for [IoT devices](/dynamics365/field-service/cfs-register-devices) in Microsoft Dynamics 365 Field Service.

## Symptoms

After pulling device data, there are no records in a device's data history, or no data in the device reported properties.

## Resolution

The main reason why pulling device data fails for successfully registered devices is that the Azure IoT Hub pricing and scale tier isn't set to **S1-Standard**.

To change the pricing and scale tier, go to the [Azure portal](https://portal.azure.com/), find your IoT Hub resource, and set the **Pricing and scale tier** to **S1-Standard**.
