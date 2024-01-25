---
title: Invalid character was found in text content
description: An error may be thrown when you parse XML that contains special characters by using the Microsoft XML parser. This article provides resolutions.
ms.date: 05/06/2020
---
# XML parser: Invalid character was found in text content

This article helps you resolve errors when you parse Extensible Markup Language (XML) that contains special characters by using the Microsoft XML parser (MSXML).

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 238833

## Symptom

When you parse XML that contains special characters by using the Microsoft XML parser (MSXML), the parser may report the following error message at the line and position of the first special character:

> An Invalid character was found in text content.

## Cause

The XML document isn't marked with the proper character encoding scheme.

## Resolution

- Specify the proper encoding scheme in the XML processing instruction.
- Re-encode the XML data as proper UTF-8.

## Status

This behavior is by design.

## More information

Special character refers to any character outside the standard American Standard Code for Information Interchange (ASCII) character set range of 0x00 - 0x7F, such as Latin characters with accents, umlauts, or other diacritics. The default encoding scheme for XML documents is UTF-8, which encodes ASCII characters with a value of 0x80 or higher differently than other standard encoding schemes.

Most often, you see this problem if you're working with data that uses the simple iso-8859-1 encoding scheme. In this case, the quickest solution is usually the first listed prior in the **Resolution** section. For example, use the following XML declaration:

```xml
<?xml version="1.0" encoding="iso-8859-1" ?>
<rootelement>
    ...XML data...
</rootelement>
```

Instead, you can encode each of those characters using the numeric entity reference. For example, you can take the special character *á*, use `<test> &#225;</test>` (decimal version) or `<test>&#x00E1;</test>` (hex version).
