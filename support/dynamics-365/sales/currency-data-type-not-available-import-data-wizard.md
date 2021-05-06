---
title: Currency data type not available in Import Data Wizard
description: This article provides a resolution for the problem that occurs when you import data using the Import Data Wizard.
ms.reviewer: mmaasjo
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Currency Data Type Not Available in Microsoft Dynamics CRM Import Data Wizard

This article helps you resolve the problem that occurs when you import data using the Import Data Wizard.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2508542

## Symptoms

You import data using the Import Data Wizard. The source data file contains a field of type Currency that does not exist in the target organization. While mapping the source Currency field to a Microsoft Dynamics CRM field, you click **Actions**, and then click **Create New Field**. However, under the **Type** option set, there is no option for Currency.

## Cause

Only the following attribute types are available to create custom attributes in the Import Data Wizard:

- Single Line of Text
- Option Set
- Two Options
- Whole Number
- Decimal Number
- Date and Time
- Lookup

## Resolution

Create the custom Currency attribute for the entity before you use the Import Data Wizard. Then, map the source Currency field to the new Microsoft Dynamics CRM Currency field for the entity.
