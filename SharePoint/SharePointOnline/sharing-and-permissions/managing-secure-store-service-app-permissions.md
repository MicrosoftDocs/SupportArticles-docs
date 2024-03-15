---
title: Permissions required for managing the Secure Store Service app
description: Describes some scenarios in which permissions are required to manage the Secure Store service application.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2013
  - SharePoint Server 2013
  - SharePoint Server 2010
  - SharePoint Online
ms.date: 12/17/2023
---

# Permissions required for managing the Secure Store Service app

## Summary

**Permissions required to manage the Secure Store Service application**

If the following conditions are true, a user must be explicitly added to the Secure Store Service application (under **Managers**) in order to manage the Secure Store service application:

- When the accounts that are used as the secure store application pool identity and as the Central Administration application pool identity are not the same account. This is the most restricted permissions scenario.
- When the account is not directly added to the Central Administration server's Local Administrators group.

Additional scenario:

- When the account is added to the Central Administration server's Local Administrators group as part of an Active Directory group, but the "Claims to Windows Token Service" SharePoint service is not enabled for the farm. By default, members of the Local Administrators group on the Central Administration server can administer the Secure Store Service. However, adding an Active Directory group to the Local Administrators group works only when the "Claims to Windows Token Service" SharePoint service is enabled.

If the accounts that are used as the Secure Store application pool identity and as the Central Administration application pool identity are not the same account, explicit permissions to manage the secure store may be required.

## More Information

Users who are added to the Farm Administrators group in SharePoint Central Administration can access SharePoint central administration. However, when they select **Manage** on the Secure Store Service application, they may receive an **Access is Denied** error message. This problem occurs in the following scenarios.

### Scenario 1

If the user is added to the Central Administration server's Local Administrators group as part of an Active Directory domain group, but the "Claims to Windows Token Service" SharePoint service is disabled, SharePoint cannot verify that the current user is a member of the Local Administrators group. And without that verification, the member cannot be granted access.

### Scenario 2

Even though the user is explicitly listed in Central Administration's Farm Administrators group, after the August 2013 Cumulative Update for SharePoint 2010 is applied, the account cannot administer the Secure Store without additional permissions.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
