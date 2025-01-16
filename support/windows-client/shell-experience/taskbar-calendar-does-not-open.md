---
title: Taskbar calendar does not open in Windows 11
description: Provides information on the behavior of the taskbar calendar in Windows 11. 
ms.date: 01/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\Desktop (Shell, Explorer.exe init, themes, colors, icons, recycle bin), csstroubleshoot
---
# Taskbar calendar does not open in Windows 11

This article provides information on the behavior of the taskbar calendar in Windows 11.

## External monitor scenario

When using an external monitor with your Windows 11 device, you can control its behavior through the display settings:

1. Go to **Settings** > **System** > **Display**.
2. Choose one of the following options:
   - **Extend these displays**: Select this option and designate the primary monitor. The taskbar calendar will only pop up on this primary monitor. This behavior is by design.
   - **Duplicate these displays**: With this option, you can open the taskbar calendar on any monitor.

## Troubleshoot calendar not opening issue

If you have disabled the notification center in Windows 11, the calendar doesn't extended when you click on the taskbar calendar. This is by design, because the calendar in Windows 11 is part of the notification center.

> [!NOTE]
> Removing the notification and action center is different from turning off notifications. If you turn off notification, the notification and action center still functions. The taskbar calendar pops up upon clicking on it.

## Check if the notification and action center is disabled

To determine if group policy is set to disable the notification and action center, follow these steps:

1. Press Win + R to open **Run** dialog box. Type *gpedit.msc* and press Enter.
2. Navigate to one of these paths:
   - **User Configuration** > **Administrative Templates** > **Start Menu and Taskbar**
   - **Computer Configuration** > **Administrative Templates** > **Start Menu and Taskbar**
3. Find **Remove Notifications and Action Center** policy.
4. Double-click the group policy to open properties. If the policy is set to **Enabled**, it means notification center is disabled.

## Check if "Remove Notification and Action Center" policy is enabled by using Intune

Follow these steps:

1. On your managed device, go to **Settings** > **Accounts** > **Access work or school**.
2. Select your work or school account, and then select **Info**.
3. At bottom of **Settings** page, select **Create report**.
4. A window opens showing log files. Select **Export**.
5. In File Explorer, navigate to C:\Users\Public\Documents\MDMDiagnostics\ to find report.
6. Open report and search for **Remove Notification and Action Center** policy to check if it's enabled.
