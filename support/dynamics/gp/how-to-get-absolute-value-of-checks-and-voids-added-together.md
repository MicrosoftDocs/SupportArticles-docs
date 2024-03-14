---
title: How to get Absolute Value of Checks and Voids added together
description: Introduces how to get the Absolute Value of Checks and Voids added together in the footer record of the Safepay file in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# How to get the Absolute Value of Checks and Voids added together in the footer record of the Safepay file

This article provides steps to get the Absolute Value of Checks and Voids added together in the footer record of the Safepay file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4057056

> [!NOTE]
> Microsoft Partners can sign in to PartnerSource and download the **SpTotals.zip** file (Customers would have to contact their Partner to get this zip file.)
>
> The zip file contains the spTotals.cnk file and text document with installation steps.

## More information

Here are steps to install the chunk file:

1. Have the users log out. Then make a backup of the server code folder and client code folder where you will be installing it.
2. Install Safe Pay: Copy and paste the chunk file on the GP code folder.

3. Sign in to GP and you will be prompted to install the new product. (After installing the cnk, verify that both the SPTOTALS.DIC [cnk] and SFPAY.DIC [product] exists in the Dynamics GP Code folder.)

4. Make sure to have a field in the Safe Pay Configurator as follows:

    1. Sign in to GP as SA.
    2. Open the Safe pay configurator window (**Tools** > **Routines** > **Financial** > **Safe Pay** > **Configurator**).
    3. Pull up the Bank Format.
    4. Highlight the footer line.
    5. Double-click the field that displays the check total. On the **Output Field** window, make sure that the amount type is set to **Net Totals**.

        Standard Fields: Check Amount  
        Currency Format: Specify the bank's currency format  
        Amount Type: **Net Totals**

    6. Create a test Safe pay upload file to test the output.

> [!NOTE]
> Once this file is installed, you do not need to alter any security setting since there are no new windows added. Also, the Net total amount type will always take the absolute total. If you need to use the original functionality of the Net Total field then you need to remove the SP Totals from the Dynamics.set file.
>
> - Be careful with how you map the amount on the detail lines. Some fields (Field Amount) will list the individual check amounts, and some fields (Check Total) will consecutively add the check amounts together on each successive line.
> - In the footer line, pick **Net Totals** to get the absolute value of checks and voids added together.
