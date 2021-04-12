---
title: Culture isn't supported when connecting Dynamics CRM for Outlook
description: Fixes an issue in which you get the "Culture is not supported" error when attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "Culture is not supported" error occurs when attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article helps you fix an issue in which you get the "Culture is not supported" error when attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2013 Service Pack 1, Microsoft Dynamics CRM 2015, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 2668553

## Symptoms

When you attempt to connect Microsoft Dynamics CRM for Microsoft Office Outlook, you encounter the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.
>
> Culture is not supported.  
> Parameter name: culture  
0 (0x0000) is an invalid culture identifier.  
 at Microsoft.Crm.MapiStore.DataStore.WaitInitialized()  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
 at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(object stateInfo)

## Cause

The language setting could not be set at the user level in CRM due to insufficient user privileges. The user's security role may be missing the Write privilege for the **User Settings** entity.

## Resolution

1. Sign into the Microsoft Dynamics CRM web application as a user with the System Administrator role.

2. Navigate to **Settings** > **Security** > **Security Roles**.

    > [!NOTE]
    > If you're not using Microsoft Dynamics CRM 2015 or later, Security Roles is located under Administration instead of Security.

3. Open the role that's assigned to this user.
4. Click the **Business Management** tab and grant the "Write" privilege for the **User Settings** entity. User level access is the minimum requirement.
5. Click **Save**.
6. Attempt to connect Microsoft Dynamics CRM for Microsoft Office Outlook again.

If you're still encountering issues connecting CRM for Outlook to your CRM Online organization, a diagnostic tool is available to help diagnose the issue:

[CRM for Outlook Configuration Diagnostic](https://aka.ms/crmoutlookconfigkb)

## More information

If you're not sure which security role is assigned to the user, use the following steps:

1. Navigate to **Settings** > **Security** > **Users**.

    > [!NOTE]
    > If you're not using Microsoft Dynamics CRM 2015 or later, Users is located under Administration instead of Security.

2. Open the User record who is facing this issue.
3. On the command bar within the user record, click **Manage Roles**.
4. Locate the security role that has a checkmark next to it. Use the steps provided in the Resolution section to grant the **Write** privilege for the **User Settings** entity.
