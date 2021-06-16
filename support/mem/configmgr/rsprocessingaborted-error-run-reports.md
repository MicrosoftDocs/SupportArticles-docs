---
title: Cannot run reports in Configuration Manager version 2103
description: Fixes an issue in which you cannot run reports in Microsoft Endpoint Configuration Manager version 2103 when SQL Server 2019 is used.
ms.date: 06/16/2021
ms.prod-support-area-path: 
ms.reviewer: maosesro
---
# rsProcessingAborted error when running reports in Configuration Manager version 2103

## Symptoms

When you run a report that relies on a collection in Microsoft Endpoint Configuration Manager current branch, version 2103, you receive the following error messages:

- > An error has occurred during report processing. (rsProcessingAborted)
- > The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'
- > The EXECUTE permission was denied on the object 'fnIsPrimary', database 'CM_IDR', schema 'dbo'

See the following screenshot for an example of the error:

:::image type="content" source="./media/rsprocessingaborted-error-run-reports/error-example.png" alt-text="Screenshot of the rsProcessingAborted error.":::

## Cause

This issue occurs because of the [Scalar UDF Inlining](/sql/relational-databases/user-defined-functions/scalar-udf-inlining) feature in SQL Server 2019. For more information, see [Scalar UDF Inlining issues in SQL Server 2019](https://support.microsoft.com/help/4538581).

## Resolution

To resolve this issue, install the cumulative update 11 ([KB5003249](https://support.microsoft.com/help/5003249)) or a later cumulative update for SQL Server 2019.
