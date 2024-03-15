---
title: Cannot access this report or form
description: Provides a solution to an error that occurs when printing a report in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, jakelaux
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Cannot access this report (or form) because the dictionary containing it is not loaded." Error Message displays when printing a report in Microsoft Dynamics GP

This article provides a solution to an error that occurs when printing a report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2545189

## Symptoms

When printing reports/forms in any module for Microsoft Dynamics GP, the below error message may happen:

> Cannot access this report because the dictionary containing it is not loaded.

or

> Cannot access this form because the dictionary containing it is not loaded.

## Cause

This message is typically caused when a user has access to a modified report or form that no longer exists. (The modified form may have been deleted, or the reports.dic or forms.dic may have been deleted, or you may have removed a product directly from the Dynamics.set file.) This issue is most commonly seen after an upgrade or service pack installation where the reports dictionary has been changed and now contains different reports.

## Resolution

Use the steps below to remove access to the missing report:

1. Select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **System** and select **Alternate/Modified Forms and Reports**.

2. Choose the Modified Forms and Reports ID assigned to the user experiencing this issue.

3. Choose the **Product** from which the report is being generated or choose **All Products** if you're unsure. (For windows or forms, choose **All Products**.)

4. Select a Type of Reports. (or if it's a form, choose **Windows**).

5. From the Modified Forms and Reports List that populates, expand the correct Series and Report Name as appropriate.

6. You may find that the modified report is missing and no security is set. Mark the Microsoft Dynamics GP report to grant access to the original report. (Or you may reimport in the modified report and set security to the modified report again.)

> [!NOTE]
> If you aren't sure of the report name or window name, you can run through the entire list and expand all to make sure one bullet is marked at least for each item in the list.

## More information

To see what modified forms and report do exist in your system, follow these steps:

1. Under Microsoft Dynamics GP, select **Tools**, point to **Customize** and select **Customization Maintenance**.

2. The modified forms and reports will be listed here that exist on your installation. You can export them to package files for safe-keeping, or import a new modified form and report.
