---
title: Custom data fields for Electronic Funds Transfer (EFT) formats
description: Introduces the custom data fields for Electronic Funds formats in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# Custom data fields for Electronic Funds Transfer (EFT) formats in Microsoft Dynamics GP

This article provides information about the custom data fields for Electronic Funds Transfer (EFT) formats in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2956922

## Symptoms

Many banks are offering check printing services, CEPS programs, and other services in which a flat payment file is needed. The EFT functionality in Microsoft Dynamics GP was designed to comply with the required fields for the standard published NACHA formats. So if you try to make a custom flat file for some of these other services provided by your bank, you'll need to set up a custom format, and likely need a dexterity customization to achieve certain fields. Custom formats aren't currently support in Microsoft Dynamics GP and our case policy is listed below. Keep in mind that just because a field can be selected in a particular line in the format, doesn't necessarily mean that it was designed to work in that line.

Review the case policy for EFT configurator files in the link below. The current policy is one field or error message per support incident. However, if the functionality for that field doesn't work in the line you're trying to use it in, a dexterity customization would be needed.

[Guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement](guidelines-that-support-professionals-use.md)

## Cause

If you're trying to obtain a custom EFT format that isn't already provided in Microsoft Dynamics GP, you'll likely need a dexterity customization to achieve a custom format to make a flat file for other services offered by your bank.

## Resolution

Here are some custom fields to be aware of:

**Unique file identifier / EFT document ID:**

The Unique File Number functionality is a unique number per EFT file generated. If selected on several line types, the same number will print in each line, and increment each time a new EFT file is generated. This number is already available in Microsoft Dynamics GP by mapping the field as follows:

*EFT Next File Number:*  
Maps to: Data Field  
Table: Checkbook Electronic Funds Transfer Master  
Field: EFT Next File Number

> [!NOTE]
> The bank prenote file generated will print zeroes in this field.

**Batch ID in batch header/batch control lines:**

Microsoft Dynamics GP is designed to put all payments into a single batch in the EFT file, and this is acceptable. (Most banks don't care how many individual batch IDs were included in Microsoft Dynamics GP.) So all the batches pulled into the file will appear as one big batch in the EFT file. Therefore, you'll only see one Batch Header, and one Batch Control line per file. This is by design and is acceptable to the bank.

**Sequence number:**

This field was designed to work in the Addenda Line type only. If this field doesn't work in any other line types, you'll need to request a customization.

**Invoice numbers:**

The Invoice numbers and Amount were intended to be mapped in the Addenda Line of your format, and should be mapped as follows to pull the correct information:

*Invoice Number:*  
Maps to: Data Field  
Table: PM Apply To History File  
Field: Apply To Document Number

*Invoice Amount:*  
Maps to: Data Field  
Table: PM Apply To History File  
Field: Applied Amount (If that doesn't work, try **Apply From Apply Amount** next, and verify it's the correct amount.)

*For the invoice, you're only limited to the fields in the PM Apply to History table (PM30300), so you wouldn't be able to get such fields as the invoice description or PO field. The EFT file is set up to get to payment record information, not invoice information, other than what is available on the apply record.

**Any 'count' or 'sum' fields in header lines:**

As a general rule, any 'count' or 'sum' fields will only work in footer lines, or AFTER the lines have been listed. Therefore, most of the 'count' or 'sum' fields only work in the Batch Control and File Control footer lines, and don't work in Header or Detail lines. You'll need to test to verify.

**Number of addenda records on Detail line:**

The Addenda Count will only work in an Addenda line type, and doesn't work in a Detail, Batch Control or File Control line. The Addenda lines can only be counted after they're consecutively listed, and not before.

For example, the 'Addenda Count' won't work in a File Control header line, or the Detail payment line because the number of addenda records hasn't yet been listed. The system is unable to count or total them before they're listed. (So you wouldn't be able to fulfill this requirement of the CTX format without a dexterity customization.)

As a work-around, there's an option for 'Detail + Addenda' available in the Batch Control and File Control lines that have been accepted by most banks instead. So verify with your bank if they would accept this field instead. Another option is to generate the EFT file using 'one check per invoice' instead of 'one check per vendor'. Since you'll have one addenda line per Detail line with this option, you can then hard-code this as '1' in the Detail Line.

**Line count:**

The Line Count data field was designed to work in the File Control line and will count all lines of the file. This field doesn't work in any other line type.

For example, if you have 10 total lines in an EFT file, the Line count in the Batch Control line will list 9 because it can only list the preceding lines. The Line Count in the File Control Line will list the correct count of 10, as this field was designed to work in this line. However, the Line Count field won't work in the additional footer lines (Trailer Label 1 and Trailer Label 2) since these additional footer lines aren't part of a standard NACHA format.

**Other date formats:**

(Include dash or slash in dates to achieve MM-DD-YYYY or MM/DD/YYYY)

For a date field in the EFT file format, only Dates formats such as MMDDYYYY or DDMMYYYY are available in the drop-down list in the configurator. However, you can get around this by splitting the date field up into 'five fields' (and the bank won't know the difference as long as the date is in the positions it should be in the line). For example, make the first field a length of 2, and 'left justify' it and select MMDDYY so it grabs the MM. Then make the second field a length of 1 as a CONSTANT with your dash or slash. Then make the third field be a length of 2, 'left justify' it and select DDMMYY so it grabs the DD. The fourth field is a length of 1 again as a CONSTANT with your slash or dash. Make the last field a length of 4, 'left justify' it and select the YYYYMMDD format this time. (or a length of 2 and select YYMMDD if needed for a two digit year.)

## More information

Setting up an EFT file format falls under Advisory services but are no longer being accepted. It's best to test on your own and use the default formats in Dynamics GP as a guide, as most standard fields are listed that you would need, and GP is coded to achieve the formats we do offer. You may open a support case for assistance with one field per case.

For more information on EFT set-up, and other Frequently Asked Questions, see [Guidelines to follow when you generate EFT files or EFT prenote files in Electronic Funds Transfer for Payables Management or Receivables Management in Microsoft Dynamics GP](guidelines-generate-eft-files.md).
