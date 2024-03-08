---
title: Navigate XML with the XPathNavigator class
description: This article describes some sample steps and sample code to navigate XML by using the XPathNavigator class in Visual Basic 2005 or in Visual Basic .NET.
ms.date: 10/10/2020
ms.custom: sap:Language or Compilers
ms.topic: how-to
---
# Navigate XML with the XPathNavigator class by using Visual Basic  

This article describes some sample steps and sample code to navigate XML by using the `XPathNavigator` class in Visual Basic 2005 or in Visual Basic .NET.

_Original product version:_ &nbsp; Visual Basic 2005, Visual Basic .NET  
_Original KB number:_ &nbsp; 301111

## Summary

This step-by-step article illustrates how to navigate Extensible Markup Language (XML) documents with an `XPathNavigator` object that is created from an `XPathDocument` object. This sample loads an `XPathDocument` object with XML data, creates an `XPathNavigator` object as a view onto the data, and displays the XML by walking through the document.

For a Microsoft Visual C# version of this article, see
[Use Visual C# to navigate XML documents with the XPathNavigator class](../../csharp/language-compilers/xml-xpathnavigator.md).

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need:

- Windows Server 2003, Windows 2000 Professional, Windows 2000 Server, Windows 2000 Advanced Server, or Windows NT 4.0 Server
- Visual Studio 2005 or Visual Studio .NET

This article assumes that you are familiar with the following topics:  

- XML terminology
- Creating and reading XML files
- XML Path Language (XPath) syntax

## Use the XPathNavigator class to navigate XML

1. In Visual Studio 2005 or in Visual Studio. NET, create a Visual Basic 2005 or Visual Basic .NET Console Application.

   > [!NOTE]
   > This example uses a file that is named *Books.xml*. You can create your own *Books.xml* file, or you can use the sample that is included with the .NET Software Development Kit (SDK) Quickstarts. If you have the Quickstarts installed, Books.xml is located in the folder: `\Program Files\Microsoft.NET\FrameworkSDK\Samples\Quickstart\Howto\Samples\Xml\Transformxml\VB`

   Alternatively, you can obtain this file by visiting: [Sample XML File (books.xml)](/previous-versions/windows/desktop/ms762271(v=vs.85))

   You must copy *Books.xml* to the `\Bin\Debug` folder that is located under the folder in which you created this project.

2. Make sure that the project references the `System.Xml` namespace.

3. Use the `Imports` statement on the `Xml` and `XPath` namespaces so that you are not required to qualify declarations in those namespaces later in your code. You must use the `Imports` statement prior to any other declarations.

    ```vbnet
    Imports System.Xml
    Imports System.Xml.XPath
    ```

4. Declare the appropriate variables. Declare an `XPathDocument` object to hold the XML document and an `XPathNavigator` object to evaluate XPath expressions and move through the document. Declare a String object to hold the XPath expression. Add the declaration code in the Main procedure in Module1.

    ```vbnet
    Dim nav As XPathNavigator
    Dim docNav As XPathDocument
    ```

5. Load an `XPathDocument` object with the sample file `Books.xml`. The `XPathDocument` class uses Extensible Stylesheet Language Transformations (XSLT) to provide a fast and performance-oriented cache for XML document processing. It is similar to the XML Document Object Model (DOM) but is highly optimized for XSLT processing and the XPath data model.

    ```vbnet
    'Open the XML.
    docNav = New XPathDocument("books.xml")
    ```

6. Create an `XPathNavigator` object from the document. `XPathNavigator` enables you to move through both the attributes nodes and the namespace nodes in an XML document.

    ```vbnet
    'Create a navigator to query with XPath.
    nav = docNav.CreateNavigator
    ```

7. Move to the root of the document with the `MoveToRoot` method. `MoveToRoot` sets the navigator to the document node that contains the entire tree of nodes.

    ```vbnet
    'Initial XPathNavigator to start at the root.
    nav.MoveToRoot()
    ```

8. Use the `MoveToFirstChild` method to move to the children of the XML document. The `MoveToFirstChild` method moves to the first child of the current node. In the case of the `Books.xml` source, you are moving away from the root document into the children, the `Comment` section, and the Bookstore node.

    ```vbnet
    'Move to the first child node (comment field).
    nav.MoveToFirstChild()
    ```

9. Use the `MoveToNext` method to iterate through nodes at the sibling level. The `MoveToNext` method moves to the next sibling of the current node.

    ```vbnet
    'Loop through all the root nodes.
    Do
    ...
    Loop While nav.MoveToNext
    ```

10. Use the `NodeType` property to make sure that you are only processing element nodes, and use the `Value` property to display the text representation of the element.

    ```vbnet
    Do
    'Find the first element.
    If nav.NodeType = XPathNodeType.Element Then
    'If children exist.
    If nav.HasChildren Then

    'Move to the first child.
    nav.MoveToFirstChild()'Loop through all the children.
    Do
    'Display the data.
    Console.Write("The XML string for this child ")
    Console.WriteLine("is '{0}'", nav.Value)
    Loop While nav.MoveToNext

    End If
    End If
    Loop While nav.MoveToNext
    ```

11. Use the `HasAttributes` property to determine whether a node has any attributes. You can also use other methods, such as `MoveToNextAttribute`, to move to an attribute and inspect its value.

    > [!NOTE]
    > This code segment only walks through the descendants of the root node and not the entire tree.

    ```vbnet
    Do
    'Find the first element.
    If nav.NodeType = XPathNodeType.Element Then
    'if children exist
    If nav.HasChildren Then

    'Move to the first child.
    nav.MoveToFirstChild()'Loop through all the children.
    Do
    'Display the data.
    Console.Write("The XML string for this child ")
    Console.WriteLine("is '{0}'", nav.Value)'Check for attributes.
    If nav.HasAttributes Then
    Console.WriteLine("This node has attributes")
    End If
    Loop While nav.MoveToNext

    End If
    End If
    Loop While nav.MoveToNext
    ```

12. Use the `ReadLine` method of the `Console` object to add a pause at the end of the console display to more readily display the above results.

    ```vbnet
    'Pause.
    Console.ReadLine()
    ```

13. Build and run your Console Application project.

## Complete code listing

```vbnet
Imports System.Xml
Imports System.Xml.XPath

Module Module1

Sub Main()
Dim nav As XPathNavigator
Dim docNav As XPathDocument
docNav = New XPathDocument("books.xml")
nav = docNav.CreateNavigator
nav.MoveToRoot()'Move to the first child node (comment field).
nav.MoveToFirstChild()

Do
'Find the first element.
If nav.NodeType = XPathNodeType.Element Then
'if children exist
If nav.HasChildren Then

'Move to the first child.
nav.MoveToFirstChild()'Loop through all the children.
Do
'Display the data.
Console.Write("The XML string for this child ")
Console.WriteLine("is '{0}'", nav.Value)'Check for attributes.
If nav.HasAttributes Then
Console.WriteLine("This node has attributes")
End If
Loop While nav.MoveToNext

End If
End If
Loop While nav.MoveToNext

'Pause.
Console.ReadLine()

End Sub

End Module
```

## References

- [XML Extended Data Type](/previous-versions/dynamics/ax-2012/reference/gg920029(v=ax.60))

- [XPathNavigator Class Definition](/dotnet/api/system.xml.xpath.xpathnavigator))

- [XPathDocument Class](/dotnet/api/system.xml.xpath.xpathdocument)

- [XslTransform Class](/dotnet/api/system.xml.xsl.xsltransform)

- [hXPath examples](/previous-versions/dotnet/netframework-4.0/ms256086(v=vs.100))

- [Version 1.0: W3C Recommendation 16 November 1999](https://www.w3.org/TR/1999/REC-xpath-19991116/)
