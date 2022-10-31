---
title: Office Feature Updates task description and FAQ
description: Describes Office Feature Updates task
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: v-maqiu
ms.custom: CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 3/31/2022
---

# Description of the Office Feature Updates task

## Summary

Starting in Microsoft Office ProPlus build 16.0.11220.* or a later build, there are two new tasks:

- Office Feature Updates
- Office Feature Updates Logon

:::image type="content" source="media/office-feature-updates-task-faq/office-feature-updates.png" alt-text="Screenshot of the Office Feature Updates tasks.":::

The **Office Feature Updates** task calls the "SDXHelper.exe" process in the background. You can view this process in Task Manager during the execution. This task runs in user context and polls Office services in the background. It doesn't cause any Office performance issues during startup.

> [!NOTE]
> If the "SDXHelper.exe" process is causing high CPU usage, try to [repair your Office installation](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

:::image type="content" source="media/office-feature-updates-task-faq/process-task-manager.png" alt-text="Screenshot shows the SDXHelper.exe process in Task Manager.":::

- This task runs for every user for all Microsoft 365 Apps Channels. However, it downloads feature updates based on your defined policies.

  For example, Semi Annual Enterprise Channel (SAEC) users are expected to receive updates on a six-month cadence. Therefore, this task doesn't schedule downloads of feature updates to run every few hours.

- This task makes sure that Office installations can check for feature updates.

## Frequently asked questions (FAQ)

**Q1: Does this feature apply for Semi Annual Enterprise Channel (SAEC) users?**

**A1:** The Office Feature Updates task runs every four hours. It may run for users in SAEC. However, it doesn't download any feature updates for these users.

**Q2: What are the pros and cons of disabling this task permanently? Is this recommended?**

**A2:** For Microsoft 365 customers, we recommend that they do not disable the Office Feature Updates task. This task makes sure that their Office features download the latest updates when the updates are available. In the future, more features will be updated through this task.

**Q3: Is this task dependent on the Office Automatic Updates 2.0 task (or vice versa) for Office feature updates?**

**A3:** No.

**Q4: Does the update polling occur on a metered network connection? If yes, is there a way to turn this off?**

**A4:** On low-cost networks, we don't run any update polling.

> [!NOTE]
> This task doesn't apply to Office LTSC 2021, Office 2019 or Office 2016 (perpetual products).
