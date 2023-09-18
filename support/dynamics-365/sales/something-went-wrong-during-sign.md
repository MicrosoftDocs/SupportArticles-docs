---
title: Something went wrong during sign-in when accessing Dynamics 365 App for Outlook
description: Provides a solution to an error that occurs when you access the Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# Something went wrong during sign-in error message displays when you access the Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you access the Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 3064194

## Symptoms

When you select the Dynamics 365 app in Outlook (anywhere the app is supported), you see the following message:

> Something went wrong during sign-in. Please try again. If the problem persists, contact your system administrator.

## Cause

Cause 1

Microsoft Dynamics 365 App for Outlook was unable to connect to the authorization service to ensure that you're authorized to use this app.

Cause 2

This issue can occur if your Dynamics 365 (online) URL was changed after the Dynamics 365 App for Outlook was installed. For example: If your Dynamics 365 URL was <`https://contosocorp.crm.dynamics.com`> when you deployed the app but you changed the URL to <`https://contoso.crm.dynamics.com`> later.

## Resolution

Resolution 1

Close the app, and open it again. If the problem still exists, try closing your internet browser and reopening it again. If the problem continues, try the solution from ["Something went wrong during sign-in" error using Dynamics 365 App for Outlook](https://support.microsoft.com/help/4035750).

Resolution 2

If you changed your Dynamics 365 (online) URL after Microsoft Dynamics 365 App for Outlook was installed, you need to redeploy the app:

1. A user with the System Administrator role can redeploy the app to users by opening the Dynamics 365 web application, and then navigating to the Dynamics 365 App for Outlook area within Settings.
1. Select the users who should have the app redeployed and use one of the **Add App** buttons to redeploy the app.
1. After the Status changes to **Added to Outlook**, you can verify if the issue has been resolved. If you already had the app open, close and reopen it.

## More information

You can verify if this issue is the result of Cause 2 by right-clicking on the **Help me resolve this issue** link in the error message and copying the URL. If you view the URL parameters, it contains the old Dynamics 365 URL. In the example provided earlier, it would show the old URL (`contosocorp.crm.dynamics.com`) instead of your current Dynamics 365 URL (`contoso.crm.dynamics.com`).
