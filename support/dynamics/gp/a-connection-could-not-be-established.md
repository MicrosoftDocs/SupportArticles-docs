---
title: A connection could not be established
description: Provides a solution to an error that occurs when using Microsoft Dynamics GP drilldown functionality.
ms.reviewer: theley, robalsta, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "A connection Microsoft Dynamics GP could not be established. Be sure you are logged on to the appropriate Company and try again." error when using drilldown functionality

This article provides a solution to an error that occurs when using Microsoft Dynamics GP drill-down functionality.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2966672

## Symptoms

You receive the following error when using Microsoft Dynamics GP drilldown functionality:

> A connection Microsoft Dynamics GP could not be established. Be sure you are logged on to the appropriate Company and try again.

## Cause

You'll see this error after transferring a Microsoft Dynamics GP installation to a new server that is running Microsoft SQL Server and you don't update the server links for the Microsoft Dynamics GP Drilldown functionality.

## Resolution

If you're moving your Microsoft Dynamics GP databases and you use the drilldown functionality in the SQL Server Reporting Services or Excel-integrated reports, you need to follow the steps below to update your server links so the drilldowns will continue to work after the server move:

1. Ensure that everyone has signed out of Microsoft Dynamics GP and close all instances of SQL Server Management Studio.

2. On a machine where Dynamics GP is installed select **Start**, then point to **All Programs**. Then select to expand Microsoft Dynamics, then GP and select **Database Maintenance**.

3. When the utility opens, select or enter the SQL Server instance name where the Dynamics GP databases are stored. If you're signed in as a domain account with rights to this SQL Server instance, you can select the Windows Trusted Authentication method. Otherwise select SQL Authentication and enter an appropriate user name and password. Select **Next**.

4. Select **Mark All** to choose each of the Dynamics GP databases. Select **Next**.

5. Select the Microsoft Dynamics GP product. Select **Next**.

6. Select **Functions and Stored Procedures**. Select **Next**.

7. Review the confirmation window. Select **Next** to begin the process.

> [!NOTE]
> This process can take some time to run. It will depend on the number of products installed along with the number of databases that need to be addressed. Once this process has completed, your external report drilldowns will work in the new SQL Server instance.
