---
title: Parameter pane is not visible in drillThrough report
description: This article helps you workaround the problem in which the parameter pane of a child report is permanently hidden.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
ms.reviewer: selvar, Matt Jones
---
# Parameter pane is not visible in drillThrough report in SharePoint integrated mode in SSRS

This article helps you workaround the problem in which the parameter pane of a child report is permanently hidden.

_Original product version:_ &nbsp; SQL Server 2012 Business Intelligence, SQL Server 2012 Developer, SQL Server 2012 Enterprise, SQL Server 2012 Standard, SQL Server 2012 Web  
_Original KB number:_ &nbsp; 2903465

## Symptoms

Consider the following scenario:

- You have an SSRS server that is running in SharePoint integrated mode.
- A parent report (Main report) that is running on the server has only hidden parameters or has no parameters at all.
- A child report (Drillthrough report) is running on the same server, and this report has one or more parameters associated with it.
- You drill through to the child report from the parent report.

In this scenario, the parameter pane of the child report is permanently hidden, and you cannot select or change the parameter values for the child report.

## Cause

This issue occurs because of a known limitation within SSRS.

## Workaround

To work around this issue, create a dummy parameter for the parent report and make sure that the parameter is set to be visible.
