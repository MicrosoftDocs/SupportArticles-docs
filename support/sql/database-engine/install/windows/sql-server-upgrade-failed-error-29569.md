---
title: Troubleshoot SQL Server Upgrade Error 29569
description: Troubleshoot SQL Server upgrade error 29569 when Setup can't restore installed-instance metadata. Review Setup logs and uninstall registry entries.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ai-usage: ai-assisted
---

# SQL Server upgrade fails with error 29569

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you troubleshoot SQL Server upgrade error 29569 when Setup can't restore required installed-instance metadata. Review the Setup logs and uninstall registry metadata to identify missing or inconsistent `InstanceId` information.

## Symptoms

When you upgrade a SQL Server instance, Setup fails and reports error 29569. The failure occurs while Setup restores or identifies an installed feature or instance.

## Cause

Setup can't restore required instance metadata because `InstanceId` or related uninstall metadata is missing or inconsistent.

## Diagnose error 29569

1. Review `Summary.txt` and the Database Engine feature log for error 29569. For log locations and structure, see [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).
1. Export the relevant uninstall registry key before you make any change.
1. Confirm that `InstanceId` and installed-feature metadata match the affected instance.

    List SQL Server uninstall metadata.

    ```powershell
    Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' |
      Where-Object { $_.DisplayName -like '*SQL Server*' } |
      Select-Object DisplayName, DisplayVersion, PSChildName
    ```

    **Expected result**. The output provides candidate installed-product entries that you can compare with the Setup logs.

## Solution

- Restore only confirmed missing metadata from a validated source or under Microsoft Support guidance.
- Retry the upgrade after installed-instance metadata is consistent.

## Related content

- [SQL Server installation errors](error-install-sql-server.md)
- [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md)
- [View and read SQL Server Setup log files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)
