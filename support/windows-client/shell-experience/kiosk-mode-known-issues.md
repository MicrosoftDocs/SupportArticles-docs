---
title: Kiosk mode known issues
description: Learn about known issues for devices that run in single-app kiosk mode or restricted user experience mode.
ms.date: 02/25/2026
manager: dcscontentpm
ms.topic: troubleshooting
ms.reviewer: anthonychen
audience: itpro
ms.custom:
- sap:windows desktop and shell experience\kiosk mode
- pcy:WinComm User Experience
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# Kiosk mode known issues

This article describes known problems for devices that run in single-app kiosk mode or restricted user experience (multi-app kiosk) mode. You can often resolve these issues by making configuration changes or installing cumulative updates. Future releases should automatically resolve some of these issues.

## Restrictions dialog box on sign-in when Microsoft Edge is an allowed app

On kiosks that have Microsoft Edge as an allowed app, a **Restrictions** dialog box appears on sign-in that displays the following message:

> This operation is canceled due to restrictions in effect on this computer. Please contact your system administrator.

This issue is fixed on Windows builds 26100.7705, 26200.7705, and later builds. To put these fixes into effect, redeploy the kiosk configuration.

## Kiosk policies don't deploy and generate error code 0x86000005

When you use certain mobile device management (MDM) providers, kiosk policies don't deploy and you see error code `0x86000005`. This issue occurs on builds between build 26100.4484 and build 26100.7705.

This issue is fixed in Windows builds 26100.7705, 26200.7705, and later builds.

## File Explorer shows a blocked location dialog box

You have a kiosk that uses [File Explorer restrictions](/windows/configuration/assigned-access/configuration-file#file-explorer-restrictions) and has the [Shared PC mode](/windows/configuration/shared-pc/set-up-shared-or-guest-pc) feature configured. When you open File Explorer, you see the following message:

> We can't open This PC. To help you keep your data safe, the location is blocked.

To work around this issue, configure the [SetAllowedFolderLocations](/windows/client-management/mdm/policy-csp-fileexplorer#setallowedfolderlocations) policy to use a value that doesn't include **This PC**.

## Packaged apps don't launch when Microsoft Edge is an allowed app

On kiosks that have Microsoft Edge as an allowed app, packaged apps (apps installed from an MSIX or APPX package) don't launch.

To work around this issue, find the name of the .exe file that the packaged app launches. To find the .exe file name, in the app's installation folder, open the AppxManifest.xml file and look for the `Executable` attribute of the `Application` element.

In the allowed apps list in your [Assigned Access configuration file](/windows/configuration/assigned-access/configuration-file#allapplist), add the .exe file name and specify the `DesktopAppPath` attribute for the file.
