---
title: Understand the .NET Framework requirements
description: This article introduces that the .NET Framework requirements for various SQL versions starting with SQL Server 2005.
ms.date: 02/12/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: uttamkp, ramakoni, jopilov
---
# Understand the .NET Framework requirements for various versions of SQL Server

This article describes the .NET Framework requirements for various SQL versions starting with SQL Server 2005.

_Original product version:_ &nbsp; SQL Server 2019, SQL Server 2017, SQL Server 2014, SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 2027770

## Summary

Different versions of Microsoft SQL Server have different .NET Framework versions as a prerequisite for setup, and the procedure to install the .NET Framework may be different on different operating systems. For newer versions of SQL Server, this information is covered as part of Hardware and Software Requirements in the following articles:

- [Hardware and Software Requirements for SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15)

- [Hardware and Software Requirements for SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)

- [Hardware and Software Requirements for SQL Server 2016](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)

- [Hardware and Software Requirements for SQL Server 2014](/previous-versions/sql/2014/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)

- [Hardware and Software Requirements for SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110))

For versions SQL Server 2008 R2 and earlier, the .NET Framework requirements vary based on the edition of SQL Server that you're installing. This article describes these requirements and gives you the necessary information so that you can install the correct .NET Framework that's required.

1. Use `Table 1` in the [Microsoft DotNET Framework prerequisites for SQL Server](#microsoft-net-framework-prerequisites-for-sql-server-2008-r2-and-earlier-versions-of-sql-server) section to check the .NET Framework requirements for the version and the edition that you're installing.
1. Check whether the .NET Framework is already included as part of the operating system or whether you must download it separately from Microsoft downloads that are listed in `Table 2` in the [.NET Frameworks for SQL Server on various operating systems and download links](#net-frameworks-for-sql-server-on-windows-server-2008-r2-and-earlier-operating-systems) section.
1. Use the last column in `Table 2` to check whether any special procedures are required to install the Framework on the target operating system. If the entry is Yes, check the later sections of this document for the necessary procedures. If the entry is No, you can download the corresponding Framework from the corresponding link in `Table 2` and install it on the target operating system.

> [!NOTE]
>
> Support for .NET Framework 4.5.2, 4.6, and 4.6.1 ended on April 26, 2022.
>
> - SQL Server 2016 (13.x) and later require .NET Framework 4.6 for Database Engine, Master Data Services, or Replication (SQL Server setup automatically installs .NET Framework). You can upgrade to .NET 4.8 Framework or directly install .NET 4.8 Framework. All frameworks with major version 4 do an in-place upgrade, and they are backward compatible. For more information, check [Download .NET Framework 4.8 | Free official downloads (microsoft.com)](https://dotnet.microsoft.com/download/dotnet-framework/net48).
> - SQL Server 2014 and SQL Server 2012 use .Net Framework 3.5 SP1, which is supported till 2029, so this retirement doesn't impact them.

## Microsoft .NET Framework prerequisites for SQL Server 2008 R2 and earlier versions of SQL Server

The following table summarizes the .NET Framework version requirements for various versions and Editions of SQL Server and explains whether the product is included with setup media and whether it's installed as part of setup.

Table 1:

| SQL version or Edition|. NET Framework version| Included with the product?| Installed as part of setup? |
|---|---|---|---|
|SQL Server 2005 (all Editions)|2.0|Yes|No|
|SQL Server 2008 Express (core)|2.0 SP2|No|No|
|SQL Server 2008 on Windows Server 2003, (64-bit), IA-64|2.0 SP2|Yes|Yes|
|SQL Server 2008 (all other Editions)|3.5 SP1|Yes|Yes|
  
The Setup program doesn't install the.NET Framework 3.5 Service Pack 1 on computers running Windows Server 2008 R2 Edition for SQL Server 2008 and SQL Server 2008 R2 Failover Cluster and Express Edition installations. For more information about how to enable the .NET Framework 3.5 SP1 on these systems, see [How to install or enable .NET Framework 3.5 SP1 on Windows](#how-to-install-or-enable-net-framework-35-sp1-on-windows).

## .NET Frameworks for SQL Server on Windows Server 2008 R2 and earlier operating systems

The following table indicates whether the .NET Framework that is required for the SQL Edition and version that you're installing is included as part of the target operating system. The table also indicates whether any additional steps are required to install or enable the Framework on the corresponding operating system and the table provides a download link for the corresponding .NET Framework redistributable files.

Table 2:

| .NET version| Version number| Included with operating system| Default with operating systems| Installed with Visual Studio .NET| Redist or download link| Are special procedures required to install redist? |
|---|---|---|---|---|---|---|
|2.0|2.0.50727.42|Windows Server 2003 R2|None|Microsoft Visual Studio 2005| |No|
|3.5 SP1|3.5.30729.1|Windows Server 2008 R2|None|None| [3.5 SP1](https://www.microsoft.com/download/details.aspx?id=22)|Yes, for Windows Server 2008 R2|

## How to install or enable .NET Framework 3.5 SP1 on Windows

To install .NET Framework on Windows 8 and later versions of the operating system, review [Install the .NET Framework 3.5 on Windows 10, Windows 8.1, and Windows 8](/dotnet/framework/install/dotnet-35-windows).

In Windows Server 2008 R2, the .NET Framework is a feature, and installing it's different than previous versions of the Windows operating system. The following procedure explains how to verify that the .NET Framework 3.5.1 is installed. The procedure also explains how to determine whether the .NET Framework isn't installed and how you can add it in these environments.

## How to determine whether the .NET Framework 3.5 SP1 is installed

To determine whether the .NET Framework 3.5.1 is installed on Windows Server 2008 R2, follow these steps:

1. Select **Start** > **Administrative Tools** > **Server Manager**.
1. Select **Features** to display all the installed features in the pane on the right side.
1. Verify that .NET Framework 3.5.1 is listed as an installed feature.

If .NET Framework 3.5.1 isn't listed as an installed feature, use one of the following methods to install it.

### Method 1: Use Server Manager  

1. In **Server Manager,** select **Add Features** to display a list of possible features.
1. In the **Select Features** interface, expand the **.NET Framework 3.5.1 Features** entry.
1. After you expand **.NET Framework 3.5.1 Features**, you see two checkboxes. One checkbox is for **.NET Framework 3.5.1** and other checkbox is for **WCF Activation**. Select the checkbox next to **.NET Framework 3.5.1**, and then select **Next**.

    > [!NOTE]
    > If you don't expand the **.NET Framework 3.5.1 Features** item and check it, the following **Add Features Wizard** is started:

    :::image type="content" source="media/understanding-dotnet-framework-requirements/add-features-wizard.png" alt-text="Screenshot of the Add Features Wizard window." border="false":::

    If the wizard starts, select **Cancel**, expand **.NET Framework 3.5.1 Features**, and then  select the **.NET Framework 3.5.1** checkbox.

1. You can't install **.NET Framework 3.5.1 Features** unless the required role services and features are also installed.
1. In the Confirm Installation Selections, review the selections, and then select **Install**.
1. Let the installation process complete, and then select **Close**.

### Method 2: Use Windows PowerShell  

1. Select **Start** > **All Programs** > **Accessories**.
1. Expand **Windows PowerShell**, right-click **Windows PowerShell**, and select **Run as administrator**. Select **Yes** in the **User Account Control** box.
1. At the PowerShell command prompt, type the following commands, and then press <kbd>ENTER</kbd> after each command:

```powershell
Import-Module ServerManager
Add-WindowsFeature as-net-framework  
```

> [!NOTE]
> See the screenshot for more information:

:::image type="content" source="media/understanding-dotnet-framework-requirements/windows-powershell.png" alt-text="Screenshot shows the output of the command in Windows PowerShell." border="false":::

## References  

- [Aaron Sterner's WebLog](/archive/blogs/astebner/)
- [.NET Framework Support in Windows Server 2008](/previous-versions/windows/server-2008/cc531167(v=msdn.10))
