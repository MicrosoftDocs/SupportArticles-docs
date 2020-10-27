---
title: Disable output escaping in transformations
description: This article describes how to disable output escaping in transformations.
ms.date: 10/15/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: .net
---
# Disable output escaping in transformations  

This article shows how to disable output escaping in transformations.

_Original product version:_ &nbsp; Microsoft XML  
_Original KB number:_ &nbsp; 315717

## Summary

This step-by-step article describes how to disable output escaping of characters such as `< and >` in an XML style sheet transformation.

To guarantee that any XSL transformation output is a well-formed document, the angle bracket characters (`< and >`) are transformed by default into `< and >` character sequences. However, sometimes this behavior is not desirable, such as when you want to generate a Document Type Declaration (DTD) in the output document:

```console
<!DOCTYPE StaffMember [
 <!ELEMENT StaffMember (#PCDATA)>
]>
```

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that are required:

- Microsoft XML version 3.0 or later
  
    This article assumes that you are familiar with the following topics:

- XML and XSL transformations and the MSXML component
- Visual Basic Scripting Edition (VBScript)
- XML Document Object Model (DOM)

## Create an XML Document and an XSL Style Sheet

1. Open a text editor such as Notepad, and then paste the following XML in a document:

    ```xml
    <?xml version="1.0"?>
    <?xml-stylesheet type="text/xsl" href="Transform.xsl"?>
    <Employee>
        <Name>Chris</Name>
    </Employee>
    ```

2. Save this file as *Source.xml*.
3. Create a new file in your text editor, and then paste the following XSL style sheet in the file.

    > [!NOTE]
    > The disable-output-escaping="yes" attribute in the first xsl:value-of tag:
  
    ```xml
    <?xml version="1.0"?>
    <xsl:stylesheet 
     version="1.0" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
    <xsl:output method="xml" omit-xml-declaration="yes"/>
        <xsl:template match="Employee">
            <xsl:value-of 
             disable-output-escaping="yes"
             select="concat('&lt;!DOCTYPE StaffMember [',
             '&lt;!ELEMENT StaffMember (#PCDATA)&gt;',
             ']&gt;')" />
            <StaffMember>
                <xsl:value-of select="Name"/>
            </StaffMember>
        </xsl:template>
    </xsl:stylesheet>
    ```

4. Save this file as Transform.xsl in the same folder as the XML document that you created.

## Use Windows Script to Execute the Style Sheet

1. Create a new file in your text editor, and then paste the following script in the file:
Option Explicit

    ```vbscript
    Dim objSource
    Dim objTransform
    Dim sResult
  
    Set objSource = CreateObject("MSXML2.DOMDocument")
    objSource.async = False
    objSource.load "Source.xml"
  
    Set objTransform = CreateObject("MSXML2.DOMDocument")
    objTransform.async = False
    objTransform.load "Transform.xsl"
  
    sResult = objSource.TransformNode(objTransform.documentElement)
  
    WScript.Echo sResult
    ```

2. Save this file as *Xform.vbs* in the same folder as the XML document and the XSL style sheet that you created.

## Test the Procedure

1. Open a command prompt, and then locate the folder that contains your three files.
2. Type `cscript xform.vbs` at the command prompt.
3. The output from the transformation is displayed as follows on the screen:

    ```console
    <!DOCTYPE StaffMember [<!ELEMENT StaffMember (#PCDATA)>]>
    <StaffMember>Chris</StaffMember>
    ```

## Troubleshooting

Be careful when you use the `disable-output-escaping` attribute. If the generated < and > characters do not match up, the output document will not be well-formed XML. The transformNodeToObject method requires the result to be well formed, so the method might not complete if `disable-output-escaping` is used.
