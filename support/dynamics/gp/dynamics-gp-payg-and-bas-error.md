---
title: PAYG and BAS error messages in Microsoft Dynamics GP
description: Describes the Pay As You Go (PAYG) error codes and the Business Activity Statement (BAS) error codes in Microsoft Great Plains 8.0. Lists the error or warning messages of the BAS and of the PAYG vendor summaries.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# Description of Pay As You Go error messages and Business Activity Statement error messages in Microsoft Dynamics GP

This article describes the Pay As You Go (PAYG) error codes and the Business Activity Statement (BAS) error codes, and lists the error or warning messages of the BAS and of the PAYG vendor summaries.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 910984

## Introduction

When you process the Pay As You Go (PAYG) vendor summaries and the Business Activity Statement (BAS) for Australian taxation reporting in Microsoft Business Solutions - Great Plains 8.0, you may receive many error messages or warning messages.

The error messages display a red cross. The warning messages display a yellow exclamation mark. If the message is a warning, the processing code has found something incorrect that will not affect the results. If the message is an error message, the processing code has found something incorrect that will cause the results to also be incorrect.

## BAS processing error messages and warning messages  

| Error code| Message text |
|---|---|
|01|GST Processing Start Date is after the End Date|
|02|PAYG Processing Start Date is after the End Date|
|03|History Transactions excluded from GST Processing|
|04|History Transactions excluded from PAYG Processing|
|05|RM Transaction appears to come from SOP but is not found in SOP tables|
|06|RM Transaction appears to come from Invoicing but is not found in Invoicing tables|
|07|PM Transaction appears to come from POP but is not found in POP tables|
|08|RM Transaction comes from SOP but the SOP transaction is voided|
|09|RM Transaction comes from Invoicing but the Invoicing transaction is voided|
|10|PM Transaction comes from POP but the POP transaction is voided|
|11|Tax Invoice Required but not Received, overridden by BAS Option setting|
|12|Transaction contains Tax Amount but no Tax Detail information is available|
|13|POP Transaction not found in PM tables|
|14|POP Transaction found in PM tables but PM transaction is voided|
|15|POP Transaction found in PM tables but PM transaction is not from POP|
|16|SOP Transaction not found in RM tables|
|17|SOP Transaction found in RM tables but RM transaction is voided|
|18|SOP Transaction found in RM tables but RM transaction is not from SOP|
|19|Invoicing Transaction not found in RM tables|
|20|Invoicing Transaction found in RM tables but RM transaction is voided|
|21|Invoicing Transaction found in RM tables but RM transaction is not from Invoicing|
|22|GL Tax Transaction not found in GL tables|
|23|Tax Detail Total Amount is zero with a non zero Tax Detail Tax Amount (1 Field)|
|24|Tax Detail Total Amount is zero with a non zero Tax Detail Tax Amount (G Field)|
|25|Tax Detail Total Amount is zero with a non zero Tax Detail Tax Amount (W Field)|
|26|Tax Detail Taxable Amount is zero with a non zero Tax Detail Tax Amount (1 Field)|
|27|Tax Detail Taxable Amount is zero with a non zero Tax Detail Tax Amount (G Field)|
|28|Tax Detail Taxable Amount is greater than Tax Detail Total Amount (1 Field)|
|29|Tax Detail Taxable Amount is greater than Tax Detail Total Amount (G Field)|
|30|Tax Detail Total Amount is zero with a non zero Tax Detail Taxable Amount (1 Field)|
|31|Tax Detail Total Amount is zero with a non zero Tax Detail Taxable Amount (G Field)|
|32|Not Reporting using Tax Collected & Paid amounts (Manual Totaling), this mode is recommended|
|33|Calculated Transaction Total for field G6 is not equal to field G1 - field G5|
|34|Calculated Tax Total for field G6 is not equal to field G1 - field G5|
|35|Calculated Transaction Total for field G17 is not equal to field G12 - field G16|
|36|Calculated Tax Total for field G17 is not equal to field G12 - field G16|
  
## PAYG vendor summaries processing error messages and warning messages

| Error Code| Error message |
|---|---|
|1|Supplier ABN Number missing|
|2|Supplier Street Address ID missing|
|3|Supplier Street Address ID, Name missing|
|4|Supplier Street Address ID, Contact missing|
|5|Supplier Street Address ID, Phone number 1 missing|
|6|Supplier Street Address ID, Phone number 1 STD area code missing|
|7|Supplier Street Address ID, Phone number 1 does not contain 8 digits|
|8|Supplier Street Address ID, Address line 1 missing|
|9|Supplier Street Address ID, City missing|
|10|Supplier Street Address ID, State missing|
|11|Supplier Street Address ID, Postcode missing|
|12|Supplier Postal Address ID missing|
|13|Payer ABN Number missing|
|14|Payer Address ID missing|
|15|Payer Legal/Tax Name missing|
|16|Payer Address ID, Name missing (optional)|
|17|Payer Address ID, Address line 1 missing|
|18|Payer Address ID, City missing|
|19|Payer Address ID, State missing|
|20|Payer Address ID, Postcode missing|
|21|Creditor Withholding, Form Type not set, check Withholding Type is correct|
|22|Creditor Withholding, TFN Mode not set|
|23|Creditor Options, Tax File Number missing|
|24|Creditor Withholding, Individual's Date of Birth missing (optional)|
|25|Creditor Cheque Name missing|
|26|Creditor Cheque Name, Surname missing|
|27|Creditor Cheque Name, First name missing|
|28|Creditor Cheque Name, comma missing (Preferred Format: Surname, Given names)|
|29|Creditor Primary Address ID missing|
|30|Creditor Purchase Address ID missing|
|31|Creditor Remit To Address ID missing|
|32|Creditor Ship Form Address ID missing|
|33|Creditor Address, Address line 1 missing|
|34|Creditor Address, City missing|
|35|Creditor Address, State missing|
|36|Creditor Address, Postcode missing|
|37|"Creditor Total Tax Withheld is zero|
|38|Creditor Gross payments are zero|
|39|Creditor Options, ABN Number missing|
|40|Creditor Withholding, Withholding Tax Rate is missing|
|41|Creditor Withholding, Payment Type not set|
|42|Creditor Withholding, Entity Type not set|
|43|Creditor Name is missing (optional)|
|44|Creditor Address, Phone number 1 missing|
|45|Creditor Address, Phone number 1 STD area code missing|
|46|Creditor Address, Phone number 1 does not contain 8 digits|
|47|Creditor Address, State Invalid Abbreviation|
|48|Payer Address ID, State Invalid Abbreviation|
|49|Supplier Street Address ID, State Invalid Abbreviation|
|50|Supplier ABN Number Invalid|
|51|Payer ABN Number Invalid|
|52|Creditor Options, ABN Number Invalid|
|53|Creditor Options, Tax File Number Invalid|
|54|Payer WPN Number missing|
|55|Payer WPN Number Invalid|
|56|Creditor Address, Postcode does not contain 4 digits|
|57|Payer Address ID, Postcode does not contain 4 digits|
|58|Supplier Street Address ID, Postcode does not contain 4 digits|
|59|Supplier Postal Address ID, State Invalid Abbreviation|
|60|Supplier Postal Address ID, Postcode does not contain 4 digits|
