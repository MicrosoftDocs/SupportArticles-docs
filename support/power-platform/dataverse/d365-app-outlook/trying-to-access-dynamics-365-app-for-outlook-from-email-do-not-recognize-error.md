---
title: Email address that we do not recognize error when accessing Dynamics 365 App for Outlook
description: It looks like you're trying to access the Microsoft Dynamics 365 App for Outlook from an email address that we don't recognize - this error occurs when you try to access the Microsoft Dynamics 365 App for Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Cannot access Microsoft Dynamics 365 App for Outlook due to email address is not recognized

This article provides a resolution for the error **It looks like you're trying to access the Microsoft Dynamics 365 App for Outlook from an email address that we don't recognize** that may occur when you access the Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4010246

## Symptoms

When you select Microsoft Dynamics 365 to access the Microsoft Dynamics 365 App for Outlook, you encounter the following error:

> It looks like you're trying to access the Microsoft Dynamics 365 App for Outlook from an email address that we don't recognize. Either sign out and sign in with the email address you use for Dynamics CRM or have your system administrator update your email Mailbox settings to reflect this email address.

## Cause

This error occurs if your primary email address for Microsoft Exchange Server does not match your email address in Microsoft Dynamics 365.

## Resolution

Compare the email address used in Exchange Server to your email address in Microsoft Dynamics 365. If they do not match, update them so that they match.

If you are using Exchange Online, open the [Office 365 Portal](https://portal.office.com) as an administrator and locate the user within the [Users area](https://portal.office.com/adminportal/home#/users). After selecting the user, select **Edit** next to the **User name / Email Aliases** section. Verify the Primary email address value matches the email address of the user record in Microsoft Dynamics 365.

You can locate the user record in Microsoft Dynamics 365 by accessing the Microsoft Dynamics 365 application in your web browser and navigating to **Settings**, **Security**, and then selecting **Users**. The Primary Email value needs to match the primary email address in Exchange Server.

If you had to update the email address in Exchange Server, close and reopen Outlook before trying to access the Microsoft Dynamics 365 app. If you had to update the email address in Microsoft Dynamics 365, you may need to select **Approve Email** within the user record.
