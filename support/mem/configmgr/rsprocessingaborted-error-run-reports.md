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

*Applies to:* Microsoft Endpoint Configuration Manager (current branch – version 2103), SQL Server 2019, SQL Server 2019 Reporting Services, SQL Server 2017 Reporting Services

## Symptoms

You're running SQL Server 2019 with SQL Server Reporting Services (SSRS) 2017 or 2019 in your Microsoft Endpoint Configuration Manager environment. After you update to Configuration Manager current branch version 2103, you receive the following error when you run reports for collections:

> An error has occurred during report processing. (rsProcessingAborted)

You may also receive one of the following error messages:

- > The EXECUTE permission was denied on the object 'fnIsCas', database 'CM_LKD', schema 'dbo'

  :::image type="content" source="./media/rsprocessingaborted-error-run-reports/error-example.png" alt-text="A screenshot of the rsProcessingAborted error.":::
- > The EXECUTE permission was denied on the object 'fnIsPrimary', database 'CM_IDR', schema 'dbo'

## Cause

This issue occurs because of the [Scalar UDF Inlining](/sql/relational-databases/user-defined-functions/scalar-udf-inlining) feature in SQL Server 2019. A query that uses Scalar UDF Inlining may return an error or unexpected results. For more information, see [Scalar UDF Inlining issues in SQL Server 2019](https://support.microsoft.com/help/4538581).

## Resolution

To fix this issue, install [KB5003249 - cumulative update 11](https://support.microsoft.com/help/5003249), or a later cumulative update for SQL Server 2019.
