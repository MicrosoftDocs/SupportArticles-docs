---
title: Payroll isn't updated when you set up benefits or deductions in Human Resources in Microsoft Dynamics GP
description: Describes a problem in which Payroll isn't updated when you set up benefits or deductions in Human Resources in Microsoft Dynamics GP.
ms.reviewer: theley, v-kimh, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# Payroll isn't updated when you set up benefits or deductions in Human Resources in Microsoft Dynamics GP

This article fixes an issue where Payroll isn't updated when you set up benefits or deductions.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850649

## Symptoms

When you're using Human Resources in Microsoft Dynamics GP, Payroll isn't updated when you set up benefits or deductions.

## Cause

This problem occurs because the **Payroll View for Human Resources** check box isn't selected. If you're using Human Resources integrated with Payroll, and you want each user to have the codes integrated between Human Resources and Payroll, you must select the **Payroll View for Human Resources** check box. If the **Payroll View for Human Resources** check box isn't selected, information is set up in Human Resources only. The information doesn't transfer to Payroll.

## Resolution

To resolve this problem, select the **Payroll View for Human Resources** check box for each user by following these steps:

1. In Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP**, point to **Tools** > **Setup** > **System**, and then click **User**.
    In Microsoft Dynamics GP 9.0, click **Tools**, point to **Setup** > **System**, and then click **User**.
2. Select the user ID that you want.
3. Click to select the **Payroll View for Human Resources** check box, and then click **Save**.

4. Repeat these steps for each user who must be able to integrate Human Resources information with Payroll.

The following information explains how the system works when the **Payroll View for Human Resources** check box is selected and when the **Payroll View for Human Resources** check box isn't selected.

## The "Payroll View for Human Resources" check box is selected

When you complete a benefit enrollment or a benefit change in Human Resources at the employee enrollment level, you're prompted to set up the corresponding benefit code or deduction code in Payroll so that the integration is completed.

After the integration is completed, you can access the Employee Deduction Maintenance window and the Employee Benefit Maintenance window on the Payroll side directly from the Miscellaneous Benefits Enrollment window in Human Resources. To do it, click **Go To** in the Employee Benefit Maintenance window, and then click **Payroll**. The deduction window or the benefit window on the Payroll side opens.

If you can move between the Human Resources window and the corresponding Payroll window, the integration is completed between the codes.

## The "Payroll View for Human Resources" check box isn't selected

When you complete a benefit enrollment or a benefit change in Human Resources at the employee enrollment level, you aren't prompted to set up the information in Payroll. You receive no prompts that the benefit enrollment is incomplete. The information doesn't roll to the Payroll side from Human Resources.

If you make a change to the deduction or the benefit on the Payroll side separately, you receive a prompt that informs you that Human Resources is registered, and that you must either save the changes in Human Resources first or run the Update Benefit Setup reconciliation.

We recommend that you select the **Payroll View for Human Resources** check box so that the changes that you make in Human Resources are rolled to the Payroll side, and so that the user is prompted accordingly.
