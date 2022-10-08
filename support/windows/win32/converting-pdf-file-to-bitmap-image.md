---
title: Converting PDF file to Bitmap image misses part of the image
description: This article discusses a problem when Converting PDF file to Bitmap image by the classes of the Windows.Data.Pdf namespace misses part of the image.
ms.date: 07/10/2022
author: shwetasohu
ms.author: v-shwetasohu
ms.custom: sap:Graphics and multimedia development
ms.reviewer: 
ms.technology: windows-dev-apps-graphics-multimedia-dev
---

# Converting PDF file to Bitmap image misses part of the image

This article helps you resolve the problem when converting PDF file to Bitmap image by the classes of the Windows.Data.Pdf namespace misses part of the image.

# Symptoms

Classes of the Windows.Data.Pdf namespace can cause parts of the PDF document to be missing when you convert a PDF file to a Bitmap image.
For example, if a PDF file contains a dashed line called a 'line dash pattern', part of the table containing the dashed line will be missing from the Bitmap image.

# Cause

The Windows.Data.Pdf namespace is implemented through features of previous Microsoft Edge.
This issue is known to occur with some PDF files, depending on implementations of previous Microsoft Edge.

# Workaround

If this issue occurs, you may be able to fix it by changing the PDF file and recreating the bitmap image.
For the line dash pattern described in the example, edit the PDF file to remove dashed lines before creating the PDF file.
If you create a Bitmap image again from a PDF file that does not contain dashed lines, the expected Bitmap image is created.

If your application can be modified, consider using the same features as the new Chromium-based Microsoft Edge.
The new Microsoft Edge is implemented using the open source PDFium, so please refer to the following site for more information:
https://pdfium.googlesource.com/pdfium/