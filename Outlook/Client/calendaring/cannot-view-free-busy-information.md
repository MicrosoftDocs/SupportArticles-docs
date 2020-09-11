---
title: Error (We're checking everyone's calendars) when viewing free/busy information in Outlook
description: Provides a solution to an issue in which you can't view free/busy information with error (We're checking everyone's calendars) in Outlook.
author: TobyTu
ms.author: meshel
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 122615
ms.reviewer: meshel
appliesto:
- Exchange Online
- Outlook for Microsoft 365
search.appverid: MET150
---

# Error when viewing free/busy information in Outlook: We're checking everyone's calendars

## Symptoms

When viewing free/busy information in the **Scheduling Assistant** in Outlook, you receive this error message:

> "We're checking everyone's calendars"

## Cause

The **FreeBusySupport** registry key could be missing after installing or reinstalling Office applications. To verify that's the case, go to these registry paths:

**For Click-to-Run installation Office**:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Outlook\SchedulingInformation\FreeBusySupport`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Outlook\SchedulingInformation\FreeBusySupport`

**For Windows Installer (MSI) installation Office**:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Office\16.0\Outlook\SchedulingInformation\FreeBusySupport`

## Resolution

Use one of these methods:

### Method 1

Reinstall Office applications.

### Method 2

Add the missing registry subkeys:

> [!NOTE]
> Add the MSI subkey only if the MSI version is installed. If using Click-to-Run, add the Click-to-Run registry keys only.

1. Close Outlook.
2. Start Registry Editor. To do this, right-click **Start**, type **regedit** in the **Run**  box, and then select **OK**.
3. Find the location of the missing **FreeBusySupport** registry key and add the key manually. You must add the **SchedulingInformation** key first, and then add the **FreeBusySupport** subkey.

    > [!NOTE]
    > 16.0 is for Outlook 2016, Outlook for Microsoft 365 and Outlook 2019.

4. Select **FreeBusySupport**, select **Edit**, point to **New**, and select **String Value**.
5. Set **Value name** to **EX**, and then double-click to edit the string.
6. Type `{0006F014-0000-0000-C000-000000000046}` into **Value data**, and then select **OK**.
7. Select **FreeBusySupport**, select the **Edit** menu, point to **New**, and select **String Value**.
8. Set **Value name** to **SMTP**, and then double-click to edit the string.
9. Type `{0006F049-0000-0000-C000-000000000046}` into **Value data**, and then select **OK**.
    :::image type="content" source=".\media\cannot-view-free-busy-information\free-busy-registry-key.png" alt-text="Value data.":::
10. Exit Registry Editor.
