---
title: Remove a partial installation of SQL Server
description: This article describes the procedure to remove a partial installation of SQL Server.
ms.date: 06/12/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: amylewis
ms.topic: how-to
---

# Remove a partial installation of SQL Server

This article describes the procedure to remove a partial installation of SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955404

## Symptoms

When you try to reinstall an instance of SQL Server after it fails to install the first time on the same server, you may notice that the second attempt also results in failure.

## Cause

This problem occurs because after the first installation fails, a partly installed instance of SQL Server exists on the server. The SQL Server Setup program doesn't roll back the installation if the installation fails. The partly installed instance doesn't include the edition of SQL Server that you were trying to install, such as the Enterprise edition, the Standard edition, or the Evaluation edition. When you try to install the same version on the same server, the Setup program finds the existing instance. However, the Setup program can't determine which version of SQL Server to install. Therefore, the installation fails.

## Resolution

Use the following procedure to resolve the problem:

1. Ensure you have valid backups of databases for each of the SQL instance on the system.

1. Navigate to *Summary.Txt* file setup log file and note down the setup command suggested by the setup program.

1. Using an elevated command prompt, navigate to the location of 'setup.exe' for \<SQL Version upgrading to\> installation media directory and execute the command from Step 2.

    > [!NOTE]
    > It's very important to ensure you're running the commands against the right instance or else you may end up uninstalling a working instance.

1. Launch the **Installation Center** wizard GUI from either the SQL Server Program group or by rerunning the setup program.

1. Navigate to the **Tools** menu and select the **Installed SQL Server features discovery report** and verify there are no more `<instance name>.INACTIVE` instances shown in the report.

1. If there are inactive instances in the discovery report, follow these steps to remove them:

   1. Open the corresponding XML file.
   1. Find each `MSSQLSERVER.INACTIVE` entry.
   1. Locate and note down the value of `ProductCode`. Here's an example:

      ```xml
      ProductCode="{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}"
      ```
   1. Open **Command Prompt** as an administrator and run the following command for each `ProductCode`:

      ```cmd
      msiexec /x {PRODUCT-CODE-GUID}
      ```
      
      > [!NOTE]
      > Repeat the command for each **ProductCode** linked to the inactive instance. Here's an example:
      >
      > ```cmd
      > msiexec /x {9FFAE13C-6160-4DD0-A67A-DAC5994F81BD}
      > ```

1. Retry the setup program that was originally failing to complete.

> [!NOTE]
> If you still see inactive instances in the discovery report even after the above procedure, use the procedure documented in the [How to Fix a failed SQL 2005, 2008, R2 or 2012 Install/Upgrade - MSSQLSERVER.INACTIVE](/archive/blogs/baliles/how-to-fix-a-failed-sql-2005-2008-r2-or-2012-installupgrade-mssqlserver-inactive) to fix the partial SQL Server installation on the system.

## See also

- [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)
- [Uninstall an Existing Instance of SQL Server (Setup)](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup)
