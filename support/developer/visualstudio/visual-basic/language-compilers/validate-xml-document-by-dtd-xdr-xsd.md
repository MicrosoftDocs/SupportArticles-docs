---
title: Validate an XML document by using DTD, XDR, or XSD
description: This article describes how to use the XmlValidatingReader class to validate an XML document against a DTD, an XDR schema, or an XSD schema in Visual Basic 2005 or in Visual Basic .NET. Also describes how to optimize validation by caching schemas.
ms.date: 10/26/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Validate an XML document by using DTD, XDR, or XSD in Visual Basic  

This article shows how to use the `XmlValidatingReader` class to validate an XML document against a DTD, an XDR schema, or an XSD schema in Visual Basic 2005 or in Visual Basic .NET. Also describes how to optimize validation by caching schemas.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 315533

## Summary

Extensible Markup Language (XML) documents contain elements and attributes, and provide a flexible and powerful way to exchange data between applications and organizations. To specify the allowable structure and content of an XML document, you can write a Document Type Definition (DTD), a Microsoft XML-Data Reduced (XDR) schema, or an XML Schema definition language (XSD) schema.

XSD schemas are the preferred way to specify XML grammars in the .NET Framework, but DTDs and XDR schemas are also supported.

In this article, you will learn how to apply a DTD, an XDR schema, or an XSD schema to an XML document in Microsoft Visual Basic 2005 or in Microsoft Visual Basic .NET. You will then learn how to use the XmlValidatingReader class to validate an XML document against the specified grammar. You will also learn how to use the XmlSchemaCollection class to cache schemas in memory as a way to optimize XML validation.

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need: Microsoft Visual Basic 2005 or Microsoft Visual Basic .NET

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Xml`
- `System.Xml.Schema`

This article assumes that you are familiar with the following topics:

- Visual Basic 2005 or Visual Basic .NET syntax
- XML concepts, including validation issues

## Create an XML document

1. Start Microsoft Visual Studio 2005 or Microsoft Visual Studio .NET. Then, create a new XML file (on the File menu, point to **New**, and then click File).
2. Select the XML File type, and then click **Open**.
3. Add the following data to the XML document to represent a product in a catalog:

    ```xml
    <Product ProductID="123">
        <ProductName>Rugby jersey</ProductName>
    </Product>
    ```

4. Save the file as *Product.xml* in a folder that you will be able to readily access later (the code samples in this article assume a folder named `C:\MyFolder`).

## Create a DTD and link to the XML document

1. In Visual Studio 2005 or in Visual Studio .NET, point to New on the File menu, and then click File.
2. Select the Text File type, and then click **Open**.
3. Add the following DTD declarations to the file to describe the grammar of the XML document:

    ```xml
    <!ELEMENT Product (ProductName)>
    <!ATTLIST Product ProductID CDATA #REQUIRED>
    <!ELEMENT ProductName (#PCDATA)>
    ```

4. Save the file as *Product.dtd* in the same folder as your XML document.
5. Reopen *Product.xml* in Visual Studio 2005 or in Visual Studio .NET; to do this, point to Open on the File menu, and then click **File**. Add a DOCTYPE statement (below the `?xml version="1.0"` line), as follows. This links the XML document to the DTD file).

    ```xml
    <?xml version="1.0" encoding="utf-8" ?>
    <!DOCTYPE Product SYSTEM "Product.dtd">
    ```

6. Save the modified XML document as *ProductWithDTD.xml*.

## Perform validation by using a DTD

1. In Visual Studio 2005 or in Visual Studio .NET, create a new Visual Basic Console Application project named *ValidateXmlUsingVB*.
2. Visual Studio 2005 or Visual Studio .NET displays a new file named *Module1.vb*. At the beginning of this file, add two Imports statements, as follows:

    ```vbnet
    Imports System.Xml ' For XmlTextReader and XmlValidatingReader
    Imports System.Xml.Schema ' For XmlSchemaCollection (used later)
    ```

3. In Module1 (before the start of the Main subroutine), declare a boolean variable named isValid, as follows:

    ```vbnet
    'If a validation error occurs,
    ' you will set this flag to False 
    ' in the validation event handler. 
    Private isValid As Boolean = True
    ```

4. In the Main subroutine, create an XmlTextReader object to read an XML document from a text file. Then, create an `XmlValidatingReader` object to validate this XML data:

    ```vbnet
    Dim r As New XmlTextReader("C:\MyFolder\ProductWithDTD.xml")
    Dim v As New XmlValidatingReader(r)
    ```

5. The XmlValidatingReader     object has a ValidationType     property, which indicates the type of validation required (DTD, XDR, or Schema). Set this property to DTD, as follows:

    ```vbnet
    v.ValidationType = ValidationType.DTD
    ```

6. If any validation errors occur, the validating reader generates a validation event. Add the following code to register a validation event handler (you will implement the MyValidationEventHandler subroutine in step 8 of this section):

    ```vbnet
    AddHandler v.ValidationEventHandler, AddressOf MyValidationEventHandler
    ```

7. Add the following code to read and validate the XML document. If any validation errors occur, MyValidationEventHandler will be called to handle the error. This subroutine will set `isValid` to *False* (see step 8 of this section). You can check the status of isValid after validation to see whether the document is valid or invalid.

    ```vbnet
    While v.Read()' Could add code here to process the content.
    End While
    v.Close()' Check whether the document is valid or invalid.
    If isValid Then
        Console.WriteLine("Document is valid")
    Else
        Console.WriteLine("Document is invalid")
    End If
    ```

8. After the Main subroutine, write the MyValidationEventHandler subroutine, as follows:

    ```vbnet
    Public Sub MyValidationEventHandler(ByVal sender As Object, _
     ByVal args As ValidationEventArgs)
         isValid = False
         Console.WriteLine("Validation event" & vbCrLf & args.Message)
    End Sub
    ```

9. Build and run the application.

The application should report that the XML document is valid.
10. In Visual Studio 2005 or in Visual Studio .NET, modify ProductWithDTD.xml to make it invalid (for example, delete the **ProductName** Rugby jersey/ **ProductName** element).
11. Run the application again.

The application should display the following error message:

> Validation event Element 'Product' has incomplete content. Expected 'ProductName'. An error occurred at file:///C:/MyFolder/ProductWithDTD.xml(4, 3). Document is invalid

## Create an XDR schema and link to the XML document

1. In Visual Studio 2005 or in Visual Studio .NET, point to New on the File menu, and then click File.
2. Select the Text File type, and then click **Open**.
3. Add the following XDR schema definitions to the file to describe the grammar of the XML document:

    ```xml
    <?xml version="1.0"?>
    <Schema name="ProductSchema" 
     xmlns="urn:schemas-microsoft-com:xml-data"
     xmlns:dt="urn:schemas-microsoft-com:datatypes">

        <AttributeType name="ProductID" dt:type="int"/>
        <ElementType name="ProductName" dt:type="string"/>

        <ElementType name="Product" content="eltOnly">
            <attribute type="ProductID" required="yes"/>
            <element type="ProductName"/>
        </ElementType>
    </Schema>
    ```

4. Save the file as *Product.xdr* in the same folder as your XML document.
5. Reopen the original *Product.xml*, and then link it to the XDR schema, as follows:

    ```xml
    <?xml version="1.0" encoding="utf-8" ?>
    <Product ProductID="123" xmlns="x-schema:Product.xdr"> 
        <ProductName>Rugby jersey</ProductName>
    </Product>
    ```

6. Save the modified XML document as *ProductWithXDR.xml*.

## Perform validation by using an XDR schema

1. Modify your application so that the XmlTextReader loads *ProductWithXDR.xml*, as follows:

    ```vbnet
    Dim r As New XmlTextReader("C:\MyFolder\ProductWithXDR.xml")
    ```

2. Set the `ValidationType` to XDR so that the validating reader performs XDR validation, as follows:

    ```vbnet
    v.ValidationType = ValidationType.XDR
    ```

3. Build and run the application.

    The application should report that the XML document is valid.
4. Modify *ProductWithXDR.xml* to make it deliberately invalid.
5. Run the application again.

    The application should report a validation error.

## Create an XSD schema and link to the XML document

1. In Visual Studio .NET, point to New on the File menu, and then click File.
2. Select the Text File type, and then click **Open**.
3. Add the following XSD schema definition to the file to describe the grammar of the XML document:

    ```xml
    <?xml version="1.0"?>
    <xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <xsd:element name="Product">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="ProductName" type="xsd:string"/>
            </xsd:sequence>
            <xsd:attribute name="ProductID" use="required" type="xsd:int"/>
        </xsd:complexType>
        </xsd:element>
    </xsd:schema>
    ```

4. Save the file as Product.xsd in the same folder as your XML document.
5. Reopen the original *Product.xml*, and then link it to the XSD schema, as follows:

    ```xml
    <?xml version="1.0" encoding="utf-8" ?>
    <Product ProductID="123" 
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
     xsi:noNamespaceSchemaLocation="Product.xsd">
        <ProductName>Rugby jersey</ProductName>
    </Product>
    ```

6. Save the modified XML document as *ProductWithXSD.xml*.

## Perform validation by using an XSD schema

1. Modify your application so that the `XmlTextReader` loads *ProductWithXSD.xml*, as follows:

    ```vbnet
    Dim r As New XmlTextReader("C:\MyFolder\ProductWithXSD.xml")
    ```

2. Set the `ValidationType` to Schema so that the validating reader performs XSD schema validation, as follows:

    ```vbnet
    v.ValidationType = ValidationType.Schema
    ```

3. Build and run the application to validate the XML document by using the XSD schema.

    The application should report that the XML document is valid.

## Use namespaces in the XSD schema

1. In Visual Studio 2005 or in Visual Studio .NET, open *ProductWithXSD.xml*. Declare a default namespace, `urn:MyNamespace`, in the document. Modify the XSD linkage to specify the XSD schema to validate content in this namespace, as follows:

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <Product ProductID="123" 
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
     xmlns="urn:MyNamespace"
     xsi:schemaLocation="urn:MyNamespace Product.xsd">
        <ProductName>Rugby jersey</ProductName>
    </Product>
    ```

2. Save *ProductWithXSD.xml*.
3. Open Product.xsd, click the XML tab, and then modify the **xsd:schema** start tag as follows, so that the schema applies to the namespace `urn:MyNamespace`:

    ```xml
    <xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"
     targetNamespace="urn:MyNamespace"
     elementFormDefault="qualified">
    ```

4. Save *Product.xsd*.
5. Run the application to validate the XML document by using the XSD schema.

## Cache namespaces

1. In Visual Studio 2005 or in Visual Studio .NET, open Module1.vb. At the start of the Main subroutine, create an `XmlSchemaCollection` object, as follows:

    ```vbnet
    Dim cache As New XmlSchemaCollection()
    ```

2. The `XmlSchemaCollection` object allows you to cache schemas in memory for improved performance. Each schema is associated with a different namespace. Add the following code to cache *Product.xsd*:

    ```vbnet
    cache.Add("urn:MyNamespace", "C:\MyFolder\Product.xsd")
    ```

3. After the code that creates the `XmlValidatingReader` object, add the following statement. This adds the schema cache to the `XmlValidatingReader` , so that the reader can use the in-memory schemas.

    ```vbnet
    v.Schemas.Add(cache)
    ```

## Verification

1. Build and run the application.
2. Verify that the XML document is still being validated against the XSD schema.
3. Make some changes to the *ProductWithXSD.xml* to deliberately make it invalid.
4. Verify that the application detects these validation errors.
