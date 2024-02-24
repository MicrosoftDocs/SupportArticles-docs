---
title: The Office Feature Updates task 
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
ms.date: 02/23/2024
---

# The Office Feature Updates task

Microsoft Office ProPlus build 16.0.11220.* and later builds provide two new tasks:

- Office Feature Updates
- Office Feature Updates Logon

:::image type="content" source="media/office-feature-updates-task-faq/office-feature-updates.png" alt-text="Screenshot of the Office Feature Updates tasks.":::

The Office Feature Updates task checks for updates to [Connected experiences in Microsoft 365](https://support.microsoft.com/office/connected-experiences-in-microsoft-365-8d2c04f7-6428-4e6e-ac58-5828d4da5b7c), such as Copilot, in Microsoft Word, Microsoft Excel, and Microsoft PowerPoint. This task runs for every user for all Microsoft 365 Apps channels. However, it downloads feature updates based on the policies defined for each user. For example, Semi-Annual Enterprise Channel (SAEC) users usually receive updates twice a year. Therefore, this task doesn't schedule downloads of feature updates to run every few hours.

The Office Feature Updates task calls the "SDXHelper.exe" process in the background. You can view this process in Task Manager when it executes. The Office Feature Updates task runs in the user's context and polls Office services in the background. It doesn't cause any Office performance issues during startup.

> [!NOTE]
> If the "SDXHelper.exe" process is causing high CPU usage, try to [repair your Office installation](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b) to resolve the issue.

:::image type="content" source="media/office-feature-updates-task-faq/process-task-manager.png" alt-text="Screenshot shows the SDXHelper.exe process in Task Manager.":::

> [!NOTE]
> This task doesn't apply to Office LTSC 2021, Office 2019 or Office 2016 (perpetual products).

## Frequently asked questions (FAQ)

**Q1: When do updates for connected experiences happen?**

**A1:** Each connected experience that supports dynamic updates publishes upgraded .appx files when changes are made and validated. This process is similar to application updates on mobile devices. The Office Feature Updates task runs approximately every 4 hours on each user's devices and downloads the the latest version of the package when available. The updates are installed silently and don't require user interaction. The installation also doesn't require Office to restart. The updates are applied at the next opportunity that doesn't interrupt the user's experience such as the next time the user invokes that feature within the application.  

**Q2: Does this feature apply for Semi-Annual Enterprise Channel (SAEC) users?**

**A2:** The Office Feature Updates task runs every four hours. It might run for users in SAEC. However, it doesn't download any feature updates for these users.

**Q3: Can I disable this task or control the update process?**

**A3:** Customers can block these updates entirely by preventing the Office Feature Updates process from starting. For example, they can disable the Office Feature Updates task in the Windows task scheduler. However, blocking updates isn't recommended. This task makes sure that their connected experiences update when the updates are available. If blocked, connected experiences are updated as part of regular Office updates, but delayed updates result in out-of-date experiences and potential functional issues.

**Q4: Is this task dependent on the Office Automatic Updates 2.0 task (or vice versa) for Office feature updates?**

**A4:** No.

**Q5: Does the update polling occur on a metered network connection?**

**A5:** No. Also no update polling occurs on low-cost networks.

**Q6: How does this feature affect battery life?**

**A6:** The Office Feature Updates task doesn't run when a laptop is reliant on battery power. The task installs updates only when the computer is connected to a power source.

**Q7: How do connection settings affect the update task?**

**A7:** Any applications and other settings that block connections to the supporting Content Delivery Network (CDN), such as firewalls, also block the delivery of feature updates to a user's machine. The URLs and IP addresses that the Office Feature Updates task needs to reach are listed along with other Microsoft domains and URLs in the information for ID 46 & 47 in the article [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-365-common-and-office-online&preserve-view=true). 

**Q8: What specific changes and updates are made by .appx files?**
**A8:** These packages contain updated versions of connected experiences in Office, such as Copilot for Word. The update mechanism allows those experiences to be updated and enhanced along with the cloud-based services that power them. The files contained within the package are stored locally to improve performance.

**Q9: How do you ensure the integrity and security of these .appx files?**
**A9:** Microsoft digitally signs each update package before publishing it. After a package is downloaded, that signature is validated before the contents of the package are made available on the local device. The signature ensures that the package wasn't manipulated after it was created. This verification also means that each individual file in the package matches the original published version.
