---
title: COLUMNOFTABLE error when creating EFT file
description: You receive the COLUMNOFTABLE error when trying to generate an EFT file in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# SCRIPT_CMD_COLUMNOFTABLE error when trying to create an EFT file in Microsoft Dynamics GP

This article provides a resolution for the SCRIPT_CMD_COLUMNOFTABLE error that occurs when you try to generate an EFT file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4464976

## Symptoms

When trying to generate a Payables or Receivables EFT file in Microsoft Dynamics GP, this error happens:

> Unhandled script exception:  
Bad Datatype detected for operation  
EXCEPTION_CLASS_SCRIPT_BAD_TYPE  
SCRIPT_CMD_COLUMNOFTABLE

## Cause

There is a field mapped in the configurator with a table, in which the field does not exist in that table

## Resolution

You must go to the configurator file, and line by line, reselect each FIELD from the pick list. You will eventually come across one that is not available in the pick list (that is, not available in the table selected). Either change the table or change the field as needed.
