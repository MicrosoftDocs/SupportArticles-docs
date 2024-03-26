---
title: Cannot embed an Adobe OpenType font in an Office document
description: Describes an issue when you embed fonts in an Office document, OpenType fonts (.otf) are not embedded.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Office
ms.date: 03/31/2022
---

# You cannot embed an Adobe OpenType font in a document in an Office program

## Symptoms

When you try to embed fonts in a Microsoft Office document, Adobe OpenType fonts that have the ".otf" extension are not embedded.

## Cause

This issue occurs because the programs that are listed in the "Applies to" section do not embed fonts that have the ".otf" extension. The programs that are listed in the "Applies to" section only embed fonts that have the ".ttf" extension.

## Workaround

To work around this issue, use only fonts that have the ".ttf" extension in documents in which you intend to embed the fonts.

## More Information

The Adobe OpenType format is an extension of the TrueType SFNT format that supports Adobe PostScript font data and new typographic features. Adobe OpenType fonts that contain PostScript data have an ".otf" extension. However, TrueType-based OpenType fonts have a ".ttf" extension.

For more information about Adobe's OpenType fonts, visit the following Adobe Web site:

[https://www.adobe.com/type/opentype/index.html](https://www.adobe.com/type/opentype/index.html)

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

For more information about fonts, visit the following Microsoft Web site:

[Microsoft Typography](https://www.microsoft.com/typography/default.mspx)