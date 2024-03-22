---
title: Error accessing SQL data
description: Provides a solution to an error that occurs when you try to generate a large report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Error accessing SQL data" Error message when you try to generate a large report in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to generate a large report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857827

## Symptoms

When you try to generate a large report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you may receive the following error message:
> Error accessing SQL data.

## Resolution

To resolve this problem, follow these steps:

1. On the workstation where the error occurs, locate the Dex.ini file.

    > [!NOTE]
    >
    > - In Microsoft Dynamics GP 10.0 and in later versions, the Dex.ini file is located in the Data folder in the folder where the Microsoft Dynamics GP client is installed.
    > - In Microsoft Dynamics GP 9.0 and in earlier versions, the Dex.ini file is located in the folder where the Microsoft Dynamics GP client is installed.

2. Right-click the **Dex.ini** file, and then select **Open**.
3. If the following lines are missing, type the following lines at the bottom of the file:

    - SQLQueryTimeout=0
    - SQLProcsTimeout=0
    - SQLRprtsTimeout=0
4. On the **File** menu, select **Save**, and then select **Exit**.
5. Restart the computer.

6. In Microsoft SQL Server Management Studio, or in SQL Server Enterprise Manager, increase the size of the tempdb setting.

7. Increase the size of the free space that is available on the hard disk drives where the SQL Server data files are stored.
