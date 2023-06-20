---
title:  Troubleshoot issues with IoT capabilities
description: Resolve issues with read-only forms in Field Service.
ms.author: vhorvath
author: vhorvathms
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Troubleshoot issues with IoT capabilities

This article helps resolve issues with IoT capabilities in Dynamics 365 Field Service.

## Symptoms

You encounter unexpected behavior with IoT capabilities in Field Service. For example, a device that won't register, or a failure to pull device data.

## Resolution

Review Azure IoT Logic Apps to help diagnose the issue.

1. Go to the [Azure portal](https://portal.azure.com) and sign in. Go to **Resource Groups** and select the resource group where Azure IoT is deployed.

2. There are two logic apps between IoT and Field Service. Select one depending on if you think the issue originates in Field Service (contains "CRM" in the app name), or if it originates in Azure IoT.

3. Review the list of jobs that run when the system performs actions. For example, when you attempt to register a device, the logic app will run.

4. Select a failed run and view the logic app to understand where an error may have occurred.

Use the information in failed logic apps to diagnose the issue. If you need to option a support ticket, that information is also helpful for the Microsoft support team. [Create a Dynamics 365 support ticket](https://dynamics.microsoft.com/contact-us/).

> [!NOTE]
> We don't recommend editing the logic apps that are deployed by the solution.
