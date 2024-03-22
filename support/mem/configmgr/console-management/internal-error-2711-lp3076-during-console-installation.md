---
title: Internal Error 2711.LP3076
description: Describes an issue that triggers an Internal Error 2711.LP3076 error that occurs during the installation of the Configuration Manager console.
ms.date: 12/05/2023
ms.reviewer: kaushika, bhaskark, yvetteo
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Console Installation or Upgrade
---
# Internal Error 2711.LP3076 occurs during installation of the Configuration Manager console

This article provides a solution to solve the **Internal Error 2711.LP3076** error that occurs when you install the Configuration Manager console.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 3211086

## Symptoms

After an upgrade to Configuration Manager current branch version 1610 or a later version, installation of the Configuration Manager console fails with this error message:

> Internal Error 2711.LP3076

## Cause

This problem may occur if the console is installed from either of the following locations:

- \\\\\<Sitemachine>\sms_*SiteCode*\cd.latest\splash.hta
- \\\\\<Sitemachine>\sms_*SiteCode*\cd.latest\SMSSETUP\BIN\I386.consolesetup.exe

## Resolution

To work around this problem, install the Configuration Manager console from one of the following locations instead:

- \<SCCMInstallation>\tools\ConsoleSetup\ConsoleSetup.exe
- \<SCCMInstallation>\bin\i386\ConsoleSetup.exe

For more information, see [Install the Configuration Manager console](/mem/configmgr/core/servers/deploy/install/install-consoles).
