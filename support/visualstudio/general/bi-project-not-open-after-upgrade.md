---
title: Can't open a BI project after an upgrade
description: This article describes a problem in which you can't open a Business Intelligence project. This problem occurs after you upgrade the project to the Visual Studio 2010 format.
ms.date: 04/28/2020
ms.prod-support-area-path:
ms.reviewer: sivah
---
# You can't open a BI project after you upgrade the project to the format that is used by Visual Studio 2010

This article helps you resolve a problem where you can't open a Business Intelligence (BI) project after you upgrade the project to the Microsoft Visual Studio 2010 format.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 983332

## Symptoms

Consider the following scenario:

- You have a BI project. For example, you have a SQL Server Analysis Services project, a SQL Server Integration Services project, a SQL Server Report Model project, or a SQL Server Reporting Services project.
- The solution and projects have the following file name extensions:
  - .sln
  - .dwproj
  - .dtproj
  - .rptproj
- The BI project is created by using SQL Server Business Intelligence Development Studio (BIDS) in one of the following SQL Server versions:
  - SQL Server 2005
  - SQL Server 2008
  - SQL Server 2008 R2

- You upgrade the project to the format that is used by Visual Studio 2010.

In this scenario, the following errors can occur:

- You can't open the project in Visual Studio 2010. In the Solution Explorer window, the project name will be dimmed with the word (unavailable) in parentheses next to the name of the project.
- You can't open the project in SQL Server BIDS after you upgrade the project.
- The project in Solution Explorer Window will list the following error:

    > The project file was unloaded.

    This error indicates that Solution Explorer doesn't have a matching project type to open the project with.
- You try to open the project file by double-clicking it, you receive the following error:

    > Microsoft Visual Studio  
    > 'Drive:\Path\Project_name.dwproj' cannot be opened because its project type (.dwproj) is not supported by this version of the application.  
    > To open it, please use a version that supports this type of project.

## Cause

This issue occurs because Visual Studio 2010 doesn't let you edit a BI project that is created by using BIDS in SQL Server 2005, in SQL Server 2008, or in SQL Server 2008 R2.

## Resolution

To resolve the issue in which you can't open the project in SQL Server BIDS after you upgrade the project, follow these steps:

1. Create a new project that has the same name as the original BI project in a different directory by using SQL Server BIDS.
2. Add all relevant project items from the upgraded BI project folder. For example, for an Analysis Services project, add the .ds and .dsv files. For a Reporting Services project, add the .rds and .rdl files.
3. Save and then open the new BI project.

## More information

A BI project is a special kind of Visual Studio project that can be opened in Visual Studio. However, you must have BIDS components installed together with the corresponding Visual Studio shell so that you can create or edit BI projects. The BIDS components are released as a part of SQL Server 2005, of SQL Server 2008, and of SQL Server 2008 R2. These BIDS components are not designed to work together with Visual Studio 2010. Therefore, the upgraded project cannot be opened in Visual Studio 2010.

You use Visual Studio 2010 to open a BI project that was created by using BIDS in SQL Server 2005, in SQL Server 2008, or in SQL Server 2008 R2. In this situation, Visual Studio 2010 prompts you to upgrade the project to the Visual Studio 2010 format. Earlier versions of Visual Studio don't support opening projects from a future version of Visual Studio. Therefore, you cannot open the upgraded project in the version of BIDS that you used to create the project.

The following table lists the configurations that are supported so that you can open and edit different BI projects by using different Visual Studio versions. BI projects that are created by using BIDS cannot be edited in Visual Studio 2010. If you have a solution that contains BI projects and other projects, we recommend that you back up the solution before you open the solution in Visual Studio 2010.

|Product version|Visual Studio 2005 (the release version and later service packs) with BIDS in SQL Server 2005|Visual Studio 2008 (Service Pack 1 and later service packs) with BIDS in SQL Server 2008|Visual Studio 2008 (Service Pack 1 and later service packs) with BIDS in SQL Server 2008 R2|Visual Studio 2010 (the release version and later service packs)|
|---|---|---|---|---|
|SQL Server 2005 BI projects|Supported|Supported after project upgrade|Supported after project upgrade|Not supported|
|SQL Server 2008 BI projects|Not supported|Supported|Supported after project upgrade|Not supported|
|SQL Server 2008 R2 BI projects|Not supported|Not supported|Supported|Not supported|
||||||

## Applies to

- Visual Studio Ultimate 2010
- Visual Studio Professional 2010
- Visual C# 2010 Express
- Visual C++ 2010 Express
- Visual Basic 2010 Express
