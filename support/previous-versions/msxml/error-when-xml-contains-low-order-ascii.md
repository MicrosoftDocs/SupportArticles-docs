---
title: Error occurs when an XML contains Low-Order ASCII
description: This article provides resolutions for the error that occurs when an XML document contains Low-Order ASCII characters.
ms.date: 10/15/2020
ms.prod-support-area-path: 
ms.prod: .net
---
# Error message when an XML document contains Low-Order ASCII characters

This article helps you resolve the problem that occurs when an XML document contains Low-Order ASCII characters.

_Original product version:_ &nbsp; Microsoft XML  
_Original KB number:_ &nbsp; 315580

## Symptoms

When you attempt to use versions 3.0 or later of the MSXML parser to parse XML documents that contain certain low-order non-printable ASCII characters (that is, characters below ASCII 32), you may receive the following error message:

> An Invalid character was found in text content.

## Cause

Versions 3.0 and later of the MSXML parser strictly enforce the valid XML character ranges that are defined by the World Wide Web Consortium (W3C) XML language specification. XML documents that are parsed using versions 3.0 or later of MSXML cannot contain characters that fall outside the defined valid XML character ranges. The low-order non-printable ASCII characters in the ranges that are listed in the [More Information](#more-information) section are not valid XML characters. An XML document that contains instances of these characters is not conformant with the W3C specifications and cannot be parsed successfully with versions 3.0 and later of MSXML.

## Resolution

To resolve this problem, either remove instances of the low-order non-printable ASCII characters, or replace the characters with an alternate valid character such as the space character (ASCII 32, hex #x20). This solution makes the XML document compliant with the W3C specifications. However, removing or replacing instances of these characters may affect other applications that use the data and to which the characters are significant. Such additional impact can only be identified by testing and will need to be addressed by implementing a fix or workaround that is appropriate for a specific situation.

## More information

Versions 2.6 and earlier of the MSXML parser permit XML documents to contain low-order non-printable ASCII characters that fall outside the W3C valid XML character ranges. However, the design of versions 3.0 and later of the MSXML parser has been changed to strictly enforce the valid XML character ranges that are defined in the W3C XML language specification. This design change is required to be able to identify non-conformant XML documents.

The following are the valid XML characters and character ranges (hex values) as defined by the W3C XML language specifications 1.0:

```console
#x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
```

The following are the character ranges for low-order non-printable ASCII characters that are rejected by MSXML versions 3.0 and later:

```console
#x0 - #x8 (ASCII 0 - 8)
#xB - #xC (ASCII 11 - 12)
#xE - #x1F (ASCII 14 - 31)
```

This design change may affect the following users and applications:

- Internet Explorer users: Users who have been using Internet Explorer versions 5.5 and earlier (and who did not install MSXML 3.0 in Replace mode) to browse and view XML documents that contain one or more instances of the specified low-order non-printable ASCII characters encounter the error message after upgrading to Internet Explorer 6.0 because Internet Explorer 6.0 installs MSXML 3.0 SP2 in Replace mode and uses it to parse XML documents.
- MDAC and ADO users: Developers and users who load ADO-persisted XML documents that contain one or more instances of the specified low-order non-printable ASCII characters into ADO `Recordset` objects encounter the error message after upgrading to MDAC 2.7 because MDAC 2.7 installs MSXML 3.0 SP2, which is the version of the MSXML parser that the ADO 2.7 `Recordset` object uses.
- Applications that use the MSXML Document Object Model (DOM): Applications that use version independent `PROGIDs` to instantiate MSXML DOM objects that are used to parse XML documents generate the specified error when MSXML 3.0 or one of its service packs is installed in Replace mode or when the code is modified to use the MSXML 3.0 or 4.0 version specific `PROGIDs`.

## References

For more information on other known causes and workarounds for the error message that is specified in the Symptoms section, see:

- [XML parser: Invalid character was found in text content](/troubleshoot/dotnet/framework/xml-parser-invalid-character)
- [XML Encoding and DOM Interface Methods](https://support.microsoft.com/help/275883/)
