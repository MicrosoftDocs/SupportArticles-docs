---
title: Error when you install SQL Server 2008 R2
description: This article provides a resolution for various errors that occur when you try to install SQL Server 2008 R2.
ms.date: 10/22/2020
ms.custom: sap:Database Engine
---
# Error message when you try to install SQL Server 2008 R2

This article helps you resolve various errors that occurs when you try to install SQL Server 2008 R2.

_Original product version:_ &nbsp; SQL Server 2008 R2
_Original KB number:_ &nbsp; 2449398

## Symptoms

When you try to install Microsoft SQL Server 2008 R2, you receive one or more of the following error messages or experience one or more of the following symptoms. Additionally, you cannot continue with the setup.

Setup error messages or symptoms

- Error message 1

  > The system cannot open the device or file specified.

- Error message 2

  > Setup.rll is either not designed to run on Windows or it contains an error.

- Error message 3

  > The installer has encountered an unexpected error installing this package.

- Error message 4

  > Setup.exe badimage.

- Error message 5

  > Error occurred during the login process due to bad media.

- Error message 6

  > The cabinet file 'Sql.cab' required for this installation is corrupt and cannot be used.

- Error message 7

  > Error reading from file

- Symptom 1

  You cannot select x64 bit installation.

- Symptom 2

  Some components are missing on the Select Component page of Setup.

Error messages in SQL Server Setup log files

> [!NOTE]
> For more information about SQL Server Setup log files, see the topic in SQL Server Books Online: [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).

- Error message 1

  > Error 2337

- Error message 2

  > SQL Server installation failed.

- Error message 3

  > Network error occurred while attempting to read from the file.

- Error message 4

  > The ENU localization is not supported by this SQL Server Media.

- Error message 5

  > Could not find the Database Engine startup handle (Summary.txt file)

- Error message 6

  > Source for file 'p76pctiy.dll' is uncompressed (sql_engine_core_shared)

- Event Viewer error message

  > Failed to initialize SQLSQM timer.

## Cause

This problem may occur for one of the following reasons:

- The installation media is damaged.
- The installation source is corrupted.

## Resolution

To resolve the problem, use one of the following methods:

- Download the SQL Server image again from the original location, and then rerun the Setup program.

- If you installed SQL Server over a computer network, install it again from a local drive, and then rerun the Setup program.

- Rename the *Setup.rll* file. To do this, follow these steps:

    1. Open Windows Explorer. To do this, click **Start**, click **All Programs**, click **Accessories**, and then click **Windows Explorer**.

    2. Locate and then click the folder: `C:\Program Files\Microsoft SQL Server\100\Setup Bootstrap\SQLServer2008R2\resources\1033`.

    3. Right-click Setup.rll, and then click **Rename**.

       See image

       :::image type="content" source="media/error-install-sql-server-2008-r2/rename.png" alt-text="Screenshot shows the Rename option of Setup.rll in Windows Explorer." border="false":::

    4. Type *setup.rll.old*, and then press **Enter**.

    5. Rerun the Setup program.

- If you are using a localized version of SQL Server, you can change the operating system settings to support localized versions. For more information about how to change the operating system settings, see [How to: Change Operating System Settings to Support Localized Versions](/previous-versions/sql/sql-server-2008-r2/ms144258(v=sql.105)).

  > [!IMPORTANT]
  > Installations of different language versions of SQL Server instances on the same computer are not supported.

## More information

The error messages that are mentioned in the [Symptoms](#symptoms) section may have other causes. If the steps in the [Resolution](#resolution) section do not resolve the problem, you may be experiencing a different problem.

- For more information about how to install SQL Server 2008 R2, see [How to: Install SQL Server 2008 R2 (Setup)](/previous-versions/sql/sql-server-2008-r2/ms143219(v=sql.105)).

- For more information about known issues when you install SQL Server on Windows 7 or on Windows Server 2008 R2, see [Known issues installing SQL Server on Windows 7 or Windows Server 2008 R2](https://support.microsoft.com/help/955725).

## Applies to

- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
