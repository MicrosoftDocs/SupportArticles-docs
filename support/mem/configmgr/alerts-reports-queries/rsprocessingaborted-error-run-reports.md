---
title: Fails to run reports in Configuration Manager
description: Resolves an issue in which reports don't run in Microsoft Endpoint Configuration Manager if SQL Server 2019 is used.
ms.date: 12/05/2023
ms.reviewer: kaushika, maosesro, v-six
---
# rsProcessingAborted error when you run reports in Configuration Manager

This article helps you fix an issue in which you can't run reports for collections if you use Microsoft SQL Server 2019 in Microsoft Endpoint Configuration Manager.

_Applies to:_ &nbsp; Microsoft Endpoint Configuration Manager, SQL Server 2019

## Symptoms

When you run reports for collections in Microsoft Endpoint Configuration Manager, you receive the following error messages :

- > An error has occurred during report processing. (rsProcessingAborted)
- > The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'
- > The EXECUTE permission was denied on the object 'fnIsPrimary', database 'CM_IDR', schema 'dbo'

Refer to the following screenshot for an example of the error messages.

:::image type="content" source="media/rsprocessingaborted-error-run-reports/error-example.png" alt-text="Screenshot of the rsProcessingAborted error." border="false":::

When this issue occurs, the following error entries are logged in the *ReportingServicesService.log* file on the reporting services point:

```output
processing!ReportServer_0-2!18fc!<Date>-<Time>:: e ERROR: Throwing Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: , Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: Query execution failed for dataset 'DeploymentSummary'.

   ---> System.Data.SqlClient.SqlException: The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'.

processing!ReportServer_0-2!18fc!<Date>-<Time>:: e ERROR: An exception has occurred in data set 'DeploymentSummary'. Details: Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: Query execution failed for dataset 'DeploymentSummary'.

   ---> System.Data.SqlClient.SqlException: The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'.

processing!ReportServer_0-2!18fc!<Date>-<Time>:: v VERBOSE: An exception has occurred. Trying to abort processing. Details: Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: Query execution failed for dataset 'DeploymentSummary'.

   ---> System.Data.SqlClient.SqlException: The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'.
```

## Cause

This issue occurs because of the [Scalar UDF Inlining](/sql/relational-databases/user-defined-functions/scalar-udf-inlining) feature in SQL Server 2019. A query that uses Scalar UDF Inlining might return an error or unexpected results. For more information, see [Scalar UDF Inlining issues in SQL Server 2019](https://support.microsoft.com/help/4538581).

## Resolution

To fix this issue, install [KB5000642 - cumulative update 9](https://support.microsoft.com/help/5000642) or a later cumulative update for SQL Server 2019.
