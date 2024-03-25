---
title:  Troubleshoot issues with IoT capabilities
description: Provides a resolution to solve issues with IoT capabilities in Dynamics 365 Field Service.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 10/19/2023
ms.custom: sap:IoT - Connected Field Service
---
# Troubleshoot issues with IoT capabilities in Dynamics 365 Field Service

This article helps resolve issues with the Internet of Things (IoT) capabilities in Microsoft Dynamics 365 Field Service.

## Symptoms

You encounter unexpected behavior with IoT capabilities in Dynamics 365 Field Service, for example, a device that won't register, or a failure to pull device data.

## Resolution

Review the Azure IoT logic apps to help diagnose the issue.

1. Sign in to the [Azure portal](https://portal.azure.com). Go to **Resource Groups** and select the resource group where Azure IoT is deployed.
2. There are two logic apps between IoT and Field Service. Select one depending on if you think the issue originates in Field Service (contains "CRM" in the app name), or if it originates in Azure IoT.
3. Review the list of jobs that run when the system performs actions. For example, when you attempt to register a device, the logic app will run.
4. Select a failed run and view the logic app to understand where an error may have occurred.

Use the information in failed logic apps to diagnose the issue. If you need to [create a Dynamics 365 support ticket](https://dynamics.microsoft.com/contact-us/), that information is also helpful for the Microsoft support team.

> [!NOTE]
> We don't recommend editing the logic apps that are deployed by the solution.
