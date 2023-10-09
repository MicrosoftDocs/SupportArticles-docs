---
title: Graphics::DrawImage appears slow when drawing a JPEG or PNG to a printer
description: Provides a resolution for an issue where Graphics::DrawImage appears slow when drawing a JPEG or PNG image to a printer. 
ms.reviewer: ishimada, v-sidong
ms.date: 10/09/2023
---
# Graphics::DrawImage with an ImageAttributes is slow when drawing a PNG or JPEG to a printer

This article provides a resolution for an issue where calling the `Graphics::DrawImage` method appears slow when drawing a JPEG or PNG to a printer. This issue occurs when `DrawImage` is called with a pointer to an `ImageAttributes` object.

## Cause

The `Graphics::DrawImage` method converts the source image to Device Independent Bitmap (DIB) when you call it with an `ImageAttributes` object.

## Resolution

Call `Graphics::DrawImage` with the `ImageAttributes` parameter set to `NULL`, unless specifying an `ImageAttributes` object is necessary.

When supported by the printer, calling `Graphics::DrawImage` with the `ImageAttributes` parameter set to `NULL` will pass the source JPEG or PNG directly to the printer.

## More Information

- [Graphics::DrawImage(Image*,constPointF*,INT,REAL,REAL,REAL,REAL,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constpointf_int_real_real_real_real_unit_constimageattributes_drawimageabort_void))
- [Graphics::DrawImage(Image*,constPoint*,INT,INT,INT,INT,INT,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constpoint_int_int_int_int_int_unit_constimageattributes_drawimageabort_void))
- [Graphics::DrawImage(Image*,constRect&,INT,INT,INT,INT,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constrect__int_int_int_int_unit_constimageattributes_drawimageabort_void))
- [Graphics::DrawImage(Image*,constRectF&,REAL,REAL,REAL,REAL,Unit,constImageAttributes*,DrawImageAbort,VOID*) method (gdiplusgraphics.h)](/windows/win32/api/gdiplusgraphics/nf-gdiplusgraphics-graphics-drawimage(image_constrectf__real_real_real_real_unit_constimageattributes_drawimageabort_void))
- [https://learn.microsoft.com/en-us/windows/win32/api/wingdi/nf-wingdi-extescape](/windows/win32/api/wingdi/nf-wingdi-extescape)
- [https://learn.microsoft.com/en-us/windows/win32/gdi/testing-a-printer-for-jpeg-or-png-support](/windows/win32/gdi/testing-a-printer-for-jpeg-or-png-support)
