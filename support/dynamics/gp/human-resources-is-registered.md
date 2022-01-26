---
title: Human Resources is registered
description: Provides a solution to an error that occurs when you make a change to a benefit or deduction after installing Human Resources in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Human Resources is registered..." message when you make a change to a benefit or deduction after installing Human Resources in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you make a change to a benefit or deduction after installing Human Resources in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3099041

## Symptoms

When you make a change to a benefit or deduction after installing Human Resources in Microsoft Dynamics GP, you get this message:

> Human Resources is registered. You may want to save changes in Human Resources first or run the Update Benefit Setup reconcile. Do you want to continue?

## Cause

This message is normal once you've HR installed and you try to make a change to a benefit or deduction on the Payroll side first.

Once HR is installed, you should make the change to a benefit/deduction on the HR side first and let the change automatically roll to the Payroll side. However, if you make the change on the Payroll side first, it doesn't automatically roll back to the HR side. The message is alerting you to start on the HR side first, or else you'll have to run the HR reconcile utility to get the change updated or pushed back to the HR side if you choose to continue on with updating directly in Payroll.

## Resolution

Once you have HR installed, it's recommended to make a change on a benefit or deduction for an employee by navigating to **Cards**, point to **Human Resources**, point to **Benefits and Deductions**, select the deduction type and the code. For a deduction, edit the EMPLOYEE or COST TO SUBSCRIBER fields and save. For a benefit, edit the EMPLOYER or COST TO EMPLOYER fields and save. The change should be rolled over to the Payroll benefit or deduction automatically.

> [!NOTE]
> If you would like to make the change on the Payroll side first, you can, but it's not recommended if you have HR installed. You could make the change under Cards, point to **Payroll**, then select **Benefit or Deduction**. Select to continue on past the message. Then once you have saved your change, you can run the HR reconcile utility for Update Benefit Enrollment (for the employee level) to push the change back to the HR side for the employee. However, keep in mind that the reconcile utility may also overwrite or change other information for the code back to a default value, so it isn't advised to do it this way as you risk losing other information or edits you have made to date.

## More information

What is the impact if only the Payroll side is updated for the benefit/deduction, and the change isn't reconciled back to the HR side?

The payroll side is used in the checkrun, so your checkrun will be correct. However, if HR isn't updated, an incorrect amount would be reflected in any reporting done on the HR side, or GP windows looking at the HR side, or even ACA reporting if they pull from HR setup. So it may be confusing to the user if the HR side isn't updated and could impact your ACA reporting if the HR side isn't correct.
