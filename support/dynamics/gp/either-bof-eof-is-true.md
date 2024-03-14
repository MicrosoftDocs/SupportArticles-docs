---
title: Either BOF or EOF is true
description: Provides a solution to an error that occurs when you run a SQL Opt Inventory Transaction integration in Integration Manager.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# "DOC1 Error: Either BOF or EOF is true or the current record has been deleted. Requested operation requires the current record" Error message when you run a SQL Opt Inventory Transaction integration in Integration Manager

This article provides a solution to an error that occurs when you run a SQL Opt Inventory Transaction integration in Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921345

## Symptoms

When you run a SQL Opt Inventory Transaction integration in Integration Manager in Microsoft Dynamics GP 9.0, you receive the following error message:
> DOC1 Error: Either BOF or EOF is true or the current record has been deleted. Requested operation requires the current record.

## Cause

This problem occurs because the following line appears in the IM.ini file.

`UseOptimizedFiltering=True`

> [!NOTE]
> The IM.ini file is installed together with Integration Manager. The file is installed in the Integration Manager Code folder.

## Resolution

To resolve this problem, modify the line in the IM.ini file as follows.

`UseOptimizedFiltering=False`
