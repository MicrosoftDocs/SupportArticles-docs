---
title: Give control doesn't work when you share screen in Teams
description: This article describes an issue in which drop-down for Give control doesn't work when you share screen in Teams desktop client. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meetings Other
  - CI 107235
  - CSSTroubleshoot
ms.reviewer: sarvdon, SfB_Triage
appliesto: 
  - Microsoft Teams
ms.date: 10/30/2023
---

# "Give Control" doesn't work when you share a screen in Teams

## Symptoms

You share a screen with another user on the Microsoft Teams desktop client, and the other user requests control of your screen. In this situation, you see the user's request on the Sharing toolbar. However, you don't see an option to approve or deny the request. Even the **Give Control** drop-down menu doesn't react when you try to open it.

## Cause

This issue occurs because the device that you're using doesn't have a graphics processing unit (GPU) installed, or GPU hardware acceleration is disabled. The Give Control drop-down menu doesn't work unless hardware acceleration is supported on the system. This behavior is by design.

## Resolution

To prevent this behavior, make sure that your system supports hardware acceleration. To verify the same, you can browse `edge://gpu/` in Microsoft Edge or `chrome://gpu/` in Google Chrome. If you can see any value in it stating "Software only" or "hardware acceleration unavailable", that means the system doesn't support it. For more help, we recommend that you contact your hardware provider.

## More information

When this issue occurs, you can see the following information in Teams client logs:

```
info -- [screenSharing][control] appSharingToolbar: AppSharingToolbar created with hardware acceleration: false
```

> [!NOTE]
> To collect the logs on a Windows machine, go to `%appdata%\Microsoft\Teams\media-stack\*.*`. On a Mac machine, go to `~Library/Application Support/Microsoft/Teams/media-stack/*.*`.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
