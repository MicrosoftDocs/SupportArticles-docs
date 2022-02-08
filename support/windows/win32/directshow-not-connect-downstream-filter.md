---
title: DirectShow can't connect to downstream filter
description: DirectShow filter does not connect to the downstream filter on Windows 8 and Windows 7 SP1 after installing KB 2670838.
ms.date: 03/16/2020
ms.custom: sap:Graphics and multimedia development
ms.reviewer: dbristol
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# DirectShow filter does not connect to the downstream filter on Windows 8 and Windows 7 SP1 with KB 2670838

This article helps you resolve the problem where the DirectShow filter will not connect to the downstream filter after you install [KB 2670838](https://support.microsoft.com/help/2670838) on Windows 8 or Windows 7 SP1.

_Original product version:_ &nbsp; Windows 8, Windows 7  
_Original KB number:_ &nbsp; 2841589

## Symptoms

You are using a DirectShow filter that does not connect to a downstream filter on Windows 8 and Windows 7 SP1 after installing [KB 2670838](https://support.microsoft.com/help/2670838). Before installing KB 2670838, this problem did not occur on Windows 7 SP1.

When calling the `CBasePin.ReceiveConnection` function, the value that is returned is `VFW_E_INVALIDMEDIATYPE (0x80040200)`.

## Cause

New checks for video media types have been added to the DirectShow base class on Windows 8. These checks may reject incorrect or unknown media types. These checks are added to protect systems from buffer overflows and buffer overruns exploitation.

## Resolution

The following are recommendations that can help ensure your code passes the new security checks:

- Verify `AM_MEDIA_TYPE` structure for invalid values. This structure describes the format of a media sample.
- When calling `CMediaType.AllocFormatBuffer` to allocate memory for the format block, make sure you are passing correct size required for the format block.

    > [!NOTE]
    > this method updates the `cbFormat` and `pbFormat` members of the `AM_MEDIA_TYPE structure`.

- Verify `BITMAPINFOHEADER` structure for invalid values.
- Make sure `biSize` is equal to `sizeof(BITMAPINFOHEADER)`.
- Verify `biSizeImage` for bad value (that is, > 0x40000000).
- Verify `biClrUsed` for bad value (that is, > 256).

## Steps to reproduce the problem using GraphEdit

GraphEdit is available in the Microsoft Windows Software Development Kit (SDK).

1. Go to **Bin** folder of the Windows SDK and run graphedt.exe.
1. From the **Graph** menu, click **Insert Filters**. A dialog box appears with a list of the filters on your system, organized by filter category.
1. Find your filter under the appropriate category (found under **DirectShow Filters** category) and click on **Insert Filter** button. If your filter is not a source filter, then make sure you have added required source filter for it.
1. Insert the required downstream filter.
1. After you have added the filters, you can connect two filters by dragging the mouse from one filter's output pin to another filter's input pin. If the pins accept the connection, GraphEdit draws an arrow connecting them. Try this for your filter with the downstream filter. You will see

    - Input pin and output pin will connect without any error on Windows 7 SP1.
    - GraphEdit will show you error message on Windows 8 and Windows 7 SP1 with KB 2670838 installed. Terms used in this article:

## More information

Terms that are used in this article:

- Buffer Overflow

    A buffer overflow occurs when we try to fit more data into a buffer than was allocated. A buffer overflow can be used to execute malicious code in a system.
- Buffer Overruns

    A buffer overrun is caused by treating unchecked, external input as trustworthy data. The act of copying this data, using operations such as `CopyMemory`, `strcat`, `strcpy`, or `wcscpy`, can create unanticipated results, which allows for system corruption.

Related links:

- [CBasePin.ReceiveConnection method](/windows/win32/directshow/cbasepin-receiveconnection)

- [CMediaType class](/windows/win32/directshow/cmediatype)

- [CMediaType.AllocFormatBuffer method](/windows/win32/directshow/cmediatype-allocformatbuffer)

- [AM_MEDIA_TYPE structure](/windows/win32/api/strmif/ns-strmif-am_media_type)

- [BITMAPINFOHEADER structure](/previous-versions/dd183376(v=vs.85))

- [Using GraphEdit](/windows/win32/directshow/using-graphedit)
