---
title: How to paste to a field level translation in Integration Manager for Microsoft Dynamics GP 10.0
description: Describes steps to paste to a field level translation in Integration Manager for Microsoft Dynamics GP 10.0.
ms.reviewer: theley, kvogel, dlanglie
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to paste to a field level translation in Integration Manager for Microsoft Dynamics GP 10.0

This article describes how to paste to an Integration Manager 10 translation for Microsoft Dynamics GP 10.0. It also notes the maximum number of columns you can paste.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945788

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## More information

To paste to a translation in Integration Manager in Microsoft Dynamics GP 10.0, follow these steps:

1. Copy the two columns from the Excel Worksheet you want to paste.
1. In Integration Manager 10, select the field that you're mapping.
1. In the **Mapping Rules** section for the field, select the **Value** ellipse (...) for the translation rule.
1. Select the whole row instead of the individual cell.
1. Select Ctrl+V to paste the two columns you selected from the Excel Worksheet.

> [!NOTE]
> The maximum number of row that can be pasted to a translation are 16,384 for the two columns.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
