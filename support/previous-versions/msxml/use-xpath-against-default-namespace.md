---
title: Use XPath to query against a default namespace
description: This article describes how to use XPath to query against a user-defined default namespace and provides code to reproduce the behavior.
ms.date: 10/20/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Use XPath to query against a user-defined default namespace

This article describes how to use XPath to query against a user-defined default namespace and provides code to reproduce the behavior.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 288147

## Symptoms

When you redefine the default namespace in the XML document, change the internal `SelectionNamespaces` property for the default namespace, and then try to programmatically use XPath to return nodes by using the `selectNodes` or `selectSingleNodes` method, no nodes are returned.

## Resolution

Either use prefixes with the namespaces when you specify the `SelectionNamespaces` property, or use Extensible Stylesheet Language (XSL) pattern-matching operations instead of XPath.

## More information

This behavior is by design.

Implementation of XPath queries against the DOMDocument requires that namespaces be declared in the Document Object Model (DOM) before the `selectNodes` or `selectSingleNode` methods are run.

## Steps to reproduce the behavior

1. In Visual Basic, create a new Standard EXE project. Form1 is created by default.
2. Paste the following code into the `Form_Unload()` event of Form1.

    ```vb
    ' You can change the ProgID to reflect the installed version of the Microsoft XML Parser:
    ' For example, with MSXML 6, you would use:
    ' Dim xmlDom As MSXML2.DOMDocument60
    Dim xmlDom As MSXML2.DOMDocument
    Dim nodeList As MSXML2.IXMLDOMNodeList
    Dim iNode As MSXML2.IXMLDOMNode

    ' For example, with MSXML 6, you would use:
    ' Set xmlDom = New MSXML2.DOMDocument60

    Set xmlDom = New MSXML2.DOMDocument

    With xmlDom
        .async = False
        .loadXML "<?xml version='1.0'?>" & _
        "<Root xmlns='uri:MyNameSpace'>" & _
        " <Test>This is a Test</Test>" & _
        "</Root>"
        .setProperty "SelectionLanguage", "XPath"
        .setProperty "SelectionNamespaces", "xmlns='uri:MyNameSpace'"
        Set nodeList = .selectNodes("//Test")
    End With

    For Each iNode In nodeList
    msgbox iNode.xml
    Next iNode
    ```

3. On the **Project** menu, click **References**. From the list of available references, select Microsoft XML, v3.0 or later.
4. Run the project. No XML is returned.
5. Comment out the two `setProperty` methods.

   > [!NOTE]
   > Alternatively, you can modify the two lines of code as follows.

    ```vb
    .setProperty "SelectionNamespaces", "xmlns:myNS='uri:MyNameSpace'"
    Set nodeList = .selectNodes("//myNS:Test")
    ```

6. Run the project. The XML nodes are returned.

## References

[How To Specify Namespace when Querying the DOM with XPath](https://support.microsoft.com/help/294797)
