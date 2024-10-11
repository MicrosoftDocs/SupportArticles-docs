---
title: ReadFromStream() returns Access Denied
description: "Describes that Access Denied error occurs when your application uses CComVariant::ReadFromStream() to read data from a stream."
ms.date: 04/27/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: prabhatt
---
# CComVariant::ReadFromStream() returns an error (Access Denied) for stream > 1 MB

This article helps you resolve the problem that an error (Access Denied) occurs when your application uses `CComVariant::ReadFromStream()` to read data from a stream.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 2831480

## Symptoms

You have developed an application that uses `CComVariant::ReadFromStream()` to read data from a stream and it returns an error message (Access Denied) for stream size > 1 MB.

## Cause

Reviewing *atlcomcli.h* we find that the size has been set here:  

```cpp
#ifndef _ATL_STREAM_MAX_SIZE
#define _ATL_STREAM_MAX_SIZE0x100000
#endif
```  

and if the size of the stream increases the MAX length it should throw an Access Denied error.  

```cpp
else if (cbStrLen > _ATL_STREAM_MAX_SIZE)
{
    ATLTRACE(atlTraceCOM, 0, _T('String exceeded the maximum allowed size see _ATL_STREAM_MAX_SIZE.'));
    hr = E_ACCESSDENIED;
}
```

## Resolution

If you have valid scenario where you are streaming data as Batch Stirred Tank Reactor (BSTR) that is larger than the predefined size you can change it. However, if you are using any untrusted code this workaround should not be employed.

One approach would be to override `CCOmVariant::ReadFromStream()`.
Another way is to change `_ATL_STREAM_MAX_SIZE` itself.

## More information

We are reading from a stream and the stream can be from untrusted source. The MAX value is there to catch any issues with streams that have been manipulated to try the code to allocate huge number of memory causing DOS attacks.

- [Inside the Active Template Library (ATL) Security Update](https://channel9.msdn.com/Blogs/Charles/Out-of-Band-Inside-the-ATL-Security-Update)  

- [Active Template Library Security Update for Developers](/previous-versions/ee309358(v=msdn.10))
