---
title: Read the XML data from a file
description: This article describes how to use the XmlTextReader class to read the XML data from a file. Describes how to do fast, tokenized stream access to the XML data instead of using an object model, such as the XML DOM.
ms.date: 09/24/2020
ms.custom: sap:Language or Compilers
ms.reviewer: willchen
ms.topic: how-to
---
# Read the XML data from a file by using Visual C++

This article shows how to use the `XmlTextReader` class to read the XML data from a file.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 815658

## Summary

This article describes how to use the `XmlTextReader` class to read the XML data from a file. The `XmlTextReader` class provides direct parsing and tokenizing of the XML data. The
`XmlTextReader` class also implements the XML 1.0 specification, in addition to the namespaces, in the XML specification that is defined by the World Wide Web Consortium (W3C). This article describes how to do fast, tokenized stream access to the XML data instead of using an object model, such as the XML Document Object Model (DOM).

For a Microsoft Visual C# .NET version of this article, see [How to read XML from a file by using Visual C#](https://support.microsoft.com/help/307548).  

This article refers to the following Microsoft .NET Framework Class Library namespace: `System.xml`

## Requirements

This article assumes that you are familiar with the following topics:  

- XML terminology
- How to create and how to read an XML file

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need:

- Microsoft Visual Studio .NET
- Microsoft Visual Studio 2005

## Read the XML data from a file

The example in this article uses a file that is named *Books.xml*. You can create your own Books.xml file, or you can use the sample file that is included with the Microsoft .NET Software Development Kit (SDK) QuickStarts. You must copy the Books.xml file to the project folder.

To read the XML data from a file, follow these steps:

1. Start Visual Studio .NET 2002, Visual Studio .NET 2003, or Visual Studio 2005.
2. On the **File** menu, point to **New**, and then click **Project**.

    The **New Project** dialog box appears.

3. Under **Project Types**, click **Visual C++ Projects**.

    > [!NOTE]
    > In Visual Studio 2005, **Visual C++ Projects** is changed to **Visual C++**.

4. Under **Templates**, click **Managed C++ Application** if you are using Visual Studio .NET 2002.

    Under **Templates**, click **Console Application (.NET)** if you are using Visual Studio .NET 2003.

    Under **Templates**, click **CLR Console Application** if you are using Visual Studio 2005.

5. In the **Name** box, type *Q815658*, and then click **OK**.
6. Add a reference to `System.xml.dll` in the project. For more information about how to add references to a managed Visual C++ project, see [Add references to a managed Visual C++ project](/troubleshoot/cpp/add-references-managed)

7. Specify the using directive in the `System::Xml` namespace as follows:

    ```cpp
    using namespace System::Xml;
    ```

    You do this so that you do not have to qualify the `XmlTextReader` class declarations later in your code. You must use the using directive before any other declarations.
8. Create an instance of the `XmlTextReader` object. Populate the `XmlTextReader` object with the .xml file.

    Typically, the `XmlTextReader` class is used if you have to access the raw XML data without the overhead of the DOM. Therefore, the `XmlTextReader` class provides a faster way to read the XML data. The `XmlTextReader` class has different `constructors` that specify the location of the XML data.
  
    The following code creates an instance of the `XmlTextReader` class and then loads the *Books.xml* file. Add the following code to the `_tmain` function:
  
    ```cpp
    XmlTextReader* reader = new XmlTextReader ("books.xml");
    ```

    > [!NOTE]
    > In Visual C++ 2005, the `_tmain` function is changed to the main function.
9. Read through the XML data.

    > [!NOTE]
    > This step demonstrates an outer *while* loop. The two steps that follow this step demonstrate how to use the *while* loop to read the XML data.
  
    After you create the `XmlTextReader` object, use the Read method to read the XML data.
  
    The Read method continues to sequentially move through the .xml file until the Read method reaches the end of the file. When the Read method reaches the end of the file, the Read method returns false.

    ```cpp
    while (reader->Read())
    {
        // Do some work here on the data.
        Console::WriteLine(reader->Name);
    }
    ```

10. Examine the nodes.

    To process the XML data, each record has a node type that can be determined from the `NodeType` property. The `Name` property and the `Value` property return the following information for the current node or for the current record:
  
    - The node name that is the element name and the attribute name.
    - The node value that is the node text.
  
    The `NodeType` enumeration determines the node type. The following code sample displays the name of the elements and the document type. The following code sample ignores element attributes:
  
    ```cpp
    while (reader->Read())
    {
        switch (reader->NodeType)
        {
            case XmlNodeType::Element: // The node is an element.
                Console::Write("<{0}", reader->Name);
                Console::WriteLine(">");
                break;
            case XmlNodeType::Text: //Display the text in each element.
                Console::WriteLine (reader->Value);
                break;
            case XmlNodeType::EndElement: //Display the end of the element.
                Console::Write("</{0}", reader->Name);
                Console::WriteLine(">");
                break;
        }
    }
    ```

11. Examine the attributes.

    Element node types can include a list of attribute nodes that are associated with the element node types. The `MovetoNextAttribute` method sequentially moves through each attribute in the element. Use the `HasAttributes` property to test whether the node has any attributes. The `AttributeCount` property returns the number of attributes for the current node.
  
    ```cpp
    while (reader->Read())
    {
        switch (reader->NodeType)
        {
            case XmlNodeType::Element: // The node is an element.
                Console::Write("<{0}", reader->Name);
  
                while (reader->MoveToNextAttribute()) // Read the attributes.
                    Console::Write(" {0}='{1}'", reader->Name, reader->Value);
                Console::WriteLine(">");
                break;
            case XmlNodeType::Text: //Display the text in each element.
                Console::WriteLine (reader->Value);
                break;
            case XmlNodeType::EndElement: //Display the end of the element.
                Console::Write("</{0}", reader->Name);
                Console::WriteLine(">");
                break;
        }
    }
    ```

12. Save the solution. Build the solution.
13. Press CTRL+F5 to run the sample application.

## View the complete code listing in Visual Studio .NET 2002 or in Visual Studio .NET 2003

```cpp
#include "stdafx.h"
#include <tchar.h>

#using <mscorlib.dll>
#using <System.xml.dll>

using namespace System;
using namespace System::Xml;

void _tmain(void)
{
    XmlTextReader* reader = new XmlTextReader ("books.xml");

    while (reader->Read())
    {
        switch (reader->NodeType)
        {
            case XmlNodeType::Element: // The node is an element.
                Console::Write("<{0}", reader->Name);
  
                while (reader->MoveToNextAttribute()) // Read the attributes.
                    Console::Write(" {0}='{1}'", reader->Name, reader->Value);
                Console::WriteLine(">");
                break;
            case XmlNodeType::Text: //Display the text in each element.
                Console::WriteLine (reader->Value);
                break;
            case XmlNodeType::EndElement: //Display the end of the element.
                Console::Write("</{0}", reader->Name);
                Console::WriteLine(">");
                break;
        }
    }
    Console::ReadLine();
}
```

> [!NOTE]
> You must add the common language runtime support compiler option (`/clr:oldSyntax`) in Visual C++ 2005 to successfully compile the previous code sample. To add the common language runtime support compiler option in Visual C++ 2005, follow these steps:

1. Click **Project**, and then click **\<ProjectName>** Properties.

    > [!NOTE]
    > **\<ProjectName>** is a placeholder for the name of the project.
2. Expand **Configuration Properties**, and then click **General**.

3. Click to select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** in the **Common Language Runtime support** project setting in the right pane, click **Apply**, and then click **OK**.

    For more information about the common language runtime support compiler option, see [/clr (Common Language Runtime Compilation)](/cpp/build/reference/clr-common-language-runtime-compilation).

These steps apply to the whole article.

## View the sample output

```xml
<bookstore>
    <book genre='autobiography' publicationdate='1981' ISBN='1-861003-11-0'>
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
    <book genre='novel' publicationdate='1967' ISBN='0-201-63361-2'>
        <title>
        The Confidence Man
        </title>
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
    <book genre='philosophy' publicationdate='1991' ISBN='1-861001-57-6'>
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

When you run the sample application, you may receive the following error message:

> An unhandled exception of type System.Xml.XmlException occurred in System.xml.dll
Additional information: System error.

## References

For more information about reading XML with the XmlReader, see [Reading XML with the XmlReader](/previous-versions/dotnet/netframework-1.1/aa720470(v=vs.71)).
