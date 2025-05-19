---
title: Microsoft 365 activation usage report issues
description: Describes issues an admin might encounter with Microsoft 365 activation usage reports.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Activation related M365 usage reports
  - CSSTroubleshoot
  - CI 157763
  - CI 159459
  - CI 5843
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/19/2025
---

# Microsoft 365 activation usage report issues

Admins can view [activation reports](/microsoft-365/admin/activity-reports/microsoft-office-activations-ww?view=o365-worldwide&preserve-view=true) in the [Microsoft 365 admin center](https://admin.microsoft.com).

For more information about Microsoft 365 reports, see the following articles:

- [Microsoft 365 Reports in the admin center](/microsoft-365/admin/activity-reports/activity-reports)
- [Overview of inventory in the Microsoft 365 Apps admin center](/deployoffice/admincenter/inventory)
- [Sign-in logs in Microsoft Entra ID](/azure/active-directory/reports-monitoring/concept-sign-ins)

For issues with the usage reports, see the following sections.

## Usage report is incorrect

Microsoft 365 Apps activations can take up to 48 hours to appear in the usage reports. If the user opens a Microsoft 365 app, such as Word or Excel, and there is no banner at the top that says they must activate, their apps have been successfully activated.

## Report shows anonymous user names

Starting September 1, 2021, user names in Microsoft 365 usage reports are anonymous by default. For more information, see [Microsoft 365 reports show anonymous user names instead of actual user names](/microsoft-365/troubleshoot/miscellaneous/reports-show-anonymous-user-name).

## Report doesn't show device name

Currently, device names aren't shown in the usage reports. This behavior is by design.
