---
title: Error (We're checking everyone's calendars) when viewing free/busy information in Outlook
description: Resolves an issue in which you can't view free/busy information and you receive an error message (We're checking everyone's calendars) in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 122615
ms.reviewer: meshel
appliesto: 
  - Exchange Online
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---

# Error when you view free/busy information in Outlook: We're checking everyone's calendars

## Symptoms

When you view free/busy information in the **Scheduling Assistant** in Outlook, you receive the following error message:

> "We're checking everyone's calendars"

## Cause

The **FreeBusySupport** registry value could be missing after you install or reinstall Office applications. To verify that this is your situation, start Registry Editor (right-click **Start**, type **regedit** in the **Run** box, select **OK**), and then locate the following registry subkeys, depending on the type of your Office installation.

**For Click-to-Run installations**:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Outlook\SchedulingInformation\FreeBusySupport`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Outlook\SchedulingInformation\FreeBusySupport`

**For Windows Installer (MSI) installations**:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Outlook\SchedulingInformation\FreeBusySupport`

> [!NOTE]
> The "16.0" path segment represents Outlook 2019, Outlook 2016, and Outlook for Microsoft 365.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry](https://support.microsoft.com/help/322756) for restoration in case problems occur.

Use one of the following methods.

### Method 1

Reinstall the Office applications.

### Method 2

Add the missing registry entries.

> [!NOTE]
> Add the registry entries under the appropriate subkey for your type of Office installation, either Click-to-Run or MSI.

1. Close Outlook.
2. Start Registry Editor.
3. Find the location of the missing **FreeBusySupport** registry entry, and add the entry manually. You must add the **SchedulingInformation** entry first,  and then add a **FreeBusySupport** entry beneath **SchedulingInformation** entry.
4. Select **FreeBusySupport**, select **Edit**, point to **New**, and then select **String Value**.
5. Set **Value name** to **EX**, and then double-click to edit the string.
6. Type `{0006F014-0000-0000-C000-000000000046}` in the **Value data** box, and then select **OK**.
7. Select **FreeBusySupport**, select the **Edit** menu, point to **New**, and then select **String Value**.
8. Set **Value name** to **SMTP**, and then double-click to edit the string.
9. Type `{0006F049-0000-0000-C000-000000000046}` in the **Value data** box, and then select **OK**.
    :::image type="content" source=".\media\cannot-view-free-busy-information\free-busy-registry-key.png" alt-text="Screenshot of the FreeBusySupport registry key after you add entries.":::
10. Exit Registry Editor.
