---
title: Query XPathDocument By Using an XPath Expression
description: Demonstrates how to query an XPathDocument object by using an XML Path Language (XPath) expression that uses the XPathNavigator class.
ms.date: 07/07/2025
ms.reviewer: JAYAPST
ms.topic: how-to
ms.custom: sap:Class Library Namespaces

#customer intent: As a developer, I want to query XML documents by using XPath expressions so that I can use XML documents together with my application. 
---
# Query XML with an XPath expression in Visual C\#

This article discusses how to query an `XPathDocument` object by using an XML Path Language (XPath) expression that uses the `XPathNavigator` class.

XPath is used programmatically to evaluate expressions and select specific nodes in a document.

This article refers to the Microsoft .NET Framework Class Library namespace, `System.Xml.XPath`.

_Applies to:_ Visual Studio, .NET Framework

_Original KB number:_ 308333

## Prerequisites

This article assumes that you're familiar with the following topics:

- Visual C#
- XML terminology
- Creating and reading an XML file
- XPath syntax

## Query XPathDocument that has an XPath expression

1. In Microsoft Visual Studio, create a Visual C# Console Application.

   > [!NOTE]
   > This example uses a file that's named *Books.xml*. You can create your own Books.xml file, or you can use the sample that's included with the .NET Software Development Kit (SDK) quickstarts.
   >
   > If you don't have the quickstarts installed, and you don't want to install them, see the "[Related content](#related-content)" section for the Books.xml download location.
   >
   > If you have the quickstarts installed, the Books.xml file can be found in the `Program Files\Microsoft.NET\FrameworkSDK\Samples\Quickstart\Howto\Samples\Xml\Transforxml\VB` folder. You can copy the file to the `\Bin\Debug` subfolder of the folder in which you created this project.

2. Make sure that the project references the `System.Xml` namespace.
3. Use the `using` statement on the `Xml` and `XPath` namespaces so that you aren't required to qualify declarations in those namespaces later in your code. You can use the `using` statement before any other declarations, as follows:

   ```csharp
   using System.Xml;
   using System.Xml.XPath;
   ```

4. Declare the appropriate variables. Declare an `XPathDocument` object to hold the XML document, an `XpathNavigator` object to evaluate XPath expressions, and an `XPathNodeIterator` object to iterate through selected nodes. Declare a `String` object to hold the XPath expressions. Add the declaration code to the `Main` function in `Class1`.

   ```csharp
   XPathNavigator nav;
   XPathDocument docNav;
   XPathNodeIterator NodeIter;
   String strExpression;
   ```

5. Load an `XPathDocument` together with the sample file, Books.xml. The `XPathDocument` class uses Extensible Stylesheet Language Transformations (XSLT) to provide a fast and performance-oriented cache for XML document processing. It's similar to the XML Document Object Model (DOM) but is highly optimized for XSLT processing and the `XPath` data model.

   ```csharp
   // Open the XML.
   docNav = new XPathDocument(@"c:\books.xml");
   ```

6. Create an `XPathNavigator` from the document. The `XPathNavigator` object is used for read-only XPath queries. The XPath queries might return a resulting value or many nodes.

   ```csharp
   // Create a navigator to query with XPath.
   nav = docNav.CreateNavigator();
   ```

7. Create an XPath expression to find the average cost of a book. This XPath expression returns a single value. For full details about XPath syntax, see **XPath Syntax** in the "[References](#related-content)" section.

   ```csharp
   // Find the average cost of a book.
   // This expression uses standard XPath syntax.
   strExpression = "sum(/bookstore/book/price) div count(/bookstore/book/price)";
   ```

8. Use the `Evaluate` method of the `XPathNavigator` object to evaluate the XPath expression. The `Evaluate` method returns the results of the expression.

   ```csharp
   // Use the Evaluate method to return the evaluated expression.
   Console.WriteLine("The average cost of the books are {0}", nav.Evaluate(strExpression));
   ```

9. Create an XPath expression to find all the books that cost more than 10 dollars. This XPath expression returns only Title nodes from the XML source.

   ```csharp
   // Find the title of the books that are greater then $10.00.
   strExpression = "/bookstore/book/title[../price>10.00]";
   ```

10. Create an `XPathNodeIterator` for the nodes that are selected together with the `Select` method of the `XPathNavigator`. The `XPathNodeIterator` represents an XPath nodeset, and supports operations on this nodeset.

    ```csharp
    // Select the node and place the results in an iterator.
    NodeIter = nav.Select(strExpression);
    ```

11. To move through the selected nodes, use the `XPathNodeIterator` that was returned from the `Select` method of `XPathNavigator`. In this case, you can use the `MoveNext` method of the `XPathNodeIterator` to iterate through all the selected nodes.

    ```csharp
    Console.WriteLine("List of expensive books:");
    //Iterate through the results showing the element value.
    while (NodeIter.MoveNext())
    {
        Console.WriteLine("Book Title: {0}", NodeIter.Current.Value);
    };
    ```

12. Use the `ReadLine` method to add a pause at the end of the console display to more readily display the results from the previous steps.

    ```csharp
    // Pause
    Console.ReadLine();
    ```

13. Build and run your project.

    > [!NOTE]
    > The results are displayed in the console window.

### Troubleshooting

When you test the code, you might receive the following exception error message:

```console
An unhandled exception of type System.Xml.XmlException occurred in System.xml.dll  
Additional information: System error.
```

This exception occurs on the following line of code:

```csharp
docNav = new XPathDocument("c:\\books.xml");
```

The error is caused by an invalid processing instruction. For example, the processing instruction might contain extraneous spaces. The following example is an invalid processing instruction:

```xml
<?xml version='1.0' ?>
```

To resolve the exception, use one of the following resolutions:

- Correct the invalid processing instruction. The following example is a valid processing instruction:

   ```xml
   <?xml version='1.0'?>
   ```

- Remove the XML processing instruction from the Books.xml file.

## Related content

- [Download Books.xml](https://download.microsoft.com/download/xml/utility/1.0.0.1/wxp/en-us/books.exe)
- [XPathDocument Class](/dotnet/api/system.xml.xpath.xpathdocument)
- [XPath Syntax](/previous-versions/dotnet/netframework-3.5/ms256471(v%3dvs.90))
