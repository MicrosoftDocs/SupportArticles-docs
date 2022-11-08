---
title: Warning 1946 when you install an Installer package
description: This article discusses a problem in which you receive a Warning 1946 message when you install a Windows Installer package in Windows 7.
ms.date: 08/28/2020
ms.custom: sap:installation
ms.reviewer: viveksi
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# Warning 1946 message when you install a Windows Installer package in Windows 7

This article introduces a problem in which you receive a Warning 1946 message when you install a Windows Installer package in Windows 7.

_Original product version:_ &nbsp; Windows 7  
_Original KB number:_ &nbsp; 2745126

## Symptoms

When you install a Windows Installer (.msi) package on a computer that is running Windows 7, you receive a warning message that resembles the following:

> Warning 1946. Property 'System.AppUserModel.NoPin' for shortcut '**Shortcut name**.lnk' could not be set.

However, the installation process is successful.

This issue occurs when one of the following shortcut properties is set in the `MsiShortCutProperty` table of the .msi package.

- `System.AppUserModel.NoPinToStartOnInstall`
- `System.AppUserModel.IsDualMode`
- `System.ItemNameSortOverride`

## Cause

This issue occurs because Windows Installer cannot set a shortcut property that is specified in the `MsiShortcutProperty` table.

The following properties are introduced in Windows 8. These properties do not exist in Windows 7 or in earlier versions of Windows.

- `System.AppUserModel.NoPinToStartOnInstall`
- `System.AppUserModel.IsDualMode`
- `System.ItemNameSortOverride`

Therefore, Windows Installer displays a warning dialog when it tries to apply these properties to a shortcut in Windows 7.

## Status

This behavior is by design. You can safely ignore this warning message.

## More information for developers

When you create a .msi package to run both in Windows 8 and in Windows 7, do not specify the shortcut properties by using their names. Instead, specify the properties by using their GUID. The properties can be set in the PropertyKey column of the `MsiShortcutProperty` table. The following table contains the GUID of each property.

|GUID|Property name|
|---|---|
| {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 12|System.AppUserModel.NoPin|
| {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 11|System.AppUserModel.IsDualMode|
| {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 23|System.ItemNameSortOverride|
  
## References

- For more information about the Windows Installer, see [Windows Installer](/windows/win32/msi/windows-installer-portal).
- For more information about the MSI installation and logging options, see [Command-Line Options](/windows/win32/msi/command-line-options).
- For more information about the `MsiShortcutPropertyTable`, see [MsiShortcutProperty table](/windows/win32/msi/msishortcutproperty-table).
- For more information about the Shortcut table, see [Shortcut table](/windows/win32/msi/shortcut-table).

## Applies to

- Windows 7 Enterprise
- Windows 7 Home Basic
- Windows 7 Home Premium
- Windows 7 Professional
- Windows 7 Starter
- Windows 7 Ultimate
