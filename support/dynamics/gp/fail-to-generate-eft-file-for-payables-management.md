---
title: Error when you generate an EFT file for Payables Management
description: Provides a solution to an error that occurs when you generate an EFT file for Payables Management in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Error message when you generate an EFT file for Payables Management in Microsoft Dynamics GP: "EXCEPTION_CLASS_SCRIPT_DIVIDE_BY_ZERO"

This article provides a solution to an error that occurs when you generate an EFT file for Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2669725

## Symptoms

When you generate the Payables Management EFT file, you receive the following error message. The EFT file still generates, however the batch remains in the **Generate EFT Files** window.

> Unhandled script exception:
>
> Division by zero, script aborted.
>
> EXCEPTION_CLASS_SCRIPT_DIVIDE_BY_ZERO
>
> SCRIPT_CMD_MOD

## Cause

This message is caused by having the **Add Pad Blocks** check box marked in the **EFT File Format Maintenance** window but one of the supporting lines for Number of Pad Chars or Pad Lines in Multiple Of has a value of '0'. The system is unable to calculate how to pad the rows in the file because of the 0 value.

## Resolution

To resolve this problem, follow these steps:

1. Click **Cards**, point to **Financial**, and then click **EFT File Format** to open the **EFT File Format Maintenance** window.
2. Select the **EFT Format ID**.
3. In the **EFT File Format Maintenance** window, review the **Add Pad Blocks** section. If this check box is marked, then the three supporting lines underneath should also have a value defined in each field. Refer to the options below to resolve this problem:

    - Option 1

        If the bank does not require the file to be padded, unmark the checkbox next to **Add Pad Blocks** to disable this feature.
    - Option 2

        If the bank requires pad blocks to be used, refer to the bank's Requirement documentation to determine the required value to enter in the **Pad Character**, **Number of Pad Chars**, and **Pad Lines in Multiple Of** fields.

        As an example, consider the following scenario: The bank requires the file to be 94 characters wide, and padded with the number "9" with a block count of 10. For this specific scenario, enter the following information in these fields:

      - **Pad Character**: 9
      - **Number of Pad Chars**: 94
      - **Pad Lines in Multiple of**: 10

4. To remove EFT batches that are still listed in the Generate EFT window, generate a new EFT file with those batches as usual to have the system clear them from the window. Then delete the new EFT file that was created. Do not send the new EFT file to the bank again.

## More information

Pad Blocks  means that the bank requires the EFT output file to be rounded up to a certain number of rows so their system will accept it. So the Add Pad Blocks feature will add dummy rows to the end of the file to bring the file up to a specific rounded number of rows as required by the bank.

For example, assume the bank requires the file to be padded in blocks of 10 rows. Below are examples of how the Pad Blocking will work:

- If your EFT file has 22 rows, GP will add 8 dummy row to the end of the EFT file to make it an even 30 rows.
- If your EFT file has 29 rows, GP will add 1 dummy row to the end of the EFT file to make it an even 30 rows.
- If your EFT file has 41 rows, GP will add 9 dummy row to the end of the EFT file to make it an even 50 rows.
- If your EFT file already has an even 10, 20, 30, 40, 50, etc. rows, GP will not add any dummy rows to the EFT file.
