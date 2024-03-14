---
title: HR is registered error message
description: Provides a solution to an error that occurs when using the Class ID field in Payroll in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick 
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Human Resources
---
# "HR is registered" Error message when using the Class ID field in Payroll in Microsoft Dynamics GP

This article provides a solution to an error that occurs when using the Class ID field in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2636801

## Symptoms

When you set up a new employee in Payroll and populate the Class ID field, you receive the following warning message:

> HR is registered. Please make changes in HR. If you save these changes in Payroll, HR will not be updated. Do you want to continue?

## Cause

You'll receive this warning message if you're using classes in the Employee Maintenance window. The message indicates that you should start the process on the Human Resources (HR) side versus Payroll. The Class ID field is mainly a Payroll feature. The message indicates that you shouldn't be assigning deductions/benefits using the class method when you have HR installed. Deductions/benefits should be set up in Human Resources first, so they can roll to Payroll. If you're assigning deductions in the Class ID, it's warning you that the HR side won't be updated. It's a warning message and cannot be turned off.

## Resolution

If you're using HR, and want to assign benefits/deductions using the Class ID method on the Payroll side, then unfortunately we can't turn off this warning message.

If you aren't using HR at this time, then follow the appropriate method below:

**Resolution 1**: If you aren't using HR, select **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **System**,  and then select **Registration**. Scroll down and unmark **Human Resources Management**.

**Resolution 2**: If you aren't using HR, then go to **Add/Remove Programs** (or **Programs and Features**) in the Control Panel, and uninstall Human Resources Management from Microsoft Dynamics GP.
