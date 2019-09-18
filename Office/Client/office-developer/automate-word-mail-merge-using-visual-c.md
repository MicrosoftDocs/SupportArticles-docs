---
title: How to automate Microsoft Word to perform Mail Merge from Visual C#
description: Describes some sample steps about how to automate Microsoft Word to perform Mail Merge from Visual C#.
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

# How to automate Microsoft Word to perform Mail Merge from Visual C#

For a Microsoft Visual Basic .NET version of this article, see [301656](https://support.microsoft.com/help/301656).

## Summary

This article demonstrates how to automate Microsoft Word to create a mail-merged document by using Microsoft Visual C# 2005 or Microsoft Visual C# .NET. 

## More Information

Automation is a process that allows applications that are written in languages such as Visual C# 2005 or Visual C# .NET to programmatically control other applications. Automation of Word allows you to perform actions such as creating new documents, adding text to documents, and formatting documents. With Word and other Microsoft Office applications, virtually all of the actions that you can perform manually through the user interface can also be performed programmatically by using Automation.

Word exposes this programmatic functionality through an object model. The object model is a collection of classes and methods that serve as counterparts to the logical components of Word. For example, there is an Application object, a Document object, and a Paragraph object, each of which contain the functionality of those components in Word. To access the object model from Visual C# 2005 or Visual C# .NET, you can set a project reference to the type library.

This article demonstrates how to set the proper project reference to the Word type library for Visual C# .NET and provides sample code to automate Word. 

### Building the Automation Sample

1. Start Microsoft Visual Studio 2005 or Microsoft Visual Studio .NET.   
2. On the File menu, click New, and then click Project. Select Windows Application from the Visual C# Project types. Form1 is created by default.   
3. Add a reference to **Microsoft Word 11.0 Object Library** in Visual Studio 2005 or to Microsoft Word Object Library in Visual Studio .NET. To do this, follow these steps: 

    1. On the Project menu, click Add Reference.   
    2. On the COM tab, locate Microsoft Word Object Library and then click Select.

       In Visual Studio 2005, locate **Microsoft Word 11.0 Object Library** on the **COM** tab.

       **Note** Microsoft Office 2003 includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they can be downloaded.

    3. Click OK in the Add References dialog box to accept your selections.    
4. On the View menu, select Toolbox to display the toolbox, and then add a button to Form1.   
5. Double-click Button1. The code window for the form appears.   
6. In the code window, replace the following code
    ```vb
      private void button1_Click(object sender, System.EventArgs e)
      {
      }
    
    ```
     with: 
    ```vb
    Word.Application wrdApp;
    Word._Document wrdDoc;
    Object oMissing = System.Reflection.Missing.Value;
    Object oFalse = false;
    
    private void InsertLines(int LineNum)
    {
    int iCount;
    
    // Insert "LineNum" blank lines.
    for(iCount = 1; iCount<=LineNum; iCount++) 
    {
    wrdApp.Selection.TypeParagraph();
    }
    }
    
    private void FillRow(Word._Document oDoc, int Row, string Text1,
    string Text2, string Text3, string Text4)
    {
    // Insert the data into the specific cell.
    oDoc.Tables[1].Cell(Row,1).Range.InsertAfter(Text1);
    oDoc.Tables[1].Cell(Row,2).Range.InsertAfter(Text2);
    oDoc.Tables[1].Cell(Row,3).Range.InsertAfter(Text3);
    oDoc.Tables[1].Cell(Row,4).Range.InsertAfter(Text4);
    }
    
    private void CreateMailMergeDataFile()
    {
    Word._Document oDataDoc;
    int iCount;
    
    Object oName = "C:\\DataDoc.doc";
    Object oHeader = "FirstName, LastName, Address, CityStateZip";
    wrdDoc.MailMerge.CreateDataSource(ref oName,ref oMissing, 
    ref oMissing,ref oHeader, ref oMissing, ref oMissing, 
    ref oMissing, ref oMissing, ref oMissing);
    
    // Open the file to insert data.
    oDataDoc = wrdApp.Documents.Open(ref oName,ref oMissing,
    ref oMissing, ref oMissing,ref oMissing,ref oMissing,
    ref oMissing,ref oMissing,ref oMissing,ref oMissing,
    ref oMissing,ref oMissing,ref oMissing,ref oMissing,
    ref oMissing/*, ref oMissing */);
    
    for (iCount=1; iCount<=2; iCount++)
    {
    oDataDoc.Tables[1].Rows.Add(ref oMissing);
    }
    // Fill in the data.
    FillRow(oDataDoc, 2, "Steve", "DeBroux", 
    "4567 Main Street", "Buffalo, NY  98052");
    FillRow(oDataDoc, 3, "Jan", "Miksovsky", 
    "1234 5th Street", "Charlotte, NC  98765");
    FillRow(oDataDoc, 4, "Brian", "Valentine", 
    "12348 78th Street  Apt. 214", 
    "Lubbock, TX  25874");
    // Save and close the file.
    oDataDoc.Save();
    oDataDoc.Close(ref oFalse, ref oMissing, ref oMissing);
    }
    
    private void button1_Click(object sender, System.EventArgs e)
    {
    Word.Selection wrdSelection;
    Word.MailMerge wrdMailMerge;
    Word.MailMergeFields wrdMergeFields;
    Word.Table wrdTable;
    string StrToAdd;
    
    // Create an instance of Word  and make it visible.
    wrdApp = new Word.Application();
    wrdApp.Visible = true;
    
    // Add a new document.
    wrdDoc = wrdApp.Documents.Add(ref oMissing,ref oMissing,
    ref oMissing,ref oMissing);
    wrdDoc.Select();
    
    wrdSelection = wrdApp.Selection;
    wrdMailMerge = wrdDoc.MailMerge;
    
    // Create a MailMerge Data file.
    CreateMailMergeDataFile();
    
    // Create a string and insert it into the document.
    StrToAdd = "State University\r\nElectrical Engineering Department";
    wrdSelection.ParagraphFormat.Alignment  = 
    Word.WdParagraphAlignment.wdAlignParagraphCenter;
    wrdSelection.TypeText(StrToAdd);
    
    InsertLines(4);
    
    // Insert merge data.
    wrdSelection.ParagraphFormat.Alignment = 
    Word.WdParagraphAlignment.wdAlignParagraphLeft;
    wrdMergeFields = wrdMailMerge.Fields;
    wrdMergeFields.Add(wrdSelection.Range, "FirstName");
    wrdSelection.TypeText(" ");
    wrdMergeFields.Add(wrdSelection.Range, "LastName");
    wrdSelection.TypeParagraph();
    
    wrdMergeFields.Add(wrdSelection.Range, "Address");
    wrdSelection.TypeParagraph();
    wrdMergeFields.Add(wrdSelection.Range, "CityStateZip");
    
    InsertLines(2);
    
    // Right justify the line and insert a date field
    // with the current date.
    wrdSelection.ParagraphFormat.Alignment = 
    Word.WdParagraphAlignment.wdAlignParagraphRight;
    
    Object objDate = "dddd, MMMM dd, yyyy";
    wrdSelection.InsertDateTime(ref objDate,ref oFalse,ref oMissing, 
    ref oMissing, ref oMissing);
    
    InsertLines(2);
    
    // Justify the rest of the document.
    wrdSelection.ParagraphFormat.Alignment = 
    Word.WdParagraphAlignment.wdAlignParagraphJustify;    
    
    wrdSelection.TypeText("Dear ");
    wrdMergeFields.Add(wrdSelection.Range, "FirstName");
    wrdSelection.TypeText(",");
    InsertLines(2);
    
    // Create a string and insert it into the document.
    StrToAdd = "Thank you for your recent request for next " +
    "semester's class schedule for the Electrical " +
    "Engineering Department. Enclosed with this " +
    "letter is a booklet containing all the classes " +
    "offered next semester at State University.  " +
    "Several new classes will be offered in the " +
    "Electrical Engineering Department next semester.  " +
    "These classes are listed below.";
    wrdSelection.TypeText(StrToAdd);
    
    InsertLines(2);
    
    // Insert a new table with 9 rows and 4 columns.
    wrdTable = wrdDoc.Tables.Add(wrdSelection.Range,9,4, 
    ref oMissing, ref oMissing);
    // Set the column widths.
    wrdTable.Columns[1].SetWidth(51, Word.WdRulerStyle.wdAdjustNone);
    wrdTable.Columns[2].SetWidth(170, Word.WdRulerStyle.wdAdjustNone);
    wrdTable.Columns[3].SetWidth(100, Word.WdRulerStyle.wdAdjustNone);
    wrdTable.Columns[4].SetWidth(111, Word.WdRulerStyle.wdAdjustNone);
    // Set the shading on the first row to light gray.
    wrdTable.Rows[1].Cells.Shading.BackgroundPatternColorIndex = 
    Word.WdColorIndex.wdGray25;
    // Bold the first row.
    wrdTable.Rows[1].Range.Bold = 1;
    // Center the text in Cell (1,1).
    wrdTable.Cell(1, 1).Range.Paragraphs.Alignment = 
    Word.WdParagraphAlignment.wdAlignParagraphCenter;
    
    // Fill each row of the table with data.
    FillRow(wrdDoc, 1, "Class Number", "Class Name", 
    "Class Time", "Instructor");
    FillRow(wrdDoc, 2, "EE220", "Introduction to Electronics II", 
    "1:00-2:00 M,W,F", "Dr. Jensen");
    FillRow(wrdDoc, 3, "EE230", "Electromagnetic Field Theory I", 
    "10:00-11:30 T,T", "Dr. Crump");
    FillRow( wrdDoc, 4, "EE300", "Feedback Control Systems", 
    "9:00-10:00 M,W,F", "Dr. Murdy");
    FillRow(wrdDoc, 5, "EE325", "Advanced Digital Design", 
    "9:00-10:30 T,T", "Dr. Alley");
    FillRow(wrdDoc, 6, "EE350", "Advanced Communication Systems", 
    "9:00-10:30 T,T", "Dr. Taylor");
    FillRow(wrdDoc, 7, "EE400", "Advanced Microwave Theory", 
    "1:00-2:30 T,T", "Dr. Lee");
    FillRow(wrdDoc, 8, "EE450", "Plasma Theory",
    "1:00-2:00 M,W,F", "Dr. Davis");
    FillRow(wrdDoc, 9, "EE500", "Principles of VLSI Design", 
    "3:00-4:00 M,W,F", "Dr. Ellison");
    
    // Go to the end of the document.
    Object oConst1 = Word.WdGoToItem.wdGoToLine;
    Object oConst2 = Word.WdGoToDirection.wdGoToLast;
    wrdApp.Selection.GoTo(ref oConst1,ref oConst2,ref oMissing,ref oMissing);
    InsertLines(2);
    
    // Create a string and insert it into the document.
    StrToAdd = "For additional information regarding the " +
    "Department of Electrical Engineering, " +
    "you can visit our Web site at ";
    wrdSelection.TypeText(StrToAdd);
    // Insert a hyperlink to the Web page.
    Object oAddress = "http://www.ee.stateu.tld";
    Object oRange = wrdSelection.Range;
    wrdSelection.Hyperlinks.Add(oRange, ref oAddress,ref oMissing,
    ref oMissing, ref oMissing, ref oMissing);
    // Create a string and insert it into the document
    StrToAdd = ".  Thank you for your interest in the classes " +
    "offered in the Department of Electrical " +
    "Engineering.  If you have any other questions, " +
    "please feel free to give us a call at " +
    "555-1212.\r\n\r\n"  +
    "Sincerely,\r\n\r\n" +
    "Kathryn M. Hinsch\r\n" +
    "Department of Electrical Engineering \r\n";
    wrdSelection.TypeText(StrToAdd);
    
    // Perform mail merge.
    wrdMailMerge.Destination = Word.WdMailMergeDestination.wdSendToNewDocument;
    wrdMailMerge.Execute(ref oFalse);
    
    // Close the original form document.
    wrdDoc.Saved = true;
    wrdDoc.Close(ref oFalse,ref oMissing,ref oMissing);
    
    // Release References.
    wrdSelection = null;
    wrdMailMerge = null;
    wrdMergeFields = null;
    wrdDoc = null;
    wrdApp = null;
    
    // Clean up temp file.
    System.IO.File.Delete("C:\\DataDoc.doc");
    } 
    
    ```

    **Note** You must change the code in Visual Studio 2005. By default, Visual C# adds one form to the project when you create a Windows Forms project. The form is named Form1. The two files that represent the form are named Form1.cs and Form1.designer.cs. You write the code in Form1.cs. The Form1.designer.cs file is where the Windows Forms Designer writes the code that implements all the actions that you performed by dragging and dropping controls from the Toolbox. 

    For more information about the Windows Forms Designer in Visual C# 2005, visit the following Microsoft Developer Network (MSDN) Web site: [Creating a Project (Visual C#)](https://msdn.microsoft.com/library/ms173077.aspx)Note Microsoft Office Word 2003 has an additional argument for the Open method of the document. If you are using the Word 2003 PIA, remove the comment notation for the additional parameter for the Open method.   
7. Add the following to the top of Form1.cs:
    ```cs
    using Word = Microsoft.Office.Interop.Word;
    
    ```

8. Press F5 to build and to run the program.   
9. Click Button1 to start Word Automation and to perform the mail merge.   

## References

For more information, visit the following Microsoft Developer Network (MSDN) Web site: Microsoft Office Development with Visual Studio
[Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[285332](https://support.microsoft.com/help/285332) How To Automate Word 2002 with Visual Basic to Create a Mail Merge