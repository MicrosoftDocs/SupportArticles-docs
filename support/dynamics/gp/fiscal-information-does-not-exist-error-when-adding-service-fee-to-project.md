---
title: Fiscal information does not exist for service fee dates error when adding service fee to project
description: Describes a problem where you receive a warning message when adding a service fee to an existing project in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Fiscal information does not exist for service fee dates" error when adding a service fee to a project in Project Accounting

This article provides a resolution for the issue that you receive the **Fiscal information does not exist for service fee dates** error when adding a service fee to a project in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2670932

## Symptoms

When you try to add a service fee to a project in Project Accounting, you receive the following message:

> Fiscal information does not exist for service fee dates. Please enter fee ID in Fee Detail Window.

You tried to change the date and then receive the following message:

> Fiscal information does not exist for the date range. The fiscal year must exist in order to create the periodic records.

## Cause

The fee is defaulting in with an End Date, which is not part of a valid fiscal year.

## Resolution

1. Enter the fee in the Fee Entry window. To open the Fee Entry window, on the **Cards** menu, point to **Project**, point to **Project**, select your project, and then select **Fees**.
2. Put your cursor in an empty row of the Project and Service Fees area, and select the **expansion** box next to Fee ID to open the **Fee Details** window.
3. Enter your service fee here in **Fee Details**.

You should notice that the Begin Date for your fee will default with the Begin Date of the project and then go for a year. Adjust as necessary so that the dates you are using are within fiscal years that you have set up.

> [!NOTE]
> If necessary you can create a new fiscal year in the **Fiscal Periods Setup** window. To access this window on the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
