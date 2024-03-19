---
title: Software Metering failed to start PrepDriver
description: Describes an issue in which Software Metering Agent fails when you install update 3125574 before you install the Configuration Manager client software.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# Software Metering Agent fails with the Software Metering failed to start PrepDriver error

This article fixes an issue in which Software Metering Agent fails and the **Software Metering failed to start PrepDriver** error is logged in mtrmgr.log.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 3213242

## Symptoms

After you install the convenience rollup update for Windows 7 SP1 and Windows Server 2008 R2 SP1 ([3125574](https://support.microsoft.com/help/3125574)) and the Configuration Manager client, the Software Metering Agent fails, and the following error message is logged in the mtrmgr.log file:

> Software Metering failed to start PrepDriver

## Cause

This error can occur if you install rollup 3125574 before you install the Configuration Manager client software. In that scenario, PrepDrv is not installed during the Configuration Manager client setup process.

## Resolution 1

1. Uninstall rollup 3125574 and the Configuration Manager client. You can uninstall the Configuration Manager client software from a computer by using `CCMSetup.exe` with the `/Uninstall` property. For more information, see [Uninstall the client](/mem/configmgr/core/clients/manage/manage-clients#BKMK_UninstalClient).
2. Reinstall the Configuration Manager client software.
3. Reinstall rollup [3125574](https://support.microsoft.com/help/3125574).

   To verify that the installation completed successfully, check mtrmgr.log and make sure no errors are found.

## Resolution 2

Manually install PrepDrv by running the following command from a command prompt:

```console
RUNDLL32.EXE SETUPAPI.DLL,InstallHinfSection DefaultInstall 128 C:\WINDOWS\CCM\prepdrv.inf
```
