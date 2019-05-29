---
title: Automate Word to perform a client-side Mail Merge using XML from SQL Server
description: Demonstrates how to automate Microsoft Word from client-side script to perform a mail merge for labels.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to automate Word to perform a client-side Mail Merge using XML from SQL Server

## Summary

This article demonstrates how to automate Microsoft Word from client-side script to perform a mail merge for labels. Word does not have a direct method for using XML data as the data source for a mail merge. The sample illustrates Active Server Pages (ASP) code that streams an XML recordset from a Web server to a client. Client-side script converts this XML data to a delimited text file that is local to the client and then automates Word to perform a mail merge by using the local text file as the mail merge data source. 

## More Information

ActiveX Data Objects (ADO) 2.5 and later allows recordset data to be persisted in XML format. Using ASP on a Web server, you can build an ADO recordset from a database and return the data as XML to your clients. In turn, clients can use ADO to read the XML recordset and manipulate the data as needed. See the "References" section of this article for links to additional resources on using ADO with XML.

For illustration purposes, the following sample uses the sample Pubs database in Microsoft SQL Server. However, similar code may be used to perform a mail merge with any database to which you can make an ADO connection. 

### Sample

1. On your Web server, create a virtual directory that is called WordMailMerge.   
2. Use Notepad to create a file called Default.asp that contains the code given below. Save the file to the WordMailMerge virtual directory.
    ```vbscript
    <%@ Language=VBScript %>
    <HTML>
    <BODY>
    <SCRIPT LANGUAGE=VBScript>
    Sub CreateDataDoc(oApp)
      ' Declare variables.
      Dim sServer,oDoc,oRS,sTemp,sHead,oRange,oField
    
    ' Place your server's name here.
      sServer = "<servername>"
      ' Create a new document.
      Set oDoc = oApp.Documents.Add
      ' Create a new recordset.
      Set oRS = CreateObject("ADODB.Recordset")
      ' Open the XML recordset from the server
      oRS.Open "http://" & sServer & "/WordMailMerge/Getdata.asp"
      ' Convert the recordset to a string.
      sTemp = oRS.GetString(2, -1, vbTab)  ' 2 = adClipString
    
    ' Append the field names to the front of the string.
      For Each oField In oRS.Fields
        sHead = sHead & oField.Name & vbTab
      Next
    
    ' Strip off the last tab.
      sTemp = Mid(sHead, 1, Len(sHead) - 1) & vbCrLf & sTemp
    
    ' Get a range object and insert the text into the document.
      Set oRange = oDoc.Range
      oRange.Text = sTemp
    
    ' Convert the text to a table.
      oRange.ConvertToTable vbTab
      ' Save the document to a temp file.
      oDoc.SaveAs "C:\data.doc"
      ' Close the document (no save).
      oDoc.Close False
    End Sub
    
    Sub ButtonClick()
      Dim oApp
      Dim oDoc
      Dim oMergedDoc
    
    ' Create an instance of Word.     
      Set oApp = CreateObject("Word.Application")
    
    ' Create our data file.
      CreateDataDoc oApp
    
    ' Add a new document.
      Set oDoc = oApp.Documents.Add
      With oDoc.MailMerge
        ' Add our fields.
        .Fields.Add oApp.Selection.Range, "au_fname"
        oApp.Selection.TypeText " "
        .Fields.Add oApp.Selection.Range, "au_lname"
        oApp.Selection.TypeParagraph
        .Fields.Add oApp.Selection.Range, "city"
        oApp.Selection.TypeText ", "
        .Fields.Add oApp.Selection.Range, "state"
        oApp.Selection.TypeParagraph
        .Fields.Add oApp.Selection.Range, "zip"
        oApp.Selection.TypeParagraph
    
    ' Create an autotext entry.
        Dim oAutoText
        Set oAutoText = oApp.NormalTemplate.AutoTextEntries.Add _
        ("MyLabelLayout", oDoc.Content)
        oDoc.Content.Delete
        .MainDocumentType = 1  ' 1 = wdMailingLabels
    
    ' Open the saved data source.
        .OpenDataSource "C:\data.doc"
    
    ' Create a new document.
        oApp.MailingLabel.CreateNewDocument "5160", "", _
             "MyLabelLayout", , 4  ' 4 = wdPrinterManualFeed
    
    .Destination = 0  ' 0 = wdSendToNewDocument
        ' Execute the mail merge.
        .Execute
    
    oAutoText.Delete
      End With
    
    ' Close the mail merge edit document.
      oDoc.Close False
      ' Get the current document.
      Set oMergedDoc = oApp.ActiveDocument
      ' Show Word to the user.
      oApp.Visible = True
    
    ' Uncomment these lines to save the merged document locally.
      'oMergedDoc.SaveAs "C:\test.doc"
      'oMergedDoc.Close False
      'oApp.Quit False
    End Sub
    </SCRIPT>
    <INPUT type=button value="Create Word Document" onclick="VBScript:ButtonClick">
    </BODY>
    </HTML>
    
    ```

3. Use Notepad to create a file called Getdata.asp that contains the code given below. Save the file to the WordMailMerge virtual directory.
    ```vbscript
    <%@ Language=VBScript %>
    <%
      Dim oConn,oRS,strConn,sSQLServer
    
    ' Build the connection string. Replace <username> and <strong password> with
      ' the username and password of an account that has permissions on the database.
      sSQLServer = "<servername>"
      strConn = "Provider=SQLOLEDB.1;Persist Security Info=False;" & _
                "User ID=<username>;Password=<strong password>;Initial Catalog=pubs;Data Source=" & sSQLServer
      ' Set our return content type.
      Response.ContentType = "text/xml"
    
    ' Create a connection.
      set oConn = Server.CreateObject("ADODB.Connection")
      ' Open the connection.
      oConn.Open strConn
      ' Execute the SQL statement.
      set oRS = oConn.Execute(“SELECT * FROM AUTHORS”)
      ' Save the recordset in the Response object.
      oRS.Save Response,1
    %>
    
    ```

4. Change the sServer variable in Default.asp to point to your Web server, and change the sSQLServer variable in Getdata.asp to point to your SQL Server.   
5. Start Internet Explorer and browse to https://servername/WordMailMerge/Default.asp (where servername is the name of your Web server).   
6. Click the button on the Web page to automate Word and perform the mail merge. When Automation is complete, Word appears with a new document that contains the mailing labels that resulted from the mail merge.   

## References

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[258512](https://support.microsoft.com/help/258512) How to automate Word from Visual Basic to create a mail merge for mailing labels