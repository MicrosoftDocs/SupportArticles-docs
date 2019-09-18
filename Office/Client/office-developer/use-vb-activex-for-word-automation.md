---
title: How to use a VB ActiveX component for Word automation from Internet Explorer
description: Describes that how to use a VB ActiveX component for Word automation from Internet Explorer.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Word
---

# How to use a VB ActiveX component for Word automation from Internet Explorer

## Summary

This article demonstrates how you can use an ActiveX component for client-side Automation of Word from a Web page that is rendered in Internet Explorer. There are several benefits to using an ActiveX component from a Web page instead of script that is embedded in the Web page itself: 

- If you already have Visual Basic code that automates Microsoft Word, you can reuse your code in the browser by converting your Visual Basic project to either an ActiveX EXE or an ActiveX DLL.   
- Word is not marked safe for scripting. Depending on security settings in Internet Explorer, Word Automation code in script may not run or the user may be prompted with a security warning. Assuming that your ActiveX component meets certain guidelines, it may be marked safe for scripting to avoid these security issues.   
- Visual Basic has several features that you cannot use with script in a Web page. For example, one feature that is available to Visual Basic but not to Web page script is the ability to call the Windows application programming interface (API).   
 
A common developer scenario is to present users with a Web page interface for creating a Word document by using data from some external source or logic. Although you can use server-side Word Automation to generate the document and stream it back to the client, there are many drawbacks to using a server-side approach that involves Word Automation. The primary drawback is scalability; Word is a very resource-intensive Automation server and is not recommended for document generation on the Web server.

By using an ActiveX component to perform the document generation at the client, you can move the resource-intensive Word Automation away from the Web server. This is the solution that is presented by the sample ActiveX component that is discussed in this article. Although the sample is specific to Word Automation, the same principles may be applied for automating other Microsoft Office applications, such as Microsoft Excel. 

## More Information

### Visual Basic ActiveX Component
 
The Visual Basic ActiveX component in this sample interacts with Web page script to generate an order invoice document at the user's request. The Web application may allow the ActiveX component to obtain the order information for a given order ID, or the Web application may choose to package the order information as XML and send it to the ActiveX component for processing. In either case, after the component obtains the order information, it can automate Word to build and display the invoice document for the order.

The ActiveX component (AutomateWord) contains a single class, the Invoice class, that exposes three methods: 

- The GetData method uses ActiveX Data Objects (ADO) to extract information about an order in the Northwind sample database. The order information is stored in the m_Data private member variable. The GetData method can be called to let the data extraction occur client-side.   
- The SendData method uses Microsoft XML (MSXML) to fill the m_Data private member variable with the order information that is provided by the caller. SendData expects one parameter that represents a DOMDocument object for the order information. The SendData method can be called to send the order information from the Web page to the component. With this approach, you can use ASP to extract the data server-side and present the client with an XML data island that can be used for the document generation.   
- The MakeInvoice method uses Word Automation to build a document that contains the order information in the m_Data private member variable. A document that is stored on the Web server is used as a starting point for the invoice. The caller may choose to display the completed Word document outside of the browser or save the completed document to a disk for later use.   

Invoice.cls

```vb
Option Explicit

Private Type InvoiceData
    OrderID As String
    OrderDate As Date
    CustID As String
    CustInfo As String
    ProdInfo As Variant
End Type

Private m_Data As InvoiceData

Public Sub GetData(sOrderID As Variant, sConn As Variant)

Dim oConn As Object, oRS As Object

'Connect to the Northwind database.
    Set oConn = CreateObject("ADODB.Connection")
    oConn.Open sConn

'Obtain the Customer ID and Order Date.
    Set oRS = CreateObject("ADODB.Recordset")
    oRS.Open "Select [OrderDate], [CustomerID] from Orders where " & _
             "[OrderID]=" & sOrderID, oConn, 3 'adOpenStatic=3
    m_Data.OrderID = sOrderID
    m_Data.OrderDate = CDate(oRS.Fields("OrderDate").Value)
    m_Data.CustID = oRS.Fields("CustomerID").Value
    oRS.Close

'Obtain Customer information.
    Set oRS = CreateObject("ADODB.Recordset")
    oRS.Open "Select * from Customers Where CustomerID='" & _
             m_Data.CustID & "'", oConn, 3 'adOpenStatic=3
    m_Data.CustInfo = oRS.Fields("CompanyName").Value & vbCrLf & _
                      oRS.Fields("City") & " "
    If Not (IsNull(oRS.Fields("Region"))) Then
       m_Data.CustInfo = m_Data.CustInfo & oRS.Fields("Region").Value & " "
    End If
    m_Data.CustInfo = m_Data.CustInfo & oRS.Fields("PostalCode").Value & _
                      vbCrLf & oRS.Fields("Country").Value
    oRS.Close

'Obtain Product information.
    Set oRS = CreateObject("ADODB.Recordset")
    oRS.Open "Select ProductName, Quantity, [Order Details].UnitPrice," & _
             "Discount from Products Inner Join [Order Details] on " & _
             "Products.ProductID = [Order Details].ProductID " & _
             "Where OrderID = " & sOrderID, oConn, 3 'adOpenStatic=3
    m_Data.ProdInfo = oRS.GetRows
    oRS.Close

'Close the connection to the database.
    oConn.Close

End Sub

Public Sub SendData(oXML As Variant)

'Extract the information from the DOMDocument object oXML and store
    'it in the private member variable m_Data.

m_Data.OrderID = oXML.getElementsByTagName("OrderID").Item(0).Text
    m_Data.OrderDate = oXML.getElementsByTagName("OrderDate").Item(0).Text
    m_Data.CustID = oXML.getElementsByTagName("CustID").Item(0).Text
    m_Data.CustInfo = oXML.getElementsByTagName("CustInfo").Item(0).Text

Dim oItems As Object, oItem As Object
    Set oItems = oXML.getElementsByTagName("Items").Item(0)
    ReDim vArray(0 To 3, 0 To oItems.childNodes.Length - 1) As Variant
    Dim i As Integer
    For i = 0 To UBound(vArray, 2)
        Set oItem = oItems.childNodes(i)
        vArray(0, i) = oItem.getAttribute("Desc")
        vArray(1, i) = oItem.getAttribute("Qty")
        vArray(2, i) = oItem.getAttribute("Price")
        vArray(3, i) = oItem.getAttribute("Disc")
    Next
    m_Data.ProdInfo = vArray

End Sub

Public Sub MakeInvoice(sTemplate As Variant, Optional bSave As Variant)

Dim oWord As Object
    Dim oDoc As Object
    Dim oTable As Object

If IsMissing(bSave) Then bSave = False

'Open the document as read-only.
    Set oWord = CreateObject("Word.Application")
    Set oDoc = oWord.Documents.Open(sTemplate, , True)

'Fill in the bookmarks.
    oDoc.Bookmarks("Customer_Info").Range.Text = m_Data.CustInfo
    oDoc.Bookmarks("Customer_ID").Range.Text = m_Data.CustID
    oDoc.Bookmarks("Order_ID").Range.Text = m_Data.OrderID
    oDoc.Bookmarks("Order_Date").Range.Text = m_Data.OrderDate

'Fill in the table with the product information.
    '** Note that the table starts out with three rows -- the first row
    '   contains headers for the table, the second row is for
    '   the first set of product data, and the third row contains a total.
    '   New rows are added for additional products before the "total row".

Set oTable = oDoc.Tables(1)
    Dim r As Integer, c As Integer
    For r = 1 To UBound(m_Data.ProdInfo, 2) + 1
        If r > 1 Then oTable.Rows.Add (oTable.Rows(oTable.Rows.Count))
        For c = 1 To 4
            oTable.Cell(r + 1, c).Range.Text = _
               m_Data.ProdInfo(c - 1, r - 1)
        Next
        oTable.Cell(r + 1, 5).Formula _
            "=(B" & r + 1 & "*C" & r + 1 & ")*(1-D" & r + 1 & ")", _
            "#,##0.00"
    Next

'Update the field for the grand total and protect the document.
    oTable.Cell(oTable.Rows.Count, 5).Range.Fields.Update
    oDoc.Protect 1 'wdAllowOnlyComments=1

If bSave Then
        'Save the document as "c:\invoice.doc" and quit Word.
        Dim nResult As Long
        nResult = MsgBox("Are you sure you wish to create the document" & _
             " ""c:\invoice.doc""? If this document already exists, " & _
             "it will be replaced", vbYesNo, "AutomateWord")
        If nResult = vbYes Then oDoc.SaveAs "c:\invoice.doc"
        oDoc.Close False
        oWord.Quit
    Else
        'Make Word visible.
        oWord.Visible = True
    End If

End Sub
```

### Using the ActiveX Component from a Web Page
 
Autoword1.htm demonstrates how you can use the GetData method to let the ActiveX component retrieve the order data client-side and build the document.

Autoword1.htm

```html
<HTML>
<HEAD>
   <OBJECT ID="AutoWord"
    CLASSID="CLSID:32646EBA-0919-4C2F-94D6-599F46DC34F2"
    CODEBASE="https://YourWebServer/invoice/package/AutomateWord.CAB#version=1,0,0,0">
   </OBJECT>
</HEAD>
<BODY>
Enter an order id between 10248 and 11077 and click the button to view the invoice for the order:
<P/><INPUT TYPE="text" VALUE="10500" ID="OrderID">
<P/><BUTTON ID="InvoiceButton">Create Invoice</BUTTON>
</BODY>

<SCRIPT Language="VBScript">

Function InvoiceButton_OnClick()
      Dim sConn
      sConn = "Provider=sqloledb;Data Source=YourSQLServer;Initial Catalog=Northwind;UID=sa;"
      AutoWord.GetData OrderID.Value, sConn
      AutoWord.MakeInvoice "https://YourWebServer/invoice/invoice.doc"
   End Function

</SCRIPT>
</HTML>
```
 
The script in Autoword1.htm uses the ActiveX component to display the completed document outside of the browser. You may also choose to save the completed document and display it in the browser; however, doing so requires that the Word document be saved to a disk. The component can save the document as C:\Invoice.doc on the client's local drive. Because the ActiveX component is marked safe for scripting, the client is prompted to confirm the save.

If you want to display the completed document in the browser, change the call to MakeInvoice in Autoword1.htm to the following: 
```html
      AutoWord.MakeInvoice "https://YourWebServer/invoice/invoice.doc", True
      window.navigate "c:\invoice.doc"

```
 
Autoword2.htm demonstrates how you can use the SendData method to send the order data as a DOMDocument object to the ActiveX component for generating the completed document. The DOMDocument is created from an XML data island that resides on the Web page. For the ActiveX component to properly process the order information that is sent by the caller, the XML must be well-formed and structured so that the component can interpret it as order information.

Autoword2.htm

```html
<HTML>
<HEAD>
   <OBJECT ID="AutoWord"
    CLASSID="CLSID:32646EBA-0919-4C2F-94D6-599F46DC34F2"
    CODEBASE="https://YourWebServer/invoice/package/AutomateWord.CAB#version=1,0,0,0">
   </OBJECT>
</HEAD>
<BODY>
   <BUTTON ID="InvoiceButton">Create Invoice</BUTTON>
   <XML ID="DataXML">
     <Order>
        <OrderID>10700</OrderID>
        <OrderDate>10/10/2000</OrderDate>
        <CustID>SAVEA</CustID>
        <CustInfo>Save-a-lot
Markets Boise ID 83720
USA</CustInfo>
        <Items>
           <Product Desc="Chai" Qty="5" Price="18" Disc="0.2"/>
           <Product Desc="Sasquatch Ale" Qty="12" Price="14" Disc="0.2"/>
           <Product Desc="Scottish Longbreads" Qty="40" Price="12.5" Disc="0.2"/>
           <Product Desc="Flotemysost" Qty="60" Price="21.5" Disc="0.2"/>
        </Items>        
     </Order>
   </XML>
</BODY>

<SCRIPT Language="VBScript">

Function InvoiceButton_OnClick()
      AutoWord.SendData DataXML.XMLDocument
      AutoWord.MakeInvoice "https://YourWebServer/invoice/invoice.doc"
   End Function

</SCRIPT>
</HTML>

```
 
In both Autoword1.htm and Autoword2.htm, you should note that the ActiveX component is instantiated by way of an <OBJECT> tag rather than the CreateObject function. The purpose of using the <OBJECT> tag is to enable automatic download of the ActiveX component for users that do not already have the component installed. If a user visits one of these pages and the component is not installed, the component is downloaded from the cabinet (CAB) file at the URL that is indicated in the CODEBASE attribute. Depending on the user's security settings in Internet Explorer, they may first receive a prompt to confirm the download.

NOTE: The CAB file that is included in Autoword.exe was created with the Package and Deployment Wizard for Visual Basic. The ActiveX component in the package is marked safe for scripting and initialization, but is not digitally signed.

For more information on creating Internet component downloads, digital signing, and marking components as safe for scripting and initialization, see the following Microsoft Developer Network (MSDN) Web sites:
 
Signing and Checking Code with Authenticode 
[https://msdn.microsoft.com/en-us/library/ms537364.aspx](https://msdn.microsoft.com/library/ms537364.aspx)

Safe Initialization and Scripting for ActiveX Controls 
[https://msdn.microsoft.com/en-us/library/Aa751977.aspx](https://msdn.microsoft.com/library/aa751977.aspx)

## References

For additional information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[257757](https://support.microsoft.com/help/257757) INFO: Automation of Office for Unattended Execution is Not Recommended or Supported

(c) Microsoft Corporation 2001, All Rights Reserved. Contributions by Lori B. Turner, Microsoft Corporation.