---
title: The menu path for Electronic Reconcile does not show
description: The menu path for Electronic Reconcile does not appear in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The menu path for Electronic Reconcile does not display in Microsoft Dynamics GP

This article provides a resolution for the issue that the menu path or Electronic Reconcile doesn't show in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 2970564

## Symptoms

You have installed Electronic Bank Reconcile (on a US install), and you are signed in as the poweruser, but the menu path does not exist.

## Cause

Electronic Bank Reconcile is for a US install. Usually the issue is that the user printed the documentation for Bank Management (for a UK install) and so the path listed in this documentation does not exist on a US install.

## Resolution

To use Electronic Bank Reconcile (on a US install), navigate to **Tools** under Microsoft Dynamics GP, point to **Routines**, point to **Financial**, point to **Electronic Reconcile** and select the appropriate window you want to use.

> [!NOTE]
> If the path above is not listed, then verify that **Electronic Reconcile** is marked in the Registration window found under **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **System** and select **Registration**.
