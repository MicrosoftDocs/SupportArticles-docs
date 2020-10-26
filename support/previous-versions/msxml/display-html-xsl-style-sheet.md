---
title: Display HTML in XSL style sheet
description: This article describes how to work with the XSL style sheets to use the HTML tags that are inside XML data.
ms.date: 10/19/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: .net
---
# Display HTML in XSL Style Sheet

This article describes how to work with the XSL style sheets to use the HTML tags that are inside XML data.

_Original product version:_ &nbsp; XSL style sheets  
_Original KB number:_ &nbsp; 264665

## Summary

When XML data contains HTML tags, those tags are considered as plain data by default, and are not parsed as HTML. The output displays as text without HTML effects. This article explains how to work with the XSL style sheets to use the HTML tags that are inside XML data.

## More information

In the `xsl:value-of` element, use the XSL disable-output-escaping property, and then set it to **yes**. By default disable-output-escaping is set to **no**. This property was added with the May 2000 version of the XML parser.

You may install the latest version of the MS XML parser from [MSXML Roadmap](/previous-versions/windows/desktop/jj152146(v=vs.85)).

The following XML/XSL example demonstrates how to work with the XSL style sheets to use the HTML tags that are inside XML data:

```xml
Here is the XML file that we want to display...
==========================================================================
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="testHTML.xsl"?>
<TABLE>
    <ROW>
        <F1>Next one should be in H1 heading</F1>
        <F2><H1>This is a H1 heading</H1></F2>
    </ROW>
    <ROW>
        <F1>Next one should be Italic</F1>
        <F2><I>I am italic</I></F2>
    </ROW>
    <ROW>
        <F1>Next one is a link</F1>
        <F2>Goto <A HREF="http://www.microsoft.com">Microsoft</A></F2>
    </ROW>
</TABLE>
==========================================================================
```

The HTML data in the first `<F2>` line can be written with special character sequences and CDATA section, as demonstrated in the following examples:

- `<F2>&lt;H1&gt;This is a H1 heading&lt;/H1&gt;</F2>`
- `<F2>`

> [!NOTE]
> Characters such as < and > are reserved characters in XML, and are not interpreted if they are placed in an XML file. Substitute these characters with case-sensitive character sequences. For more information on Microsoft's work with XML, see [MSXML SDK Overview](/previous-versions/windows/desktop/ms760399(v=vs.85)).

The following is the corresponding TestHTML.xsl file that demonstrates how to work with the XSL style sheets to use the HTML tags that are inside XML data:

```xml
==========================================================================
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
<xsl:template match="TABLE">
<HTML>
    <BODY>
        <TABLE border='1' style='table-layout:fixed' width='600'>
            <TR bgcolor='#FFFF00'>
                <TD>Expected action</TD>
                <TD>HTML display</TD>
            </TR>
            <xsl:for-each select="ROW">
            <TR>
                <TD><xsl:value-of select='F1'/></TD>
                <TD><xsl:value-of select='F2' disable-output-escaping="yes"/></TD>
            </TR>
        </xsl:for-each>
        </TABLE>
    </BODY>
</HTML>
</xsl:template>
</xsl:stylesheet>
==========================================================================
```

## References

- [How to Encode XML Data](/previous-versions/aa468560(v=msdn.10))

- [Frequently Asked Questions about XSLT](/previous-versions/windows/desktop/ms757858(v=vs.85))
