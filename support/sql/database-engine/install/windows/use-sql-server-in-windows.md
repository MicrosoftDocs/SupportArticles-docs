---
title: SQL Server in Windows operating system
description: This article describes how to use SQL Server in Windows 8, Windows 8.1, Windows Server 2012, and Windows Server 2012 R2 environments.
ms.date: 05/30/2022
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: ramakoni, randolphwest
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Using SQL Server in Windows

This article contains guidance about how to use different versions of Microsoft SQL Server on a computer that is running Windows operating system.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2681562

## Summary

> [!NOTE]
> Unless noted otherwise, when an OS is supported for a SQL Major version, it remains supported for all subsequent servicing releases. For example, if SQL Server 2016 RTM is supported on Windows 10, this implies that any CUs on top of SQL Server 2016 RTM or SQL Server 2016 Service Pack 1 (SP1) are supported on Windows 10.

How to use this article:

- Use the following table to find out the minimum requirements for the SQL Server version you are trying to install for the corresponding OS.

- Use the links in the **Hardware and Software Requirements page** row to see specific details about the hardware and software requirements for each version of SQL Server.

|Windows Version/SQL Version |SQL Server 2022|SQL Server 2019|SQL Server 2017|SQL Server 2016 |SQL Server 2014 |SQL Server 2012 |SQL Server 2008 R2 |SQL Server 2008|
|---| -------- |---|---|---|---|---|---|---|
|Windows Server 2022  |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) | Not supported | Not supported | Not supported |Not supported |Not supported |(#minimum-sql-server-version-requirements-for-windows-server-2022-and-windows-11)|
|Windows 11 |Yes  (RTM)|Yes  (RTM) |Yes  (RTM) |Not supported |Not supported |Not supported |Not supported |Not supported |
|Windows 10 |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Not supported |Not supported |
|Windows Server 2019  |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Not supported |Not supported |
|Windows Server 2016  |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Not supported |Not supported |
|Windows 8.1  |No|No |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4)|
|Windows Server 2012 R2 |No|No  |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4) |
|Windows 8 |No|No |Yes  (RTM)  |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4) |
|Windows Server 2012 |No|No |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4) |
|Hardware and Software Requirements page |[SQL Server 2022](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022)|[SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15) |[SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)  |[SQL Server 2016](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)  |[SQL Server 2014](/previous-versions/sql/2014/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)  |[SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110))  |[SQL Server 2008 R2](/previous-versions/sql/sql-server-2008-r2/ms143506%28v%3dsql.105%29)  |[SQL Server 2008](/previous-versions/sql/sql-server-2008/ms143506%28v%3dsql.100%29) |

## Support for switching modes in Windows Server 2012 R2 or Windows Server 2012

This section discusses the support policy when you switch Windows Server 2012 R2 or Windows Server 2012 operating modes while SQL Server is installed.

Windows Server 2012 R2 and Windows Server 2012 have the following feature states, or modes:

- Full Server
- Minimal Server Interface
- Server CoreYou can switch between these feature states at any time.

You can switch from Server Core or Minimal Server Interface to Full Server when one or more instances of SQL Server 2014 or SQL Server 2012 are installed. However, be aware that you cannot switch from Full Server to Minimal Server Interface or Server Core when one or more instances of SQL Server 2014 or SQL Server 2012 are installed.

To switch from Full Server to Minimal Server Interface or Server Core when one or more instances of SQL Server 2014 or SQL Server 2012 are installed, you must uninstall SQL Server 2014 or SQL Server 2012, switch modes, and then reinstall SQL Server 2014 or SQL Server 2012. However, you can turn on SQL Server 2014 or SQL Server 2012 installation prerequisites in Full Server mode, switch to Server Core mode, and then install SQL Server 2014 or SQL Server 2012.

> [!NOTE]
>
> - Minimal Server is a Server Core installation that has Server Manager and other server tools installed. Therefore, the SQL Server Setup program performs the same installation steps in Windows Server 2012 R2 Minimal Server Interface mode and Windows Server 2012 Minimal Server Interface mode and Server Core mode. Additionally, you can switch between Server Core and Minimal Server when one or more instances of SQL Server 2014 or SQL Server 2012 are installed. This is a supported scenario.
>
> - SQL Server Reporting Services 2012 is not supported on Windows Server 2012 R2 Server Core, Windows Server 2012 Server Core, Windows Server 2012 R2 Minimal Server Interface mode, or Windows 2012 Minimal Server Interface mode. You can install SQL Server Reporting Services 2012 on a server that is running Windows Server 2012 in Full Server mode and then switch to Windows Server 2012 Server Core mode. However, this configuration is not supported.
>
> - We recommend that you uninstall all the SQL Server 2012 features that are not supported on a server that is running Windows Server 2012 R2 or Windows Server 2012 in Server Core mode. For information about how to do this, see [Install SQL Server 2012 on Server Core](/previous-versions/sql/sql-server-2012/hh231669(v=sql.110))).
>
> - This issue does not apply to SQL Server 2008 or SQL Server 2008 R2. SQL Server 2008 and SQL Server 2008 R2 are not supported in Minimal Server Interface mode or Server Core mode.

For more information about the installation options that are available when you install Windows Server 2012, see [Windows Server Installation Options](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831786(v=ws.11)).
