---
title: You do not have a license to use Microsoft Dynamics CRM Online error
description: You do not have a license to use Microsoft Dynamics CRM Online error occurs when you try to set up Microsoft Dynamics CRM for Microsoft Office Outlook. Provides a resolution.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# "You do not have a license" error when you configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a resolution for the **You do not have a license to use Microsoft Dynamics CRM Online** error that may occur when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 3091628

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> You do not have a license to use Microsoft Dynamics CRM Online. Contact your Office 365 administrator to assign a Microsoft Dynamics CRM license to you.

## Cause

Your user account has not been assigned a Microsoft Dynamics CRM Online license.

> [!NOTE]
> If you have an existing Office 365 subscription and later added a Microsoft Dynamics CRM Online subscription, a Microsoft Dynamics CRM Online license is not assigned to your user record automatically. If your user account has the Global Administrator or Service Administrator role, you can still sign into the Microsoft Dynamics CRM web application to perform administrative actions but cannot create records such as Accounts, Contacts, Leads, and so on. You must have a Microsoft Dynamics CRM Online license assigned to successfully connect Microsoft Dynamics CRM for Microsoft Office Outlook to your Microsoft Dynamics CRM Online instance. Within the Microsoft Dynamics CRM Online web application, you can navigate to **Settings** > **Security** > **Users** and change the view to Administrative Access Users. This view displays users who have administrative roles in the Office 365 portal but do not have a Microsoft Dynamics CRM Online license assigned.

## Resolution

Sign in to [Office 365 Portal](https://portal.office.com) as a user with administrative privileges and assign a Microsoft Dynamics CRM Online license to your user account. It may take a few minutes before the license information synchronizes from Office 365 to Microsoft Dynamics CRM Online.

For detailed steps on how to assign a license in Office 365, see [Add users and assign licenses at the same time](/microsoft-365/admin/add-users/add-users).

## More information

When you select **Details** on the error dialog or if you view the log file, the following error is shown:

> *Time*| Error| Exception : The user has not been assigned any License at Microsoft.Crm.Application.Outlook.Config.ServerInfo.RunServerDiagnostics()  
 at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadUserInfo(IClientAuthProvider\`1 orgAuthProvider)  
 at Microsoft.Crm.Application.Outlook.Config.ServerInfo.Initialize(Uri discoveryUri, OrganizationDetail selectedOrg, String displayName, Boolean isPrimary, IClientAuthProvider\`1 authenticatedProvider)  
 at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadDataToServerInfo()  
 at Microsoft.Crm.Application.Outlook.Config.ServerForm.\<InitializeBackgroundWorkers>b__3(Object sender, DoWorkEventArgs e)  
 at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)  
 at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)
