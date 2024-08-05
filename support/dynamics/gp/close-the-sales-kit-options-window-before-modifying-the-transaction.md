---
title: Close the Sales Kit Options window before modifying the transaction error when you run a Sales Order Processing integration that contains a kit item
description: Describes a problem that occurs when the Sales Order Processing integration contains a kit item. Provides a resolution.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# "Close the Sales Kit Options window before modifying the transaction" error when running a Sales Order Processing integration that has a kit item

This article provides a resolution for the issue that an error occurs when you try to run a Sales Order Processing integration that contains a kit item in Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917943

## Symptoms

When you run a Sales Order Processing integration that contains a kit item, you receive the following error message:

> Close the Sales Kit Options window before modifying the transaction

You receive this error message in Integration Manager for Microsoft Dynamics GP 9.0 and for Microsoft Business Solutions - Great Plains 8.0.

## Cause

This problem occurs when the **Qty to Back Order** field and the **Qty Fulfilled** field are set to **0**.

## Resolution for Microsoft Dynamics GP

To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Dynamics GP.
