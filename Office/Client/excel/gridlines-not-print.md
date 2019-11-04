---
title: Gridlines not printing in Excel
description: Describes an issue where Excel doesn't print the gridlines. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2016
- Excel 2013
- Excel 2010
- Excel 2007
---

# Gridlines not printing as expected in Excel

## Symptoms

When printing a workbook or worksheet, and gridlines are set to print, Excel is not printing the gridlines as expected.

## Cause

This is seen in the following scenario:

The default printer driver with a Universal Printer Driver connected to a printer that is capable and set to a high resolution setting (e.g. 1200 dpi).

AND

The workbook is printed and saved with these print settings.

AND

From the same system, or another system, using the same Universal Printer Driver, but connected to a different printer, which has a lower resolution capability (e.g. 600 dpi) the workbook is then printed to this printer.

## Resolution

Option 1: Prior to printing the workbook or worksheet, open the printing preferences, and select the printer properties option. Within the printer properties, set the print quality to 600 dpi, and save the file to retain the 600 dpi setting for future printing.

Option 2: Install and load the model-specific driver for the printer rather than the Universal Printer Driver. (Example: When printing from an HP Laserjet 4020, install and use the Laserjet 4020 printer driver, not the Universal Printer Driver)

Option 3: Print to a printer that is 1200 dpi capable if using a Universal Printer Driver (e.g. HP LaserJet 9040). 

## More Information

Microsoft is aware of this issue. When saving the file, Excel stores printer related information within the workbook.  This cached information is then compared to the client’s default printer information when the workbook is printed.  If the information is different, Excel will use the client’s default printer information.  

However, in the scenario described above, since the same Universal Printer Driver is being used in both cases, Excel does not consider the lower resolution printer to be different, and as such uses the cached information when printing the workbook.  This results in the workbook being printed at a higher resolution than the printer supports and this leads to the issue described within the Symptoms section.
