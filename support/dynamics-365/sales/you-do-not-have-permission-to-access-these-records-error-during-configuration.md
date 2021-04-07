---
title: You do not have permission to access these records occurs when configuring
description: You may receive an error that states you do not have permission to access these records. This error occurs when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook. Provides a resolution.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# You do not have permission to access these records occurs when configuring Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a resolution for the issue that you may receive an error **You do not have permission to access these records** when setting up Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 3187736

## Symptoms

When you attempt to connect Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> You do not have permission to access these records. Contact your Microsoft Dynamics CRM administrator.

If you select **Details**, you see the following more details:

> Principal user (Id=\<GUID>, type=8) is missing prvWriteUserSettings privilege (Id=\<ID>) at Microsoft.Crm.Application.Commands.ApplicationCommand.UpdateUserSettingsLanguage(String propertyName, Int32 oldLcid, Int32 lcid, IOrganizationContextEx context, Boolean allowThrowingCrmException)  
 at Microsoft.Crm.Application.Commands.ApplicationCommand.UpdateUserSettingsUICulture(Int32 lcid, IOrganizationContextEx context, Boolean allowThrowingCrmException)  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
 at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)  

## Cause

The language setting could not be set at the user level in Microsoft Dynamics CRM due to insufficient user privileges. The user's security role may be missing the Write privilege for the User Settings entity.

## Resolution

1. Sign in to the Microsoft Dynamics CRM web application as a user with the System Administrator role.
2. Navigate to **Settings** > **Security** > **Security Roles**.

   > [!NOTE]
   > If you are not using Microsoft Dynamics CRM 2015 or later, Security Roles is located under Administration instead of Security.

3. Open the role that is assigned to this user.
4. Select the **Business Management** tab and grant the **Write** privilege for the User Settings entity. User level access is the minimum requirement.
5. Select **Save**.
6. Attempt to connect Microsoft Dynamics CRM for Microsoft Office Outlook again.

If you are still encountering issues connecting Microsoft Dynamics CRM for Outlook to your Microsoft Dynamics CRM Online organization, run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) to diagnose and fix the problem.

## More information

If you are not sure which security role is assigned to the user, use the following steps:

1. Navigate to **Settings** > **Security** > **Users**.

   > [!NOTE]
   > If you are not using Microsoft Dynamics CRM 2015 or later, Users is located under Administration instead of Security.

2. Open the User record who is facing this issue.
3. On the command bar within the user record, select **Manage Roles**.
4. Locate the security role that has a checkmark next to it. Use the steps provided in the Resolution section to grant the Write privilege for the User Settings entity.
