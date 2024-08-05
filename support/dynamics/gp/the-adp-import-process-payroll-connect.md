---
title: The ADP import process in Payroll Connect
description: Describes the Payroll Connect installation process and provides information about specific fields that are required for Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# The ADP import process in Payroll Connect and the specific fields that are required for Microsoft Dynamics GP

This article describes the Automatic Data Processing (ADP) import process in Payroll Connect and provides information about the specific fields that are required for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866501

## Introduction

If the format used to generate the file in ADP doesn't meet the requirements for GP, you'll get this message:

> The selected import file is not a valid ADP export file.

## More information

Payroll Connect is installed in the Microsoft Dynamics GP installation process. Payroll Connect doesn't require a separate installation process. You must enter Payroll Connect registration keys. Additionally, you must select the **Payroll Connect** check box in the Registration window.

Before you use the Import From ADP window, work with your ADP representative to complete the following tasks:

- Obtain the correct file structure for the import file.
- In the ADP product, set up the same account framework as in Microsoft Dynamics GP.
- The format used in the ADP tool must contain 10 fields. Even though all 10 fields aren't used by GP, they must still exist.
- The file should be comma delimited and have a suffix of `.gli`, `.txt`, or `.csv`.
- Each field should have quotes around it. Open the file with Notepad to confirm.
- Each field shouldn't be mapped wider than the maximum width allowed for each field in GP. See the Maximum Widths defined for each field at the end of the article below. (The Description field in field 7 is shorter than the allowable length defined in Microsoft Dynamics GP.)
- All 10 fields must exist in the file. The fields not used by GP can be blank or have a fixed value, but must still exist in the file.
- In the GL Batch Entry window, the **number of Journal Entries** displayed for the ADP batch will actually display the **number of lines** from the ADP file, so it can be misleading. However, if you drill into the transaction detail, it's composed of only one journal entry and does post correctly as one journal entry. Since it's only a display issue and does post correctly, this issue won't be changed at this time. However, if you wish to correct it, you can select **Tools** under **Microsoft Dynamics GP**, point to **Utilities**, point to **Financial**, select **Reconcile**, select **Batches**, and select **Reconcile**. This reconcile process will update the Number of Journal Entries in this batch to be correct. The user can add it to their documentation or part of their processes after they bring in an ADP file. Which has been written up as a product suggestion, so vote on this request using the [Microsoft Connect Has Been Retired](/collaborate/connect-redirect) if you would like to see it as a future enhancement:

The following table describes the 10 fields needed in the ADP Payroll Connect import file:

| Import field| Description |
|---|---|
| **Client Code**|This field is assigned by ADP but isn't used in Microsoft Dynamics GP. If this field isn't used in Microsoft Dynamics GP, you can leave this field blank. |
| **General Ledger Account Number**|This field is used for the distribution account number. Don't use spaces, dashes, or commas.|
| **Journal Source Code**|If you create a batch for the import, **GJ** (General Journal) is displayed in the **Batch Type** field.|
| **Date**|This field isn't used in Microsoft Dynamics GP. The transaction date for the journal entry is used as the date that is entered in the import window.|
| **Amount**|This field is used for the debit lines and the credit lines of the distributions. Negative amounts are preceded by a minus sign (-).|
| **Reference number 1**|This field isn't used in Microsoft Dynamics GP, but still must exist. |
| **Description**|This field is used as the description for the corresponding distribution line. |
| **Reference number 2**|This field isn't used in Microsoft Dynamics GP, but still must exist.|
| **Reference number 3**|This field isn't used in Microsoft Dynamics GP, but still must exist.|
| **Record Code**|This field is assigned by ADP but isn't used in Microsoft Dynamics GP.|
  
The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Here's a more detailed description of how to map each field listed above in the ADP tool:

Field 1 - Client Code - Map to Fixed value or leave blank.  Max width: 5.  
Field 2 - GL account - Map to GL account. Don't use dashes, spaces, or commas. Can set to width of your GL account. Max width: 24.  
Field 3 - Journal Source Code - Map to fixed value of ' GJ '. Max width: 2.  
Field 4 - Date - Map to Issue date. Can use MMDDY or MMDDYYYY. GP doesn't use this date. Max width: 5.  
Field 5 - Amount - Map to Amount. Don't use dollar signs or commas. Set to two decimals. Max width: 13.  
Field 6 - Ref 1 - Map to fixed value of blank. No filler. Max width: 6.  
Field 7 - Description - Map to Description. Max width: 20. This field doesn't truncate, so can't be greater than 20.  
Field 8 - Ref 2  - Map to fixed value of blank. No filler. Max width: 6.  
Field 9 - Ref 3 - Map to fixed value of blank. No filler. Max width: 6.  
Field 10 - Record Code - Map to fixed value of ' 02 '. Max width: 2.

When you open the ADP file in Notepad, all 10 fields must exist and it should look similar to this example:

```console
"","0000001028","GJ","07051","45102.10","","DESCRIPTION","","","02"
"","0000001028","GJ","07051","-2696.34","","DESCRIPTION","","","02"
"","0000001028","GJ","07051","-630.59","","DESCRIPTION","","","02"
```

## Troubleshooting

Specific lines in the ADP file will be skipped if the Description  in field 7 is longer than 20 characters. Even though this field allows 30 characters in Microsoft Dynamics GP, it can't be longer than 20 characters in the file being imported as specified in the field widths above.

The below error can happen for various reasons, but one reason is that the date format in your import file isn't MMDDY or MMDDYYYY format. Make sure leading zeroes aren't missing from the MM or DD.

> "The selected import file is not a valid ADP export file."
