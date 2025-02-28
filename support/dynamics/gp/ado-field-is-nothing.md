---
title: ADO Field is nothing
description: Provides solutions to errors that occur when you preview the source query in Integration Manager for Microsoft Dynamics GP 10.0.
ms.reviewer: theley, kvogel, grwill
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "ADO Field is nothing" Error message when you run an integration or when you preview the source query in Integration Manager for Microsoft Dynamics GP 10.0

This article provides solutions to errors that occur when you preview the source query in Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954632

## Symptoms

When you run an integration or preview a source query in Integration Manager for Microsoft Dynamics GP 10.0, you receive one of the following error messages:
> ERROR: ADO Field is nothing.

> The following problem occurred while attempting to open Query 'queryname': ADO Field is nothing.

## Resolution

To resolve this problem, follow one of these resolutions:

### Resolution 1

Obtain the latest service pack for Integration Manager for Microsoft Dynamics GP 10.0.

### Resolution 2

Make sure that the column names in the source data contain no Microsoft Jet reserved words.

### Resolution 3

Make sure that your column names in the source data contain no special characters. The column names must only consist of alpha-numeric characters.

### Resolution 4

This error can occur if the data type of a column was changed that is used in the **Query Relationship** window. Open the properties for each source and then select the **Refresh Columns** button on the **Columns** tab. After you refresh the columns, verify the mapping of the integration and the **Query Relationship** window are still correct.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
