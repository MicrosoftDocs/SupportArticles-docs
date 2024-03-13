---
title: Long Integer out of range
description: Provides a solution to an error that occurs when running the Reconcile to GL financial routine.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Reconcile to GL utility throws "Long Integer out of range." error

This article provides a solution to an error that occurs when running the Reconcile to GL financial routine.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3210592

## Symptoms

When running the Reconcile to GL financial routine, you get this error:

> Unhandled script exception:  
Long integer out of range. Results invalid.  
EXCEPTION_CLASS_SCRIPT_OUT_OF_RANGE

## Cause

More than 32,767 records in the unmatched section of the results.

## Resolution

This issue was fixed in Microsoft Dynamics GP 2016 RTM. Upgrade for the fix.

Workaround: When running the Reconcile to GL tool, make the date range smaller, so you have fewer records returned and break up the period that you're trying to reconcile into smaller date ranges.
