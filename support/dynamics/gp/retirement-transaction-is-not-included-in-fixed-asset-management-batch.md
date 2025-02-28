---
title: Retirement transaction not included in Fixed Asset Management batch
description: A retirement transaction may not be included in a Fixed Asset Management batch that was created in General Ledger in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# A retirement transaction may not be included in a Fixed Asset Management batch that was created in General Ledger

In Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, a retired asset may not post to the General Ledger as expected.

This article describes why a retirement transaction may not be included in a Fixed Asset Management batch that was created in General Ledger.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874000

## More information

A retirement batch may not be included in the FATRX00000X batch that was created in General Ledger by the **Fixed Asset Management to General Ledger** posting routine. A retirement transaction may not be included in a Fixed Asset Management batch for any of the following reasons.

### The retirement date is outside the date range

A retirement transaction is not included in a Fixed Asset Management batch in the General Ledger if the retirement date is outside the date range that was used to generate the General Ledger batch.

For example, if the retirement date for the asset is December 31, 2008 and if the General Ledger Interface was created for the range from January 31, 2008 to February 28, 2008, the retirement transaction is not included in the Fixed Asset Management batch. To resolve this issue, create a General Ledger Interface that has a date range from 0000-000 to the present. To do this, follow these steps:

1. Open the Fixed Assets General Ledger Posting window. To do this in Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, select **Tools**, select **Routines**, select **Fixed Assets**, and then select **GL Posting**.

2. In the **Beginning Period** box, type *0000-000*.
3. In the **Ending Period** box, type the current date.
4. Under **Posting Information**, type the posting date.

   > [!NOTE]
   > This is also the date that is used in the FATRX General Ledger batch.

5. Select **Continue**.

   > [!NOTE]
   > The progress window does not automatically update or refresh. To see which asset is being processed, select **Progress**, and then select **Redisplay**.

### The averaging convention that is used to retire an asset has an effect

The averaging convention on an asset determines when the asset begins depreciating and when the asset is considered retired. For example, if an asset is retired on December 31, 2008 and the Half Year averaging convention is used, the retirement date for the asset is June 30, 2008. Therefore, the retirement transaction may not be included in the Fixed Asset Management batch as expected.

### The details in the Financial Detail Inquiry window are incorrect

A retirement transaction may not be included in a Fixed Asset batch if the details in the Financial Detail Inquiry window are incorrect. To verify the details in the Financial Details Inquiry window, follow these steps:

1. Open the Financial Detail Inquiry window. To open the Financial Detail Inquiry window, select **Inquiry**, select **Fixed Assets**, and then select **Financial Detail**.
2. In the **Asset ID** box, select an asset, and then select the corporate book in the **Book ID** box.
3. Verify that Source Document FARET or FAMRT transactions exist. If there are no FARET or FAMRT transactions, the retirement transaction was not completed.

   > [!NOTE]
   > To verify that a book is set to a corporate book, open the Fixed Assets Company Setup window. To do this, use the appropriate method:
   >
   > - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP 10.0**, point to **Tools**, point to **Setup**, point to **Fixed Assets**, and then select **Company**.
   > - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, select **Tools**, point to **Setup**, point to **Fixed Assets**, and then select **Company**.

   The book that is listed in the Fixed Assets Company Setup window is the corporate book and the only book that integrates to the General Ledger.

### The FA period of the FARET or FAMRT transactions is incorrect

The FA period of the FARET or FAMRT transactions must be included in the period range that you selected during the General Ledger posting. In the Financial Details Inquiry window, verify that the FARET and FAMRT transactions have a batch number. If the **Batch Number** field is blank, the General Ledger interface probably does not include the FA period. To resolve this problem, verify the year and the period that are noted in the FA Period column.

### The asset retirement transaction was not successful

To verify that an asset retirement was successful, verify that the asset is not listed in the Asset General window. To verify that an asset is not listed in the Asset General window, follow these steps:

1. Select **Cards**, select **Fixed Assets**, and then select **General**.
2. Verify that the asset is listed. If the retirement transaction was successful, the asset is not listed.

   > [!NOTE]
   > If an asset was partly retired (PARET-P), the retired amount of the asset has the same asset ID as the original asset. However, the retired amount of the asset has a different suffix. For example, the unretired amount of the asset is listed as Asset 1(active), and the unretired amount of the asset is listed as Asset 2(retired).
