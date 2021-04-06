---
title: You only have administrative or read-only error
description: This article provides a resolution for the problem that occurs when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Error (You only have administrative or read-only access to your organization) when you configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article helps you resolve the problem that occurs when you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015, Dynamics CRM 2016  
_Original KB number:_ &nbsp; 2997751

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> You only have administrative or read-only access to your organization. To configure the organization with Outlook, you must have read-write access

## Cause

The Microsoft Dynamics CRM user's access-mode is not set to read-write (administrative or read-only). This is common if the user has been set as administrator only in Office 365.

## Resolution

In the Microsoft Dynamics CRM organization, set the option of the user to have their access-mode set to read-write.

The user needs a CRM Online license assigned as well. To assign a Microsoft Dynamics CRM Online license, sign into `https://portal.office.com` as a user with O365 administrative privileges and assign a Microsoft Dynamics CRM Online license to your user account. It may take a few minutes before the license information synchronizes from Office 365 to Microsoft Dynamics CRM Online.

For detailed steps on how to assign a license in Office 365, see [Add users and assign licenses at the same time](https://support.office.com/article/Assign-or-unassign-licenses-for-Office-365-for-business-997596B5-4173-4627-B915-36ABAC6786DC).

## More information

If you are still encountering issues connecting CRM for Outlook to your CRM Online organization, a diagnostic tool is available to help diagnose the issue: [CRM for Outlook Configuration Diagnostic](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72fb).
