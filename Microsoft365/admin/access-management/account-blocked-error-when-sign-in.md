---
title: Account has been blocked error when sign in to Office 365
description: Describes an issue that triggers an error message when a user tries to sign in to the Office 365 portal. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office 365
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Office 365 Identity Management
---

# "It looks like your account has been blocked" error when signing in to Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem 

When a user tries to sign in to the Office 365 portal, he or she receives the following error message:

**It looks like your account has been blocked
Please contact your admin to unblock it.**

## Solution 

To resolve this issue, use the following methods in the order in which they're presented. After each method, test to see whether the issue is resolved. If the issue isn't resolved, go to the next method. 

### For users

Method 1: Wait 15 minutes.

> [!NOTE]
> If this doesn't resolve the issue, contact your admin to perform the other methods in this article.

### For admins

Method 2: Make sure that the user is allowed to sign in. 

To do this, follow these steps:

1. Sign in to the Office 365 portal as an admin.   
2. Locate the user, and then open the settings for that user. 
3. Under **Set sign-in status**, click **Allowed**, and then click **Save**.   

Method 3: Reset the user's password.

As an Office 365 admin, perform a password reset for the user.

Method 4: Reset the user's sign-in status.

Change the sign-in status of the user from Allowed to Blocked, and then change it back to Allowed. To do this, follow these steps:

1. Sign in to the Office 365 portal as an admin.   
2. Locate the user, and then open the settings for that user.   
3. Under **Set sign-in status**, click **Blocked**, and then click **Save**.   
4. Under **Set sign-in status**, click **Allowed**, and then click **Save**.   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).