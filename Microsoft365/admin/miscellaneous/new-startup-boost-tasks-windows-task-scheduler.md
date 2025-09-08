---
title: New Startup Boost Tasks in Windows Task Scheduler
description: Describes the Startup Boost feature and how to turn it off in Microsoft Word.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CSSTroubleshoot
  - CI 3719
ms.date: 03/27/2025
appliesto: 
  - Microsoft 365 Business 
  - Microsoft 365 Apps for business
  - Microsoft 365 Family
  - Microsoft 365 Apps for enterprise
  - Microsoft 365 Personal
---
# New Startup Boost tasks in Windows Task Scheduler

Startup Boost is a new feature that's built into Office to support the desktop versions of Microsoft Word. This feature reduces the time that’s required for the Word app to open. Startup Boost enables the operating system to preload Word by starting parts of the app before you open it.  

After the app is preloaded, it remains in a paused state until either the user opens it and the app's loading sequence resumes, or the operating system removes the app from memory to reclaim resources.  

The operating system preloads Word after you restart your computer, or whenever the computer has enough resources to run without affecting system performance. These requirements include the following resources:

- At least 8 GB of available RAM
- At least 5 GB of available disk space

> [!NOTE]
> The tasks to preload Word are turned off automatically while the Energy Saver mode for power consumption is active.

In the Windows Task Scheduler, you can see the following tasks that Office creates to preload the Word app:

- Office Startup Boost
- Office Startup Boost Logon

## Turn off Startup Boost

By default, the Startup Boost feature is active when you start Windows. However, you can turn off the feature.

To turn off Startup Boost, follow these steps:

1. In Word, select **File** > **Options**.
1. On the **General** tab, locate the **Startup options** section, and then clear the **Startup Boost** checkbox.
