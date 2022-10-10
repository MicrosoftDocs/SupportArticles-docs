---
title: Converting a PDF file to a Bitmap image results in partial data loss
description: This article helps you resolve the problem of partial data loss when you convert a PDF to a Bitmap image by using the classes of the Windows.Data.Pdf namespace.
ms.date: 07/10/2022
author: shwetasohu
ms.author: v-shwetasohu
ms.custom: sap:Graphics and multimedia development
ms.reviewer: 
ms.technology: windows-dev-apps-graphics-multimedia-dev
---

# Converting a PDF file to a Bitmap image results in partial data loss

This article helps you resolve the problem of partial data loss when you convert a PDF file to a Bitmap image by the classes of the Windows.Data.Pdf namespace.

## Symptoms

Classes of the Windows.Data.Pdf namespace can cause parts of the PDF document to be missing when you convert a PDF file to a Bitmap image.
For example, if a PDF file contains a dashed line called a line dash pattern, part of the table containing the dashed line will be missing from the Bitmap image.

## Cause

The Windows.Data.Pdf namespace is implemented by using the features of previous version of Microsoft Edge.
This issue is known to occur with some PDF files, depending on implementation of previous version of Microsoft Edge.

## Workaround

If this issue occurs, you may be able to fix it by regenerating the PDF file and converting it to a bitmap image.
For the line dash pattern example given in the Symptoms section, remove dashed lines in the source file and then create the PDF file. Convert this newly created PDF file to a Bitmap image. You can also edit the PDF, save it and convert it to Bitmap. The Bitmap image is created without any loss.

If your application can be modified, consider using the same features as the new Chromium-based Microsoft Edge.
The new Microsoft Edge is implemented using the open-source PDFium, refer to https://pdfium.googlesource.com/pdfium/ for more information.
