---
title: Tax fields and year-end update fields
description: Describes what the different date fields mean for tax and year-end updates In Microsoft Dynamics GP.
ms.reviewer: Theley, Dbader
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# Information about the tax fields and year-end update fields in Payroll in Microsoft Dynamics GP

This article describes what the different date fields mean and how they're updated with the release of Payroll tax and year-end updates.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949154

## Introduction

There are several different date fields that are updated when you install the payroll tax and year-end updates. Additionally, there may be manual modifications to the tax tables. The following list describes the date fields and how they're updated in the system.

## More information

The Payroll Tax Setup window is the main window that displays which tax update a company currently has installed. To open the Payroll Tax Setup window, follow these steps:

For Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **Payroll Tax**.

- Last Tax Update: Displays the last date that your tax table files were updated. This field is updated when you run the automatic or manual updates in Microsoft Dynamics GP.

- Last Modification: Displays the date when the tax files were manually modified after the last tax update was installed. For example, if a user makes a modification to the Payroll Tax Setup window and saves the changes, this field is populated with the date when the change was saved. However, when the next tax update is run against the system, the date will default back to 00/00/0000. This behavior occurs because installing the tax update automatically overwrites any manual edits a user has made.

- Last Tax Code Update: Displays the date when changes are made to Dynamics programming code and not the actual tax tables. The Tax Code update refers to the Dexterity code that is used to build Microsoft Dynamics GP and interface with the tax tables.

The Payroll Setup window is used to track which year-end update has been applied to a workstation. To open the Payroll Setup window, follow these steps:

For Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Payroll**, and then select **Payroll**.

Select **Tools**, point to **Setup**, point to **Payroll**, and then select **Payroll**.

- Last Year-End Update: Displays the date when the last year-end update was applied to the system. It includes changes that were made to IRS reporting forms and to W-2 electronic files. This field is automatically updated with the current year date after the year-end update is installed.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
