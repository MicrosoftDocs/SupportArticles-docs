---
title: Specify namespace when you query DOM with XPath
description: This article describes that you must use qualified names when you use XPath query with the selectSingleNode and selectNodes methods of the IXMLDOMNode object.
ms.date: 10/20/2020
ms.prod-support-area-path: 
ms.prod: visual-cpp
---
# Specify Namespace when you query the DOM with XPath

This article describes that you must use qualified names when you use XPath query with the selectSingleNode and `selectNodes` methods of the `IXMLDOMNode` object.

_Original product version:_ &nbsp; Microsoft XML Parser  
_Original KB number:_ &nbsp; 294797

## Summary

With the XML Parser (MSXML) 3.0 release, `XPath` provides a convenient way to query XML documents and return a node or a node set. When you use `XPath` query with the `selectSingleNode` and `selectNodes` methods of the `IXMLDOMNode` object, you must use qualified names. For example, to select the Book node with the following XML data:

```xml
<?xml version ="1.0"?>
<a:Books xmlns:a="x-schema:bookschema.xml" >
    <a:Book>
        <title>Presenting XML</title>
        <author>Richard Light</author>
    </a:Book>
</a:Books>
```

if we use a as the alias of the `x-schema:bookschema.xml` Uniform Resource Identifier (URI), the corresponding XPath query is the following:

```xml
pXMLDoc->setProperty("SelectionNamespaces","xmlns:a='x-schema:bookschema.xml'");
pXMLDoc->documentElement->selectNodes("/a:Books/a:Book");
```

In this case, using the qualified name is straightforward. When the default namespace is used, however, using the qualified name can be more difficult, as in the following example:

```xml
<?xml version ="1.0"?>
<Books xmlns="x-schema:bookschema.xml" >
    <Book>
        <title>Presenting XML</title>
        <author>Richard Light</author>
    </Book>
</Books>
```

> [!NOTE]
> No prefix is used in the node tags. The qualified name must still be used inside the XPath query, otherwise the query (for example, /Books/Book) returns no result because there are no matching nodes.

## More information

The following Visual C++ sample is provided to demonstrate the technique.

To specify the namespace when you query the DOM with XPath, follow these steps:

1. Create a Win32 console project, and add a new .cpp file to the project. Paste the following code into the .cpp file and name the file Test.cpp:

    ```cpp
    #include <stdio.h>

    #import "msxml3.dll"
    using namespace MSXML2;

    void dump_com_error(_com_error &e);

    int main(int argc, char* argv[])
    {
        CoInitialize(NULL);
        try{
            IXMLDOMDocument2Ptr pXMLDoc;
            HRESULT hr = pXMLDoc.CreateInstance(__uuidof(DOMDocument));

            pXMLDoc->async = false; // default - true,

            pXMLDoc->validateOnParse = true;

            hr = pXMLDoc->load("books.xml");

            if(hr!=VARIANT_TRUE)
            {
                IXMLDOMParseErrorPtr pError;

                pError = pXMLDoc->parseError;
                _bstr_t parseError =_bstr_t("At line ")+ _bstr_t(pError->Getline()) + _bstr_t("\n")+
                _bstr_t(pError->Getreason());
                MessageBox(NULL,parseError, "Parse Error",MB_OK);
                return -1;
            }

            hr = pXMLDoc->setProperty("SelectionLanguage", "XPath");
            hr = pXMLDoc->setProperty("SelectionNamespaces", "xmlns:a='x-schema:bookschema.xml'");

            IXMLDOMNodeListPtr pNodeList;
            pNodeList = pXMLDoc->documentElement->selectNodes("/a:Books/a:Book");
            int count = pNodeList->Getlength();
            char pLength[64];
            sprintf(pLength, "Total number of nodes selected is %d", count);
            MessageBox(NULL,pLength,"Test", MB_OK);

        }
        catch(_com_error &e)
        {
            dump_com_error(e);
            return -1;
        }
        return 0;
    }

    void dump_com_error(_com_error &e)
    {
        printf("Error\n");
        printf("\a\tCode = %08lx\n", e.Error());
        printf("\a\tCode meaning = %s", e.ErrorMessage());
        _bstr_t bstrSource(e.Source());
        _bstr_t bstrDescription(e.Description());
        printf("\a\tSource = %s\n", (LPCSTR) bstrSource);
        printf("\a\tDescription = %s\n", (LPCSTR) bstrDescription);
    }
    ```

2. Save the following XML as Books.xml in the same project folder as Test.cpp.

    ```xml
    <?xml version ="1.0"?>
    <Books xmlns="x-schema:bookschema.xml" >
    <Book>
    <title>Presenting XML</title>
    <author>Richard Light</author>
    <pages>334</pages>
    </Book>
    <Book>
    <title>Mastering XML</title>
    <author>John Smith</author>
    <pages>209</pages>
    </Book>
    </Books>
    ```

3. Save the following XML as Bookschema.xml in the same project folder as Test.cpp.

    ```xml
    <?xml version="1.0"?>
    <Schema xmlns="urn:schemas-microsoft-com:xml-data">
    <ElementType name="title" />
    <ElementType name="author" />
    <ElementType name="pages" />
    <ElementType name="Book" model="closed">
    <element type="title" />
    <element type="author" />
    <element type="pages" />
    </ElementType>
    <ElementType name="Books" model="closed">
    <element type="Book" />
    </ElementType>
    </Schema>
    ```

4. Compile and run the application. A message box shows the number of nodes that are returned by the `XPath` query. See the following:

    - The same sample code can used with an explicit URI as a namespace.
    - In the following lines

        ```xml
        IXMLDOMDocument2Ptr pXMLDoc;
        ...
        hr = pXMLDoc->setProperty("SelectionLanguage", "XPath");
        hr = pXMLDoc->setProperty("SelectionNamespaces", "xmlns:a='x-schema:bookschema.xml'");
        ...
        pNodeList = pXMLDoc->documentElement->selectNodes("/a:Books/a:Book");
        ```

       the `setProperty` method is not available with the `IXMLDOMDocument` interface.

A qualified name (QName) is composed of a prefix and a local part. The prefix provides the namespace prefix of the qualified name, and must be associated with a namespace URI.

## References

[How to use XPath to query against a user-defined default namespace](https://support.microsoft.com/help/288147)
