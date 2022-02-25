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
ms.reviewer: jmartin
appliesto: 
  - Exchange Online
search.appverid: MET150
---

# "You can't get there from here" error when accessing an application from iOS devices

## Symptoms

When you try to start an application from an iOS device, you receive the following error message:

> You can't get there from here

:::image type="content" source="media/cannot-access-application-from-ios-device/access-error.png" alt-text="Screenshot of the error that states you must use Microsoft Edge to access this resource.":::

## Cause

This error occurs if your organization has deployed a Conditional Access policy that prevents access by using the application on iOS devices.

## Resolution

To resolve this issue, find out which Conditional Access policy causing the error and then change the corresponding policy.

**Note:** You must have administrator permissions to change the Conditional Access policy.

Here's how to find the Conditional Access policy:

1. Click **More details** in the error message, select **User sign-ins (interactive)**, and then you'll see the **Request ID** of the failed request.

    :::image type="content" source="media/cannot-access-application-from-ios-device/sign-in-details.png" alt-text="Screenshot of the sign-in log in which the Request ID of the failed request is highlighted.":::

2. Select the failed request, select **Basic info** and **Conditional Access**, and then you'll respectively see the failure reason and the policy causing the failure.

    :::image type="content" source="media/cannot-access-application-from-ios-device/basic-info.png" alt-text="Screenshot of the information under the Basic info tab, and the failure reason is highlighted.":::

    :::image type="content" source="media/cannot-access-application-from-ios-device/conditional-access.png" alt-text="Screenshot of the information under the Conditional Access tab, and the policy name which causes the error is highlighted.":::
