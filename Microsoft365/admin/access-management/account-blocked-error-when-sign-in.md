---
title: Account has been blocked error when sign in to Office 365
description: Describes an issue that triggers an error message when a user tries to sign in to the Microsoft 365 portal. Provides a resolution.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-maqiu
appliesto:
- Office 365 Identity Management
---

# "Your account has been locked. Contact your support person to unlock it, then try again." error when signing in to Microsoft 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem 

When a user tries to sign in to the Microsoft 365 portal, he or she receives the following error message:

**Your account has been locked. Contact your support person to unlock it, then try again.**

## Solution 

To resolve this issue, use the following methods in the order in which they're presented. After each method, test to see whether the issue is resolved. If the issue isn't resolved, go to the next method. 

### For users

Method 1: Wait 15 minutes.

> [!NOTE]
> If this doesn't resolve the issue, contact your admin to perform the other methods in this article.

### For admins

Method 2: Make sure that the user is allowed to sign in. 

To do this, follow these steps:

1. Sign in to the Microsoft 365 portal as an admin.  
2. Under **Users**, Select **Active Users**.
2. Locate the user, and then click the users Display name to open the settings pane. 
3. At the top of the pane, select **Unblock sign-in**.
4. In the **Unblock sign-in** screen, de-select **Block this user from signing in** and click **Save changes**. 

Method 3: Reset the user's password.

As an Microsoft 365 admin, perform a password reset for the user.

Method 4: Reset the user's sign-in status.

Change the sign-in status of the user from Allowed to Blocked, and then change it back to Allowed. To do this, follow these steps:

1. Sign in to the Microsoft 365 portal as an admin.  
2. Under **Users**, Select **Active Users** 
2. Locate the user, and then click the users Display name to open the settings pane. 
3. At the top of the pane, select **Block sign-in**.
4. In the **Block sign-in** screen, select **Block this user from signing in** and click **Save changes**. 
5. In the **Unblock sign-in** screen, de-select **Block this user from signing in** and click **Save changes**. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
