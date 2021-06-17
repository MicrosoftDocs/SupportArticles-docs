---
title: Fails to run reports in Configuration Manager version 2103
description: Describes an issue in which reports may fail to run in Microsoft Endpoint Configuration Manager version 2103 when SQL Server 2019 is used. Provides a resolution.
ms.date: 06/16/2021
ms.prod-support-area-path: 
ms.reviewer: maosesro
author: simonxjx
ms.author: v-six
---
# rsProcessingAborted error when running reports in Configuration Manager version 2103

This article helps you fix an issue in which running reports for collections doesn't work with SQL Server 2019 after you upgrade Microsoft Endpoint Configuration Manager to version 2103.

_Applies to:_ &nbsp; Microsoft Endpoint Configuration Manager (current branch – version 2103), SQL Server 2019

## Symptoms

After you upgrade the Configuration Manager environment to version 2103 of Configuration Manager current branch, you receive the following errors when you run reports for collections:

- > An error has occurred during report processing. (rsProcessingAborted)
- > The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'
- > The EXECUTE permission was denied on the object 'fnIsPrimary', database 'CM_IDR', schema 'dbo'

See the following screenshot for an example of the error:

:::image type="content" source="./media/rsprocessingaborted-error-run-reports/error-example.png" alt-text="A screenshot of the rsProcessingAborted error.":::

When this issue occurs, the following error messages are logged in the *ReportingServicesService.log* file on the reporting services point:

```output
processing!ReportServer_0-2!18fc!<Date>-<Time>:: e ERROR: Throwing Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: , Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: Query execution failed for dataset 'DeploymentSummary'.

   ---> System.Data.SqlClient.SqlException: The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'.

processing!ReportServer_0-2!18fc!<Date>-<Time>:: e ERROR: An exception has occurred in data set 'DeploymentSummary'. Details: Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: Query execution failed for dataset 'DeploymentSummary'.

   ---> System.Data.SqlClient.SqlException: The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'.

processing!ReportServer_0-2!18fc!<Date>-<Time>:: v VERBOSE: An exception has occurred. Trying to abort processing. Details: Microsoft.ReportingServices.ReportProcessing.ReportProcessingException: Query execution failed for dataset 'DeploymentSummary'.

   ---> System.Data.SqlClient.SqlException: The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'.
```

## Cause

This issue occurs because of the [Scalar UDF Inlining](/sql/relational-databases/user-defined-functions/scalar-udf-inlining) feature in SQL Server 2019. A query that uses Scalar UDF Inlining may return an error or unexpected results. For more information, see [Scalar UDF Inlining issues in SQL Server 2019](https://support.microsoft.com/help/4538581).

## Resolution

To fix this issue, install [KB5003249 - cumulative update 11](https://support.microsoft.com/help/5003249), or a later cumulative update for SQL Server 2019.
