---
title: Reminders in Outlook do not appear
description: This article provides a resolution for the issue that reminders don't show in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Reminders in Outlook do not appear

_Original KB number:_ &nbsp; 2787708

## Symptoms

Reminders for meetings, tasks, and follow-up items do not display in Outlook.

## Cause

This problem can occur if you have the option to display reminders is turned off either in the Outlook user interface or through a Group Policy setting. When a feature is configured by group policy, the option is disabled (grayed out) in the user interface. Therefore, it cannot be modified.

## Resolution

If reminders are not being managed by Group Policy, follow these steps to re-enable reminders.

- Outlook 2019, Outlook 2016, Outlook 2013, Outlook 2010, and Outlook for Microsoft 365
  1. On the **File** tab, select **Options**.
  2. Select **Advanced** in the **Outlook Options** dialog box.
  3. In the **Reminders** section, select **Show reminders**.
  4. Select **OK**.

- Outlook 2007 and Outlook 2003

  1. On the **Tools** menu, select **Options**.
  2. On the **Other** tab, select **Advanced Options**.
  3. In the **Advanced Options** dialog box, select **Reminder Options**.
  4. In the **Reminder Options** dialog box, select **Display the reminder**.
  5. Select **OK** three times.

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

The option to control the display of reminders in Outlook is stored in the Windows registry by using the following registry data.

Key: `HKEY_CURRENT_USER\software\microsoft\office\\<x.0>\Outlook\Options\Reminders`  
DWORD: Type  
Values: 0 = do not display reminders, 1 = display reminder (default behavior of the Type value does not exist)

> [!NOTE]
> In this registry path, <x.0> represents the version of Outlook (16.0 = Outlook 2016, Outlook 2019, or Outlook for Microsoft 365, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007, and 11.0 = Outlook 2003)

> [!NOTE]
> If the option to display reminders is being managed by Group Policy, the registry key path is slightly different.  
> Key: `HKEY_CURRENT_USER\software\Policies\microsoft\office\<x.0>\Outlook\Options\Reminders`

Contact your domain administrator if you must have this setting changes from the current value deployed by Group Policy.
