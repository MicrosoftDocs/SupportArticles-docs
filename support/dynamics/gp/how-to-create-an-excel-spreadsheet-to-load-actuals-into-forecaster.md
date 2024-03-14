---
title: How to create spreadsheet to load actuals into Forecaster
description: Explains how to create a Microsoft Excel spreadsheet to load actuals into Microsoft Forecaster 7.0 using Microsoft Management Reporter 2012.
ms.reviewer: theley, kevogt, gbyer
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# How to create an Excel spreadsheet to load actuals into Forecaster 7.0 using Management Reporter 2012

This article discusses how to create a Microsoft Management Reporter 2012 report, and how to export that report to Microsoft Excel in order to use the file to import data into Microsoft Forecaster 7.0.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2935967

To do this, follow these steps:

1. Open Management Reporter and sign in to the company you need to import data.
2. Create a new **Row Definition**.
   1. To add the desired accounts, select **Edit**, and then select **Add Rows from Dimensions**. All dimensions should have the ampersand (&) to import all possible combinations.

        > [!IMPORTANT]
        > This may include just profit and loss accounts, so make sure that you remove the **Normal Balance** of C for any of the account types that have typical credit balances.
        >
        > The data will need to be modified in Excel to the proper segments in Forecaster before you complete the import.
   2. Save the **Row Definition**.

3. Create a new **Column Definition**.
   1. Select a **DESC** column, an **ACCT** column, and 12 **FD** columns using **PERIODIC** (each column is hard-coded using period 1 through period 12).

        > [!NOTE]
        > The **DESC** column is not needed for the import to Forecaster, but is required for the Management Reporter report.
   2. Save the **Column Definition**.

4. Create a new **Report Definition**.
    1. On the **Report** tab, choose the Row Definition and Column Definition created in step 2 and step 3.
    2. On the **Headers and Footers** tab, delete all headers.
    3. On the **Settings** tab, clear the option **Display currency symbol on first row** and **Display blanks for zero amounts**. Select **Whole Dollars** for the Rounding precision. Select **Display rows with no amounts** if you want to bring over all amounts including those with a zero budget amount.
    4. Select **Save**, and then select **Generate** to generate the report.

5. Export the Management Reporter report to Microsoft Excel.

    In Report Viewer, select **File**, point to **Export** and then select **Microsoft Excel**. Clear all the **Microsoft Excel options** and clear the **Include comments** option. Select the option **Open workbook after exporting**.

6. Open the report in Excel.

    > [!IMPORTANT]
    > You must split the full account column and you may need to concatenate the accounts in Excel for a successful import to Forecaster. To determine the segments and the order of the accounts in Forecaster, log on to Forecaster and select **Setup,** select **Segments**, and then select **Definition**.
    >
    > Segment numbers in the Excel worksheet with leading zeros will need to be saved as a text field in Excel when you split the full account or the Department 0010 may change to Department 10 , causing these records to fail during the import.

    Select **File,** select **Save as**, choose **Text (Tab delimited).txt** for the **Save as type**, and then select **Save**.

7. In Forecaster, select **Tools,** select **Import**, and then select **Data**.

    > [!NOTE]
    > Make sure have a valid backup of the Forecaster database before you import the data.
    >
    > Additional details on the Import data process can be found in the Forecaster Help screens under the **Contents** tab, expand **Loading Data**, expand **Import**, then select **Import Data**. You can also use the **Search** tab and type *Import Data*.

8. And then following these steps:

   1. Type a batch name, and then select **Browse** to locate the .txt file you saved from step 6A.
   2. For the **Column** selection, choose either **Number of columns** or **Input Set**.

        > [!IMPORTANT]
        > If you choose the **Input Set** option, make sure you have the input set created in Forecaster first.
   3. For the **File format**, choose **Delimited**.
   4. Select **Next**.
   5. Map the field to the appropriate **Position in File**.
   6. Confirm the segment positions chosen and the months of data, then select **Next**.
   7. Confirm the **Source** file to load, and then select **Finish**.
