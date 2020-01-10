---
title: Automate Word from Visual Basic to create a mail merge for mailing labels
description: Describes how to automate Word from a Visual Basic application to create and execute a mail merge for mailing labels.
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

# How to automate Word from Visual Basic to create a mail merge for mailing labels

## Summary

This article describes how to automate Microsoft Office Word from a Microsoft Visual Basic application to create and to execute a mail merge for mailing labels. 

## More Information

The sample code in this article uses a tab-delimited text file for the data source. The text file has the following fields:

- Contact_Name   
- Address   
- City   
- Postal_Code   
- Country   
 
You can use any text editor to create the text file data source. For example, you can use Notepad.

When you create the data source, remember to separate the fields (columns) by using a tab character and to separate the records (rows) by using a carriage return. The following is an example of how the text file might appear: 

```AsciiDoc
Contact_NameAddress City Postal_Code Country
Maria AndersObere Str. 57 Berlin 12209 Germany 
Thomas Hardy120 Hanover Sq. London WA1 1DP UK
Hanna MoosForsterstr. 57 Mannheim 68306 Germany
Laurence Lebihan 12, rue des Bouchers Marseille 13008 France
```
> [!NOTE]
> You can use any other data source instead of the tab-delimited text file. For example, you can use a Microsoft Access database.

### Step-by-step example

1. Start a new Standard EXE project in Visual Basic. By default, a form that is named Form1 is created.   
2. Add a CommandButton to Form1.   
3. Select the Microsoft Word Object Library for the version of Word that you intend to automate, and then click OK.    
4. Copy the following code to the code window of Form1. 
    ```vb
    Private Sub Command1_Click()
    
    Dim oApp As Word.Application
        Dim oDoc As Word.Document
    
    'Start a new document in Word
        Set oApp = CreateObject("Word.Application")
        Set oDoc = oApp.Documents.Add
    
    With oDoc.MailMerge
    
    'Insert the mail merge fields temporarily so that
            'you can use the range that contains the merge fields as a layout
            'for your labels -- to use this as a layout, you can add it
            'as an AutoText entry.
            With .Fields
                .Add oApp.Selection.Range, "Contact_Name"
                oApp.Selection.TypeParagraph
                .Add oApp.Selection.Range, "Address"
                oApp.Selection.TypeParagraph
                .Add oApp.Selection.Range, "City"
                oApp.Selection.TypeText "  "
                .Add oApp.Selection.Range, "Postal_Code"
                oApp.Selection.TypeText " -- "
                .Add oApp.Selection.Range, "Country"
            End With
            Dim oAutoText As Word.AutoTextEntry
            Set oAutoText = oApp.NormalTemplate.AutoTextEntries.Add("MyLabelLayout", oDoc.Content)
            oDoc.Content.Delete 'Merge fields in document no longer needed now
                                'that the AutoText entry for the label layout
                                'has been added so delete it.
    
    'Set up the mail merge type as mailing labels and use
            'a tab-delimited text file as the data source.
            .MainDocumentType = wdMailingLabels 
            .OpenDataSource Name:="C:\data.txt" 'Specify the data source here
    
    'Create the new document for the labels using the AutoText entry
            'you added -- 5160 is the label number to use for this sample.
            'You can specify the label number you want to use for the output
            'in the Name argument.
            oApp.MailingLabel.CreateNewDocument Name:="5160", Address:="", _
                AutoText:="MyLabelLayout", LaserTray:=wdPrinterManualFeed
    
    'Execute the mail merge to generate the labels.
            .Destination = wdSendToNewDocument
            .Execute
    
    'Delete the AutoText entry you added
            oAutoText.Delete
    
    End With
    
    'Close the original document and make Word visible so that
    
    'the mail merge results are displayed
        oDoc.Close False
        oApp.Visible = True
    
    'Prevent save to Normal template when user exits Word
        oApp.NormalTemplate.Saved = True
    
    End Sub
    
    ```
     The Name argument for the OpenDataSource method in this code references the data source as c:\data.txt. If the data source has a different path or a different file name, modify this line in the code accordingly.   
5. Press the F5 key to run the program, and then click Command1. A mailing label document is created by using data that is taken from the data source.   

## References

For more information about how to automate Word or about how to create mail merge documents, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[220911](https://support.microsoft.com/help/220911) How to automate Microsoft Word to perform a mail merge using Visual C++ and MFC

[212034](https://support.microsoft.com/help/212034) How to create mailing labels by using Mail Merge in Word