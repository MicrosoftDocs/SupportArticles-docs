---
title: How to automate Word with Visual Basic to create a Mail Merge
description: Describes that how to automate Word with Visual Basic to create a Mail Merge.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Word
---

# How to automate Word with Visual Basic to create a Mail Merge

## Summary

This article discusses how to automate Word to create a mail merge for an external data source. This article also explains the code differences between accessing the data with OLEDB, ODBC, and dynamic data exchange (DDE).

## More Information

### Data access methods

To programmatically set up a data source for a Word mail merge document, you first call the OpenDataSource method of a MailMerge object. The syntax for the OpenDataSource method is as follows: 

```vb
<MailMergeObject>.OpenDataSource(Name, [Format], [ConfirmConversions], [ReadOnly], [LinkToSource], [AddToRecentFiles], [PasswordDocument], [PasswordTemplate], [Revert],[WritePasswordDocument], [WritePasswordTemplate], [Connection], [SQLStatement], [SQLStatement1], [OpenExclusive], [SubType]) 
```

> [!NOTE]
> For a complete description of each argument, refer to the Microsoft Word Visual Basic online Help. Of primary interest for connecting to an external data source are the Name, Connection, and SubType arguments. Different combinations of these three arguments represent different data access methods for the mail merge. 

### Using OLEDB
 
OLEDB is the recommended data access method. To specify OLEDB as the data access method with OpenDataSource, supply the Name argument with the path and the file name to either the database or an Office DataSource Connection (.odc). If you provide a database for the Name argument, Word will automatically use OLEDB if there is an OLEDB provider installed that supports the database format.

Example

```vb
<MailMergeObject>.OpenDataSource Name:="C:\MyDB.mdb", _
           SQLStatement:="SELECT * FROM [MyTable]"
```
or
```vb
<MailMergeObject>.OpenDataSource Name:="C:\MyDataSource.odc", _
           SQLStatement:="SELECT * FROM [MyTable]"
```
 
Word and other Office XP applications use the Office DataSource Object (ODSO) for OLEDB access to external data sources. ODSO is the only mechanism by which Word can access data by using OLEDB for a mail merge. ODSO requires that the Name argument for OpenDataSource be either a complete path to a database or a complete path to a valid ODC file. ODSO ignores any information in the Connection argument.

### Using ODBC
 
You can use ODBC for your mail merge to access data for which a user data source name (DSN) has been set up on the system. To specify ODBC as the data access method with OpenDataSource, supply an empty string for the Name argument, an ODBC connection string for the Connection argument, and wdMergeSubTypeWord2000 for the SubType argument.

Example

```vb
<MailMergeObject>.OpenDataSource Name:= "", _
     Connection:= "DSN=MySQLServerDSN;DATABASE=pubs;uid=sa;pwd=;", _
     SQLStatement:= "Select au_id, au_lname, au_fname from authors", _
     SubType:= wdMergeSubTypeWord2000

```

### Using DDE
 
You can use DDE to access data in Microsoft Access databases or Microsoft Excel workbooks. To specify DDE as the data access method with OpenDataSource, supply the path and the file name to the database or the workbook for the Name argument, and wdMergeSubTypeWord2000 for the SubType argument.

Example

```vb
<MailMergeObject>.OpenDataSource Name:="C:\MyDB.mdb", _
           SQLStatement:="SELECT * FROM [MyTable]", _
           SubType:=wdMergeSubTypeWord2000
```

### Automation sample
 
The following sample code creates and executes a mail merge for form letters by using OLEDB (by way of ODSO). The data source that is used is the sample Access database Northwind.mdb. If Northwind is not installed, start Microsoft Access 2002 or Microsoft Office Access 2003. On the **Help** menu, click **Sample Databases**, and then choose Northwind Sample Database to install this feature.

To run this sample, follow these steps: 

1. Start a new Standard EXE project in Visual Basic. By default, Form1 is created.   
2. On the **Project** menu, click **References**.   
3. Click **Microsoft Word 2000 Object Library** in the list of references, and then click **OK**.

   **Note** To use the Microsoft Office Word 2003 Object, add the Microsoft Word 11.0 Object Library in the list of references and then Click **OK**.   
4. Add a **CommandButton** control to Form1.   
5. Add the following code to the code module for Form1.

    **Note** If it is necessary, modify the path to Northwind.mdb to match your installation for Office XP.

    ```vb
    Dim WithEvents oApp As Word.Application
    
    Private Sub Form_Load()
        'Start Word.
        Set oApp = CreateObject("Word.Application")
    End Sub
    
    Private Sub Command1_Click()
    
    Dim oMainDoc As Word.Document
        Dim oSel As Word.Selection
        Dim sDBPath as String
    
    'Start a new main document for the mail merge.
        Set oMainDoc = oApp.Documents.Add
    
    With oMainDoc.MailMerge
    
    .MainDocumentType = wdFormLetters
    
    'Set up the mail merge data source to Northwind.mdb.
            sDBPath = "C:\Program Files\Microsoft Office\" & _
                      "OfficeXP\Samples\Northwind.mdb"
            .OpenDataSource Name:=sDBPath, _
               SQLStatement:="SELECT * FROM [Customers]"
    
    'Add the field codes to the document to create the form letter.
            With .Fields
                Set oSel = oApp.Selection
                .Add oSel.Range, "CompanyName"
                oSel.TypeParagraph
                .Add oSel.Range, "Address"
                oSel.TypeParagraph
                .Add oSel.Range, "City"
                oSel.TypeText ", "
                .Add oSel.Range, "Country"
                oSel.TypeParagraph
                oSel.TypeParagraph
                oSel.TypeText "Dear "
                .Add oSel.Range, "ContactName"
                oSel.TypeText ","
                oSel.TypeParagraph
                oSel.TypeParagraph
                oSel.TypeText " This letter is to inform you..."
                oSel.TypeParagraph
                oSel.TypeParagraph
                oSel.TypeText "Sincerely, [Your Name Here]"
            End With
        End With
    
    'Perform the mail merge to a new document.
        With oMainDoc
            .MailMerge.Destination = wdSendToNewDocument
            .MailMerge.Execute Pause:=False
        End With
    
    End Sub
    
    Private Sub oApp_MailMergeAfterMerge(ByVal Doc As Word.Document, ByVal DocResult As Word.Document)
    
    'When the mail merge is complete, 1) make Word visible,
        '2) close the mail merge document leaving only the resulting document
        'open and 3) display a message.
        Doc.Close False
        oApp.Visible = True
        MsgBox "Mail Merge Complete: " & oApp.ActiveDocument.Name
    
    End Sub
    
    Private Sub Form_Unload(Cancel As Integer)
        Set oApp = Nothing
    End Sub
    ```

6. Press F5 to run the program.   
7. Click the **CommandButton** control on Form1 to perform the mail merge.   
 
When the code completes, Word is made visible with a new document open. The new document contains form letters that result from a mail merge containing data that is extracted from the Customers table in Northwind.mdb.

## References

For more information, view the article in the Microsoft Knowledge Base:

[285176](https://support.microsoft.com/help/285176) How to automate Word to perform a client-side Mail Merge using XML from SQL Server