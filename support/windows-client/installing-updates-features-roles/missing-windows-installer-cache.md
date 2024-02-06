---
title: Restore missing Windows Installer cache files
description: Windows Installer cache (by default, c:\windows\installer) is used to store important files for applications that are installed using the MSI Windows Installer. The cache should not be deleted manually.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kelho, sureshka
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Missing Windows Installer cache requires a computer rebuild

This article discusses how to restore missing Windows Installer cache files.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2667628

## Summary

The Windows Installer Cache is used to store important files for applications that are installed by using Windows Installer. By default, this cache is located in the c:\windows\installer folder, and it should not be deleted. If the installer cache is compromised, you may not immediately see problems until you take an action such as uninstalling, repairing, or updating a product.

When a product is installed by using the Windows Installer, important files are stored in the Windows Installer cache that are required for uninstalling and updating applications. Missing files cannot be copied between computers because the files are unique.

## More information

If application files are missing from the Windows Installer Cache, ask the vendor or support team for the application about the missing files. You must follow the procedures or steps recommended by the application vendor to restore the files. In some cases, you may have to rebuild the operating system and reinstall the application to fix the problem.

Windows support engineers cannot help you recover missing application files from the Windows Installer cache.

If the missing installer cache files are SQL Server files, see [How to restore the missing Windows Installer cache files and resolve problems that occur during a SQL Server update](https://support.microsoft.com/help/969052).

If the missing installer cache files are Microsoft Office or SharePoint files, follow the instructions in the following topics on the Microsoft website:

- [Collect data about Office installations by using Robust Office Inventory Scan](/previous-versions/office/office-2010/hh221405(v=office.14))

- [Utility for Office patch maintenance tasks "log, repair, apply, remove, clean"](https://gist.github.com/jwstl/0240b284ecf7049731294e53587f4bc5)

## Third-party recovery tools

Some third-party entities claim to be able to rebuild or repair the Windows Installer cache. For legal and supportability reasons, we cannot recommend or endorse any of these entities. If you use such third-party products and recommendations, you do this at your own risk.
If you have backups for your system that were made before the file deletions, consider the following options:

- System Restore points (available only on client operating systems)
- Restoreable system state backup
- Failure recovery methods that can restore the full system state backup
- Reinstallation of the operating system and all applications

To restore the missing files, a full system state restoration is required. It is not possible to replace only the missing files from a previous backup.

## Other error messages

Other error messages might be triggered by missing Windows Installer Cache files. Many of the following messages are SQL-specific and are not limited to this issue. These entries are logged in either the Setup or MSI Verbose log.

- **1612**: The installation source for this product is not available. Verify that the source exists and that you can access it.
- **1620**: This installation package could not be opened. Contact the application vendor to verify that this is a valid Windows Installer package.
- **1635**: Unable to install Windows Installer MSP file
- This update package could not be opened. Verify that the update package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer update package.

    **1636**: Unable to install Windows Installer MSP file
- **1642**: The upgrade cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade.
- **1706**: The endpoint format is invalid.
- **1714**: The older version of Microsoft SQL Server Native Client cannot be removed.

## Report availability

We strongly encourage you to download this package from the portal instead of reusing a portable copy. If you submit the results, the latest diagnostic rules will be used. This package is frequently updated.

The report is available immediately after you run this tool without submitting the results to Microsoft. The report is an XML file. It will be located in the user profile Temp folder in a path that resembles the following:

`C:\Users\<UserName>\AppData\Local\Temp\WICFIX_MAIN_Report.xml`

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
