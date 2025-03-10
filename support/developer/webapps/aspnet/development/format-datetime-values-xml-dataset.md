---
title: Format DateTime and Date Values in XML by VB .NET
description: Describes how to format DateTime and Date values of DataTable columns in the XML extracted from an ADO.NET DataSet by using Visual Basic .NET.
ms.date: 05/12/2020
ms.custom: sap:General Development
---
# How to format DateTime and Date values in the XML extracted from an ADO.NET DataSet by using Visual Basic .NET

This article describes how to format `DateTime` and `Date` values of `DataTable` columns in the XML that is extracted from an ADO.NET `DataSet` object.

_Original product version:_ &nbsp; Visual Basic .NET  
_Original KB number:_ &nbsp; 811767

## Summary

In ADO.NET, the `DateTime` and `Date` values of `DataTable` columns are written in the XSD `DateTime` and `Date` formats when the `DataSet` is saved as XML. The standard XSD `DateTime` and `Date` formats are CCYY-MM-DDThh:mm:ss and CCYY-MM-DD, respectively, because the underlying XSD schema of the `DataSet` maps the `DateTime` and `Date` columns of the database to the `DateTime` and XSD `Date` data types.

To generate XML where `DateTime` and `Date` values are represented in the required custom formats, use one of the following methods.

## Method 1: Use XmlConvert class

1. Open Microsoft Visual Studio .NET. In Visual Basic .NET, create a new ASP.NET web application project that is named *DateTimeXmlConvert*.
2. Right-click the designer surface of *WebForm1.aspx*, and then click **View Code**.
3. Add the following code to the end of `Imports` directives section in *WebForm1.aspx.vb*:

    ```vb
    Imports System.Xml
    Imports System.Text
    Imports System.Data.SqlClient
    ```

4. Paste the following code in the `Page_Load` event:

    ```vb
    ' Change SqlServerName, UserId and Password in the following connection string.
    Dim conn As String = "Server=<SQLServerName>; database=Northwind; user id=<UserID>; password=<Password>;"
    Dim connection As SqlConnection = New SqlConnection()
    connection.ConnectionString = conn

    Dim objDataSet As DataSet = New DataSet()
    Dim objAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim objCmd As SqlCommand = New SqlCommand()' Retrieve the first 10 records from the employees table.
    objCmd.CommandText = "select top 10 FirstName,BirthDate from employees"
    objCmd.Connection = connection
    objAdapter.SelectCommand = objCmd
    objAdapter.Fill(objDataSet)

    connection.Close()' Create an instance of XmlTextReader class that reads the XML data.
    Dim xmlReader As XmlTextReader = New XmlTextReader(objDataSet.GetXml(),XmlNodeType.Element,Nothing)

    Response.ContentType = "text/xml"
    Dim xmlWriter As XmlTextWriter = New XmlTextWriter(Response.OutputStream,Encoding.UTF8)
    xmlWriter.Indentation = 4
    xmlWriter.WriteStartDocument()
    Dim elementName As String = ""

    ' Parse & display each node
    While xmlReader.Read()
        Select Case xmlReader.NodeType
            Case XmlNodeType.Element
                xmlWriter.WriteStartElement(xmlReader.Name)
                elementName = xmlReader.Name

            Case XmlNodeType.Text
                If elementName.ToLower() = "birthdate" Then
                    xmlWriter.WriteString(XmlConvert.ToDateTime(xmlReader.Value).ToString())
                Else
                    xmlWriter.WriteString(xmlReader.Value)
                End If

            Case XmlNodeType.EndElement
                xmlWriter.WriteEndElement()
        End Select
    End While
    xmlWriter.Close()
    ```

5. Save the changes to *WebForm1.aspx.vb*.
6. On the **Build** menu, click **Build Solution**.
7. Start Microsoft Internet Explorer and open *WebForm1.aspx* by specifying the `http://IISServerName/DateTimeXmlConvert/WebForm1.aspx` URL, where *IISServerName* is the name of your Microsoft Internet Information Services (IIS) server.

You can now see that the XML file that is rendered in the browser is displayed in custom `DateTime` format.

## Method 2: Apply an XSLT transformation on the XML representation of DataSet data

You can use inline script blocks and external code components, known as XSLT Extension objects, to implement custom routines. These are invoked during an XSLT to perform calculations and process data. Microsoft recommends that you avoid using inline script blocks. You can use extension objects to implement custom routines when you design portable XSLT style sheets.

### Create an ASP.NET web form

1. Create a new Visual Basic .NET ASP.NET Web application project that is named *DateTimeXSLT*.
2. Add a new class that is named *DateConvertor.vb* to the project.
3. Replace the existing code with the following code in the `DateConvertor` class:

    ```vb
    Public Class DateConvertor
        Public Function GetDateTime(ByVal data As String, ByVal format As String) As String
            Dim dt As DateTime = DateTime.Parse(data)
            Return dt.ToString(format)
        End Function
    End Class
    ```

4. Save the changes to *DateConvertor.vb*.
5. Right-click the designer surface of *WebForm1.aspx*, and then click **View Code**.
6. Add the following code to the end of `Imports` directives section in *WebForm1.aspx.vb*:

    ```vb
    Imports System.IO
    Imports System.Xml
    Imports System.Xml.Xsl
    Imports System.Xml.XPath
    Imports System.Data.SqlClient
    ```

7. Paste the following code in the `Page_Load` event:

    ```vb
    ' Change SqlServerName, UserId and Password in the following connection string.
    Dim strConn As String = "Server=<SQLServerName>; database=Northwind; user id=<UserID>; password=<Password>;"
    Dim connection As SqlConnection = New SqlConnection()
    connection.ConnectionString = strConn

    Dim objDataSet As DataSet = New DataSet()
    Dim objAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim objCmd As SqlCommand = New SqlCommand()' Retrieve all records from employees table.
    objCmd.CommandText = "select FirstName,BirthDate from employees"
    objCmd.Connection = connection
    objAdapter.SelectCommand = objCmd
    objAdapter.Fill(objDataSet)

    connection.Close()' Create an instance of StringReader class that reads the XML data.
    Dim reader As StringReader = New StringReader(objDataSet.GetXml())
    Dim doc As XPathDocument = New XPathDocument(reader)' Create an XslTransform object and load xslt file.
    Dim transform As XslTransform = New XslTransform()
    transform.Load(Me.MapPath("DateTime.xslt"))'Add an object to convert DateTime format.
    Dim objDateConvertor As DateConvertor = New DateConvertor()
    Dim args As XsltArgumentList = New XsltArgumentList()
    args.AddExtensionObject("urn:ms-kb", objDateConvertor)

    transform.Transform(doc, args, Response.OutputStream)
    ```

8. Save the changes to *WebForm1.aspx.vb*.

### Create a sample XSLT document

1. Add a new XSLT file that is named *DateTime.xslt* to the DateTimeXSLT ASP.NET Web Project.
2. Replace the generated code with the following code. (Use notepad as an intermediary tool if you experience any encoding or character problems when you try to paste the following code.)

    ```xml
    <?xml version='1.0'?>
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:myObj="urn:ms-kb">
        <xsl:template match="NewDataSet">
            <table>
                <xsl:attribute name="border">1</xsl:attribute>
                  <TR>
                      <TD>Employee name</TD>
                      <TD>Original DateTime Format</TD>
                      <TD>Changed DateTime Format</TD>
                  </TR>
                <xsl:apply-templates select="*"/>
            </table>
        </xsl:template>
        <xsl:template match="*">
            <TR>
                <xsl:apply-templates select="*"/>
            </TR>
        </xsl:template>
        <xsl:template match="FirstName">
            <TD>
                <xsl:value-of select="."/>
            </TD>
        </xsl:template>
        <xsl:template match="BirthDate">
        <xsl:variable name="Date" select="."/>
            <TD>
                <xsl:value-of select="$Date"/>
            </TD>
            <TD>
                <xsl:value-of select="myObj:GetDateTime($Date, 'F')"/>
            </TD>
        </xsl:template>
    </xsl:stylesheet>
    ```

3. Save the changes to *DateTime.xslt*.

### Test the XSLT transformation by using the ASP.NET web form

1. Save the changes to the DateTimeXSLT ASP.NET web project.
2. On the **Build** menu, click **Build Solution**.
3. Start Internet Explorer and open *WebForm1.aspx* by specifying the `http://IISServerName/DateTimeXSLT/WebForm1.aspx` URL, where *IISServerName* is the name of your IIS server.

You can now see that two `DateTime` formats, the `DateTime` format of DataSet and the transformed `DateTime` format on the *WebForm1.aspx* page.
