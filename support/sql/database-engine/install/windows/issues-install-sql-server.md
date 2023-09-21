---
title: Known issues when you install SQL Server
description: This article describes some known issues and prerequisites when you plan to install SQL Server on Windows 7 or on Windows Server 2008 R2.
ms.date: 10/22/2020
ms.custom: sap:Database Engine
ms.reviewer: ramakoni
---
# Known issues installing SQL Server on Windows 7 or Windows Server 2008 R2

This article describes some known issues and prerequisites when you plan to install SQL Server on Windows 7 or on Windows Server 2008 R2.

_Original product version:_ &nbsp; SQL Server, Windows Server, Windows  
_Original KB number:_ &nbsp; 955725

## Summary

This article describes the known issues when you install Microsoft SQL Server on a computer that is running Windows 7 or Windows Server 2008 R2.

- For all editions except the Express Edition of SQL Server 2008 that's running on Windows 7 or on Windows Server 2008 R2, you must have at least SQL Server 2008 Service Pack 1 (SP1) installed.

    > [!NOTE]
    > Express Edition already includes Service Pack 1.

- In this article, Windows 7 indicates the client version of Windows 7. Windows Server 2008 R2 indicates the server version of Windows 7.

- For more information about hardware and software requirements for various versions of SQL Server, see [Hardware and Software Requirements for Installing SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110)).

- For release notes that document various known issues at the time the product is released, see the [SQL Server 2012 Release Notes](/sql/sql-server/sql-server-2012-release-notes).

## Known issues

- Windows 7 doesn't use the `RequireKerberos` property to determine whether Kerberos authentication is enabled.

  Because Windows 7 doesn't use the `RequireKerberos` property to determine whether Kerberos authentication is enabled for a Network Name resource, Failover Cluster installation of SQL Server 2008 fails.

- When Federal Information Processing Standard (FIPS) policy is enabled in Windows 7 or in Windows Server 2008 R2, Cluster Validation fails during SQL Server 2008 installation.

  When FIPS policy is enabled in Windows 7 or in Windows Server 2008 R2, Cluster Validation fails during the installation of SQL Server 2008. Therefore, the setup fails.

  To resolve these two problems, you must install SQL Server 2008 together with SQL Server 2008 (SP1) or a later update for clustered installations. For more information about how to obtain SQL Server 2008 SP1, see [KB968382 - How to obtain the latest service pack for SQL Server 2008](https://support.microsoft.com/help/968382).

  For more information about how to update SQL Server Setup in either a clustered or a nonclustered environment, see [How to update or slipstream an installation of SQL Server 2008](https://support.microsoft.com/help/955392).

- SQL Server 2008 installation may fail on Windows Server 2008 R2

  The SQL Server 2008 installation may fail on Windows Server 2008 R2 if the .NET Framework isn't enabled. This problem occurs because installation of the .NET Framework 3.5 is a prerequisite to this installation.

  On Windows Server 2008 R2, the .NET Framework 3.5 is included as a Windows component. By default, the .NET Framework 3.5 isn't enabled. To avoid this installation failure, you must enable the .NET Framework 3.5 from the Windows Features component before you run the SQL Server 2008 installation.

- Setup of SQL Server 2008 may fail

  Setup of SQL Server 2008 may fail, and you receive the following error:

  > Invoke or BeginInvoke cannot be called on a control until the window handle has been created.

  You can install a cumulative update to resolve this issue. For more information, see [FIX: Error message when you install SQL Server 2008 on a computer that is running Windows 7: "Invoke or BeginInvoke cannot be called on a control until the window handle has been created."](https://support.microsoft.com/help/975055).

## Minimum version requirements for Windows 7 or for Windows Server 2008 R2

Before you install SQL Server on a computer that's running Windows 7 or Windows Server 2008 R2, you must make sure that you fulfill the following minimum prerequisites, as appropriate for your situation.

## SQL Server 2008

- Clustered installations

    You must install SQL Server 2008 together with SQL Server 2008 Service Pack 1 or a later update (this is also known as a slipstreamed version).

- Nonclustered installations

    You must install SQL Server 2008 followed by SQL Server 2008 Service Pack 1 or a later update.

    > [!NOTE]
    > SQL Server 2008 express runtime is supported on Windows 7 and on Windows 2008 R2.

For more information about hardware and software requirements for installing SQL Server 2008, see [SQL Server 2016 and 2017: Hardware and software requirements](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server).

## The .NET Framework

You must enable the .NET Framework 3.5 SP1 before you install SQL Server 2008 on a computer that's running Windows Server 2008 R2. The .NET Framework 3.5 SP1 is a prerequisite for SQL Server 2008. SQL Server 2008 Setup will install the .NET Framework 3.5 SP1 if it's not already installed. However, for Failover Clustering, the .NET Framework 3.5 SP1 must be installed before the SQL Server 2008 Failover Cluster installation.

In Windows Server 2008 R2, the .NET Framework is a system component. Therefore, you can't install the .NET Framework from a redistribution point. You must install the .NET Framework from the Server role or by using *ServerManagerCmd.exe*.

You don't have to install the .NET Framework in the following scenarios:

- On a computer that's running Windows Server 2008 R2 and on which the .NET Framework 3.5 SP1 is installed.

- On a computer that's running Windows 7.

> [!NOTE]
> By default, .NET Framework 3.5 SP1 is installed in Windows 7.

## Applies to

- SQL Server 2008 Enterprise
- SQL Server 2008 Developer
- SQL Server 2008 Standard
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Web Edition
- Windows 7 Enterprise
- Windows 7 Professional
- Windows 7 Ultimate
