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
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 06/06/2024
---

# Microsoft 365 activation usage report issues

Admins can view activation reports for Microsoft 365 Apps by going to the [Microsoft 365 admin center](https://admin.microsoft.com), and selecting **Users** > **Active users** > **View Office activations**.

If you want to see which activations are still being used, go to https://admin.microsoft.com/#/reportsUsage/ProPlusUsage and sort by **Last activity date**. This can help you determine if there are unused licenses that can be assigned to other individuals in your organization.

Individuals in your organization can see their Microsoft 365 Apps activations by going to https://portal.office.com/account/?ref=MeControl#

For information about usage reports, see the following articles:

- [Microsoft 365 Reports in the admin center](/microsoft-365/admin/activity-reports/activity-reports)

- [Overview of inventory in the Microsoft 365 Apps admin center](/deployoffice/admincenter/inventory)

- [Sign-in logs in Microsoft Entra ID](/azure/active-directory/reports-monitoring/concept-sign-ins)

For issues with the usage reports, see the following troubleshooting topics.

## Usage report is incorrect

Note that Microsoft 365 Apps activations can take up to 48 hours to appear in the usage reports. If the individual opens a Microsoft 365 App such as Word or Excel, and there is no banner at the top stating they must activate, then their apps have successfully been activated.

## Report shows anonymous user names

Beginning September 1, 2021, user names in Microsoft 365 usage reports are anonymous by default. For more information, see [Microsoft 365 reports show anonymous user names instead of actual user names](/microsoft-365/troubleshoot/miscellaneous/reports-show-anonymous-user-name).

## Report doesn’t show device name

Currently, device names are not shown in the usage reports. This is by design.
