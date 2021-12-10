---
title: Class ID not updated between Human Resources and Canadian Payroll
description: The Class ID field is not updating between Human Resources and Canadian Payroll.
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# Class ID not updated between Human Resources and Canadian Payroll in Microsoft Dynamics GP

This article describes a by design behavior that the Class ID field isn't updated between Human Resources and Canadian Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2534979

## Symptoms

The Class ID field is not integrated between Human Resources and Canadian Payroll in Microsoft Dynamics GP.

## Cause

The Class ID field is related to US Payroll only and unfortunately does not sync up with the Class ID on the Canadian Payroll side.

Class ID rolls down to US Payroll only. There is no synchronization for the Class ID between Canadian Payroll and the Employee Maintenance window. When entering a Class ID on the Canadian Payroll side, the HR Employee Class does not get updated and will be blank (or grayed out if you are not registered for US Payroll). This can leave a discrepancy between Human Resources and Canadian Payroll.

The reason for this discrepancy is because Human Resources and Canadian Payroll are both purchased products, and therefore you will see a few fields that won't sync up between the modules, with Class ID being one of them.

## Status

This is the current design.
