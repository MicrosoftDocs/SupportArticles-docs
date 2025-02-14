---
title: Taskbar Calendar Doesn't Open in Windows 11
description: Provides information on the behavior of the taskbar calendar in Windows 11.
ms.date: 01/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows desktop and shell experience\desktop (shell,explorer.exe init,themes,colors,icons,recycle bin)
- pcy:WinComm User Experience
---
# Taskbar calendar doesn't open in Windows 11

This article provides information on the behavior of the taskbar calendar in Windows 11.

## External monitor scenario

When using an external monitor with your Windows 11 device, you can control its behavior through the display settings:

1. Go to **Settings** > **System** > **Display**.
2. Choose one of the following options:
   - **Extend these displays**: Select this option and designate the primary monitor. The taskbar calendar will only pop up on this primary monitor. This behavior is by design.
   - **Duplicate these displays**: With this option, you can open the taskbar calendar on any monitor.

## Troubleshoot the calendar not open issue

If you have disabled the Notifications and Action Center in Windows 11, the calendar doesn't extend when you select the taskbar calendar. This behavior is by design because the calendar in Windows 11 is part of the Notifications and Action Center.

> [!NOTE]
> Removing the Notifications and Action Center is different from turning off notifications. If you turn off notifications, the Notifications and Action Center will still function. The taskbar calendar pops up upon selecting it.

### Check if the Notifications and Action Center is disabled

To determine if Group Policy is set to disable the Notifications and Action Center, follow these steps:

1. Press <kbd>Win</kbd> +<kbd>R</kbd>  to open the **Run** dialog. Type **gpedit.msc** and press <kbd>Enter</kbd>.
2. Navigate to one of these paths:
   - **User Configuration** > **Administrative Templates** > **Start Menu and Taskbar**
   - **Computer Configuration** > **Administrative Templates** > **Start Menu and Taskbar**
3. Find the **Remove Notifications and Action Center** policy.
4. Double-click the group policy to open the properties. If the policy is set to **Enabled**, the notification center is disabled.

### Check if the "Remove Notifications and Action Center" policy is enabled by using Intune

Follow these steps:

1. On your managed device, go to **Settings** > **Accounts** > **Access work or school**.
2. Select your work or school account, and then select **Info**.
3. At the bottom of the **Settings** page, select **Create report**.
4. A window opens showing the path to the log files. Select **Export**.
5. In File Explorer, navigate to **C:\Users\Public\Documents\MDMDiagnostics\\** to find the report.
6. Open the report and search for the **Remove Notifications and Action Center** policy to check if it's enabled.
