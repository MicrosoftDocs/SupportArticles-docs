---
title: Maximum row size exceeds the allowed maximum
description: Provides a workaround for the error during solution import in Power Apps - Maximum row size exceeds the allowed maximum.
ms.reviewer: matp
ms.date: 08/02/2023
author: nhelgren
ms.author: nhelgren
---
# Maximum row size exceeds the allowed maximum during solution import

This article provides a workaround for an error that occurs when you [import a solution](/power-apps/maker/data-platform/import-update-export-solutions) in Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you import a solution that contains columns not present in the target table, you receive the following error message:

> Exception type: System.ServiceModel.FaultException`1[Microsoft.Xrm.Sdk.OrganizationServiceFault]
Creating or altering table [table name] failed because the minimum row size would be 8070, including 1287 bytes of internal overhead. This exceeds the maximum allowable table row size of 8060 bytes.

## Cause

SQL Server has a row limit of 8,060 bytes per row, and the size consumed by each column varies by data type.

## Workaround

The row limit can't be extended. To work around this issue, you have to remove the columns for the import to succeed.

Here are the estimated total columns and sizes for various data types:

- Choice column: 4 bytes.
- Date and time: 8 bytes.
- ID: 20 bytes or more, depending on the Unicode values.
- Lookup: Two to three columns are added for each lookup, consuming 16 bytes or more, depending on the Unicode values. The number of columns depends on whether it's a standard lookup or a custom polymorphic lookup.
- Image: Two columns are used, one for images and one for thumbnails. The size may vary depending on the pointer size and thumbnails.
- File: The size varies depending on the pointer size.
- Currency: Depending on the decimal conversion, it consumes two to four columns. The number of bytes varies depending on the decimal conversion.
- Multiline text: Up to 24 bytes.
