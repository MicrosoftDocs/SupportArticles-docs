---
title: Read XML data from a URL by using C#
description: Describes how to use the XmlTextReader class to read XML from a URL by using Visual C#. Also provides a code sample that illustrates this task.
ms.date: 04/13/2020
ms.reviewer: INDIRAD
ms.topic: how-to
---
# Use Visual C# to read XML data from a URL

This article shows you how to use the `XmlTextReader` class to read XML from a URL. The streamed information can come from all kinds of sources, such as a byte stream from a server, a file, or a `TextReader` class.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 307643

## Requirements

This article assumes that you're familiar with the following topics:

- Microsoft Visual Studio
- XML terminology
- Creating and reading XML
- URLs and creating an XML endpoint

This article refers to the .NET Framework Class Library namespace `System.Xml`.

## How to read XML data from a URL

This example uses a file named *Books.xml*. You can create your own *Books.xml* file or use the sample file that is included with the .NET Software Development Kit (SDK) QuickStarts. This file is also available for download; refer to the first item in the [References](#references) section of this article for the download location.

1. Copy the *Books.xml* file to the `\Inetpub\Wwwroot` folder on your computer.
2. Open Visual Studio.
3. Create a new Visual C# Console Application. You can either continue to the [Complete code listing](#complete-code-listing) section or continue through these steps to build the application.
4. Specify the using directive on the `System.Xml` namespace so that you aren't required to qualify the `XmlTextReader` class declarations later in your code. You must use the using directive before any other declarations.

    ```csharp
    using System.Xml;
    ```

5. Retrieve the XML stream by means of a URL. Streams are used to provide independence from the device; thus, program changes aren't required if the source of a stream changes. Declare a constant for the `http://localhost/books.xml` URL. You'll use the constant in the next step with `XmlTextReader`. Add the following code sample to the main procedure of the default class:

    ```csharp
    String URLString = "http://localhost/books.xml";
    ```

6. Create an instance of the `XmlTextReader` class, and specify the URL. Typically, `XmlTextReader` is used if you need to access the XML as raw data without the overhead of a Document Object Model (DOM); thus, `XmlTextReader` provides a faster mechanism for reading the XML. The `XmlTextReader` class has different constructors to specify the location of the XML data. The following code creates an instance of an `XmlTextReader` object and passes the URL to the constructor:

    ```csharp
    XmlTextReader reader = new XmlTextReader (URLString);
    ```

7. Read through the XML.

    > [!NOTE]
    > This step shows a basic, outer `while` loop, and the next two steps describe how to use that loop and read XML.

    After it is loaded, `XmlTextReader` performs sequential reads to move across the XML data and uses the `Read` method to obtain the next record. The `Read` method returns false if there are no more records.

    ```csharp
    while (reader.Read())
    {
        // Do some work here on the data.
        Console.WriteLine(reader.Name);
    }
    Console.ReadLine();
    ```

8. Inspect the nodes. To process the XML data, each record has a node type that can be determined from the `NodeType` property. The `Name` and `Value` properties return the node name (the element and attribute names) and the node value (the node text) of the current node (or record). The `NodeType` enumeration determines the node type. The following sample code displays the name of the elements and the document type.

    > [!NOTE]
    > This example ignores element attributes.

    ```csharp
    while (reader.Read())
    {
        switch (reader.NodeType)
        {
            case XmlNodeType.Element: // The node is an element.
                Console.Write("<" + reader.Name);
                Console.WriteLine(">");
                break;

            case XmlNodeType.Text: //Display the text in each element.
                Console.WriteLine (reader.Value);
                break;

            case XmlNodeType. EndElement: //Display the end of the element.
                Console.Write("</" + reader.Name);
                Console.WriteLine(">");
                break;
        }
    }
    ```

9. Inspect the attributes. Element node types can include a list of attribute nodes that are associated with them. The `MovetoNextAttribute` method moves sequentially through each attribute in the element. Use the `HasAttributes` property to test whether the node has any attributes. The `AttributeCount` property returns the number of attributes for the current node.

    ```csharp
    while (reader.Read())
    {
        switch (reader.NodeType)
        {
            case XmlNodeType.Element: // The node is an element.
                Console.Write("<" + reader.Name);

                while (reader.MoveToNextAttribute()) // Read the attributes.
                    Console.Write(" " + reader.Name + "='" + reader.Value + "'");
                Console.Write(">");
                Console.WriteLine(">");
                break;
            case XmlNodeType.Text: //Display the text in each element.
                Console.WriteLine (reader.Value);
                break;
            case XmlNodeType. EndElement: //Display the end of the element.
                Console.Write("</" + reader.Name);
                Console.WriteLine(">");
                break;
        }
    }
    ```

10. Build and run your project.

## Complete code listing

```csharp
using System;
using System.Xml;

namespace ReadXMLfromURL
{
    /// <summary>
    /// Summary description for Class1.
    /// </summary>
    class Class1
    {
        static void Main(string[] args)
        {
            String URLString = "http://localhost/books.xml";
            XmlTextReader reader = new XmlTextReader (URLString);

            while (reader.Read())
            {
                switch (reader.NodeType)
                {
                    case XmlNodeType.Element: // The node is an element.
                        Console.Write("<" + reader.Name);

                        while (reader.MoveToNextAttribute()) // Read the attributes.
                            Console.Write(" " + reader.Name + "='" + reader.Value + "'");
                        Console.Write(">");
                        Console.WriteLine(">");
                        break;
                    case XmlNodeType.Text: //Display the text in each element.
                        Console.WriteLine (reader.Value);
                        break;
                    case XmlNodeType. EndElement: //Display the end of the element.
                        Console.Write("</" + reader.Name);
                        Console.WriteLine(">");
                        break;
                }
            }
        }
    }
}
```

## Sample output

```xml
<bookstore>
    <book genre="autobiography" publicationdate="1981" ISBN="1-861003-11-0">
        <title>
        The Autobiography of Benjamin Franklin
        </title>
        <author>
            <first-name>
            Benjamin
            </first-name>
            <last-name>
            Franklin
            </last-name>
        </author>
        <price>
        8.99
        </price>
    </book>
    <book genre="novel" publicationdate="1967" ISBN="0-201-63361-2">>
        <title>
        The Confidence Man
        </title
        <author>
            <first-name>
            Herman
            </first-name>
            <last-name>
            Melville
            </last-name>
        </author>
        <price>
        11.99
        </price>
    </book>
    <book genre="philosophy" publicationdate="1991" ISBN="1-861001-57-6">
        <title>
        The Gorgias
        </title>
        <author>
            <name>
            Plato
            </name>
        </author>
        <price>
        9.99
        </price>
    </book>
</bookstore>
```

## Troubleshooting

When you test the code, you may receive the following exception error message:

> An unhandled exception of type System.Xml.XmlException occurred in system.xml.dll Additional information: Unexpected XML declaration. The XML declaration must be the first node in the document, and no white space characters are allowed to appear before it. Line 1, position 4.

The exception error occurs on the following line of code.

```csharp
while (reader.Read())
```

To resolve the exception error, remove the white-space character that precedes the first node in the *Books.xml* document.

## References

- [XML in .NET: .NET Framework XML Classes and C# Offer Simple, Scalable Data Manipulation](/previous-versions/bb985993(v=msdn.10))

- [XmlReader Class](/dotnet/api/system.xml.xmlreader)
