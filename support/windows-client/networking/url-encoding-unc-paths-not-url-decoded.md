---
title: URL-encoded UNC paths not URL-decoded in Windows 10, version 1803 and later versions
description: In Windows 10, version 1803, and later versions of Windows URL-encoded UNC paths are no longer URL-decoded.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tonyga, ajayps, v-jeffbo
ms.custom: sap:dns, csstroubleshoot
---
# URI-encoding in UNC paths interpreted literally in Windows 10, version 1803 and later

This article provides some information about URI-encoding in UNC paths interpreted literally in Windows 10, version 1803 and later.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4467268

## Summary

In Windows 10, version 1803 and later versions of Windows, URLs (such as SharePoint document libraries) can't be referenced by Universal Naming Convention (UNC) paths that contain URI encoding characters.

For example, when the path `http://myserver/Shared Documents` is URI-encoded, the path becomes `http://myserver/Shared%20Documents`. Before Windows 10, version 1803, the UNC path \\\\myserver\\shared%20documents could be used. After you upgrade to version 1803, the "%20" is no longer interpreted as a space but as the literal value "%20". This can prevent previously generated links from resolving to the correct http path.

## More information

This is by design. The UNC pathing should be updated to reflect the literal path, and any URI-encoding characters should be removed. Or, use a scheme of file://so that the path is decoded. (For example: file://\\\\myserver\\shared%20documents.)

To achieve parity with the local Windows file system naming convention, Windows 10, version 1803 introduces support for additional characters in file names and folders on web-based paths.

One of the previously unsupported characters is the percent sign (%). Because this character is the escape character that's used for URI encoding, a UNC path that has been URI-encoded will no longer be URI decoded. Instead, it will be treated as a literal path.

Windows style paths are not URIs and thus don't follow normal URI-encoding rules, so any characters that use percent encoding in URIs should be decoded when translating WebDAV-style paths back into Windows-style paths. Similarly, Windows-style paths don't use percent-encoding to represent special characters in file names, so whenever the WebClient service observes a percent character in a Windows style path when translating to a URI, the "%" character will be replaced by "%25" even when the "%" character is followed by two hex digits.
