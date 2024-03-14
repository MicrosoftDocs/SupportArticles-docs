---
title: CSST Setup for Canadian Payroll
description: Contains steps to set up CSST in Canadian Payroll.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# CSST Setup for Canadian Payroll in Microsoft Dynamics GP

This article contains steps to set up CSST in Canadian Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4101476

## Symptom

Improper setup can lead to errors on the poster file stating that it doesn't balance or an account is missing.

## Cause

It's often caused by the Debit Account not being set up for CSSTDR.

## Resolution

1. Setup your CSST Deduction and make sure that you select **Gross Pay** for the Calculate Rate on, and select **CSST Premiums** for the Further Identification.

    :::image type="content" source="media/csst-setup-canadian-payroll/csst-deduction.png" alt-text="Screenshot of Payroll Deduction Paycode Setup window with the Further Identification selected." border="false":::

1. Enter the Deduction Percentage that you need to have calculate under the **Amounts** button.

    :::image type="content" source="media/csst-setup-canadian-payroll/deduction-percentage.png" alt-text="Screenshot of the Payroll Deduction Other Amounts window." border="false":::

1. Setup a CSSTDR code. It doesn't need to have the Further Identification selected. It's used to read to the account for the debit portion of your CSST code.

    :::image type="content" source="media/csst-setup-canadian-payroll/csstdr-code.png" alt-text="Screenshot of CSST Deduction Paycode Setup window with no Further Identification selected." border="false":::

    Here's an example of the Debit and Credit on the Poster File based on the setups above.

    :::image type="content" source="media/csst-setup-canadian-payroll/debit-credit.png" alt-text="Screenshot of an example of the Debit and Credit." lightbox="media/csst-setup-canadian-payroll/debit-credit.png":::

    The Employer CSST Amount will be updated after the payrun is posted and will appear on the **Employee R1** button on the Employee Card.

    :::image type="content" source="media/csst-setup-canadian-payroll/employee-r1.png" alt-text="Screenshot shows Employer CSST Amount is updated.":::
