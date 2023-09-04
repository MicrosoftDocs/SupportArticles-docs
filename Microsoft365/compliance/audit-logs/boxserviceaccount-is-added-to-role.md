---
title: BOXServiceAccount is added to a role in Microsoft 365 alerts
description: BOXServiceAccount is added to a role in Microsoft 365 alerts.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - Office 365 Security & Compliance Center
ms.date: 03/31/2022
---

# BOXServiceAccount is added to a role in Microsoft 365 alerts

## Problem

You receive Microsoft 365 security alerts (configured in the Security Compliance Center) that state that the BOXServiceAccount is added to a role.

This is an example of such an alert:

BOXServiceAccount@DomainName.prod.outlook.com is added to DomainName.PROD.OUTLOOK.COM/Microsoft Exchange Hosted Organizations/contoso.onmicrosoft.com/role name.

## Cause

This is by design.

## Resolution

After a tenant administrator assigns an Exchange administrator, Skype for Business administrator, or SharePoint administrator role to a user in the Microsoft 365 portal, the Microsoft 365 portal uses a built-in account (BOXServiceAccount) to add the user to the **View-Only Organization Management** Role Based Access Control (RBAC) group.

To see the actual audit log, you can either use Search similar activities in the Microsoft 365 alert detail activity list view or do a free-text search for "BOXServiceAccount" directly from the Audit log search page.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
