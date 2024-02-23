---
title: Office Feature Updates task description and FAQ
description: Describes Office Feature Updates task
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 03/31/2022
---

# Description of the Office Feature Updates task

The Office Feature Updates task checks for updates to service-delivered Office features, such as Copilot. This task runs for every user for all Microsoft 365 Apps Channels. However, it downloads feature updates based on your defined policies. For example, Semi-Annual Enterprise Channel (SAEC) users are expected to receive updates on a six-month cadence. Therefore, this task doesn't schedule downloads of feature updates to run every few hours.

## Summary

Starting in Microsoft Office ProPlus build 16.0.11220.* or a later build, there are two new tasks:

- Office Feature Updates
- Office Feature Updates Logon

:::image type="content" source="media/office-feature-updates-task-faq/office-feature-updates.png" alt-text="Screenshot of the Office Feature Updates tasks.":::

The **Office Feature Updates** task calls the "SDXHelper.exe" process in the background. You can view this process in Task Manager during the execution. This task runs in user context and polls Office services in the background. It doesn't cause any Office performance issues during startup.

> [!NOTE]
> If the "SDXHelper.exe" process is causing high CPU usage, try to [repair your Office installation](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

:::image type="content" source="media/office-feature-updates-task-faq/process-task-manager.png" alt-text="Screenshot shows the SDXHelper.exe process in Task Manager.":::

> [!NOTE]
> This task doesn't apply to Office LTSC 2021, Office 2019 or Office 2016 (perpetual products).

## Frequently asked questions (FAQ)

**Q1: Does this feature apply for Semi-Annual Enterprise Channel (SAEC) users?**

**A1:** The Office Feature Updates task runs every four hours. It might run for users in SAEC. However, it doesn't download any feature updates for these users.

**Q2: Can I disable this task?**

**A2:** For Microsoft 365 customers, we recommend that they don't disable the Office Feature Updates task. This task makes sure that their service-delivered Office features download the latest updates when the updates are available. However, these services are still updated through the standard update mechanisms.

**Q3: Is this task dependent on the Office Automatic Updates 2.0 task (or vice versa) for Office feature updates?**

**A3:** No.

**Q4: Does the update polling occur on a metered network connection?**

**A4:** On low-cost networks, we don't run any update polling.

**Q5: How does this feature affect battery life?**

**A5:** The Office Feature Updates task doesn't run when a laptop is reliant on battery power. These updates only occur when the computer connected to a power source.

**Q6: How do connection settings affect the update task?**

**A6:** Any applications and other settings, like firewalls, that block connections to the supporting Content Delivery Network (CDN) also block the delivery feature updates to user's machine. The URLs and IP addresses that need to be reachable are documented with other Microsoft domains and URLs in the article [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges). Lines 46 and 47 are the relevant items for this feature.

**Q7: When do updates for service-delivered features happen?**

**A7:** Updates to service-delivered features can happen at any time. However, these updates are silent and don't require any user intervention. They don't require Office to restart.
