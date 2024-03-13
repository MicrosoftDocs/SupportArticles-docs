---
title: Multiple addenda lines in the EFT file
description: Provides a solution to an issue where multiple addenda lines in the EFT file in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Multiple addenda lines in the EFT file in Microsoft Dynamics GP

This article provides a solution to an issue where multiple addenda lines in the EFT file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2551488

## Symptoms

Consider the following scenario:

The Select Checks process is built with the option **One Check Per Vendor** in Microsoft Dynamics GP, and addenda records are turned on in the EFT file format. In this scenario, only one addenda record prints in the EFT output file generated.

## Cause

Microsoft Dynamics GP 10. 0 - It's by design to have 0 or 1 addenda record. The US NACHA PPD+ and CCD+ file formats only allow **1** addenda row per US NACHA rules, whatever if the Select Checks process was built with **one check per vendor** or **one check per invoice**.

Microsoft Dynamics GP 2010 RTM & SP1 - You have the option for 0 or ALL addenda lines.

Microsoft Dynamics GP 2010, SP2 (11.00.1752), and Microsoft Dynamics GP 2013 - In Service Pack 2 of Microsoft Dynamics GP 2010, another functionality was added to choose if you want 0, 1 or ALL (multiple) addenda records on the PPD or CCD file formats. A new checkbox in the EFT File Format Maintenance window called Detail Line Addenda was added. Mark this option to include all addenda lines with the detail line in the EFT file. If this option is unmarked, only one addenda line for the detail line will be included in the EFT file.

## Resolution

For multiple addenda records added to the EFT file format, follow the resolution below for the appropriate version:

Microsoft Dynamics GP 10.0 - Multiple addenda records isn't supported in Microsoft Dynamics GP 10.0. The workaround to report all invoice numbers to the bank in the EFT file is to build the checkrun with the option one check per invoice, since each detail line only allows one addenda record in this version. Otherwise, upgrade to Microsoft Dynamics GP 2010 to get the functionality for multiple addenda records per payment.

Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 2013 - In the EFT file format window, mark the option for Detail Line Addenda. This option will include all the addenda records that make up the payment.

## More information

The standard EFT file formats are published by the National Automated Clearing House Association (NACHA) and used by most banks. The PPD and CCD file formats are explained below. The + next to the file format indicates that the addenda row is also mapped.

PPD - Prearranged Payment and Deposit

- This format is used for Corporate debits or credits to Individual accounts. Typically this format only allows one addenda record.

CCD - Corporate Credit or Debit

- This format is used for payments between unrelated corporate entities. Typically this format only allows one addenda record.

CTX

- This format is used when the information is accompanied by multiple addendum information.

A calculation field for Detail+Addenda Count was added to Microsoft Dynamics GP 10.0 SP3 for the Batch Control line, and a quality issue #53695 on this field was fixed in SP4 so the Addenda Count and Detail+Addenda Count show consistency. It isn't an issue in Microsoft Dynamics GP 2010.
