---
title: Unable to access application from iOS devices
description: Fixes an issue in which a Conditional Access policy prevents access by using the application on iOS devices.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 160266
  - CSSTroubleshoot
ms.reviewer: jmartin, aruiz
appliesto: 
  - Microsoft 365 for enterprise
search.appverid: MET150
---

# "You can't get there from here" error when accessing applications from iOS devices

## Symptoms

When you try to start a web application from an iOS device, you receive the following error message:

> You can't get there from here

:::image type="content" source="media/cannot-access-application-from-ios-device/access-error.png" alt-text="Screenshot of an error message that states you must use Microsoft Edge to access the resource.":::

## Cause

This error occurs if your organization has deployed a Conditional Access policy that prevents access by using the application on iOS devices.

## Resolution

To resolve this issue, determine which Conditional Access policy causes the error, and then change the corresponding policy.

**Note:** You must have administrator permissions to change the Conditional Access policy.

Here's how to identify the problematic Conditional Access policy:

1. In the error message, select **More details** > **User sign-ins (interactive)** to see the **Request ID** of the failed request.

    :::image type="content" source="media/cannot-access-application-from-ios-device/sign-in-details.png" alt-text="Screenshot of the sign-in log in which the Request ID of the failed request is highlighted.":::

2. Select the failed request, and then select both **Basic info** and **Conditional Access** to respectively see the failure reason and the policy that is causing the failure.

    :::image type="content" source="media/cannot-access-application-from-ios-device/basic-info.png" alt-text="Screenshot of the information on the Basic info tab that shows the failure reason highlighted.":::

    :::image type="content" source="media/cannot-access-application-from-ios-device/conditional-access.png" alt-text="Screenshot of the information on the Conditional Access tab that shows the policy name highlighted.":::
