---
title: Matching nodes are not returned
description: This article provides resolutions for the problem where matching nodes are not returned when you run XPath queries against XML documents that specify a default namespace declaration.
ms.date: 10/15/2020
ms.prod-support-area-path: 
ms.reviewer: KARTHIKR
ms.prod: .net
---
# MSXML 6.0: Matching Nodes Are Not Returned When You Run XPath Queries Against XML Documents that Specify a Default Namespace Declaration

This article helps you resolve the problem where matching nodes are not returned when you run XPath queries against XML documents that specify a default namespace declaration.

_Original product version:_ &nbsp; Microsoft XML  
_Original KB number:_ &nbsp; 313372

## Symptoms

When you use the MSXML 6.0 Document Object Model (DOM) methods (`selectNodes` and `selectSingleNode`) to run XPath queries against an XML document that specifies a default namespace declaration, the matching node or nodes are not returned.

## Cause

The default namespace declaration is not added to the Namespace names of the DOMDocument object, or a namespace prefix is not specified for the default namespace declaration when it is added to the Namespace names of the DOMDocument object.

## Resolution

Add the default namespace declaration to the Namespace names of the DOMDocument object by specifying a namespace prefix. To do this, use the `setProperty` method of the DOMDocument object to set the `SelectionNamespaces` internal property.

## More information

MSXML 6.0 no longer supports the XSLPattern query language. It only supports the XPath query language. This implies that simple tree-style hierarchical queries to access nodes in an XML document are also run as XPath queries in MSXML 6.0. When you use the MSXML 6.0 DOM to run XPath queries against an XML document that specifies a default namespace declaration, you must use the `setProperty` method of the DOMDocument object to add the default namespace declaration by specifying a namespace prefix, to the Namespace names of the DOMDocument object.

### Steps to Reproduce Behavior

To recreate the problem and test the specified resolution by using a Visual Basic Standard EXE project, follow these steps:

1. In Notepad, create an XML document that contains the following XML named Books.xml in the root folder of drive C:

    ```xml
    <?xml version='1.0'?>
    <Books xmlns="urn:books">
        <Book>
            <Title>Beginning XML</Title>
            <Publisher>Wrox</Publisher>
        </Book>
        <Book>
            <Title>XML Step by Step</Title>
            <Publisher>MSPress</Publisher>
        </Book>
        <Book>
            <Title>Professional XML</Title>
            <Publisher>Wrox</Publisher>
        </Book>
        <Book>
            <Title>Developing XML solutions</Title>
            <Publisher>MSPress</Publisher>
        </Book>
    </Books>
    ```

2. In Visual Basic, create a new Standard EXE project.
3. Add a reference to Microsoft XML, version 6.0.
4. Drag a command button onto **Form1**.
5. Paste the following code in the Click event procedure of the command button:

    > [!NOTE]
    > This code loads the sample Books.xml document into an instance of the MSXML 6.0 DOMDocument60 object. It then uses the SelectNodes DOM method to run an XPath query against the DOMDocument60 object to identify the titles that are published by MSPress.

    ```vb
    Dim xmldoc As MSXML2.DOMDocument60
    Dim bookList As MSXML2.IXMLDOMNodeList
    Dim bookNode As MSXML2.IXMLDOMNode

    Set xmldoc = New MSXML2.DOMDocument60
    'xmldoc.setProperty "SelectionNamespaces", "xmlns:bk='urn:books'"
    xmldoc.Load "c:\books.xml"

    Set bookList = xmldoc.selectNodes("//Publisher[. = 'MSPress']/parent::node()/Title")'Set bookList = xmldoc.selectNodes("//bk:Publisher[. = 'MSPress']/parent::node()/bk:Title")

    For Each bookNode In bookList
        Debug.Print "Title : " & bookNode.Text
    Next
    ```

6. Save and run the project.
7. Click the command button when the form is displayed. Although the XPath query is valid, it does not generate any results, and the matching titles are not written to the Visual Basic Immediate window.
8. Stop the project.
9. Uncomment the following line of code immediately after the Set xmldoc = New MSXML2.DOMDocument60 statement to add the default namespace declaration by specifying a namespace prefix to the Namespace names of the DOMDocument object:

    ```vb
    'xmldoc.setProperty "SelectionNamespaces", "xmlns:bk='urn:books'"
    ```

10. Comment the call to the `selectNodes` DOM method that is used to execute the XPath query.

    ```vb
    Set bookList = xmldoc.selectNodes("//Publisher[. = 'MSPress']/parent::node()/Title")
    ```

11. Uncomment the following statement:

    ```vb
    'Set bookList = xmldoc.selectNodes("//bk:Publisher[. = 'MSPress']/parent::node()/bk:Title")
    ```

    > [!NOTE]
    > The element names are now prefixed with the bk namespace alias that you specify when the default namespace declaration is added to the Namespace names of the DOMDocument object.

12. Save and run the project. Click the command button when the form is displayed. The matching nodes are listed in the Visual Basic Immediate window.
