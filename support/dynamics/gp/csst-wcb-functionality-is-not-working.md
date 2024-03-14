---
title: CSST/WCB functionality isn't working
description: Provides a solution to an issue where CSST/WCB functionality isn't working in Canadian Payroll for Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# CSST/WCB functionality isn't working in Canadian Payroll for Microsoft Dynamics GP

This article provides a solution to an issue where CSST/WCB functionality isn't working in Canadian Payroll for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2493498

## Symptoms

CSST/WCB functionality for Quebec isn't working in Canadian Payroll after installing the 2010 Year-end/2011 Tax Update for Microsoft Dynamics GP. In Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010, the cheque is reduced by the amount of the CSST amount causing an unbalanced entry. However in Microsoft Dynamics GP 9.0, the CSST premium option is missing in the Further Identification field to set it up.

> [!NOTE]
> Functionality to calculate the CSST premium was new to the 2010 Year-end/2011Tax Update for Microsoft Dynamics GP.

## Cause

Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010  
When CSST is assigned to an employee that also has a benefit with an offsetting deduction included in the payrun (example RRSPB/RRSPD), the net pay will be reduced by the CSST amount on the cheque and the posting will error because of an unbalanced entry for the CSST amount.

Microsoft Dynamics GP 9.0

The option of CSST Premiums isn't an option under the **Further Identification** field in the Payroll Deduction PaycodeSetup-Canada window.

## Resolution

This issue was fixed in the 2011 Tax Update (Round 2).

## More information

It's recommended to install the Round 2 Tax Update to obtain the fix. However, the specific chunk file to resolve this issue is also available to download, but make sure to have the 2010 Year-end/2011 Tax Update installed first.
