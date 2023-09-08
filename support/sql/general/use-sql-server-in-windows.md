---
title: SQL Server in Windows operating system
description: This article describes how to use SQL Server in Windows 8, Windows 8.1, Windows Server 2012, and Windows Server 2012 R2 environments.
ms.date: 05/30/2022
ms.custom: sap:Installation, Patching and Upgrade
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

1. 1. Find out the minimum requirements for the SQL Server version you are trying to install for the corresponding OS.

   |Windows Version/SQL Version |SQL Server 2022|SQL Server 2019|SQL Server 2017|SQL Server 2016 |SQL Server 2014 |SQL Server 2012 |SQL Server 2008 R2 |SQL Server 2008|More Information/Limitations|
   |---| -------- |---|---|---|---|---|---|---|---|
   |Windows Server 2022  |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) | Not supported | Not supported | Not supported |Not supported |Not supported |[Additional information for Windows Server 2022 environments](#minimum-sql-server-version-requirements-for-windows-server-2022-and-windows-11)|
   |Windows 11 |Yes  (RTM)|Yes  (RTM) |Yes  (RTM) |Not supported |Not supported |Not supported |Not supported |Not supported |[Additional information for Windows 11 environments](#minimum-sql-server-version-requirements-for-windows-server-2022-and-windows-11)|
   |Windows 10 |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Not supported |Not supported |[Additional information for Windows 10 environments](#minimum-sql-server-version-requirements-for-windows-10-and-windows-server-2016)|
   |Windows Server 2019  |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Not supported |Not supported |[Additional information for Windows Server 2019 environments](#minimum-sql-server-version-requirements-for-windows-server-2019)|
   |Windows Server 2016  |Yes  (RTM) |Yes  (RTM) |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Not supported |Not supported |[Additional information for Windows Server 2016 environments](#minimum-sql-server-version-requirements-for-windows-10-and-windows-server-2016)|
   |Windows 8.1  |No|No |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4)|[Additional information for Windows 8.1 environments](#minimum-sql-server-version-requirements-for-windows-server-2012-r2-or-windows-81)|
   |Windows Server 2012 R2 |No|No  |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4) |[Additional information for Windows Server 2012 R2 environments](#minimum-sql-server-version-requirements-for-windows-server-2012-r2-or-windows-81)|
   |Windows 8 |No|No |Yes  (RTM)  |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4) |[Additional information for Windows 8 environments](#minimum-sql-server-version-requirements-for-windows-server-2012-or-windows-8)|
   |Windows Server 2012 |No|No |Yes  (RTM) |Yes (SP2) |Yes (SP3) |Yes (SP4) |Yes (SP3)  |Yes (SP4) |[Additional information for Windows Server 2012 environments](#minimum-sql-server-version-requirements-for-windows-server-2012-or-windows-8)|
   |Hardware and Software Requirements page |[SQL Server 2022](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022?view=sql-server-ver16&preserve-view=true)|[SQL Server 2019](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15) |[SQL Server 2017](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)  |[SQL Server 2016](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)  |[SQL Server 2014](/previous-versions/sql/2014/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)  |[SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110))  |[SQL Server 2008 R2](/previous-versions/sql/sql-server-2008-r2/ms143506%28v%3dsql.105%29)  |[SQL Server 2008](/previous-versions/sql/sql-server-2008/ms143506%28v%3dsql.100%29) ||
   
1. To find answers to the following questions, review the corresponding link under Hardware and Software Requirements page.

    - Which editions of SQL Server are compatible with which versions of Windows?
    - What are the .NET Framework requirements for my SQL version?
1. Use the More Information/Limitations column in the above table to find additional information about running SQL server on the specific operating system.

    For example, if you want to install SQL Server 2016 Developer Edition on Windows 10 Professional:
  
    1. Check if SQL Server 2016 is supported on Windows 10. The corresponding value in the above table is **Yes (SP2)**.
  
        - **Yes** indicates that SQL Server 2016 on Windows 10 is supported.  
  
        - **(SP2)** indicates that SQL Server 2016 should be updated to at least SP2 for it to be supported on Windows 10.
  
    1. The **Hardware and Software Requirements** page for SQL 2016 confirms that SQL Server 2016 Developer edition is supported on Windows 10 Professional.
  
    1. The More Information/Limitations column for Windows Server 2016 do not call out any additional known issues for this configuration.

## Minimum SQL Server version requirements for Windows Server 2022 and Windows 11

This section describes the minimum version requirements to install SQL Server on a computer that is running Windows Server 2022 or Windows 11.

Before you install SQL Server on a computer that is running Windows Server 2022 or Windows 11, you must make sure that you fulfill the following minimum requirements, as appropriate for your situation.

- **For SQL Server 2022 on Windows**
   The release is supported at the SQL Server 2022 on Windows RTM Release version.
- **For SQL Server 2019 on Windows**
    The release is supported at the SQL Server 2019 on Windows RTM Release version.

- **For SQL Server 2017 on Windows**

    The release is supported at the SQL Server 2017 on Windows RTM Release version.

- **For SQL Server 2016** and older versions

    SQL Server 2016 and older versions are not supported on Windows Server 2022 or Windows 11.
  
## Minimum SQL Server version requirements for Windows Server 2019

This section describes the minimum version requirements to install SQL Server on a computer that is running Windows Server 2019.

Before you install SQL Server on a computer that is running Windows Server 2019 you must make sure that you fulfill the following minimum requirements, as appropriate for your situation.

- **For SQL Server 2022 on Windows**  
   The release is supported at the SQL Server 2022 on Windows RTM Release version.
- **For SQL Server 2019 on Windows**
    The release is supported at the SQL Server 2019 on Windows RTM Release version.

- **For SQL Server 2017 on Windows**

    The release is supported at the SQL Server 2017 on Windows RTM Release version.

- **For SQL Server 2016**

    You must apply SQL Server 2016 Service Pack 2 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534).

- **For SQL Server 2014**

    You must apply SQL Server 2014 Service Pack 3 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2014](https://support.microsoft.com/help/2958069).  

- **For SQL Server 2012**

    You must apply SQL Server 2012 Service Pack 4 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2012](https://support.microsoft.com/help/2755533).

    > [!NOTE]
    >
    > - Make sure that you check known setup issues when you install SQL Server 2012 on Windows 10 or Windows Server 2016.
    > - The Books Online topic **Hardware and Software Requirements for Installing SQL Server 2012** has not yet been updated to reflect the support for Windows Server 2016 and Windows Server 2019.

- **For SQL Server 2008 R2**

    SQL Server 2008 R2 is not supported on Windows 10 or Windows Server 2016.

- **For SQL Server 2008**

    SQL Server 2008 is not supported on Windows 10 or Windows Server 2016.

## Minimum SQL Server version requirements for Windows 10 and Windows Server 2016

This section describes the minimum version requirements to install SQL Server on a computer that is running Windows 10 or Windows Server 2016.

Before you install SQL Server on a computer that is running Windows 10 or Windows Server 2016, you must make sure that you fulfill the following minimum requirements, as appropriate for your situation.

- **For SQL Server 2022 on Windows**  
   The release is supported at the SQL Server 2019 on Windows Server 2016 RTM Release version and Windows 10 TH1 1507 or greater versions.
- **For SQL Server 2019 on Windows**
-  The release is supported at the SQL Server 2019 on Window Server 2016 RTM Release version and Windows 10 TH1 1507 or greater versions.

- **For SQL Server 2017 on Windows**

  The release is supported at the SQL Server 2017 on Windows RTM Release version.

- **For SQL Server 2016**

  You must apply SQL Server 2016 Service Pack 2 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534).

- **For SQL Server 2014**

  You must apply SQL Server 2014 Service Pack 1 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2014](https://support.microsoft.com/help/2958069).

- **For SQL Server 2012**

  You must apply SQL Server 2012 Service Pack 2 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2012](https://support.microsoft.com/help/2755533).

  > [!NOTE]
  >
  > - Make sure that you check known setup issues when you install SQL Server 2012 on Windows 10 or Windows Server 2016.
  >
  > - The Books Online topic **Hardware and Software Requirements for Installing SQL Server 2012** has not yet been updated to reflect the support for Windows Server 2016 and Windows Server 2019.

- **For SQL Server 2008 R2**

  SQL Server 2008 R2 is not supported on Windows 10 or Windows Server 2016.

- **For SQL Server 2008**

  SQL Server 2008 is not supported on Windows 10 or Windows Server 2016.

## Minimum SQL Server version requirements for Windows Server 2012 R2 or Windows 8.1

This section describes the minimum version requirements for installing SQL Server on a computer that is running Windows Server 2012 R2 or Windows 8.1.

Before you install SQL Server on a computer that is running Windows Server 2012 R2 or Windows 8.1, you must make sure that you fulfill the following minimum requirements, as appropriate for your situation:

- **For SQL Server 2022 on Windows**  
   SQL Server 2022 is not supported on Windows 8.1 or Windows Server 2012 R2.
- **For SQL Server 2019 on Windows**
    SQL Server 2019 is not supported on Windows 8.1 or Windows Server 2012 R2.

- **For SQL Server 2017 on Windows**

  You can install the release version of SQL Server 2017 on Windows or a later version. For more information, see the [SQL Server 2014 main page](https://www.microsoft.com/sql-server/sql-server-2019).

- **For SQL Server 2016**

    You must apply SQL Server 2016 Service Pack 2 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534).

- **For SQL Server 2014**

  You must apply SQL Server 2014 Service Pack 3 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2014](https://support.microsoft.com/help/2958069).

- **For SQL Server 2012**

  You must apply SQL Server 2012 Service Pack 1 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2012](https://support.microsoft.com/help/2755533).

  > [!NOTE]
  > Please check [known setup issues](/troubleshoot/sql/install/sql-server-2012-setup-issues) when you install SQL Server 2012 on Windows 8 or Windows Server 2012.

- **For SQL Server 2008 R2**

  You must apply SQL Server 2008 R2 Service Pack 3 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2008 R2](https://support.microsoft.com/help/2527041).

- **For SQL Server 2008**

  You must apply SQL Server 2008 Service Pack 4 or a later update.

  > [!NOTE]
  > The RTM installation of the product is supported. However, you have to install the respective service packs after the initial setup is complete. Your SQL Server 2008 installation is not supported unless you apply Service Pack 4 after you install the RTM edition. For more information, see [How to obtain the latest service pack for SQL Server 2008](https://support.microsoft.com/help/968382).

Also check [known setup issues](/troubleshoot/sql/install/sql-server-2008-setup-issues) when you install SQL Server 2008 R2 and SQL Server 2008 on a computer that is running Windows Server 2012 R2, Windows Server 2012, Windows 8.1, or Windows 8.

## Minimum SQL Server version requirements for Windows Server 2012 or Windows 8

> [!NOTE]
> Windows 8 has reach end of support, which means Windows 8 devices no longer receive important security updates. We recommend making the free upgrade to Windows 8.1 to continue receiving security updates and support. For additional information review [Update to Windows 8.1 from Windows 8](https://support.microsoft.com/windows/update-to-windows-8-1-from-windows-8-17fc54a7-a465-6b5a-c1a0-34140afd0669).

This section describes the minimum version requirements to install SQL Server on a computer that is running Windows Server 2012 or Windows 8.

Before you install SQL Server on a computer that is running Windows Server 2012 or Windows 8, you must make sure that you fulfill the following minimum requirements, as appropriate for your situation:

- **For SQL Server 2022 on Windows**
   SQL Server 2022 is not supported on Windows 8.1 or Windows Server 2012 R2
- **For SQL Server 2019 on Windows**
    SQL Server 2019 is not supported on Windows 8.1 or Windows Server 2012 R2.

- **For SQL Server 2017 on Windows**

    The release is supported at the SQL Server 2017 on Windows RTM Release version.

- **For SQL Server 2016**

    You must apply SQL Server 2016 Service Pack 2 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534).

- **For SQL Server 2014**

    You must apply SQL Server 2014 Service Pack 3 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2014](https://support.microsoft.com/help/2958069).  

- **For SQL Server 2012**

    You must apply SQL Server 2012 Service Pack 4 or a later update. For more information, see [How to obtain the latest service pack for SQL Server 2012](https://support.microsoft.com/help/2755533).

  > [!NOTE]
  > Please check [known setup issues](/troubleshoot/sql/install/sql-server-2012-setup-issues) when you install SQL Server 2012 on Windows 8 or Windows Server 2012.

- **For SQL Server 2008 R2**

  You must apply Microsoft SQL Server 2008 R2 Service Pack 3 or a later update.

  > [!NOTE]
  > The RTM installation of the product is supported. However, you have to install the respective service packs after the initial setup is complete. You will see the following message on the Solution Center page:

  :::image type="content" source="media/use-sql-server-in-windows/problem-details-sql-server-2008-r2.svg" alt-text="Screenshot of the setup problem details for SQL Server 2008 R2: Microsoft SQL Server (2008 and 2008 R2) has known compatibility issues." border="false":::

  For more information, see [How to obtain the latest service pack for SQL Server 2008 R2](https://support.microsoft.com/help/2527041).

- **For SQL Server 2008**

  You must apply SQL Server 2008 Service Pack 4 or a later update.

  > [!NOTE]
  > The RTM installation of the product is supported. However, you have to install the respective service packs after the initial setup is complete. Your SQL server 2008 installation is not supported unless you apply Service Pack 4 after you install the RTM edition. You will see the following message on the Solution Center page.

  :::image type="content" source="media/use-sql-server-in-windows/problem-details-sql-server-2008.svg" alt-text="Screenshot of the setup problem details for SQL Server 2008: Microsoft SQL Server (2008 and 2008 R2) has known compatibility issues." border="false":::

  For more information, see [How to obtain the latest service pack for SQL Server 2008](https://support.microsoft.com/help/968382).

  > [!IMPORTANT]
  > The following dialog box appears in SQL Server 2008 R2 and SQL Server 2008 when you run the Setup program.

  :::image type="content" source="media/use-sql-server-in-windows/program-has-compatibility-issues.svg" alt-text="Screenshot of the Program Compatibility Assistant dialog box, which shows This program has compatibility problems." border="false":::

  After the SQL Server Setup program is finished, you have to install service packs before you run SQL Server on this version of Windows.

  - For SQL Server 2008, you have to install Service Pack 4 (SP4) or a later version.

  - For SQL Server 2008 R2, you have to install Service Pack 3 (SP3) or a later version.

    > [!NOTE]
    > Please also check [known setup issues](/troubleshoot/sql/install/sql-server-2008-setup-issues) when you install SQL Server 2008 R2 and SQL Server 2008 on a computer that is running Windows Server 2012 R2, Windows Server 2012, Windows 8.1, or Windows 8.

- **For SQL Server Compact editions**

  The following versions are supported in Windows 8.1, Windows 8, Windows Server 2012, and Windows Server 2012 R2 environments:

  - SQL Server Compact 3.5 Service Pack 2 and later versions
  - SQL Server Compact 4.0 and later versions

  > [!NOTE]
  > No support is planned for Windows RT devices.

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

## SQL Server 2012 and SQL Server 2008 R2 support for new features in Windows 8.1, Windows 8, Windows Server 2012 R2, and Windows Server 2012

This section summarizes how versions of SQL Server work with some new features in Windows 8.1, Windows 8, Windows Server 2012 R2, and Windows Server 2012.

The following table summarizes how versions of SQL Server work with some new features in Windows 8 and Windows Server 2012.

> [!NOTE]
> Unless noted in the following table, all features of Windows Server 2012 are supported in all the supported versions of SQL server.

|Feature|SQL feature or component that interacts with this new feature|SQL feature that is affected or supported|Minimum version and service pack requirements for SQL|Exceptions or support limitations|More information|
|---|---|---|---|---|---|
|Storage Spaces|||SQL Server 2008 R2 Service Pack 1 or later version, SQL Server 2012 (RTM and later versions)<br/><br/>**NOTE**<br/> SQL Server 2008 R2 requires Service Pack 2 on Windows 8.1 and Windows Server 2012 R2.||This feature is supported with the service packs that are specified for the respective versions.|
|Resilient File System (ReFS)||||ReFS is not supported in SQL 2012 and all other down-level versions. SQL Server 2014 supports ReFS.| |
|Mitigation of RAM Hardware Errors|LazyWriter|Checksum page sniffer|SQL Server 2012||When SQL Server 2012 is installed on a Windows 2012 operating system with hardware that supports bad memory diagnostics, you will notice new error messages like 854, 855, and 856 instead of the 832 errors that LazyWriter usually generates.|
|Number of instances per cluster|High availability|Failover Clustering|SQL Server 2012|25 per failover cluster when you use drive letters and up to 50 if you are using SMB file share storage| |
|Cluster Share Volumes (CSV's)||||Beginning in SQL Server 2014, Always On Failover Cluster Instances supports Clustered Shared Volumes (CSV) in both Windows Server 2008 R2 and Windows Server 2012. For more information on CSV, see [Understanding Cluster Shared Volumes in a Failover Cluster](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759255(v=ws.11)). CSVs are not supported in versions prior to SQL Server 2014.| |

## SQL Server 2005 information

This section provides support information about instances of SQL Server 2005 in Windows 8.1 or Windows 8 environments. It also describes the options that are available for customers who are using SQL Server 2005.
Microsoft SQL Server 2005 (the release version and service packs) and earlier versions of SQL Server are not supported on Windows 10, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 8.1, or Windows 8. You will receive a warning in the Action Center if Windows 10, Windows 8.1, or Windows 8 detects an instance of SQL Server 2005.

To resolve this issue, upgrade or remove the existing instance of SQL Server 2005. For information about how to upgrade SQL Server, see [Upgrade to SQL Server](/sql/database-engine/install-windows/upgrade-sql-server).

> [!NOTE]
> This link points to SQL Server 2014. You can use the version picker tool at the top of the MSDN link (Other Versions) for information about other versions.

For information about the Express editions of SQL Server, go to the following Microsoft websites:
- [SQL Server 2014 Service Pack 2 Express Edition](https://www.microsoft.com/download/details.aspx?id=53167)

- [SQL Server 2012 Service Pack 3 (SP3) Express Edition](https://www.microsoft.com/download/details.aspx?id=50003)

- [SQL Server 2008 R2 Service Pack 3 (SP3) Express Edition](https://www.microsoft.com/download/details.aspx?id=44271)

For more information about how to uninstall an existing instance of SQL Server 2005, see [How to manually uninstall an instance of SQL Server 2005](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup) or [How to: Uninstall an Existing Instance of SQL Server 2005 (Setup)](/previous-versions/sql/sql-server-2005/ms143412(v=sql.90)).

## Applies to

- SQL Server 2005 Enterprise X64 Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Standard Edition
- SQL Server 2005 Standard X64 Edition
- SQL Server 2005 Workgroup Edition
- SQL Server 2005 Developer Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 Standard
- SQL Server 2008 Standard Edition for Small Business
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2014 Business Intelligence
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Express
- SQL Server 2014 Standard
- SQL Server 2014 Web
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2017 on Windows (all editions)
- SQL Server 2019 on Windows

