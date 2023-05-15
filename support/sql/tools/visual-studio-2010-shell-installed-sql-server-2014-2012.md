---
title: Visual Studio 2010 Shell is installed with SQL Server 2014 and 2012 
description: This article provides a workaround for the Visual Studio 2010 Shell end-of-support warning that occurs when you scan the server with a security software.
ms.date: 05/04/2023
ms.custom: sap:Tools
ms.reviewer: suresh.kandoth, jopilov
author: HaiyingYu
ms.author: haiyingyu
---

# Visual Studio 2010 Shell is installed with SQL Server 2014 and 2012

_Applies to:_ &nbsp; SQL Server 2014, SQL Server 2012

## Symptoms

After you install SQL Server 2014 or SQL Server 2012 with SQL Server Management Studio (SSMS) or SQL Server Data Tools (SSDT), the following programs are installed and listed as installed programs:

- Microsoft Visual Studio 2010 Shell (Isolated)

- Microsoft Visual Studio 2010 Shell (Integrated)

When you scan the server with a security software, Visual Studio 2010 Shell may be flagged as an end-of-support (EOS) or obsolete software.

## Cause

When you install SQL Server 2014 or SQL Server 2012, you find that SSMS requires Visual Studio 2010 Shell (Isolated) and SSDT requires Visual Studio 2010 Shell (Integrated). SQL Server Management Studio (SSMS) ships with SQL Server Database Engine in those versions.

According to [Microsoft lifecycle policy of Visual Studio 2010](/lifecycle/products/visual-studio-2010), the support ended on July 14, 2020. However, if Visual Studio 2010 Shell (Isolated) or Shell (Integrated) is installed with SQL Server 2014 or SQL Server 2012, Visual Studio 2010 Shell will be supported until the end of support for [SQL Server 2014](/lifecycle/products/sql-server-2014) (July 09, 2024) or for [SQL Server 2012](/lifecycle/products/microsoft-sql-server-2012) (July 12, 2022).

Starting with SQL Server 2016, SSMS and SSDT no longer ship with SQL Server bits but can be downloaded as separate applications. These later versions don't have the dependency on Visual Studio 2010 Shell component. Therefore, you can download and use more up-to-date versions of SSMS or SSDT. For more information on these tool changes, see [SQL Client Tools update for SQL Server 2016](https://cloudblogs.microsoft.com/sqlserver/2016/03/25/sql-client-tools-update-for-sql-server-2016/).

## Workaround

To avoid dependence on Visual Studio 2010 Shell component, you can uninstall and download the latest SSMS or SSDT version. Here's how to accomplish this goal:

1. Use the SQL Server installation wizard to [uninstall the installed version of SSMS](../ssms/uninstall-management-studio.md) or SSDT.

1. Download and install the latest version of [SSMS](/sql/ssms/download-sql-server-management-studio-ssms) or [SSDT](/sql/ssdt/download-sql-server-data-tools-ssdt).

    > [!NOTE]
    >
    > - If you use SSMS to manage SQL Server Integration Services (SSIS) packages, see [Supported SQL offerings](/sql/ssms/download-sql-server-management-studio-ssms#supported-sql-offerings).
    > - If you use Business Intelligence Development Studio (BIDS) to design and manage SSIS packages, see [Supported SQL versions](/sql/ssdt/download-sql-server-data-tools-ssdt#supported-sql-versions).

1. Make sure Visual Studio 2010 Shell (Isolated) or Shell (Integrated) isn't used by other applications or services.

1. Uninstall Visual Studio 2010 Shell (Isolated) or Shell (Integrated) via **Add or remove programs**.
