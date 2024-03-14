---
title: Budgets are not available in the column definition
description: Describes an issue in which the budgets do not appear in the column definition in Microsoft Management Reporter. Provides a resolution.
ms.reviewer: theley, gbyer, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# Budgets are not available in the column definition in Microsoft Management Reporter

This article provides a resolution for the issue that no budgets are available in the Book Code/Attribute drop-down list in Microsoft Management Reporter.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2598691

## Symptoms

When you open a column definition in Management Reporter, no budgets are available in the Book Code/Attribute drop-down list. This happens when you are signed in to the company that is set up to use Microsoft Dynamics GP Financial with Analytical Accounting.

## Resolution

If the company in MR is set up to use Microsoft Dynamics GP Financial with Analytical Accounting, you won't see your GL budgets. You'll only see the AA budgets when you are logged into the AA company in MR. When you are logged into the AA company, MR is reading from the AA tables and not the GL00201 budget table. This is working as designed. If you must see your GL budgets, you'll have to set up a company in MR for Microsoft Dynamics GP Financial only. When you are signed in to that company, you'll be able to see the GL budgets. To use both AA and GP budgets, create a consolidated report between the two companies.
