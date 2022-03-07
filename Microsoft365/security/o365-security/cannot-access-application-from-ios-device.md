---
title: Unable to access applications from iOS devices
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

# Error when accessing applications from iOS devices

## Symptoms

When you try to start a web application from an iOS device, you receive the following error message:

> You can't get there from here

:::image type="content" source="media/cannot-access-application-from-ios-device/access-error.png" alt-text="Screenshot of an error message that states you must use Microsoft Edge to access the resource.":::

## Cause

This error occurs if your organization has configured a Conditional Access policy that prevents access to the application from iOS devices.

## Resolution

To resolve this issue, determine which Conditional Access policy causes the error, and then modify the corresponding policy.

**Note:** You must have administrator permissions to modify the Conditional Access policy.

Here's how to identify the problematic Conditional Access policy:

1. Select **More details** in the error message to open the Azure Active Directory **Sign-in logs**.
1. Select **User sign-ins (interactive)** to see the **Request ID** of the failed request.

    :::image type="content" source="media/cannot-access-application-from-ios-device/sign-in-details.png" alt-text="Screenshot of the sign-in log in which the Request ID of the failed request is highlighted.":::

1. Select the failed request, and then select **Basic info** to see the failure reason.

    :::image type="content" source="media/cannot-access-application-from-ios-device/basic-info.png" alt-text="Screenshot of the information on the Basic info tab that shows the failure reason highlighted.":::

1. Select **Conditional Access** to see the policy that is causing the failure.

    :::image type="content" source="media/cannot-access-application-from-ios-device/conditional-access.png" alt-text="Screenshot of the information on the Conditional Access tab that shows the policy name highlighted.":::
