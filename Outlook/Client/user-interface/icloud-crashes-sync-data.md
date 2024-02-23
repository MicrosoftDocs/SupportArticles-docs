---
title: iCloud crashes when synchronizing data
description: Describes an issue where Apple iCloud crashes when synchronizing Contacts, Calendars, and Tasks with Microsoft Outlook 2016.  Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: tasitae
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2016
ms.date: 10/30/2023
---
# iCloud crashes when synchronizing data with Outlook 2016

_Original KB number:_ &nbsp; 3178906

## Symptoms

When you configure Apple iCloud to synchronize Contacts, Calendars and Tasks with Outlook 2016 and then click **Apply**, iCloud may crash. When this occurs, you may find one of the following crash signatures in the Application log for Event ID 1000.

```console
Faulting application name: AppleOutlookDAVConfig.exe
Faulting application version: 4.8.24.0
Faulting module name: mso20win32client.dll
Faulting module version: 0.0.0.0
Fault offset: 0x000ae519

Faulting application name: AppleOutlookDAVConfig64.exe
Faulting application version 4.8.24.0
Faulting module name: mso20win32client.dll
Faulting module version: 0.0.0.0
Fault offset: 0x00000000000e6b26
```

> [!NOTE]
> In the Application log, the version of AppleOutlookDAVConfig.exe, AppleOutlookDAVConfig64.exe and mso20win32client.dll may vary from those listed here.

## Cause

This issue may occur with Office 2016 Click-to-Run based installations, version 16.0.6965.2058 or later versions.

> [!NOTE]
> To determine whether your Office 2016 installation is Click-to-Run or MSI-based, and to find the version of Office, see the [More Information](#more-information) section.

## Workaround

To work around this issue, revert the Office 2016 Click-to-Run installation to the 16.0.6868.2067 version. To do this, follow these steps:

1. Exit all Office applications.
2. Open an elevated command prompt. To do this, click **Start**, type *cmd* in the Start Search box, right-click Command Prompt or cmd.exe, and then click **Run as administrator**.
3. At the command prompt, type the following command, and then press Enter:

    ```cosnole
    cd %programfiles%\Common Files\Microsoft Shared\ClickToRun
    ```

4. Type the following command, and then press Enter:

    ```console
    officec2rclient.exe /update user updatetoversion=16.0.6868.2067
    ```

5. When the repair dialog box appears, click **Online Repair**.
6. Click **Repair**, and then click **Repair** again.
7. After the repair is complete, start **Outlook**.
8. Click **File**, and then click **Office Account**.
9. In the **Product Information** column, click **Update Options**, and then click **Disable Updates**.

    > [!IMPORTANT]
    > This step is very important. The repair process re-enables automatic updates. To prevent the newest version of Office Click-to-Run from being automatically reinstalled, make sure that you follow this step.

10. Set a reminder in your calendar for a future date to check this Knowledge Base article (3178906) for a resolution for this issue. Enable automatic updates in Office again after this issue is fixed. Enabling automatic updates again will make sure that you don't miss future updates.

> [!NOTE]
> If you revert to version 16.0.6868.2067, you can configure iCloud to synchronize Contacts, Calendars and Tasks with Outlook 2016 successfully. At this point, if you prefer to, you can update Office 2016 to the latest version as long as you do not change the iCloud synchronization with Outlook.

## More information

To determine whether your Office 2016 installation is Click-to-Run or MSI-based, and to find the version of Office, follow these steps:

1. Open Outlook 2016.
2. On the **File** menu, select **Office Account**.
3. For Office 2016 Click-to-Run installations, an **Update Options** item is displayed. For MSI-based installations, the **Update Options** item isn't displayed.
4. For Office 2016 Click-to-Run installations, the version number is displayed under **Office Updates**.
