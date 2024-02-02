---
title: PNG images don't print correctly in Word 2010 after the system display scaling setting is changed in Windows 7
description: Discusses an issue in which PNG images don't print correctly in Word 2010 after the scaling setting for the system display is changed in Windows 7. Provides a workaround.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:errors-and-troubleshooting:-print-output-or-print-failures, csstroubleshoot
---
# PNG images don't print correctly in Word 2010 after the system display scaling setting is changed in Windows 7

This article discusses an issue in which PNG images don't print correctly in Word 2010 after the scaling setting for the system display is changed in Windows 7.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3101023

## Symptoms

Consider the following scenario:

- You have a Windows 7-based computer that has Microsoft Word 2010 installed.
- You have a Word document that contains a PNG image.
- In Control Panel, you change the Windows display scaling from the default setting of **Smaller - 100% (default)**  to **Medium - 125%**.
- In Word, you print the document to an XPS-based printer driver.

After you print the Word document, you notice that the edges of PNG image are cut off on the printout.

## Cause

This issue may occur because the PNG image doesn't contain the pHYs (physical pixel dimensions) chunk to specify the size of each pixel in the image.

## Workaround

To work around this issue, follow these steps:

1. Start Word 2010.
2. Right-click the PNG image, and then click **Format picture**.
3. Change any of the **Sharpen and Soften** or **Brightness and Contrast** slider settings.
4. Click **Close**  to save the changes.
5. Right-click the PNG image again, and then revert the slider settings to their original positions.
6. Click **Close**  to save the changes.

This change in the image settings adds the pHYs chunk to the PNG image and enables it to print correctly.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
