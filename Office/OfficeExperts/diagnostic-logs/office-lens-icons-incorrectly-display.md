---
title: Office Lens icons on Windows 10 do not display correctly
description: Explains why some Office Lens icons may not show up correctly in Windows 10 after creating private characters
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Lens
ms.date: 03/31/2022
---

# Office Lens icons on Windows 10 do not display correctly after registering private characters

## Summary

Some Office Lens icons display incorrect glyphs after you register private characters on Windows 10. 

## More information

This behavior is a limitation of Office Lens and the Universal Windows Platform (UWP) UI. It happens due to an incorrect font fallback.

Some of the Office Lens icons use the following code points with a custom font: 

**U+E000 through U+E00F, E010 through E013** 

The issue will occur if you register a private character to one of the above code points in the Private Use Area. This result will be incorrect icons displayed instead of Office Lens icons.
