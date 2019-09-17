---
title: Report contains no data when you try to save the "Content viewing" audit log report in SharePoint Online
description: Describes an issue in which you receive "Report contains no data" error when you try to save the "Content viewing" audit log report in SharePoint Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# "Report contains no data" error when you try to save the "Content viewing" audit log report

## Problem

Consider the following scenario:

- You enable the Reporting feature on a SharePoint Online site collection.

- You browse to Audit Log Reports.

- When you try to save a "Content viewing" report to a location, you receive one of the following error messages:

  - **This report contains no data. Please ensure data for this report is being captured by the current audit settings. It may also take some time after audit settings are changed for events to surface here.**

  - **Sorry, something went wrong. An unexpected error has occurred.**

## Solution/Workaround

To work around this issue, Office 365 administrators can enable and use the audit log in the Office 365 Security & Compliance Center. For more information, see [Search the audit log in the Office 365 Security & Compliance Center](https://support.office.com/article/search-the-audit-log-in-the-office-365-security-compliance-center-0d4d0f35-390b-4518-800e-0c7ec95e946c).

## More information

This error occurs because the "Content viewing" report isn't supported in SharePoint Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
