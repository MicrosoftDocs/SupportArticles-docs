---
title: Print preview display is missing lines in Excel
description: Some lines are not rendered in the print preview area in Excel if print scaling is set too small when you use a PCL-based printer, an XPS printer, or any other printer except a printer that uses a PS driver.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2013
- Excel 2010
---

# Print preview display is missing lines in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Summary

Thin lines or lines at certain positions in an Excel spreadsheet are not rendered in the print preview area when the print scaling is set too small. This problem occurs when you use any printer that uses a PCL driver or when you use the Microsoft XPS Document Writer or any other XPS printer. This problem does not occur when you use a printer that uses a PostScript (PS) driver.

##  More Information

Print preview is implemented by creating and displaying a metafile. If the file has a small print scaling setting, such as less than 50 percent, thin lines, or lines at certain positions are not rendered in the print preview area. This is because the preview graphic is too small to display many lines or lines that are too thin.