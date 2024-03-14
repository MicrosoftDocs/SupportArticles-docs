---
title: Electronic Reconcile in the Registration window in Dynamics GP
description: Provides a solution to an issue where the Electronic Reconcile option is listed in the Registration window.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
---
# Electronic Reconcile in the Registration window in Microsoft Dynamics GP

This article provides a solution to an issue where the Electronic Reconcile option is listed in the Registration window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2972243

## Symptoms

In the Registration window in Microsoft Dynamics GP, the three options below are listed. Which one do I mark?

- Electronic Bank Management
- Electronic Reconcile
- Electronic Reconciliation Management

## Cause

Both UK and US modules may be listed.

## Resolution

Use the following modules together:

On a U.S. install:

- Bank Reconciliation
- Electronic Reconcile

On a U.K. install:

- Cashbook Bank Management
- Electronic Reconciliation Management
- Electronic Bank Management
