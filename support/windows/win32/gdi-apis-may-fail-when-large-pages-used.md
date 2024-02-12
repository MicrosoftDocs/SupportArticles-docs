---
title: GDI APIs may fail when large pages are used
description: This article describes that GDI APIs fails when large pages or VAD spanning are used.
ms.date: 01/29/2021
ms.custom: sap:Graphics and Multimedia development
ms.reviewer: roriddle, daleche
ms.subservice: graphics-multimedia-dev
---
# GDI APIs fail when large pages or VAD spanning are used

This article introduces that GDI APIs fails when large pages or Virtual Address Descriptors (VAD) spanning are used.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 4567569

When large page sizes are configured for virtual memory allocations and/or when buffers spanning multiple VAD are passed to the GDI APIs listed below, the function calls fail.

> [!NOTE]
> VAD-spanning can occur if memory management facilities such as heap managers and/or garbage collectors request contiguous virtual address ranges(each of which has its own VAD), but attempts to use them as a single block of memory.

- [SetDIBitsToDevice function](/windows/win32/api/wingdi/nf-wingdi-setdibitstodevice)
- [StretchDIBits function](/windows/win32/api/wingdi/nf-wingdi-stretchdibits)
- [GetBitmapBits function](/windows/win32/api/wingdi/nf-wingdi-getbitmapbits)
- [CreateDIBitmap function](/windows/win32/api/wingdi/nf-wingdi-createdibitmap)
- [CreateDIBSection function](/windows/win32/api/wingdi/nf-wingdi-createdibsection)
- [PolyDraw function](/windows/win32/api/wingdi/nf-wingdi-polydraw)
- [DrawEscape function](/windows/win32/api/wingdi/nf-wingdi-drawescape)
- [CreateBitmap function](/windows/win32/api/wingdi/nf-wingdi-createbitmap)
- [SetBitmapBits function](/windows/win32/api/wingdi/nf-wingdi-setbitmapbits)
- [GetDIBits function](/windows/win32/api/wingdi/nf-wingdi-getdibits)
