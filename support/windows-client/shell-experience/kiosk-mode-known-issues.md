---
title: Kiosk mode known issues
description: Learn about known issues for devices configured in single-app kiosk mode or restricted user experience mode.
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

This article describes known problems for devices configured in single-app kiosk mode or restricted user experience (multi-app kiosk) mode. You can often resolve these problems by making configuration changes or installing cumulative updates. Some known problems are resolved automatically in future releases.

## Restrictions dialog box on sign-in when Edge is an allowed app

On kiosks that have Microsoft Edge as an allowed app, a **Restrictions** dialog box appears on sign-in with the message: *This operation is canceled due to restrictions in effect on this computer. Please contact your system administrator.*

This problem is fixed on Windows builds 26100.7705, 26200.7705, and newer. Admins should re-deploy the kiosk configuration for the fixes to take effect.

## Kiosk policy deployment fails with error code 0x86000005

Kiosk policy deployment fails with error code `0x86000005` when using certain MDM providers for deployment starting with build 26100.4484.

This problem is fixed on Windows builds 26100.7705, 26200.7705, and newer.

## File Explorer shows a blocked location dialog box

You have a kiosk that uses [File Explorer restrictions](/windows/configuration/assigned-access/configuration-file#file-explorer-restrictions) and has the [Shared PC mode](/windows/configuration/shared-pc/set-up-shared-or-guest-pc) feature configured. When you open File Explorer, you see the following message:

> We can't open This PC. To help you keep your data safe, the location is blocked.

To work around this issue, configure the [SetAllowedFolderLocations](/windows/client-management/mdm/policy-csp-fileexplorer#setallowedfolderlocations) policy to use a value that doesn't include **This PC**.

## Packaged apps fail to launch when Edge is an allowed app

On kiosks that have Microsoft Edge as an allowed app, packaged apps (apps installed from an MSIX or APPX package) fail to launch.

To work around this problem, find the name of the `.exe` file that the packaged app launches and add it to the allowed apps list in your [Assigned Access configuration file](/windows/configuration/assigned-access/configuration-file?pivots=windows-11#allapplist), specifying it with the `DesktopAppPath` attribute. To find the `.exe` file name, open the `AppxManifest.xml` file in the app's installation folder and look for the `Executable` attribute of the `Application` element.
