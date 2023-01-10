---
title: License validation when Microsoft 365 administrator disables a user
description: Describes an issue that occurs when an administrator tries to disable a Skype for Business Online user in Microsoft 365. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: romanma, corbinm, dahans
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# "License validation error" when a Microsoft 365 administrator tries to disable a Skype for Business Online user

## Problem

When a Microsoft 365 administrator tries to disable a Skype for Business Online (formerly Lync Online) user, the administrator receives the following error message:

```asoc
"License validation error: the action 'Disable-UMMailbox','Identity', can't be performed on the user **<user>**, with license **<license>**
```

## Solution

To resolve this issue, apply the correct license, and then try to disable the user again. For Skype for Business Online, an Exchange Plan 2 license or higher is required. 

## More Information

This issue occurs because the appropriate license isn't applied to the user. Therefore, the action fails with a license validation error.

To perform any administrative action, a valid Exchange Plan 2 license or higher is required for user enablement or disablement of Skype for Business Online. Microsoft 365 administrators must make sure that the appropriate licensing is in place so that users can use the feature or perform the administrative tasks that are related to the feature.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
