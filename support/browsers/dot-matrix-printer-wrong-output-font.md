---
title: Wrong output font if using dot matrix printer via IE 8
description: When you print to a dot matrix printer like Epson LX-300+II via IE8 on Windows XP or Windows 7, the output font gets larger or smaller than real size, and characters are overlapped sometimes. There's no problem if using IE6/7 or not using Dot Matrix Printer to print.
ms.prod-support-area-path: Internet Explorer 8
ms.date: 02/14/2020
---
# Printing to a dot matrix printer from Internet Explorer 8 results in malformed characters 

_Original product version:_ &nbsp; Internet Explorer 8  
_Original KB number:_ &nbsp; 2543597

When you print to a dot matrix printer like Epson LX-300+II via IE8 on Windows XP or Windows 7, the output font gets larger or smaller than real size, and characters are overlapped sometimes. There's no problem if using Internet Explorer 6, Internet Explorer 7 or not using Dot Matrix Printer to print.

## Symptoms

When you print to a dot matrix printer from Internet Explorer 8 on Windows XP or Windows 7, the output font in the printout isn't the correct size. Additionally, printed characters may overlap adjacent characters. This problem does not exist when printing to a dot matrix printer from Internet Explorer 6 or Internet Explorer 7. In addition, this issue does not occur when printing from Internet Explorer 8 to a printer that is not dot matrix.

## Workaround

To work around this problem, choose one of the following options:  

1. Use Internet Explorer 7 to print from instead of Internet Explorer 8. 
2. Set your printer resolution as used by Internet Explorer 8 to a square aspect (equal horizontal and vertical) if that option is available. If it is not, pick a resolution where the difference between the horizontal and vertical is not extreme, and preferably one where the horizontal is 
greater than the vertical. You can do this setting on a per-job basis, or do this setting as the printer defaults once by following these steps:
   1. Open the Printers Control Panel.
   2. Right-click the dot-matrix printer.
   3. Select **Printing Preferences…**.
   4. Click the **Advanced** button.
   5. Under **Graphic**, click **Print Quality**.
   6. Select from the resolutions available for your printer. Choose a square resolution if it's available, or the closest available to square to minimize the problem described in this article.
3. Instead of printing from Internet Explorer, save the web page to disk and then open it in Microsoft Word. Then, print from Microsoft Word using a view other than Web view, such as Page View or Normal View.
