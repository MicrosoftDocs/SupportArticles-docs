---
title: Navigate XML documents with XPathNavigator
description: Describes how to navigate Extensible Markup Language (XML) documents by using an XPathNavigator object that is created from an XPathDocument object.
ms.date: 04/20/2020
ms.custom: sap:Language or Compilers\C#
ms.reviewer: JAYAPST
ms.topic: how-to
---
# Use Visual C# to navigate XML documents with the XPathNavigator class

This article describes how to navigate XML documents with an `XPathNavigator` object that is created from an `XPathDocument` object.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 308343

## Summary

This sample loads an `XPathDocument` object with XML data, creates an `XPathNavigator` object as a view onto the data, and displays the XML by walking through the document.

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Xml`  
- `System.Xml.XPath`

For a Microsoft Visual Basic .NET version of this article, see [How to navigate XML with the XPathNavigator class by using Visual Basic](https://support.microsoft.com/help/301111).

## Requirements

This article assumes that you're familiar with the following topics:

- Visual C#
- XML terminology
- Creating and reading an XML file
- XML Path Language (XPath) syntax

## How to use the XPathNavigator class to navigate XML

1. Create a new Visual C# Console Application in Visual Studio.

    > [!NOTE]
    > This example uses a file named *Books.xml*. You can create your own *Books.xml* file, or you can use the sample that is included with the .NET Software Development Kit (SDK) Quickstarts. If you do not have the Quickstarts installed and don't want to install them, see the [References](#references) section for the *Books.xml* download location. If you have the Quickstarts installed, *Books.xml* is located in the following folder:  
    > `\Program Files\Microsoft.NET\FrameworkSDK\Samples\Quickstart\Howto\Samples\Xml\Transformxml\VB`

    You can copy *Books.xml* to the `\Bin\Debug` folder that is located under the folder in which you created this project.

2. Make sure that the project references the `System.Xml` namespace.

3. Use the `using` statement on the `Xml` and `XPath` namespaces so that you aren't required to qualify declarations in those namespaces later in your code. You can use the `using` statement before any other declarations, as follows:

    ```csharp
    using System.Xml;
    using System.Xml.XPath;
    ```

4. Declare the appropriate variables. Declare an `XPathDocument` object to hold the XML document and an `XPathNavigator` object to evaluate `XPath` expressions and move through the document. Declare a `String` object to hold the `XPath` expression. Add the declaration code in the `Main` procedure in Module1.

    ```csharp
    XPathNavigator nav;
    XPathDocument docNav;
    ```

5. Load an `XPathDocument` object with the sample file *Books.xml*. The `XPathDocument` class uses Extensible Stylesheet Language Transformations (XSLT) to provide a fast and performance-oriented cache for XML document processing. It's similar to the XML Document Object Model (DOM) but is highly optimized for XSLT processing and the XPath data model.

    ```csharp
    // Open the XML.
    docNav = new XPathDocument(@"c:\books.xml");
    ```

6. Create an `XPathNavigator` object from the document. `XPathNavigator` enables you to move through both the attributes nodes and the namespace nodes in an XML document.

    ```csharp
    // Create a navigator to query with XPath.
    nav = docNav.CreateNavigator();
    ```

7. Move to the root of the document with the `MoveToRoot` method. `MoveToRoot` sets the navigator to the document node that contains the entire tree of nodes.

    ```csharp
    //Initial XPathNavigator to start at the root.
    nav.MoveToRoot();
    ```

8. Use the `MoveToFirstChild` method to move to the children of the XML document. The `MoveToFirstChild` method moves to the first child of the current node. If there's the *Books.xml* source, you're moving away from the root document into the children, the Comment section, and the Bookstore node.

    ```csharp
    //Move to the first child node (comment field).
    nav.MoveToFirstChild();
    ```

9. Use the `MoveToNext` method to iterate through nodes at the sibling level. The `MoveToNext` method moves to the next sibling of the current node.

    ```csharp
    //Loop through all of the root nodes.
    do
    {
    } while (nav.MoveToNext());
    ```

10. Use the `NodeType` property to make sure that you're only processing element nodes, and use the `Value` property to display the text representation of the element.

    ```csharp
    do
    {
       //Find the first element.
       if (nav.NodeType == XPathNodeType.Element)
       {
            //Determine whether children exist.
            if (nav.HasChildren == true)
            {
                //Move to the first child.
                nav.MoveToFirstChild();

                //Loop through all the children.
                do
                {
                    //Display the data.
                    Console.Write("The XML string for this child ");
                    Console.WriteLine("is '{0}'", nav.Value);
                } while (nav.MoveToNext());
            }
        }
    } while (nav.MoveToNext());
    ```

11. Use the `HasAttributes` property to determine whether a node has any attributes. You can also use other methods, such as `MoveToNextAttribute`, to move to an attribute and inspect its value.

    > [!NOTE]
    > This code segment only walks through the descendents of the root node and not the entire tree.

    ```csharp
    do
    {
       //Find the first element.
       if (nav.NodeType == XPathNodeType.Element)
       {
            //if children exist
            if (nav.HasChildren == true)
            {
                //Move to the first child.
                nav.MoveToFirstChild();
                //Loop through all the children.
                do
                {
                    //Display the data.
                    Console.Write("The XML string for this child ");
                    Console.WriteLine("is '{0}'", nav.Value);

                    //Check for attributes.
                    if (nav.HasAttributes == true)
                    {
                        Console.WriteLine("This node has attributes");
                    }
                } while (nav.MoveToNext());
            }
        }
    } while (nav.MoveToNext());
    ```

12. Use the `ReadLine` method of the `Console` object to add a pause at the end of the console display to more readily display the above results.

    ```csharp
    //Pause.
    Console.ReadLine();
    ```

13. Build and run the Visual C# project.

## Complete code listing

```csharp
using System;
using System.Xml;
using System.Xml.XPath;

namespace q308343
{
    class Class1
    {
        static void Main(string[] args)
        {
            XPathNavigator nav;
            XPathDocument docNav;

            docNav = new XPathDocument(@"c:\books.xml");
            nav = docNav.CreateNavigator();
            nav.MoveToRoot();

            //Move to the first child node (comment field).
            nav.MoveToFirstChild();

            do
            {
                //Find the first element.
                if (nav.NodeType == XPathNodeType.Element)
                {
                    //Determine whether children exist.
                    if (nav.HasChildren == true)
                    {
                        //Move to the first child.
                        nav.MoveToFirstChild();
                        //Loop through all of the children.
                        do
                        {
                            //Display the data.
                            Console.Write("The XML string for this child ");
                            Console.WriteLine("is '{0}'", nav.Value);
                            //Check for attributes.
                            if (nav.HasAttributes == true)
                            {
                                Console.WriteLine("This node has attributes");
                            }
                        } while (nav.MoveToNext());
                    }
                }
            } while (nav.MoveToNext());
            //Pause.
            Console.ReadLine();
        }
    }
}
```

## Troubleshooting

When you test the code, you may receive the following exception error message:

> An unhandled exception of type System.Xml.XmlException occurred in system.xml.dll  
> Additional information: Unexpected XML declaration. The XML declaration must be the first node in the document, and no white space characters are allowed to appear before it. Line 1, position

The exception error occurs on the following line of code:

```csharp
docNav = new XPathDocument("c:\\books.xml");
```

To resolve the error, remove the white-space character(s) that precede the first node in the books.xml document.

## References

- [Download Books.xml now](https://download.microsoft.com/download/xml/utility/1.0.0.1/wxp/en-us/books.exe)

- [XPathNavigator Class](/dotnet/api/system.xml.xpath.xpathnavigator)

- [XPathDocument Class](/dotnet/api/system.xml.xpath.xpathdocument)

- [XPath Examples](/previous-versions/dotnet/netframework-4.0/ms256086(v=vs.100))

- [XML Path Language (XPath) Version 1.0 W3C Recommendation 16 November 1999](https://www.w3.org/TR/1999/REC-xpath-19991116/)
