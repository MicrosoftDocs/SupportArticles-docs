---
title: Error when you view a report
description: This article provides a resolution for the problem that occurs when you attempt to view a TFS report in SQL Server Reporting Services.
ms.date: 09/25/2020
ms.custom: sap:Server Administration
ms.service: azure-devops-server
---
# Error browsing Microsoft Team Foundation Server reports

This article helps you resolve the problem that occurs when you attempt to view a Team Foundation Server (TFS) report in SQL Server Reporting Services.

_Original product version:_ &nbsp; Microsoft Team Foundation Server  
_Original KB number:_ &nbsp; 976701

## Rapid publishing

[!INCLUDE [Rapid Publishing Disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## Action

A user of TFS attempts to view a TFS report in SQL Server Reporting Services (SSRS).

## Result

Rather than rendering correctly, one of the following errors occurs:

- ERROR 1

  > An error has occurred during report processing. (rsProcessingAborted)
Query execution failed for data set 'dsLastProcessedTime'. (rsErrorExecutingCommand)
For more information about this error navigate to the report server on the local server machine, or enable remote errors

  > [!NOTE]
  > If remote errors are enabled, or the report is rendered on the console of the SSRS machine, this additional information is given: **Query (3, 10) Parser: The syntax for '=' is incorrect**.

- ERROR 2

  > An error has occurred during report processing. (rsProcessingAborted)
Query execution failed for dataset 'IterationParam'. (rsErrorExecutingCommand)
For more information about this error navigate to the report server on the local server machine, or enable remote errors

  > [!NOTE]
  > If remote errors are enabled, or the report is rendered on the console of the SSRS machine, this additional information is given: **Incorrect syntax near 'Measures'**.

## Cause

These errors can occur when the Data Source Type for TFS Data Sources in SSRS is set incorrectly. In the case of these two errors:

- ERROR 1

  > The Data Source Type for the TFS Data Source named "TfsReportDS" in SSRS is erroneously set to "Microsoft SQL Server Analysis Services".

- ERROR 2

  > The Data Source Type for the TFS Data Source named "TfsOlapReportDS" in SSRS is erroneously set to Microsoft SQL Server.

## Resolution

Using the SSRS web site, ensure the two TFS Data Sources point to the proper Data Source Type:

1. Connect to the SSRS web site. This is usually `HTTP://LOCALHOST/REPORTS` on the TFS application tier machine, but may be different. Check with your TFS administrator for this location.

2. Open the details for the `TfsReportDS` Data Source and ensure its Data Source Type is set to **Microsoft SQL Server**.

3. Return to the HOME page then open the details for the `TfsOlapReportDS` Data Source. Ensure that the Data Source Type is set to **Microsoft SQL Server Analysis Services**.

> [!NOTE]
> You will need to provide the password for the credentials being used by each Data Source before you can apply any changes made.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

## Disclaimer

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
