---
title: How to set up Vacation Accrual in Canadian Payroll
description: The article illustrates how to set up the regular vacation accrual based on dollars or units in CPR.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# How to set up the Vacation Accrual in Canadian Payroll

This article introduces how to set up the Vacation Accrual in Canadian Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2003429

## Regular Vacation example

### Setup

Basically, you can accrue in dollars, or units, or both. The below example is in DOLLARS, but also tells you how to setup units, if you need it.

1. In the setup (**Tools** > **Setup** > **Payroll Canada** > **Control** > **Control**), set the **Allow Vacation Pay** to **yes**. If you're also accruing in units, set the **Allow Accrue Vacation Units** to **yes** as well. You may also choose to mark **Allow Vacation Pay Accrual to G/L**. Choose to **Accrue Vacation Units** in Days or Hours.

2. Go to Tools/setup/Payroll Canada/Income Paycodes. Locate your income code you'll be accruing on. Make sure **Vacation pay applicable** is set to **yes** for all the income codes that you'll be accruing on.

3. Focus on one employee. Go to **Cards** > **Payroll-Canada** > **Employee** > **VacSick** tab and be sure the **Set Calculate Vacation Pay** is set to **Yes** and a **Vacation Pay Percentage** is filled in. (If you're only accruing units and no dollars then the percentage can be set to 0.0000%.) Mark **Accrue Vacation Pay to G/L** is desired.

    1. Notice the Vacation Pay Accrual Flags in this window on how you want vacation accrued.
    2. To accrue in units, select **Accrue Vacation by Paycode** must be marked.

    Then select the **Other Options** button and set **Accrue Vacation Units** to **yes**. Enter the Standard Paycode, which will ensure when you incraet the rate of this paycode, the Vacation Adm. Gain/Loss will be calculated.  THe Last Vacation Accrual Rate can be left at 0.00000 and will automatically update each time Masters is updated.

    Select the Vacation Paycode.

4. On the employee card, select the **Paycodes** tab, and then select the paycodes that will be accrued on. On the paycode at the employee level, you'll need to set how much vacation they'll accrue if you're using units(calculated out per 100 units, so 11.66 hours per unit would be listed as 1166.00 or multiplied by 100.) Also mark if you want vacation units accrued in hours or days. Salary employees only get one unit per payrun.

5. To view the employee vacation balance, select the **Vacation** Tab in the Payroll Employee Setup-Canada window. You can see the employee below has $100.00 dollars available for vacation. The employee isn't accruing in units.

    Only the top line will be filled in for regular vacation. The Accruing/Available/Immed. Payout/Available After date/Pays Out After date and Also Accrue into Available checkbox are for **Vacation Pooling**, which you'll most likely not be using. Vacation Pooling is designed for unionized companies where the concept of vacation pay is available on a certain date (Available After date), and paid out if not taken by a certain date (Pays Out After Date). You would have to turn on vacation pooling to use this feature, but I don't hardly see any regular companies use it, so I won't go into that feature any further.

6. In the Employee Vac/Sick tab, there's also an option to **"Pay Vacation Pay This Period"**. So if you want any accrued vacation to pay out this pay run, mark this option. This option is often used when the employee leaves the company and want their final accrual to pay out.

    **DEMO:**

7. So now when I do a payrun for this employee:  

    The employee's vacation tab shows the employee earned $48. (The employee's vacation is set to 4%. The employee's income was $1200.)

    4% x $1200  = $48  so you can see the employee's vacation is now $48 above.

    **DEMO:**

8. So now if the employee takes vacation, you can key a transaction: I'll key one unit at $900 to use.
9. After the payrun is completed, you'll see the employee is left with $50. ($148 available -$98 used)
