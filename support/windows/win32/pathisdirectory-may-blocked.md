---
title: PathIsDirectory may be blocked when called by a UNC server
description: This article provides resolutions for problem where the PathIsDirectory function may be blocked when it is called by applications that use a UNC server name that has a trailing backslash.
ms.date: 01/29/2021
ms.prod-support-area-path: Developer Tools\Windows SDK\Windows SDK for Windows 10
ms.reviewer: davean
---
# PathIsDirectory function may be blocked when called by using a UNC server name with a trailing backslash

This article helps you resolve the problem where the `PathIsDirectory` function may be blocked when it is called by applications that use a UNC server name that has a trailing backslash.

_Original product version:_ &nbsp; Windows SDK for Windows 10  
_Original KB number:_ &nbsp; 4525162

## Symptoms

Applications that call the `PathIsDirectory` function may block the calling thread for up to two minutes when they make the call by using a Universal Naming Convention (UNC) server name that has a trailing backslash, for example: `\\servername\`.

## Cause

An application that is blocking a calling thread in a `PathIsDirectory` call may have a call stack that resembles the following:

> 0:000> kn  
 # Child-SP          RetAddr           Call Site  
00 0000006f`3b59f108 00007ffc`94f48ba3 ntdll!ZwWaitForSingleObject+0x14  
01 0000006f`3b59f110 00007ffc`8eebb303 KERNELBASE!WaitForSingleObjectEx+0x93  
02 (Inline Function) --------`-------- WINHTTP!HTTP_USER_REQUEST::_HandleSyncPending+0x2d  
03 0000006f`3b59f1b0 00007ffc`8eec9a85 WINHTTP!HTTP_USER_REQUEST::SendRequest+0x3f3  
04 0000006f`3b59f2b0 00007ffc`8afff4fe WINHTTP!WinHttpSendRequest+0x585  
05 0000006f`3b59f410 00007ffc`8b000135 davclnt!DavDoesServerDoDav+0x4ba  
06 0000006f`3b59f4f0 00007ffc`8affc2fa davclnt!DavShouldStartWebclientService+0x2f9  
07 0000006f`3b59f570 00007ffc`70b8e851 davclnt!NPGetResourceInformation+0x23a  
08 0000006f`3b59f610 00007ffc`70b8c7d5 MPR!CGetResourceInformation::TestProvider+0x21  
09 0000006f`3b59f650 00007ffc`70b8c9fd MPR!CRoutedOperation::GetResult+0x135  
0a 0000006f`3b59f6d0 00007ffc`70b8ca69 MPR!CMprOperation::Perform+0x4d  
0b 0000006f`3b59f710 00007ffc`70b8e9bf MPR!CRoutedOperation::Perform+0x29  
0c 0000006f`3b59f740 00007ffc`956ed27c MPR!WNetGetResourceInformationW+0x4f  
0d 0000006f`3b59f7d0 00007ff7`226f292e SHLWAPI!PathIsDirectoryW+0x60fc

This occurs when the `WNetGetResourceInformation` function is called to obtain information about the specified server. In this call stack, the Web DAV network provider DLL (DAVCLNT.DLL) blocks the calling thread while it waits for the specified server to respond to an HTTP request. This operation may take up to two minutes to time out. The calling thread will be blocked until the server responds to the HTTP request or until the request times out.

## Resolution

Applications can avoid this scenario if you remove the trailing backslash in the UNC name before **PathIsDirectory** is called, as this: `\\servername`.

Alternatively, to avoid the delay in the HTTP request that is made by the Web DAV network provider, either disable the WebClient service or configure the service to start automatically.
