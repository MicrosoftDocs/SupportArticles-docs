---
title: Error when accessing CRM App for Outlook
description: Provides a solution to an error that occurs when you access the App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# You only have administrative access to Microsoft Dynamics CRM error message displays when accessing the Microsoft Dynamics CRM App for Outlook

This article provides a solution to an error that occurs when you access the Microsoft Dynamics CRM App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3064256

## Symptoms

When you select the Dynamics CRM app in Outlook (anywhere the app is supported), you see the following message:

> "You only have administrative access to Microsoft Dynamics CRM. To use this app, you must have read-write access."

## Cause

The Access Mode option for the user is set as Administrative. If the access mode is set as Administrative, the privileges of the user are restricted.

## Resolution

To fix this issue, follow these steps:

1. As a user with the System Administrator role, change the access type of this user to **Read-Write**.
2. Sign in to the Microsoft Dynamics CRM web application as a user with the System Administrator role.
3. Navigate to **Settings** > **Security** > **Users**.
4. Double-click on the user.
5. Under **Administration**, select the value **Read-Write** for Access Mode.
6. Select **Save**.
