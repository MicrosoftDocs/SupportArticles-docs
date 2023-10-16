---
title: Issues after Autoplay is disabled in Group Policy
description: Describes issues after Autoplay is disabled in Group Policy, and provides the resolutions.
ms.date: 06/07/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, warrenw, kimberj, olturcio, v-lianna
ms.custom: sap:desktop-shell, csstroubleshoot
ms.technology: windows-client-shell-experience
---
# Issues after Autoplay is disabled in Group Policy

This article describes the issues that occur after [Autoplay](/previous-versions/windows/desktop/legacy/cc144212(v=vs.85)) is disabled in Group Policy and provides resolutions.

_Applies to:_ &nbsp; Supported versions of Windows Client  
_Original KB number:_ &nbsp; 2328787, 3096935

After Autoplay is disabled in Group Policy, you experience the following issues:

- HotStart buttons don't work when Autoplay is disabled.
- Autoplay Group Policy doesn't lock the Autoplay setting in Control Panel or the Settings app.

## HotStart buttons don't work when Autoplay is disabled

You have a laptop running  Windows 7 with HotStart buttons. When Autoplay is disabled on all drives in the Group Policy setting, the HotStart buttons don't work.

When you disable Autoplay on all drives in the Group Policy setting, the Autoplay registry value is set to `0xFF`, which causes the HotStart buttons to not work.

### Change the setting by using Local Group Policy Editor

Here are the steps:

1. Select Start, enter *gpedit.msc* in the Start search box, and then press <kbd>Enter</kbd> to open the Local Group Policy Editor.

    > [!NOTE]
    > If you're prompted for an administrator password or confirmation, enter the password, or select **Allow**.

2. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **AutoPlay Policies**, and double-click **Turn off Autoplay**.
3. Select **Enabled**, and then select **CD-ROM and removable media drives** in the drop-down list of **Turn off Autoplay on**.

By selecting this option, the Autoplay registry value is set to `0xB5`. Random access memory (RAM) drives are the only ones still enabled. Any other drives like unknown type drives, removable drives, network drives, and CD-ROM drives are disabled.

> [!NOTE]
> If you experience this issue on a domain-joined system, contact the domain administrator for assistance. Your system settings have been synchronized to the domain server.

### Change the NoDriveTypeAutoRun value data

As an optional resolution for operating systems that don't include *gpedit.msc*, you can directly change the `NoDriveTypeAutoRun` value data other than `0xFF` in the following registry path:

- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Polices\Explorer\`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\policies\Explorer\`

## Autoplay Group Policy doesn't lock the Autoplay setting in Control Panel or the Settings app

When an administrator configures the Group Policy **Turn off Autoplay**, the AutoPlay settings in Control Panel or the Settings app may still be available.

This is an unexpected behavior but is by design. Most Group Policy settings lock a user out of the User Interface (UI) if a Group Policy is controlling the setting. The Group Policy setting takes precedence over any changes made to the Autoplay UI by an end user.
