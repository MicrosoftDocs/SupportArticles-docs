---
title: Can't import attribute-centric XML
description: Explains why you cannot import all tables of an XML document. This article gives solutions to the problem.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CI 162681
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: REBC
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# You cannot import attribute-centric XML in Access

Advanced: Requires expert coding, interoperability, and multiuser skills.

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Symptoms

When you import an XML document, at least one blank table is imported or not all of the data is imported. Depending on the structure of the XML document, more than one table may actually be imported.

## Cause

If a blank table is imported, it typically indicates that the data of the source XML document is attribute-centric. Microsoft Access supports only element-centric XML. XML that is persisted from ADO recordsets is created in attribute-centric XML.

## Resolution

This article shows you how to import XML data that is created by persisting an ADO Recordset to its XML format. The transform that is supplied in this article applies to the ADO XML persisted format.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. In order to import attribute-centric XML into Access, you must first create and apply an XML Transformation (XSLT) to the source document. This process creates a new XML document that is element-centric and can be imported into Access.

### Create an XML Document from ADO

1. Create a new blank database and name it ImportADOXML.mdb.
2. On the **Insert** menu, click **Module**.

   **Note** In Access 2007, click **Macro** in the **Other** group on the **Create** tab, and then click **Module**.
3. In the Visual Basic Editor, type or paste the following code into the new module:

    ```vb
     Sub CreateADOXML()
      'Persists an ADO recordset to XML
      Dim cn As ADODB.Connection
      Dim rs As ADODB.Recordset

     'Open an ADO Connection object
     'If the path to Northwind differs on your machine, you will need to
     'adjust the Data Source property accordingly.
     Set cn = New ADODB.Connection
     With cn
        .Provider = "Microsoft.Jet.OLEDB.4.0"
        .ConnectionString = "Data Source=C:\Program Files\Microsoft " & _
          "Office\Office10\Samples\Northwind.mdb"
        .Open
     End With

     'Open an ADO Recordset
     Set rs = New ADODB.Recordset
     With rs
        Set .ActiveConnection = cn
        .Source = "SELECT * FROM Customers WHERE Country='UK'"
        .CursorLocation = adUseServer
        .CursorType = adOpenForwardOnly
        .LockType = adLockReadOnly
        .Open
        'persist the recordset to XML
        .Save "C:\ado_customersUK.xml", adPersistXML
        .Close
     End With

     'Cleanup
     cn.Close
     Set rs = Nothing
     Set cn = Nothing
     End Sub
     ```

4. Save the module as basCreateADOXML.
5. In the Visual Basic Editor, click Immediate Window on the View menu to open the Immediate window.
6. Type the following code in the Immediate window, and then press ENTER:

    ```vb
    CreateADOXML
    ```

### Create the XSL Transform

Because the namespaces that are defined by ADO are not recognized by Access, the following transform defines these namespaces, but excludes them from the resulting output.

1. Start Notepad, and then type the following XSLT code:

   ```xsl
   <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rs="urn:schemas-microsoft-com:rowset"
    exclude-result-prefixes="rs">

   <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
    <!-- root element for the XML output -->
    <rootElement xmlns:z="#RowsetSchema" xsl:exclude-result-prefixes="z">

    <!-- for each z:row element in the ADO output -->
    <xsl:for-each select="/xml/rs:data/z:row">

    <!--
          This will be used for the table name imported into Access.
          Change this name to suit your needs.
         -->
        <TableName>
            <!-- 
              for each attribute of the z:row element in the ADO XML document
              -->
            <xsl:for-each select="@*">

    <!-- 
                  dynamically create elements and fill with attribute 
                  value using the XPath name() function
                 -->
                <xsl:element name="{name()}">
                    <xsl:value-of select="."/>
               </xsl:element>

    </xsl:for-each>
        </TableName>

    </xsl:for-each>
    </rootElement>
    </xsl:template>
    </xsl:stylesheet>

    ```

2. Save the document as ADOXMLToAccess.xsl in the same folder to which you save the ImportADOXML.mdb database.

### Apply the Transform and Import

To apply the XSL transform, you must use an XSLT processor such as the Microsoft MSXML3 processor, which is installed with Microsoft Office XP. The following steps use the XML Document Object Model to apply the transform that you created earlier to an ADO XML document and to import it into Access.

> [!NOTE]
> The sample code in this article uses the XML Document Object Model. For this code to run properly, you must reference the Microsoft XML 3.0 library. To do so, click References on the Tools menu in the Visual Basic Editor, and ensure that the **Microsoft XML, v3.0** check box is selected.

1. Start Microsoft Access and open the ImportADOXML.mdb database that you created earlier.
2. In the Database window, click **Modules** under **Objects**, and then click **New**.

    **Note** In Access 2007, click **Macro** in the **Other** group on the **Create** tab, and then click **Module**.
3. In the Visual Basic Editor, type or paste the following code in the module:

   ```vb
   Sub ImportXMLFromADO()

   'Uses the XML DOM to transform XML from ADO
    'to element-centric XML and imports into Access
    Dim domIn As DOMDocument30
    Dim domOut As DOMDocument30
    Dim domStylesheet As DOMDocument30

    Set domIn = New DOMDocument30

    domIn.async = False

    'Open the ADO xml document
    If domIn.Load("C:\ado_customersUK.xml") Then

    'Load the stylesheet
        'In this example you will need to change <PathToStylesheet> to
        'the actual path where you stored the ADOXMLToAccess.xsl file.    
        Set domStylesheet = New DOMDocument30
        domStylesheet.Load "<PathToStylesheet>\ADOXMLToAccess.xsl"

    'Apply the transform
        If Not domStylesheet Is Nothing Then
            Set domOut = New DOMDocument30
            domIn.transformNodeToObject domStylesheet, domOut

    'Save the output
            domOut.Save "c:\customersUK.xml"

    'Import the saved document into Access
            Application.ImportXML "c:\customersUK.xml"
        End If
    End If

    'Cleanup
    Set domIn = Nothing
    Set domOut = Nothing
    Set domStylesheet = Nothing

    MsgBox "done!", , "ImportXMLFromADO"
    End Sub
    ```

4. In the Visual Basic Editor, click Immediate Window on the View menu to open the Immediate Window.
5. Type the following code in the Immediate Window, and then press ENTER:

    ```vb
    ImportXMLFromADO
    ```

    **Note** that a table containing customers from the UK with the name that you specified for \<TableName\> is imported into Access. You may optionally delete the element-centric XML document that is created during the transformation.

## Status

This behavior is by design.

## References

For additional information about persisting an ADO Recordset to XML, see [Persisting records in XML format](/office/client-developer/access/desktop-database-reference/persisting-records-in-xml-format).
