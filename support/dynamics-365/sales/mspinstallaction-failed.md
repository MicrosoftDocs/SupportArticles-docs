---
title: MspInstallAction failed
description: Provides a solution to an error that occurs when you try to install Microsoft Dynamics CRM 2011 Update Rollup 6 or higher.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 
---
# MspInstallAction failed when installing an Update Rollup on Microsoft Dynamics CRM

This article provides a solution to an error that occurs when you try to install Microsoft Dynamics CRM 2011 Update Rollup 6 or higher.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2668504

## Symptoms

When you try to install Microsoft Dynamics CRM 2011 Update Rollup 6 or higher, you get the following error:

> Action Microsoft.Crm.UpdateWrapper.MspInstallAction failed. The upgrade cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade may update a different version of the program. Verify that the program to be upgrade exists on your computer and that you have the correct upgrade

## Cause

The full install packages (slipstreams) for version 5.0.9689.1985, were re-released. Which was the install packages that included Update Rollup 6.Because of this re-release, the old install packages are no longer valid for future update rollups.

## Resolution

To resolve this issue, you'll need to uninstall the current Dynamics CRM Server, Client, E-mail Router, or any other component you may have installed using those slipstream packages. Then you'll need to reinstall with the new packages that are available on the [Microsoft Download Site](https://www.microsoft.com/download).

## More information

If you initially installed the Update Rollup 6 patch ([Microsoft Dynamics CRM 2011 Update Rollup 6)](https://support.microsoft.com/help/2600640), you won't see this issue installing future update rollups.

If you're on Update Rollup 5 or an earlier version of Dynamics CRM 2011, you won't see this issue updating to the re-released Update Rollup 6 patch.
