---
title: Quotation marks around values in .csv file for Safe Pay
description: Quotation marks are appearing around each value in a field in the Safe Pay file generated as a comma-delimited (.csv) file. The bank wants only numerical values between the commas and the quotation marks removed.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Quotation marks appear around values in .csv file for Safe Pay in Microsoft Dynamics GP

This article provides options for you to solve the issue that quotation marks appear around values in .csv file for Safe Pay in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2511178

## Symptoms

Quotation marks appear around each value in a field in the Safe Pay file generated as a comma-delimited (.csv) file in Microsoft Dynamics GP. The bank wants only numerical values between the commas and the quotation marks removed.

## Cause

If the file format is set to comma-delimited, then it will put quotes around the text. This is by design.

## Workaround

Safe Pay can't generate a comma-delimited file that does not have the double quotes around the fields. Quotes will be placed around the text fields. Use one of the following options to work around this issue:

### Option 1

Set up the safepay configurator as a fixed-length file instead, and hard-code a comma in-between each field as a constant. At this time, only the fixed-length format will omit quotes on a text field. Most banks will also accept a .txt file. However, confirm this fact first. This option will take some initial time to reset up the configurator file, but then the file will generate correctly without the quotes going forward.

### Option 2

Leave the safepay configurator as a comma-delimited file type. Open the file before you send it each time. Use the Find command to find each quotation mark (") and replace it with nothing. This would require a manual edit for each file sent.

### Option 3

Pay for a customization to have the quotes stripped out of the .csv file generated. If you want to pursue this option, open a support case or call 1-888-477-7877 to reach Customer Service. This service would be a billable consulting expense to you.
