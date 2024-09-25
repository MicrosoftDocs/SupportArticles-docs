---
title: Graphics::DrawImage appears slow when drawing a JPEG or PNG image to a printer
description: Provides a resolution for an issue where Graphics::DrawImage appears slow when you call it to draw a JPEG or PNG image to a printer. 
ms.reviewer: ishimada, davean, aartigoyle, v-sidong
ms.date: 12/19/2023
ms.custom: sap:Graphics and Multimedia development\GDI+ API
---

# Graphics::DrawImage with ImageAttributes is slow when drawing a PNG or JPEG image to a printer

This article provides a resolution for an issue where the `Graphics::DrawImage` method appears slow when you call it with an `ImageAttributes` object to draw a JPEG or PNG image to a printer.

## Cause

The `Graphics::DrawImage` method converts the source image to a device-independent bitmap (DIB) when you call it with an `ImageAttributes` object.

## Resolution

To solve the issue, call `Graphics::DrawImage` with the `ImageAttributes` parameter set to `NULL` unless specifying an `ImageAttributes` object is necessary.

When supported by the printer, calling `Graphics::DrawImage` with the `ImageAttributes` parameter set to `NULL` will pass the source JPEG or PNG directly to the printer.

## More information

- [Graphics::DrawImage(Image*,constPointF*,INT,REAL,REAL,REAL,REAL,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constpointf_int_real_real_real_real_unit_constimageattributes_drawimageabort_void))
- [Graphics::DrawImage(Image*,constPoint*,INT,INT,INT,INT,INT,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constpoint_int_int_int_int_int_unit_constimageattributes_drawimageabort_void))
- [Graphics::DrawImage(Image*,constRect&,INT,INT,INT,INT,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constrect__int_int_int_int_unit_constimageattributes_drawimageabort_void))
- [Graphics::DrawImage(Image*,constRectF&,REAL,REAL,REAL,REAL,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constrectf__real_real_real_real_unit_constimageattributes_drawimageabort_void))
- [ExtEscape function (wingdi.h)](/windows/win32/api/wingdi/nf-wingdi-extescape)
- [Testing a Printer for JPEG or PNG Support](/windows/win32/gdi/testing-a-printer-for-jpeg-or-png-support)
