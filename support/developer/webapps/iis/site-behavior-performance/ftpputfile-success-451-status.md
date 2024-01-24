---
title: FtpPutFile always returns success
description: This article provides resolutions for the problem where the WinInet FtpPutFile returns TRUE even when the operation fails with 451 status.
ms.date: 03/23/2020
ms.custom: sap:Site behavior and performance
ms.technology: site-behavior-performance
---
# WinINet FtpPutFile returns success when 451 status is returned

This article helps you resolve the problem where the Windows Internet (WinINet) `FtpPutFile` function still returns **TRUE** even when the operation fails with the 451 status.

_Original product version:_ &nbsp; Internet Explorer 10, 9  
_Original KB number:_ &nbsp; 2790777

## Symptoms

The *Wininet.dll* `FtpPutFile` API returns **TRUE** even when the operation fails with the following status:

> 451 - Requested action aborted: local error in processing.

The sequence of events leading up to this result is similar to the following:

> FTP:Response to Port 28376, '230 Login successful.'  
> FTP:Response to Port 28376, '200 Switching to ASCII mode.'  
> FTP:Request from Port 28376, 'PASV'  
> FTP:Response to Port 28376, '227 Entering Passive Mode (192,168,0,99,213,154).'  
> FTP:Request from Port 28376,'STOR myTesting.txt'  
> FTP:Response to Port 28376, '150 Ok to send data.'  
> (Now data is sent to 192,168,0,99 with port 256x213+154 = 54682)  
> FTP:Response to Port 28376, '451 Failure writing to local file.'

## Cause

The WinINet `FtpPutFile` function (including both `FtpPutFileA` and `FtpPutFileW`) reports the status code as **TRUE** even though the internal WinINet implementation of `FtpPutFile` function already captured the
**451 Failure writing to local file** error response from the server.

## Workaround

To work around this issue, check the return status code of `FtpPutFile` instead of relying on the API returning **False**. To achieve this, you can use the `InternetGetLastResponseInfo()` function to check the Server-Response.

> [!NOTE]
> The FTP protocol can return additional text information along with most errors. This extended error information can be retrieved by using the `InternetGetLastResponseInfo` function.
