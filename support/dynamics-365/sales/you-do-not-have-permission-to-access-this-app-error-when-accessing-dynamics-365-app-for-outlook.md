---
title: You don't have permission to access this app when accessing Dynamics CRM 365 App for Outlook
description: Provides a resolution for the issue that an error may occur when using the Microsoft Dynamics 365 App for Outlook.
ms.reviewer: dmartens
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# You don't have permission to access this app occurs when accessing the Microsoft Dynamics 365 App for Outlook

This article provides a resolution to make sure you have sufficient privileges to use the Microsoft Dynamics CRM App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3064189

## Symptoms

When you select the Microsoft Dynamics 365 app in Outlook (anywhere the app is supported), you see the following message:

> You don't have permission to access this app. Contact your system administrator to add the "Use Dynamics 365 for Office Apps" privilege to your user role.

## Cause

You do not have sufficient privileges to use the Microsoft Dynamics CRM App for Outlook. This error occurs if your security role in Microsoft Dynamics 365 does not include the *Use Dynamics 365 App for Outlook* privilege.

## Resolution

A user with the System Administrator role needs to enable the *Use Dynamics 365 App for Outlook* privilege for any security role that needs access to this app.

> [!NOTE]
> This privilege is located on the Business Management tab within the Privacy Related Privileges section. For more information on modifying security roles, see [Edit a security role](/power-platform/admin/create-edit-security-role#edit-a-security-role).
