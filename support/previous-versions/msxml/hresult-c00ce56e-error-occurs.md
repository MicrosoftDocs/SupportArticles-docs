---
title: HRESULT C00CE56E error occurs
description: This article provides resolutions for HRESULT C00CE56E 'System Does Not Support the Specified Encoding' error message with MSXML.
ms.date: 10/15/2020
ms.prod-support-area-path: 
ms.reviewer: JAYALLEN
ms.prod: .net
---
# HRESULT C00CE56E 'System Does Not Support the Specified Encoding' error message with MSXML

This article helps you resolve the problem that HRESULT C00CE56E `System Does Not Support the Specified Encoding` error message with MSXML.

_Original product version:_ &nbsp; Microsoft XML  
_Original KB number:_ &nbsp; 304625

## Symptoms

When you load a remote XML document from a Web server by using either XMLHTTP or XMLDocument::Load, you may receive the following error message:

> HRESULT C00CE56E  
System does not support the specified encoding.

This error is most prevalent when you use a Java-based middle-tier application framework.

## Cause

As of version 2.6, MSXML passes all XML documents through Mlang.dll to verify their encoding. If Mlang.dll encounters a non-standard encoding string, it returns an error.

'ISO8859_1' is the canonical representation of the Latin-1 character encoding string in the Java language and class libraries. The standard that is defined by the Internet Assigned Numbers Authority, however, is 'ISO-8859-1', which is not an accepted alias.

## Resolution

To resolve this problem, do either of the following:

- Change the character encoding string in the relevant Java server environment from 'ISO8859_1' to 'ISO-8859-1'.

- Use `IXMLDOMDocument::get_responseBody` to retrieve the data as a raw buffer of bytes. If you are developing the application in Microsoft Visual C++, you may define an HGLOBAL handle for your data and use `CreateStreamOnHGlobal` to make processing the data easier.

## References

For more information, see [Character Sets](https://www.iana.org/assignments/character-sets/character-sets.xhtml).
