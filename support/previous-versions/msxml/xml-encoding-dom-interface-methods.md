---
title: XML encoding and DOM interface methods
description: This article describes XML encoding and DOM interface methods.
ms.date: 10/20/2020
ms.prod-support-area-path: 
---
# XML encoding and DOM interface methods

 This article describes XML encoding and DOM interface methods.

_Original product version:_ &nbsp; Extensible Markup Language  
_Original KB number:_ &nbsp; 275883

## Summary

One major advantage of Extensible Markup Language (XML) data is that it is platform independent. However, correct encoding must be specified to ensure proper transfer of XML data between different platforms. The white paper *How to Encode XML Data* addresses general XML encoding issues in detail: [How to Encode XML Data](/previous-versions/aa468560(v=msdn.10)).

Under most scenarios, XML encoding errors originate from the different default encoding settings of the XML parser (MSXML) methods and interfaces. A clear understanding of these default settings will help in preventing the encoding errors.

## XML Encodings

MSXML supports all encodings that are supported by Internet Explorer. Internet Explorer's support depends on which language packs are installed on the computer; this information is stored under the registry key: `HKEY_CLASSES_ROOT\MIME\Database\Charset`

MSXML has native support for the following encodings:

```console
UTF-8
UTF-16
UCS-2
UCS-4
ISO-10646-UCS-2
UNICODE-1-1-UTF-8
UNICODE-2-0-UTF-16
UNICODE-2-0-UTF-8
It also recognizes (internally using the WideCharToMultibyte API function for mappings) the following encodings:
US-ASCII
ISO-8859-1
ISO-8859-2
ISO-8859-3
ISO-8859-4
ISO-8859-5
ISO-8859-6
ISO-8859-7
ISO-8859-8
ISO-8859-9
WINDOWS-1250
WINDOWS-1251
WINDOWS-1252
WINDOWS-1253
WINDOWS-1254
WINDOWS-1255
WINDOWS-1256
WINDOWS-1257
WINDOWS-1258
```

The proper place to specify encoding for the data is the XML declaration. For example, if the data is encoded with `ISO-8859-1` standard, you can specify this as follows:

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
```

Without this information, the default encoding is UTF-8 or UTF-16, depending on the presence of a UNICODE byte-order mark (BOM) at the beginning of the XML file. If the file starts with a UNICODE byte-order mark (0xFF 0xFE) or (0xFE 0xFF), the document is considered to be in UTF-16 encoding; otherwise, it is in UTF-8. The Save method of the `IXMLDOMDocument` interface maintains the original encoding of the document. The default for this method is UTF-8.

## MSXML DOM Errors

Two common errors that are returned from the XML Document Object Model (DOM) interface methods are:

- > An Invalid character was found in text content.

- > Switch from current encoding to specified encoding not supported.

With the load method of the `IXMLDOMDocument` interface, these errors usually occur under the following conditions:

- No encoding is specified, no byte-order mark is found at the beginning of the XML file, and the data contains special characters

- The specified encoding does not match the actual encoding of the XML data. A good practice is to always specify the correct encoding inside the XML declaration, rather than accepting the default encoding.

With the MSXML parser versions 2.5, 2.5 SP1 and 2.6, the `loadXML` method of `IXMLDOMDocument` can only load UTF-16 or UCS-2 encoded data. Any attempt to load XML data that is encoded with another encoding format results in the following error:

> Switch from current encoding to specified encoding not supported.
With the release of MSXML 3.0 (Msxml3.dll), this restriction is removed, and the following code runs without error:

```xml
hr = pXMLDoc->loadXML("<?xml version=\"1.0\" encoding=\"UTF-8\"?><tag1>Abcdef</tag1>");
```

> [!NOTE]
> The xml property of the `IXMLDOMDocument` interface writes out the XML data as UTF-16 encoded but without the byte-order mark at the beginning. This may lead to encoding problems.

You may also receive these errors when you call the `transformNode` method of the `IXMLDOMNode` interface with an XSL or XSLT file in which the XML encoding information is specified as follows:

```xml
<xsl:output method="xml" encoding="UTF-8" />
```

The `transformNode` method returns a BSTR that is UTF-16 encoded data by definition. A better way to retain the encoding is to call the `transformNodeToObject` method and store the results to a stream or to a new XML document and then save it.

## References

[System.Xml Namespace](/dotnet/api/system.xml)
