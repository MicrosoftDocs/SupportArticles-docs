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

The Office Feature Updates task checks for updates to [Connected experiences in Microsoft 365](https://support.microsoft.com/office/connected-experiences-in-microsoft-365-8d2c04f7-6428-4e6e-ac58-5828d4da5b7c), such as Copilot. This task runs for every user for all Microsoft 365 Apps Channels. However, it downloads feature updates based on your defined policies. For example, Semi-Annual Enterprise Channel (SAEC) users are expected to receive updates twice a year. Therefore, this task doesn't schedule downloads of feature updates to run every few hours.

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

**Q1: When do updates for connected experiences happen?**

**A1:** Each connected experience that supports dynamic updates publishes upgraded **.appx** files as changes are made and validated, similar to application updates on mobile devices. The Office Feature Updates task runs approximately every 4 hours on users' devices and downloads the most up-to-date package if a newer one is available. Updates are silent and don't require user interaction. They don't require Office to restart. Updates are applied at the next opportunity that doesn't interrupt the user's experience (for example, the next time the user invokes that feature within the application UI).  

**Q2: Does this feature apply for Semi-Annual Enterprise Channel (SAEC) users?**

**A2:** The Office Feature Updates task runs every four hours. It might run for users in SAEC. However, it doesn't download any feature updates for these users.

**Q3: Can I disable this task or control the update process?**

**A3:** We recommend that Microsoft 365 customers don't disable the Office Feature Updates task. This task makes sure that their connected experiences update when the updates are available. If blocked, connected experiences are updated as part of regular Office updates, but delayed updates result in out-of-date experiences and potential functionally issues.

**Q4: Is this task dependent on the Office Automatic Updates 2.0 task (or vice versa) for Office feature updates?**

**A4:** No.

**Q5: Does the update polling occur on a metered network connection?**

**A5:** On low-cost networks, we don't run any update polling.

**Q6: How does this feature affect battery life?**

**A6:** The Office Feature Updates task doesn't run when a laptop is reliant on battery power. These updates only occur when the computer connected to a power source.

**Q7: How do connection settings affect the update task?**

**A7:** Any applications and other settings that block connections to the supporting Content Delivery Network (CDN), such as firewalls, also block the delivery feature updates to user's machine. The URLs and IP addresses that need to be reachable are documented with other Microsoft domains and URLs in the article [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges). Lines 46 and 47 are the relevant items for this feature.

**Q8: What specific changes and updates are made by .appx files?**
**A8:** These packages contain updated versions of resources used by connected experiences in Office, such as Copilot in Word. This update mechanism allows those features to be updated and enhanced along with the cloud-based services that power them. The files contained within the package are stored locally to improve performance.

**Q9: How do we ensure the integrity and security of these .appx files?**
**A9:** Microsoft digitally signs each update package before publishing it. After a package is downloaded, that signature is validated before the contents of the package are made available on the local device. The signature ensures that no one manipulated the package after it was created. This verification also means each individual file in the package matches the original published version.
