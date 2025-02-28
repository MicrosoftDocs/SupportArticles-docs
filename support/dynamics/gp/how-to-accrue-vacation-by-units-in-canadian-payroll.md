---
title: How to accrue vacation by units in Canadian Payroll
description: Describes how to accrue vacation in units in Canadian Payroll in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, kriszree
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# How to accrue vacation by units in Canadian Payroll in Microsoft Dynamics GP

This article describes how to accrue vacation by units in Canadian Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 854116

To accrue vacation by units in Canadian Payroll, follow these steps:

1. Make sure that the **Allow Vacation Pay** and the **Allow Accrue Vacation Units** options are set to **Yes** in the Payroll Control Variables - Canada window. Follow these steps:

   1. Open the Payroll Control Variables - Canada window:

      In Microsoft Dynamics GP 10.0, point to **Tools** on the Microsoft Dynamics GP menu, point to **Payroll - Canada**, and then select **Control**. In the Payroll Control Setup - Canada window, select **Control**.

      In Microsoft Dynamics GP 9.0 and earlier versions, on the **Tools** menu, point to **Payroll - Canada**, and then select **Control**. In the Payroll Control Setup - Canada window, select **Control**.

   2. Make sure that the following options are set to **Yes**:
      - **Allow Vacation Pay**
      - **Allow Accrue Vacation Units**

2. Make sure the income paycode is set up to accrue in units. Follow these steps:

   1. Open the Payroll Income Paycode Setup - Canada window:

       In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Payroll - Canada**, and then select **Income Paycodes**.

       In Microsoft Dynamics GP 9.0 and earlier versions, on the **Tools** menu, point to **Setup**, point to **Payroll - Canada**, and then select **Income Paycodes**.

   2. Select the income Paycode that you'll be accruing on.
   3. Make sure that the **Vacation Pay Applicable** option is set to **Yes**.
   4. Select **Amounts**. In the **Vacation Accrual Units** box, type the number of vacation units to accrue for every 100 units of the income code.
   5. Repeat steps b through d for each paycode that will have vacation units accrued.

3. Make sure the employee is set up to accrue vacation by units. Follow these steps:
   1. Select **Cards**, point to **Payroll - Canada**, and then select **Employee**.
   2. Type or select an **Employee ID**.
   3. Select **Vac/sick** to open the Payroll Employee Vacation/Sick - Canada window.
   4. Make sure that the **Calculate Vacation Pay** option is set to **Yes**.
   5. If you're accruing in dollars, you must type a value in the **Vacation Pay Percentage** box. If you're accruing in units only and not in dollars, leave the **Vacation Pay Percentage** box blank.
   6. Make sure that the **Accrue Vacation by Paycode** check box under the **Vacation Pay Accrual Flags** section is selected.
   7. In the Payroll Employee Vacation/Sick - Canada window, select **Other Options**.
   8. In the Payroll Employee Vacation Other - Canada window, make sure that the **Accrue Vacation Units** option is set to **Yes**.

> [!NOTE]
> When you use Update Masters for the pay run, the units are updated in the Employee Vacation Pay window. It is updated in the **Vacation Pay** area under the **Units** column next to **Outstanding**. It is not updated in the cell next to **Available**. The **Accruing** and **Available** columns are updated if Vacation Pooling is used.
