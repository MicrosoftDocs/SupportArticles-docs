---
title: Users don't receive SharePoint Online alert notifications
description: This article describes an issue that users don't receive SharePoint Online alert notifications, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Lists and Libraries\Alerts
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Users don't receive SharePoint Online alert notifications

## Problem

In a Microsoft 365 environment, users don't receive SharePoint Online alert notifications as expected. Specifically, users may experience one or more of the following symptoms:

- Alert email messages aren't received after an alert is created.

- Alerts don't work. Alerts aren't received.

- Task list notifications don't work.

- Workflow email messages aren't received.

- The workflow doesn't work.

## Solutions

### Solution 1

Investigate the user's permissions for the list, for the library, or for the task list. Make sure that the user account has at least Read permissions on the object.

- If these permissions are present, go to Solution 2.
- If these permissions aren't present, direct the user to the site administrator to have these permissions corrected.

For more information about Permission Levels, see [Understanding Permission Levels](/sharepoint/understanding-permission-levels).

### Solution 2

Verify that new alerts work. To do this, create a new alert on a test library or on a test list. Perform an action to generate the alert. For example, add, edit, or delete an item. Then, wait 15 minutes. If the alert isn't received, collect the following information, and then contact Microsoft 365 technical support:

- Verify the last known time that alerts were received.
- Record the exact steps to reproduce the issue in the new alert.

### Solution 3

If the new alert is received but existing alerts aren't received, delete and then re-create all the user's alerts on the site. To do this, see [Manage, view, or delete SharePoint alerts](https://support.office.com/article/manage-view-or-delete-sharepoint-alerts-99dfb19c-9a90-4a8c-aba1-aa8c8afb0de2?ui=en-US&rs=en-US&ad=US#ID0EAADAAA=Online) to recreate the alert.

### Solution 4

If all alerts from multiple files or libraries are not delivered, visit the Service Health Dashboard from the Microsoft 365 admin center, Health, Service health to check for any advisories/incidents that may be occurring with SharePoint or Exchange. The issue could be with the SharePoint alert capability or delays in emails through Exchange. It will also be important to note whether other email is being delivered, and if not, the issue is likely with Exchange delays.

> [!Note]
>
> * Check the JUNK folder in your email, as sometimes alerts might go there.
> 
> * In cases where an immediate alert rule is generating extremely high volume for a recipient email address SharePoint may apply throttling. This is designed to protect service health and overall alert delivery reliability. If a single email address is receiving several thousand immediate alert emails per hour across all its list or library subscriptions then throttles may be applied.
> 
> * It is not possible to send alerts to Distribution or O365 groups. Only mail-enabled security groups are supported.
>
> * You cannot customize alert email templates; you need to use Microsoft FLOW or SharePoint Designer Workflow to achieve those.

## More information

This issue may occur if permissions aren't granted to the user's account in order to access the sites, the library, or the list in which the user wants to use alert functionality. This means that users must have permissions to the list or to the library for alerts and to the task list for tasks and for workflows.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
