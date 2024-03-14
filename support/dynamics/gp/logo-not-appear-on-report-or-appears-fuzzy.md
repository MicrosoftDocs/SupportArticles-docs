---
title: Logo doesn't appear on report or appears fuzzy in Microsoft Dynamics GP
description: Provides steps to review why user is unable to add a logo to a report writer report.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Logo does not appear on report or appears fuzzy in Microsoft Dynamics GP

This article provides a solution to an issue where the logo doesn't appear or it appears fuzzy when you add a logo to a report by using Report Writer.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850524

## Symptoms

You are trying to add a logo to a report using Report Writer, but the logo is not appearing or it appears fuzzy.

## Resolution

Graphic logos should print similarly to how they would print from Paint. Microsoft Word is not an accurate comparison as it uses a different method for graphics and prints graphics better.

Here are the general rules for graphic logos:

1. Logos should be no larger than 32 KB.
2. Logos should be a bitmap. (Microsoft Dynamics GP should print the same as Paint).
3. If possible, use a postscript (pscript) or pcl6 printer driver to print graphics.
4. If using a pcl5 driver or a non-postscript inkjet driver, change the picture to 16 colors or black &amp; white in Paint.
5. Bring the logo into Report Writer as the size needed or larger and then reduce the size as necessary in Report Writer. If the picture size is increased in Report Writer, the picture dots will only become enlarged and thus the clarity of the picture is compromised.

For the most part, Microsoft Dynamics GP prints like Paint. The exception is pictures with shading or lots of colors on pcl5 based or non-graphic print drivers. For some reason, shading and 256 colors aren't handled well with those drivers and the picture is changed to Black and White only. This causes the picture to appear blotchy and all the shading is lost.
