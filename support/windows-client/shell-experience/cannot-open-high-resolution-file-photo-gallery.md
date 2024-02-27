---
title: Can't open high-resolution file in Photo Gallery
description: Provides a solution to an issue where users can't open high-resolution file in Windows Photo Gallery.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
---
# Unable to open high-resolution file in Windows Photo Gallery

This article provides a solution to an issue where users can't open high-resolution file in Windows Photo Gallery.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 2725211

## Symptoms

Consider the following scenario:

- You start Windows Photo Gallery
- You select File, then choose Import From Camera or Scanner.
- You then import a high-resolution image. For example, you use a high-resolution scanner to scan a full-page document at a resolution of 1200 dpi. Alternately, you try to view a previously created image that is high resolution (such as a 1200-dpi full-page scan) using Windows Photo Gallery.

In this scenario, Windows Photo Gallery will fail to display the image, and will display the following message:

Photo Gallery can't open this picture or video. This file format is not supported, or you don't have the latest updates to Photo Gallery.

## Cause

This problem occurs because, by default, Windows Photo Gallery will not open an image file that is larger than 100 megapixels.

For example, if you scan a full 8.5x11" page using a resolution of 1200 dpi, the resulting image file will be large (approximately 136 megapixels). This exceeds the default size limit for Windows Photo Gallery.

## Resolution

To work around this issue:

When scanning an image, reduce the size of the image by scanning a smaller area (not a full page), or by using a lower resolution, such as 600 dpi or less. This will allow Windows Photo Gallery to open the scanned image successfully.

Alternately, you can override Windows Photo Gallery's image size limit by editing the registry:

1. Click Start, type regedit in the Start Search box, and then click regedit.exe in the Programs list. If you are prompted for an administrator password or for confirmation, type a valid password, or click Continue.
2. Locate and then click the following subkey in the registry:  
 `HKEY_CURRENT_USER\Software\Microsoft\Windows Photo Gallery\Viewer`  
3. Click Edit, click New, and then click DWORD (32-bit) Value.
4. Type MaximumFrameSizeMegapixels for the value name, and then press ENTER.
5. Double-click the MaximumFrameSizeMegapixels value, click Decimal, enter a new value in the Value data box, and then click OK.
6. Exit Registry Editor.
7. Restart Windows Photo Gallery. The Value data to enter is the maximum image size that Windows Photo Gallery will be able to open, in megapixels. For example, entering a value of 150 will allow Windows Photo Gallery to open files of up to 150 megapixels in size. This value would be sufficient to allow viewing of 1200 dpi full-page scans.

> [!Note]
> Entering a value of 0 will disable the image size limit. However, this is not recommended, because if Windows Photo Gallery then attempts to open a large or corrupt file, it could potentially result in a hang or crash.
