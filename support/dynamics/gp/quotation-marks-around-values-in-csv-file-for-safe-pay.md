---
title: Quotation marks around values in .csv file for Safe Pay
description: Quotation marks are appearing around each value in a field in the Safe Pay file generated as a comma-delimited (.csv) file. The bank wants only numerical values between the commas and the quotation marks removed.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
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

Safe Pay doesn't have the option to generate a comma-delimited file that doesn't have the double quotes around the fields. Quotes will be placed around the text fields. Use one of the following options to work around this issue.

### Option 1

Set up the Safe Pay configurator as a fixed length file instead, and hard-code a comma in-between each field as a constant. At this time, only the fixed length format will omit quotes on a text field. Most banks will also accept a .txt file. However, confirm the bank would accept this first. This option will take some initial time to set up the configurator file again, but then the file will generate correctly without the quotes going forward.

### Option 2

Leave the Safe Pay configurator as a comma-delimited file type. Open the file in Notepad before you send it each time. Use the Find command to find each quotation mark (") and replace it with nothing. This would require a manual edit for each file sent.

### Option 3

Pay for a customization on your own to have the quotes stripped out of the .csv file generated. Or pursue finding a third party product compatible with Dynamics GP that can achieve the file format you need.
