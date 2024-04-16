---
title: Editing reports fails if Internet Explorer isn't the default browser
description: Solves an issue that you can't edit reports in System Center 2012 Configuration Manager if the default browser isn't Internet Explorer.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Reports and subscriptions
---
# Editing reports in Configuration Manager may fail when Internet Explorer isn't the default browser

This article provides a solution for the issue that you cannot edit reports in Microsoft System Center 2012 Configuration Manager if the default browser is not Internet Explorer.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2788371

## Symptoms

When attempting to edit reports in the Administrator Console on a System Center 2012 Configuration Manager site server, you may receive this error:

> Application cannot be started. Contact the application vendor.

or

When attempting to edit reports from the Configuration Manager console installed on a client computer, the action may fail with this error:

> Cannot download the application. The application is missing required files. Contact application vendor for assistance.

## Cause

This may occur if Internet Explorer is not the default browser on the computer. Different limitations and requirements exist depending on which version of SQL Server is being used for the site database.

## Resolution

To resolve this issue, install a supported browser and set it as the default. For a list of supported browsers and limitations for your version of SQL Server, see the following articles:

- For SQL Server 2008: [Planning for Browser Support](/previous-versions/sql/sql-server-2008/ms156511(v=sql.100))
- For SQL Server 2008 R2: [Planning for Browser Support)](/previous-versions/sql/sql-server-2008-r2/ms156511(v=sql.105))
- For SQL Server 2012: [Planning for Reporting Services and Power View Browser Support (SSRS 2012)](/previous-versions/sql/sql-server-2012/ms156511(v=sql.110))

## More information

The following article lists the SQL Server versions that are supported by System Center 2012 Configuration Manager:

[Configurations for the SQL Server Site Database](/previous-versions/system-center/system-center-2012-R2/gg682077(v=technet.10))
