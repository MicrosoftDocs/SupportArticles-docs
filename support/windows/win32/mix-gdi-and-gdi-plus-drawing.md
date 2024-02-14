---
title: Interoperability between GDI and GDI+
description: Explains how to mix GDI and GDI+ drawing operations in the same code path.
ms.date: 12/19/2023
ms.custom: sap:Graphics and multimedia development
ms.reviewer: V-JEFFBO, jhornick
ms.topic: article
ms.subservice: graphics-multimedia-dev
---
# Interoperability between GDI and GDI+

It's sometimes desirable to mix Windows Graphics Device Interface (GDI) and GDI+ drawing operations in the same code path. This article provides tips to help you write code that allows GDI and GDI+ to work together.

_Original product version:_ &nbsp; Windows Graphics Device Interface  
_Original KB number:_ &nbsp; 311221

## Summary

Certain rules apply when mixing GDI and GDI+ code. For example, you shouldn't interleave GDI and GDI+ calls on one target object. It's okay to wrap a Graphics object around an HDC, but you shouldn't access the HDC directly from GDI until the Graphics object is destroyed.

Four primary scenarios for interoperability between GDI and GDI+ are covered in this article:

- Using GDI on a GDI+ Graphics object backed by the screen
- Using GDI on a GDI+ Graphics object backed by a bitmap
- Using GDI+ on a GDI HDC
- Using GDI+ on a GDI memory `HBITMAP` (a handle to a bitmap object)

## Using GDI on a GDI+ Graphics object backed by the screen

One example of a need to use GDI on a GDI+ Graphics object backed by the screen would be to draw a rubber band or focus rectangle. GDI+ currently has no direct support for raster operations (ROPs), so GDI must be used directly if R2_XOR pen operations are required. In this case, you would use `Graphics::GetHDC()` to obtain an HDC to which the GDI output would be directed. GDI+ output shouldn't be attempted on the Graphics object for the life of the HDC (that is, until `Graphics::ReleaseHDC()` is called).

## Using GDI on a GDI+ Graphics object backed by a bitmap

When `Graphics::GetHDC()` is called for a Graphics object that is backed by a bitmap rather than the screen, a memory HDC is created and a new `HBITMAP` is created and selected into the memory HDC. This new memory bitmap isn't initialized with the original bitmap's image but rather with a sentinel pattern, which allows GDI+ to track changes to the bitmap. Any changes that are made to the memory bitmap through the use of GDI code become apparent in changes to the sentinel pattern. When `Graphics::ReleaseHDC()` is called, those changes are copied back to the original bitmap. Because the memory bitmap isn't initialized with the bitmap's image, an HDC that is obtained in this way should be considered **write only** and is therefore not suitable for use with ROPs, the use of which requires the ability to read the target, like R2_XOR. Also, there's a performance cost to this approach because GDI+ must copy the changes back to the original bitmap.

## Using GDI+ on a GDI HDC

You can facilitate the use of GDI+ on an HDC by using the Graphics constructor that takes an HDC as a parameter. The drawing members of the Graphics class can be used to draw on the HDC in this way. Once the Graphics object is attached to the HDC, no GDI operations should be performed on the HDC until the Graphics object is destroyed or goes out of scope. If GDI output is required on the HDC, either destroy the Graphics object before using the original HDC or use `Graphics::GetHDC()` to get a new HDC and then follow the rules described earlier in this article for interoperability while using GDI on a GDI+ object.

## Using GDI+ on a GDI memory HBITMAP

The GDI+ Bitmap constructor that takes an `HBITMAP` as a parameter doesn't use the actual source `HBITMAP` as the backing image for the bitmap. Rather, a copy of the image is made in the constructor, and changes aren't written back to the original bitmap, even during execution of the destructor. The new bitmap can be thought of as copy on creation, so to get GDI+ to draw on a memory `HBITMAP` from GDI and have the changes apply to the `HBITMAP`, an approach like the following is needed instead:

1. Create a `DIBSection`.
2. Select the `DIBSection` into a memory HDC.
3. To use GDI+ to draw to the `DIBSection`, wrap a Graphics object around the HDC.
4. To use GDI to draw to/from the `DIBSection`, destroy the Graphics object, and use the HDC.
5. Destroy the Graphics objects, and then clear the `DIBSection` selection from the HDC. Later, a bitmap can be constructed from the `DIBSection` and used as a source image in `Graphics::DrawImage()` if needed.
