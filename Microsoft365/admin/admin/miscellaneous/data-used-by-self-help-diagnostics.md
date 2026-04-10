---
title: Data processed by Microsoft 365 admin center diagnostics
description: Describes the types of data that is processed when you run self-help diagnostics in the Microsoft 365 admin center.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 11175
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - Microsoft 365 admin center
search.appverid: MET150
ms.date: 04/09/2026
---

# Data processed by diagnostics run in the Microsoft 365 admin center

# Summary

When you run a self-help diagnostic in the Microsoft 365 admin center, a consent notice informs you that tenant and user configuration information will be processed and stored temporarily outside the compliance boundary. This article explains what that means and what types of data are involved.

## Types of data processed by diagnostics

To run a diagnostic, administrators provide specific values needed to troubleshoot an issue, such as a user name, URL, or Meeting ID. Microsoft uses this information to gather additional data that is scoped to those values. This data can be tenant, user, or system-defined
configuration information.

Examples of tenant or user-defined configuration data that might be retrieved include, but is not limited to:

- User mailbox folder names
- User aliases
- User display names
- User email addresses
- Email subject lines
- User mailbox rule names
- Administration policy names
- SharePoint site names
- Meeting subject lines and titles

> [!IMPORTANT]

> Customer content such as email messages, documents, and chat conversations is **never** accessed by the diagnostic service.

## Time frame for which data is retained

The data that is processed by the support systems is automatically removed after the diagnostic process is complete. This data is not retained for use beyond the scope of the specific diagnostic that you run.

## Related diagnostic resources

For a full list of self-help diagnostics by product area, see the following articles:

- [Self-help diagnostics for SharePoint Online and OneDrive administrators](https://learn.microsoft.com/en-us/troubleshoot/sharepoint/diagnostics/sharepoint-and-onedrive-diagnostics)
- [Self-help diagnostics for issues in Exchange Online and Outlook](https://learn.microsoft.com/en-us/troubleshoot/exchange/administration/self-help-diagnostics)
- [Self-help diagnostics for Microsoft Teams administrators](https://learn.microsoft.com/en-us/troubleshoot/microsoftteams/teams-administration/admin-self-help-diagnostics)
- [Self-help diagnostics for Microsoft Purview](https://learn.microsoft.com/en-us/troubleshoot/microsoft-365/purview/diagnostics/purview-compliance-diagnostics)
