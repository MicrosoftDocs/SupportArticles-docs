---
title: Excel worksheet is printed at a different size
description: Describes a problem that may occur when you print a worksheet in Excel. The worksheet may be resized. To avoid this problem, make sure that the printer contains paper size that you selected in the printer's printing preferences.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
- Microsoft Office Excel 2002
---

# A worksheet is printed at a different size than you expect when printing the worksheet in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you print a Microsoft Excel worksheet, the printed text may appear to be a slightly different size than expected. The number of rows printed per page may not be the same as expected, or the margins may not appear to be the same width that you set.

## Cause

This behavior can occur because Excel automatically detects the size of the paper that is in the printer, by reading the paper size selection in the printer driver.

Excel can detect whether the printer contains A4-sized paper or letter-sized paper by reading the settings from the printer driver. When you print a worksheet, if the paper size stated by the printer driver does not match the paper size that is actually in the printer, Excel adjusts the printer output to match the reported paper size. The printed worksheet appears differently than in Print Preview.

## Resolution

To resolve this behavior, check the paper size in the printer properties, and then ensure that the printer actually contains paper of that size. Because Excel determines the paper size in the printer by reading the settings in the printer driver, it is very important that the paper size settings in the printer driver match the actual size of the paper that the printer is using.

## More Information

To view the selected paper size in the printer properties, follow these steps:

1. Click Start, point to Settings, and then click Printers.

   > [!NOTE]
   > On a computer that is running Windows Vista, click **Start**, click **Control Panel**, and then click **Printers**.

2. In the Printers dialog box, right-click the printer that you want.
3. On the shortcut menu, click Printing Preferences.
4. On the Paper/Quality tab, click Advanced, and then note the paper size that is selected.

To select or clear the automatic worksheet resizing option, follow these steps, as appropriate for the version of Excel that you are running.

### Microsoft Excel 2002 or Microsoft Office Excel 2003

1. On the Tools menu, click Options.
2. In the Options dialog box, click the International tab.
3. Under Printing, click to select or to clear the **Allow A4/Letter paper resizing** check box, and then click OK.

### Microsoft Office Excel 2007

1. Click the **Microsoft Office Button**, and then click **Excel Options**.
2. Click the the **Advanced** tab.
3. Under the **General** section, click to select or to clear the **Scale content to A4 or 8.5x11" paper sizes** check box, and then click **OK**.