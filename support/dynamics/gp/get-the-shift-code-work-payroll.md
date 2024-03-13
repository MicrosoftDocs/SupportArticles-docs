---
title: Get the Shift Code to work in Payroll
description: Describes how to get the Shift Code to work in Payroll in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to get the Shift Code to work in Payroll in Microsoft Dynamics GP

This article describes how to get the Shift Code to work in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4021693

## Question

I created a Shift Code, and entered an Add-on code for $1.00, and assigned the shift code to the employee's paycode. However, when I process a Payroll Pay run, the shift code premium isn't added in to the pay rate, and the premium amount isn't updated in the UPR41500 table. How do you get the shift code to work in Payroll?

## Answer

Security for the Shift Code Setup window options includes the Microsoft Dynamics GP window and the HRM Solution Series option.

When you have HRM/Payroll Extensions installed, it automatically takes over the security to the Shift Code Setup window and replaces the bottom of the window with the **Add-On code** field used with Overtime Rate Manager (Payroll Extensions). If you aren't using Overtime Rate Manager (ORM) and just want to use the shift code with a pay code in Payroll, you can set security back to the **Microsoft Dynamics GP** window.  Follow the steps below.

**STEPS:**  

1. Set Security back as follows:
    1. Go to **Tools | Setup | System | Alternate/Modified forms and reports.**  
    1. Select:  
        **All Products**  
        **Windows**  
        **All**
    1. Expand **Payroll**  
    1. Expand **Shift Code Setup**  
    1. Mark **Microsoft Dynamics GP** option
    1. Save.

    :::image type="content" source="media/get-the-shift-code-work-payroll/alternate-modified-forms-reports.png" alt-text="Screenshot of the Alternate/Modified forms and reports window with Microsoft Dynamics GP option marked.":::

2. Set up the shift code:
    1. Go to **Tools | Setup | Payroll | Shift Code.**  
    1. Enter the **Shift Premium** by Amount or Percent as needed, and enter the amount or percent.
    1. Save.

    :::image type="content" source="media/get-the-shift-code-work-payroll/shift-code-setup.png" alt-text="Screenshot of the Shift Code Setup window.":::

3. Assign the Shift Code to a Paycode:  
    1. Go to **Cards | Payroll | Paycode**.
    1. Select the **Employee ID** and **Paycode**.
    1. Select the **shift code**. Save.
    1. You're prompted "Do you want to roll down this shift code change to all of this employee's pay codes that are based on this pay code?" Select **Yes** or **No** as wanted. Enter a reason code if prompted.

4. Enter a transaction for the employee using the paycode under **Transactions | Payroll | Transaction**.

    - Note the pay rate from the Base paycode is displayed on the transaction.
    - **Expand** the transaction to view the **Shift Code** and the **Shift Premium** amount in the line details.
    - Save the payroll batch.

5. Build and calculate the pay run, and on the PreCheck report, you'll see the Pay Rate now consists of the Base pay rate and the Shift Premium.
