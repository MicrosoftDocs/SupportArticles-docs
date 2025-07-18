---
title: Users Don't Receive SharePoint Alert Notifications
description: This article discusses and resolves an issue that prevents users from receiving SharePoint alert notifications.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Lists and Libraries\Alerts
  - CSSTroubleshoot
appliesto: 
  - SharePoint in Microsoft 365
ms.date: 05/14/2025
---

# Users don't receive SharePoint alert notifications

> [!IMPORTANT]
> Starting in July 2026, Microsoft will remove the ability to use SharePoint Alerts. We recommend that you use [rules](https://support.microsoft.com/office/create-a-rule-to-automate-a-list-or-library-151ea008-7fa6-409b-b0bd-b04a3b3cacd5) or [Power Automate](https://go.microsoft.com/fwlink/?linkid=2111055) to handle notifications. For more information, see [SharePoint Alerts retirement](https://aka.ms/retirement/alerts/support).

## Symptoms

In a Microsoft 365 environment, users don't receive SharePoint alert notifications as expected. Specifically, users might experience one or more of the following symptoms:

- Alert email messages aren't received after an alert is created.
- Alerts don't work or aren't received.
- Task list notifications don't work.
- Workflow email messages aren't received.
- The workflow doesn't work.

## Resolution

### Resolution 1

Investigate the user's permissions for the list, for the library, or for the task list. Make sure that the user account has at least the Read permission on the object.

- If these permissions exist, go to Resolution 2.
- If these permissions don't exist, direct the user to the site administrator to have the permissions corrected.

For more information about Permission Levels, see [Understanding Permission Levels](/sharepoint/understanding-permission-levels).

### Resolution 2

Verify that new alerts work. To do this, create an alert on a test library or on a test list. Perform an action to generate the alert. For example, add, edit, or delete an item. Then, wait 15 minutes. If the alert isn't received, collect the following information, and then contact Microsoft 365 technical support:

- Determine the last known time that alerts were received.
- Record the exact steps that are required to reproduce the issue in the new alert.

### Resolution 3

If the new alert is received but existing alerts aren't received, delete and then re-create all the user's alerts on the site. To do this, see [Manage, view, or delete SharePoint alerts](https://support.office.com/article/manage-view-or-delete-sharepoint-alerts-99dfb19c-9a90-4a8c-aba1-aa8c8afb0de2?ui=en-US&rs=en-US&ad=US#ID0EAADAAA=Online).

### Resolution 4

If all alerts from multiple files or libraries aren't delivered, visit the Service Health Dashboard in the Microsoft 365 admin center (select **Health** > **Service health**) to check for any advisories or incidents that might be occurring in SharePoint or Exchange. The issue could be a fault in the SharePoint alert capability or delays in delivering email messages through Exchange. Also, check whether other email is being delivered. If it's not, the issue is likely Exchange delays.

> [!NOTE]
>
> * Check the JUNK folder in your email client. Sometimes, alerts are sent there.
> * In cases in which an immediate alert rule is generating extremely high volume for a recipient email address, SharePoint might apply throttling. This process is intended to protect service health and overall alert delivery reliability. If a single email address is receiving several thousand immediate alert messages per hour across all its list or library subscriptions, it's likely that throttling is being applied.
> * It's not possible to send alerts to Distribution or O365 groups. Only mail-enabled security groups are supported.
> * You can't create custom alert email templates. You have to use Microsoft FLOW or SharePoint Designer Workflow to use custom templates.

## More information

This issue might occur if permissions aren't granted to the user's account to access the sites, the library, or the list for which the user wants to use alert functionality. In this situation, users must have permissions to the list or to the library for alerts and to the task list for tasks and workflows.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
