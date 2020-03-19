---
title: Error if opening a downloaded .ZIP file with IE
description: When you open a downloaded .ZIP file by using Internet Explorer, you receive the Compressed (zipped) Folder is invalid or corrupted error. This article provides the methods to solve this issue.
ms.date: 03/16/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer: Apinho
---
# An error occurs when opening a .ZIP file with Internet Explorer 8 or a later version

This article introduces the workarounds to solve the error message that occurs after you open a downloaded .ZIP file in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 8, Internet Explorer 7, Internet Explorer 6  
_Original KB number:_ &nbsp; 2002350

## Symptoms

You download a .ZIP file from a web site by using Internet Explorer 8 or a later version. Once the .ZIP file is downloaded and saved to your local machine, you try to open the .ZIP file. At this point, the following error message is displayed:

>The Compressed (zipped) Folder is invalid or corrupted.

## Cause

This problem occurs if HTTP compression is enabled for .ZIP files on the web server that the .ZIP file is downloaded from. When HTTP compression is enabled on the web server, the .ZIP file is encoded before being sent to Internet Explorer. Once the HTTP-compressed .ZIP file is received by the client, Internet Explorer passes the .ZIP file directly to the program configured to unzip the .ZIP file without first decoding the HTTP compression.

## Workaround 1

Disable HTTP compression for .ZIP files on the web server.

> [!NOTE]
> If the web server hosting the .ZIP file is running Microsoft Internet Information Services (IIS), you can find more information about configuring HTTP compression at the following location:
>
> [Configuring HTTP Compression in IIS 7.0](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771003(v=ws.10))

## Workaround 2

Change the MIME type for .ZIP files on the web server from application/x-zip-compressed to application/octet-stream.

> [!NOTE]
> If the web server hosting the .ZIP file is running Microsoft Internet Information Services (IIS), you can find more information about configuring MIME types at the following location:
>
> [Configuring MIME types in IIS 7.0](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753281(v=ws.10))
