---
title: Product 6499 doesn't support upgrading
description: Provides a solution to an error that occurs when doing an upgrade of Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Product 6499 doesn't support upgrading from version xx.xx.xxxx" Error message when doing an upgrade of Microsoft Dynamics GP

This article provides a solution to an error that occurs when doing an upgrade of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2831912

## Symptoms

When doing an upgrade to Microsoft Dynamics GP 2010 or Microsoft Dynamics GP 2013, Utilities does the version check and gives the following error:

> Error: Product 6499 does not support upgrading from version xx.xx.xxxx.

## Cause

Usually this error is caused because the Dynamics Online Services module / Product 6499, was removed from the DynUtils.set and possibly the Dynamics.set files within the Microsoft Dynamics GP application directory, and because of it, the Dynamics Online Services module didn't get installed or upgraded to a correct version to upgrade to the new version.

Dynamics Online Services / Product 6499 was introduced in Service Pack 5 (10.0.1579) for Microsoft Dynamics GP 10.0 and Service Pack 1 (11.0.1524) for Microsoft Dynamics GP 2010 and is a core module, meaning it gets installed by default, without the installer needing to select this module to be included in the installation.

Because this module is a core module, we don't want to remove it from being included in these versions of Microsoft Dynamics GP because there are other default processes, such as Sales and other modules that will look for this module's tables and other objects and error out if it doesn't find them. Another error that you could potentially run into is an *Microsoft.Dynamics.GP.OnlineServices.dll* error when users attempt to sign in to the Microsoft Dynamics GP application.

## Resolution

Instead of removing Dynamics Online Services / Product 6499 from the DynUtils.set or Dynamics.set file for Microsoft Dynamics GP, if you're failing on an upgrade and this module has never been used by any company databases, you can reset the module to be installed at the new version of Microsoft Dynamics GP that you're upgrading to.

To do it, make sure to have backups of the DYNAMICS or system database and all company databases for Microsoft Dynamics GP and then run the following scripts before launching Utilities to do the upgrade:

1. Run the following scripts against the DYNAMICS or system database:

    ```sql
    Delete DYNAMICS..DB_UPGRADE where PRODID = 6499
    Delete DYNAMICS..DU000020 where PRODID = 6499
    Delete DYNAMICS..DU000030 where PRODID = 6499
    DROP TABLE DO40100
    ```

1. Run the following script against each company database:

    ```sql
    DROP TABLE DO03100
    ```  

1. Make sure your Dynamics GP install that you're launching Utilities from has the 6499/Dynamics Online Services module in both the Dynamics.set and DynUtils.set file and then launch GP Utilities, which will see this module as missing and reinstall it again at the new version and then upgrade all other modules as normal.
