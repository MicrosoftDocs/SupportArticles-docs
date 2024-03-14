---
title: Payables EFT Standard ACH format
description: Introduces the Payables Management EFT Standard ACH format in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# Payables EFT Standard ACH format

This article provides a link to a Microsoft Excel spreadsheet that you can download. The spreadsheet contains an example of the Payables Management EFT Standard ACH format for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857497

Select the following Exchange link to sign into your Microsoft account and download the Excel file:

[https://mbs2.microsoft.com/fileexchange/?fileID=105da9fb-7e67-49e9-968c-b473d1a491d8](https://mbs2.microsoft.com/fileexchange/?fileID=105da9fb-7e67-49e9-968c-b473d1a491d8)

> [!NOTE]
> If the link does not work, copy it and open a new tab in your browser and paste it in and see if it works in a new browser.

## More information

The following spreadsheet outlines each section and each field of a Standard ACH Payables Management transaction file. The spreadsheet also describes where the character position of each section starts and stops. The contents column shows the field information for each associated section and row of the ACH file or the format that the section and the row must use.

The sections in the format include:

|Section|Record type code (first position of each section starts with:)|
|-|-|
|File header record |1|
|Batch header record |5|
|Detail record|6+ (see chart below for next two positions)|
|Addenda record|7|
|Settlement line|6+ (see chart below for next two positions)|
|Batch control record |8|
|File control record |9|

The next two numbers after the above record type code in the first position is usually system driven for the following:

22 - Deposit destination for a Checking Account  
23 - Prenotification for a checking credit  
24 - Zero dollar with remittance into Checking Account  
27 - Debit destined for a Checking Account  
28 - Prenotification for a checking debit  
29 - Zero dollar with remittance into Checking Account  
32 - Deposit destined for a Savings Account  
33 - Prenotifications for a Savings Credit  
34 - Zero dollar with remittance into Savings Account  
37 - Debit destined for a Savings Account  
38 - Prenotification for a Savings Debit  
39 - Zero Dollar with remittance into Savings Account

For a Payroll Direct Deposit file or Payables EFT file, the **Detail** line typically starts with a **622** for a checking account or **632** for a savings account on an actual EFT file. (or **623** or **633** in the prenote file). The system will adjust these values automatically in the EFT file for you, based on whether you marked checking or savings account on the vendor/employee, and what type of file it is (actual vs prenote), or Payables versus Receivables. So don't hard-code the 2-digit **Transaction code** value in field 2 in the EFT file format as the system will adjust these values for you when the file is generated.

And then the **Settlement** line in a Payables EFT file typically starts with a **627** to offset the detail lines above. The system will automatically adjust these codes for you.

An EFT file for Receivables would use the same codes from the chart above, but in opposite lines. (For example, **627** in detail lines and **622** in settlement line, for checking accounts in both (since we're taking money from the customer instead of paying them.)
