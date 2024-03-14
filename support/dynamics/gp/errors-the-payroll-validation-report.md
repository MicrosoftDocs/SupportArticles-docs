---
title: Errors on the Payroll Validation report
description: Describes the different errors or warnings that you may see on the Payroll Validation Error report when you complete the Payroll year-end close process in Microsoft Dynamics GP.
ms.reviewer: theley, dbader
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# Description of the errors or warnings that may appear on the Payroll Validation report in Payroll in Microsoft Dynamics GP

This article describes the different errors or warnings that you may see on the Payroll Validation Error report when you complete the Payroll year-end close process.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872100

## Introduction

Many of the messages are only warnings that don't prevent you from processing the W2 forms.

## More information

- > **[First 2 digits of SSN]** is invalid as the 1st two characters of Company EIN

    > [!NOTE]
    > Replace the **[First 2 digits of SSN]** placeholder with the first two digits of the social security number.

    The first two digits of the employee social security number must be between 01 and 99. Additionally, the digits shouldn't be equal to the following numbers: 7, 08, 09, 10, 17, 18, 19, 20, 26, 27, 28, 29, 30, 40, 49, 50, 60, 69, 70, 78, 79, 80, 89, 90.

- > **[Last 2 digits of SSN]** is an invalid value for the last two characters of Company EIN

    > [!NOTE]
    > Replace the placeholder *[Last 2 digits of SSN]* with the last 2 digits of the social security number.

    The last 2 digits of the employee social security number must be between 01 and 99.

- > The Company State Code *[State]* is not Federal Information Processing Standard compliant and is unacceptable.

    > [!NOTE]
    > Replace the placeholder *[State]* with a state code.

    In the Company Setup window, the **State** field must contain a valid state code in uppercase letters.

- > **[SSN]** as SSN is invalid. [Add]

    > [!NOTE]
    > Replace the placeholder *[SSN]* with a social security number.

    This message is also a validation message that prompts you to validate the social security number. It may not always indicate that the social security number is incorrect. The employee social security number must be greater than 000000000 and less than or equal to 999999999. Also, the social security number can't be equal to 111111111, 333333333, or 123456789.

- > **[First 3 digits]** illegal as 1st 3 digits of SSN

    > [!NOTE]
    > Replace the placeholder *[First 3 digits]* with the first three digits of the social security number.

    The first three digits of the employee social security number mustn't be equal to 000 and must be less than or equal to 764.

- > The Employee State Code **[State]** is not Federal Information Processing Standard compliant and is unacceptable.

    > [!NOTE]
    > Replace the placeholder *[State]* with a state code.

    A valid state code in uppercase letters must exist in the **State** field in the Employee Maintenance window and in the Employee State Tax Maintenance window.

- > Wages, Tips, Other Compensation' field is Blank or negative

    It's a validation error message that prompts you to verify that the employee has no wages for the year.

- > 'Social Security Wages' field is Blank or negative

    It's a validation error message that prompts you to verify that the employee does have wages for the year.

- > The FICA/SS Wages of $ **[SS Wages]** exceeds Limit of $ **[FICA/SS Wage Limit]**  

    > [!NOTE]
    > Replace the placeholder *[SS Wages]* with the social security wages, and replace the placeholder *[FICA/SS Wage Limit]* with the FICA/social security wage limit.

    It's a validation error message that prompts you to verify the accuracy of the FICA/Social Security wages for any employee that exceeds the limit specified in Payroll Tax Setup window for the **FICAS** tax code.

- > FICA/SS Tax W/H' of $ **[SS Tax W/H]** <> calculated of $ **[recalculated SS Tax W/H]**

    > [!NOTE]
    > Replace the placeholder *[SS Tax W/H]* with the social security tax withholding, and replace the placeholder *[recalculated SS Tax W/H]* with the calculated social security tax withholding.

    It's a validation error message that prompts you to verify the accuracy for any employee who has a **FICA/SS tax withheld** amount that is more than the employee **FICA/SS wages** multiplied by the **FICA/SS** rate.

- > The FICA/MC Wages of $ **[MC Wages]** exceeds Limit of $ **[FICA/Med Wage Limit]**  

    > [!NOTE]
    > Replace the placeholder *[MC Wages]* with the FICA/Medicare wages, and replace the **[FICA/MED Wage Limit]** placeholder with the FICA/Medicare wage limit.

    It's a validation error message that prompts you to verify the accuracy of the Employee FICA/Medicare Wages for any employee that exceeds the limit specified in Payroll Tax Setup window for the **FICAM** code.

- > FICA/MC Tax W/H' of $ **[MC Tax W/H]** <> calculated of $ **[recalculated MC Tax W/H]**  

    > [!NOTE]
    > Replace the placeholder *[MC Tax W/H]* with the FICA/Medicare tax withheld, and replace the placeholder *[recalculated MC Tax W/H]* with the calculated FICA/Medicare tax withholding amount.

    It's a validation error message that prompts you to verify the accuracy for any employee who has a FICA/Medicare tax withheld amount that is more than the employee FICA/Medicare Wages multiplied by the FICA/Medicare rate.

The following errors don't have resolutions listed because the resolutions are self-explanatory:

- > A blank Company Name is unacceptable

- > A blank Company State is unacceptable

- > A blank Company City is unacceptable

- > A blank Company ZIP Code is unacceptable

- > A blank Employee Address is unacceptable

- > A blank Employee City is unacceptable

- > A blank Employee State is unacceptable

- > A blank Employee Zip Code is unacceptable

- > Blank or negative 'SS Tax W/H' is unacceptable

- > A blank Social Security Number is unacceptable

- > Employee SSN is less than 9 digits

- > Employee 'First Name' or 'Last Name' is missing

- > 'Federal Income Tax W/H' field is negative

- > 'Social Security Wages' must be blank for MQGE employees

- > 'SS Tax W/H' must blank for MQGE employees

- > 'Social Security Tips' field is negative

- > 'Allocated Tips' field is negative

- > 'Advance EIC Payment' field is negative

- > 'Dependent Care Benefits' field is negative

- > 'Non-qualified Plans' field is negative

- > 'Special-1 Amount' field is negative

- > 'Special-2 Amount' field is negative

- > 'Special-3 Amount' field is negative

- > 'Other-1 Amount' field is negative

- > 'Other-2 Amount' field is negative

- > 'Other-3 Amount' field is negative
