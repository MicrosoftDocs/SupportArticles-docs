---
title: Edit an attendance transaction in Human Resources in Microsoft Dynamics GP
description: Describes the method to edit the attendance transaction in Human Resources.
ms.reviewer: cwaswick, lmuelle
ms.topic: how-to
ms.date: 03/31/2021
---
# How to edit an attendance transaction in Human Resources if the Hours Used attendance transaction or the Hours Adjustment attendance transaction doesn't appear in the Attendance Transaction Lookup window in Microsoft Dynamics GP

This article describes the method to edit the attendance transaction in Human Resources if the Hours Used attendance transaction or the Hours Adjustment attendance transaction doesn't appear in the Attendance Transaction Lookup window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943026

## Introduction

You may want to edit an Hours Used attendance transaction or an Hours Adjustment attendance transaction in the Attendance Transaction Entry window in Microsoft Dynamics GP. However, the Hours Used attendance transaction or the Hours Adjustment attendance transaction may not appear in the Attendance Transaction Lookup window when you open the Attendance Transaction Lookup window from the Attendance Transaction Entry window. This behavior was designed to tighten the integration between Payroll in Microsoft Dynamics GP and Human Resources in Microsoft Dynamics GP.

This situation occurs if the following conditions are true:

- The time code of the attendance transaction isn't linked to a pay code.
- The attendance transaction isn't saved in a batch. This article describes how to edit the available balance of an attendance transaction in Human Resources if the Hours Used attendance transaction or the Hours Adjustment attendance transaction doesn't appear in the Attendance Transaction Lookup window.

To edit the available balance of an attendance transaction in Human Resources, use one of the following methods.

## Method 1

Edit the available balance of the attendance transaction in the Employee Attendance Maintenance window. To open the Employee Attendance Maintenance window, point to **Human Resources** on the **Cards** menu, point to **Employee-Attendance**, and then click **Maintenance**.

> [!NOTE]
>  
> - No audit trail is processed because no transaction is created for this adjustment.
> - You must click to select the **Edit Attendance Maintenance and Earnings History** check box if this check box is not selected. To do this, follow these steps:
>
>   1. Use the appropriate steps:
>
>      - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **Systems**, and then click **Human Resources Preferences**.
>
>      - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Systems**, and then click **Human Resources Preferences**.
>
>   2. Enter the password if you're prompted to enter the system password.
>   3. Click to select the **Edit Attendance Maintenance and Earnings History** check box.
>   4. Click **OK**.

## Method 2

Create an adjustment transaction to reverse the original attendance transaction by following these steps:

1. On the **Transactions** menu, point to **Human Resources**, and then click **Transaction Entry**.
2. Click **Hours Available Adjustment**.
3. In the **Employee ID** field, enter the employee identifier (ID).
4. In the **Time Code** field, enter the time code that you want to use.
5. In the **Hours** field, type a value.
    > [!NOTE]
    > The value can be positive or negative. Use a negative value to reduce the available balance. Use a positive value to increase the available balance to reverse an Hours Used attendance transaction.
6. Click **Save**.

You can view all the posted transactions in the Attendance Transaction Inquiry window. To open the Attendance Transaction Inquiry window, point to **Human Resources** on the **Inquiry** menu, and then click **Attendance Inquiry**.

## References

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[917057](https://support.microsoft.com/help/917057) Changes in the Attendance functionality in Human Resources in Microsoft Dynamics GP
