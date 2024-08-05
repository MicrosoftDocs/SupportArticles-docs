---
title: There is no check transaction type setup
description: Provides a solution to an error that occurs when you upload Safe Pay Transactions in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# "There is no check transaction type setup. Upload Aborted" Error message when you upload Safe Pay Transactions in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you upload Safe Pay Transactions in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871759

## Symptoms

When you upload Safe Pay Transactions in Microsoft Dynamics GP, you receive the following error message:

> There is no check transaction type setup. Upload Aborted.

## Cause

This problem occurs if the **Transaction Code** field is specified in the bank format, and if no corresponding code is specified for the check transaction type.

## Resolution

To resolve this problem, follow these steps:

1. Open the Safe Pay Configurator window. To do it, follow the appropriate step, depending on your version of the program:
   - Microsoft Dynamics GP 10.0

        On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Routines**, point to **Financial**, point to **Safepay**, and then select **Configurator**.
   - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

        On the **Tools** menu, point to **Routines**, point to **Financial**, point to **Safepay**, and then select **Configurator**.

2. Select the appropriate bank format ID.
3. Open the Transactions Codes Entry window. To do it, follow the appropriate step, depending on your version of the program:
   - Microsoft Dynamics GP 10.0

        In the Safe Pay Configurator window, select **Codes Entry**, and then select **Transaction Codes Entry**.
   - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

        On the **Extras** menu, point to **Codes Entry**, and then select **Transactions Codes Entry**.
4. On the list in the **Transaction Type** field, select **Check**.
5. In the **Matching Code** field, enter the code for the check transactions according to the bank requirements.

    > [!NOTE]
    > A matching code must also be set for the **Void** transaction type. Repeat steps 4 and 5 to assign a code for the **Void** transaction type. If EFT transactions are included in your Safe Pay upload file, also enter a code for the **EFT** type.

6. Select **Save**, and then close the Transactions Types Entry window.
7. Select **Save**, and then close the Safe Pay Configurator window.
8. Upload the Safe Pay transactions. To do it, follow the appropriate step, depending on your version of the program:
   - Microsoft Dynamics GP 10.0

      On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Routines**, point to **Financial**, point to **Safepay**, and then select **Transactions Upload**.
   - Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

      On the **Tools** menu, point to **Routines**, point to **Financial**, point to **Safepay**, and then select **Transactions Upload**.
