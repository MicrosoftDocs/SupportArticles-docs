---
title: The signed-in user does not have the appropriate security permissions error when setting Dynamics CRM for Outlook
description: When a user tries to configure the Microsoft Dynamics CRM client for Outlook, they receive an error stating with The signed-in user does not have the appropriate security permissions to view these records or perform the specific action. Contact your organization's Microsoft Dynamics CRM administrator to review the security permissions for this user. Provides a resolution.
ms.reviewer: jowells
ms.topic: troubleshooting
ms.date: 
---
# An error occurs when trying to configure the Microsoft Dynamics CRM client for Outlook 2011

This article provides a resolution for the issue that you can't successfully configure the Microsoft Dynamics CRM client for Microsoft Outlook 2011 due to the error **The signed-in user does not have the appropriate security permissions to view these records or perform the specific action**.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2619752

## Symptoms

When a user tries to configure the Microsoft Dynamics CRM client for Outlook, an error message occurs:

> The signed-in user does not have the appropriate security permissions to view these records or perform the specific action. Contact your organization's Microsoft Dynamics CRM administrator to review the security permissions for this user.

## Cause

The user's Access Mode within their Microsoft Dynamics CRM User Profile is configured to Restricted Access Mode.

## Resolution

To fix this issue, follow these steps:

1. Sign in to Microsoft Dynamics CRM as a CRM administrator.
2. Point to **Settings**, select **Administration**, and select **Users**.
3. Select the user having problems configuring the Microsoft Dynamics CRM client for Outlook.
4. Under Client Access License (CAL) Information, change **Access Mode** to **Read-Write**.

## More information

In the Microsoft Dynamics CRM platform trace, you can see the following error:

> \>Crm Exception: Message: Principal user (Id=\<USERGUID>, type=8) is missing prvReadUserQuery privilege (Id=*ID*), ErrorCode: -2147220960
