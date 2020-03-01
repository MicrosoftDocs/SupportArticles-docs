---
title: Wrong output font if using dot-matrix printer via IE 8
description: When you print to a dot-matrix printer like Epson LX-300+II via IE8 on Windows XP or Windows 7, the output font gets larger or smaller than real size, and characters are overlapped sometimes. There's no problem if using IE6/7 or not using dot-matrix printer to print.
ms.prod-support-area-path: Internet Explorer 8
ms.date: 02/29/2020
---
# Printing to a dot-matrix printer from Internet Explorer 8 results in malformed characters

This article discusses flaws in printouts from dot-matrix printers, when printing with Internet Explorer 8 (IE8). Sometimes the font size is incorrect, and sometimes characters overlap.

[!INCLUDE[Visual eye catcher for legacy KB](../includes/kb-letters-blue.md)]
_Original product version:_ &nbsp; Internet Explorer 8  
_Original KB number:_ &nbsp; 2543597

## Symptoms

The font _size_ on a printout is sometimes either too large or too small when all the following are true:

- You print to a dot-matrix printer.
- You print using IE8.
- You are on Windows XP or Windows 7.

The font size can be too large or too small.

Additionally, _overlap_ between adjacent characters might exist. However, this overlap problem does not exist when printing to a dot-matrix printer from the earlier versions IE7 and IE6. Nor does any overlap occur with printers that are not dot-matrix, even when IE8 is used.

One dot-matrix printer model that IE8 has this inter-operation problem with is Epson LX-300+II.

## Workarounds

To work around this problem, choose one of the following options:

&nbsp;

- Use Internet Explorer 7 to print from instead of Internet Explorer 8.

&nbsp;

- Set your printer resolution to a square aspect ratio, if that option is available. If the square option is not available, choose a resolution that has a horizontal resolution that is slightly greater than the vertical resolution.

    You can configure these settings repeatedly on a per-job basis. Or you can configure these settings one time, as the default, by following these steps:

   1. Open the Printers Control Panel.

   2. Right-click the dot-matrix printer.

   3. Select **Printing Preferences...**.

   4. Click the **Advanced** button.

   5. Under **Graphic**, click **Print Quality**.

   6. Select from the resolutions available for your printer. Choose a square resolution if it's available, or the closest available to square to minimize the problem described in this article.

&nbsp;

- Instead of printing from Internet Explorer, print from Microsoft Word by using the following steps:

   1. Use IE8 to save the web page to your hard drive.

   2. Open the file in Microsoft Word.

   3. Print from Microsoft Word. Use a view other than Web view, such as Page View or Normal View.
