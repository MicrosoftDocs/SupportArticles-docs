---
title: Converting PDF to bitmap causes partial data loss in the image
description: This article helps you resolve the problem of partial data loss when you convert a PDF to a Bitmap image by using the classes of the Windows.Data.Pdf namespace.
ms.date: 10/14/2022
ms.custom: sap:Graphics and multimedia development
ms.reviewer: hiroakii, v-jayaramanp
ms.technology: windows-dev-apps-graphics-multimedia-dev
---

# Converting PDF to bitmap causes partial data loss in the image

This article helps you resolve a problem that causes a partial loss of image data when you convert a PDF file to a bitmap image by using Windows.Data.Pdf.

## Symptoms

Parts of a PDF document are missing after you convert the PDF file to a bitmap image by using the classes of the [Windows.Data.Pdf namespace](/uwp/api/windows.data.pdf?view=winrt-22621&preserve-view=true). For example, if a PDF file contains a dashed line (also known as a line dash pattern), part of the table that contains the dashed line will be missing from the bitmap image.

## Cause

The Windows.Data.Pdf namespace is implemented by using features of Microsoft Edge Legacy.
This problem is known to affect some PDF files, depending on the implementation of Microsoft Edge Legacy.

## Workaround

If this problem occurs, you might be able to fix it by regenerating the PDF file to eliminate any elements that seem to cause the data loss. For the line dash pattern example given in the "Symptoms" section above, remove the dashed lines in the source file before you create the PDF file, and then try again to convert the PDF file to a bitmap image.
If your application can be modified, consider using the same features as the new Chromium-based Microsoft Edge. The new Microsoft Edge is implemented by using the open source [PDFium](https://pdfium.googlesource.com/pdfium/) library.