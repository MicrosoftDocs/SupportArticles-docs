---
title: Use XML Web Service by using ASP.NET from an Office VBA Macro in Word or Excel
description: This article demonstrates how to use an XML Web service using ASP.NET from a Visual Basic for Applications (VBA) macro in Word or Excel.
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
- Microsoft Excel
---

# How To Use an XML Web Service by Using ASP.NET from an Office VBA Macro in Word or Excel

## Summary

This article demonstrates how to use an XML Web service using ASP.NET from a Visual Basic for Applications (VBA) macro in Word or Excel. 

## More Information

In order to successfully communicate with an XML Web service using ASP.NET from an Office macro, the SOAP Toolkit must be installed on the client computer on which the macro runs. Accordingly, the SOAP Toolkit is required for the demonstration in this article. For details on the SOAP Toolkit, including download instructions.

### Create the XML Web Service using ASP.NET

1. Start Microsoft Visual Studio .NET. On the File menu, click New and then click Project. In the New Project dialog box, click Visual Basic Projects under Project types, and then click XML Web Service using ASP.NET under Templates. Name the project SQLQuery and click OK. The design form for Service1 appears by default.   
2. On the View menu, click Code to display the code window for Service1.   
3. Paste the following code at the top of the code window:
    ```vb
    Imports System.Data.SqlClient
    ```

4. Paste the following code in the Service1 class (just before
End Class).

    **Note** You must change User ID \<username> and password =\<strong password> to the correct values before you run this code. Make sure that User ID has the appropriate permissions to perform this operation on the database. 
    ```vb
    Private Const strConn = "User ID=<username>;Password=<strong password>;Initial Catalog=pubs;Data Source=localhost"

    <WebMethod()> Public Function GetIDs() As String()
        Dim i As Integer
    
    ' Create an open connection.
        Dim oConn As New SqlConnection(strConn)
        oConn.Open()
    
    Dim oDataset As New System.Data.DataSet()
        ' Execute the query.
        Dim oAdapter As New SqlDataAdapter("SELECT au_id FROM authors", oConn)
        ' Fill the dataset.
        oAdapter.Fill(oDataset)
    
    Dim s(oDataset.Tables(0).Rows.Count - 1) As String
        ' Create an array of IDs.
        For i = 0 To oDataset.Tables(0).Rows.Count - 1
            s(i) = oDataset.Tables(0).Rows(i).ItemArray.GetValue(0)
        Next i
        ' Return the array.
        Return s
    End Function
    
    <WebMethod()> Public Function QueryDatabase(ByVal sID As String) As String()
        Dim i As Integer
    
    ' Create an open a connection.
        Dim oConn As New SqlConnection(strConn)
        oConn.Open()
    
    Dim oCommand As New SqlCommand("SELECT * FROM authors WHERE au_id='" + sID + "'", oConn)
        Dim oReader As SqlDataReader
        ' Execute the query and assign results to a SqlDataReader.
        oReader = oCommand.ExecuteReader()
        oReader.Read()
    
    Dim s(7) As String
        ' Build an array of results.
        For i = 0 To 7
            s(i) = CType(oReader.GetValue(i), String)
        Next
        ' Return the array.
        Return s
    End Function
    
    ```

> [!NOTE]
> Modify the strConn constant in the code so that it is a valid connection string for the SQL Server pubs database.    

### Test the Web Service

1. Press F5 to build and run the Web service solution. When you run the Web service from the .NET Integrated Development Environment (IDE), Microsoft Internet Explorer loads Service1.asmx from your solution.   
2. Test the GetIDs method. To do this, click the GetIDs hyperlink, then click Invoke. 

    The method returns a list of author IDs that the Web service extracted from the pubs database. The results are displayed in the browser as XML.

3. Close the browser window or windows and return to Visual Studio.   
4. Press F5 again to run the Web service.   
5. Test the QueryDatabase method. To do this, click the QueryDatabase hyperlink, then type 409-56-7008 for the sID parameter and click Invoke.

    The method returns the details for the author with the ID 409-56-7008. The results are displayed in the browser as XML.   
6. Close the browser window or windows to end the Web service.   

### Use the Web Service from Word
 
This sample uses the Elegant Fax template that ships with Word. This sample does not work without this template. To install the template, follow these steps: 

1. Start the Office Setup wizard.   
2. In the wizard, click Add or Remove Features.   
3. Under Features to Install, expand Microsoft Excel for Windows. Click Spreadsheet Templates, click Run from My Computer, and then click Update.   
 
To use the Web service from Word, follow these steps: 

1. Start Word. A blank document is created by default.   
2. On the Tools menu, click Macro and then click Visual Basic Editor. On the Insert menu, click Module to insert a blank code module.   
3. On the **Tools **menu, click **References**.    
4. In the **References** dialog box, Select **Microsoft SOAP Type Library**, and then click **OK**. 

    **Note** If the **Microsoft SOAP Type Library** is not available in the **References** dialog box, then click **Browse**. In the **Add Reference** dialog box browse to the directory C:\Program Files\Common Files\MSSoap\Binaries and select mssoap1.dll. Click **Open** and then click **OK**.   
5. Paste the following code in the code module:
    ```vb
    Public Const sServer = "localhost"
    
    Sub GenerateForm(sID As String)
        Dim oSOAPClient As Object
    
    On Error GoTo errhand
        Set oSOAPClient = CreateObject("MSSOAP.SoapClient")
        oSOAPClient.mssoapinit "http://" + sServer + "/SQLQuery/Service1.asmx?wsdl", "Service1", "Service1Soap"
    
    Dim arrTemp() As String
        arrTemp = oSOAPClient.QueryDatabase(sID)
    
    Dim oDoc As Word.Document
    
    Set oDoc = Application.Documents.Add("Elegant Fax.dot")
        oDoc.Bookmarks("Company").Range.Text = arrTemp(2) + " " + arrTemp(1) + vbCrLf + _
                arrTemp(4) + vbCrLf + arrTemp(5) + ", " + arrTemp(6) + "  " + arrTemp(7) + vbCrLf + _
                arrTemp(3)           
        Exit Sub
    errhand:
        MsgBox "Error #" + Err.Number + ": " + Err.Description
    End Sub
    
    Sub ShowForm()
      ' Show the dialog box to the user.
      UserForm1.Show
    End Sub
    
    ```
    **NOTE** Modify the sServer constant to point to the server that is hosting the Web service that you just created.

6. On the Insert menu, click UserForm to insert a blank user form.   
7. Place a large list box and a command button on the form.   
8. On the View menu, click Code to change to the code window for the user form.   
9. Replace the contents of the code window with the following:
    ```vb
    Private Sub CommandButton1_Click()
        ' Generate a FAX based on the ID.
        GenerateForm ListBox1.List(ListBox1.ListIndex)
        UserForm1.Hide
    End Sub
    
    Private Sub UserForm_Initialize()
        Dim oSOAPClient As Object
    
    ' Create a SOAP client.
        Set oSOAPClient = CreateObject("MSSOAP.SoapClient")
        ' Initialize the SOAP client to the Web service.
        oSOAPClient.mssoapinit "http://" + Module1.sServer + "/SQLQuery/Service1.asmx?wsdl", "Service1", "Service1Soap"
    
    Dim arrTemp() As String
        ' Get an array of IDs.
        arrTemp = oSOAPClient.GetIDs()
    
    ' Fill the list box with IDs.
        For i = 0 To UBound(arrTemp)
          ListBox1.AddItem arrTemp(i)
        Next
    End Sub
    ```

10. Close the VBA Editor to return to the document.   
11. On the Tools menu, click Macro and then click Macros. In the Macros dialog box, run the ShowForm macro to display the list of IDs. Select an ID from the list and click the command button to generate a fax document with that user's information.   

#### Use the Web Service from Excel
 
This sample uses the Sales Invoice template that ships with Excel. This sample does not work without this template. To install the template, follow these steps: 

1. Start the Office Setup wizard.   
2. In the wizard, click Add or Remove Features.   
3. Under Features to Install, expand Microsoft Excel for Windows, expand Spreadsheet Templates, and then click Sales Invoice. Click Run from My Computer and click Update.   
 
To use the Web service from Excel, follow these steps: 

1. Start Excel. A blank workbook is created by default.   
2. On the Tools menu, click Macro and then click Visual Basic Editor. On the Insert menu, click Module to insert a blank code module.   
3. On the **Tools **menu, click **References**.    
4. In the **References** dialog box, Select **Microsoft SOAP Type Library**, and then click **OK**. 

    **Note** If the **Microsoft SOAP Type Library** is not available in the **References** dialog box, then click **Browse**. In the **Add Reference**dialog box browse to the directory C:\Program Files\Common Files\MSSoap\Binaries and select mssoap1.dll. Click **Open** and then click **OK**.   
5. Paste the following code in the code module:
    ```vb
    Const sTemplatePath = "C:\Microsoft Office\Templates\1033\Sales Invoice.xlt"
    Public Const sServer = "localhost"
    
    Sub GenerateForm(sID As String)
        Dim oSOAPClient As Object
    
    On Error GoTo errhand
        Set oSOAPClient = CreateObject("MSSOAP.SoapClient")
        oSOAPClient.mssoapinit "http://" + sServer + "/SQLQuery/Service1.asmx?wsdl", "Service1", "Service1Soap"
    
    Dim arrTemp() As String
        arrTemp = oSOAPClient.QueryDatabase(sID)
    
    Dim oBook As Excel.Workbook
    
    Set oBook = Application.Workbooks.Add(sTemplatePath)
        With oBook.ActiveSheet
          If If CInt(Application.Version) = 10 Or CInt(Application.Version) = 11 Then
            .Range("D13").Value = arrTemp(2) + " " + arrTemp(1)
            .Range("D14").Value = arrTemp(4)
            .Range("D15").Value = arrTemp(5)
            .Range("F15").Value = arrTemp(6)
            .Range("H15").Value = arrTemp(7)
            .Range("D16").Value = arrTemp(3)
    
    .Range("M13").Value = CStr(Date)
            .Range("C19").Value = "45.8"
            .Range("D19").Value = "Consulting hours"
            .Range("L19").Value = "75"
          ElseIf CInt(Application.Version) = 9 Then
            .Range("data5").Value = arrTemp(2) + " " + arrTemp(1)
            .Range("data6").Value = arrTemp(4)
            .Range("data7").Value = arrTemp(5)
            .Range("data8").Value = arrTemp(6)
            .Range("data9").Value = arrTemp(7)
            .Range("data10").Value = arrTemp(3)
    
    .Range("data11").Value = "45.8"
            .Range("data12").Value = "Consulting hours"
            .Range("data13").Value = "75"
          End If
        End With
        Exit Sub
    errhand:
        MsgBox "Error #" + Err.Number + ": " + Err.Description
    End Sub
    
    Sub ShowForm()
      ' Show the dialog box to the user.
      UserForm1.Show
    End Sub
    
    ```
    **Note** Modify the sServer constant to point to the server that is hosting the Web service that you just created. Modify the sTemplatePath constant to point to the correct path for the invoice file. For Office 2000, the default location for this file is C:\Microsoft Office\Templates\1033\Invoice.xlt. For Office XP, the default location is C:\Microsoft Office\Templates\1033\Sales Invoice.xlt. 

6. On the Insert menu, click UserForm to insert a blank user form.   
7. Place a large list box and a command button on the form.   
8. On the View menu, click Code to change to the code window for the user form.   
9. Replace the contents of the code window with the following:
    ```vb
    Private Sub CommandButton1_Click()
        ' Generate a FAX based on the ID.
        GenerateForm ListBox1.List(ListBox1.ListIndex)
        UserForm1.Hide
    End Sub
    
    Private Sub UserForm_Initialize()
        Dim oSOAPClient As Object
    
    ' Create a SOAP client.
        Set oSOAPClient = CreateObject("MSSOAP.SoapClient")
        ' Initialize the SOAP client to the Web service.
        oSOAPClient.mssoapinit "http://" + Module1.sServer + "/SQLQuery/Service1.asmx?wsdl", "Service1", "Service1Soap"
    
    Dim arrTemp() As String
        ' Get an array of IDs.
        arrTemp = oSOAPClient.GetIDs()
    
    ' Fill the list box with IDs.
        For i = 0 To UBound(arrTemp)
          ListBox1.AddItem arrTemp(i)
        Next
    End Sub
    
    ```

10. Close the VBA Editor to return to the workbook.   
11. On the Tools menu, click Macro and then click Macros. In the Macros dialog box, run the ShowForm macro to display the list of IDs. Choose an ID from the list and click the command button to generate an invoice with that user's information.   

## References

For additional information on Web services, view the article in the Microsoft Knowledge Base:

[301273](https://support.microsoft.com/help/301273) How To Write a Simple Web Service by Using Visual Basic .NET