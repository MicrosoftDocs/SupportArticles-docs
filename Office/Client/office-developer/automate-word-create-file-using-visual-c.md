---
title: How to automate Microsoft Word to create a new document by using Visual C#
description: Describes how to create a new document in Microsoft Word by using Automation from Microsoft Visual C# 2005 or Microsoft Visual C# .NET.
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

# How to automate Microsoft Word to create a new document by using Visual C#

For a Microsoft Visual Basic .NET version of this article, see

- [How to automate Word from Visual Basic .NET to create a new document](https://support.microsoft.com/help/316383)

- [How to Automate Microsoft Word by using Visual Basic to create a new document](https://support.microsoft.com/help/313193)

## Summary

This step-by-step article describes how to create a new document in Microsoft Word by using Automation from Microsoft Visual C# 2005 or Microsoft Visual C# .NET.

### Sample Code

The sample code in this article demonstrates how to do the following: 

- Insert paragraphs with text and formatting.   
- Browse and modify various ranges within a document.   
- Insert tables, format tables, and populate the tables with data.   
- Add a chart.   
 
To create a new Word document by using Automation from Visual C# 2005 or Visual C# .NET, follow these steps: 

1. Start Microsoft Visual Studio 2005 or Microsoft Visual Studio .NET.   
2. On the File menu, click New, and then click Project. Under Project Types, click Visual C# Projects, and then click Windows Application under Templates. Form1 is created by default.

   **Note** In Visual Studio 2005, click **Visual C#** instead of **Visual C# Projects**.   
3. Add a reference to Microsoft Word Object Library. To do this, follow these steps:

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, locate Microsoft Word Object Library, and then click Select.

   **Note** In Visual Studio 2005, you do not have to click **Select**.

   **Note** Microsoft Office 2003 includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they can be downloaded. 

   3. Click OK in the Add References dialog box to accept your selections. If you are prompted to generate wrappers for the libraries that you selected, click Yes.   
   
4. On the View menu, select Toolbox to display the Toolbox, and then add a button to Form1.   
5. Double-click Button1. The code window for the form appears.   
6. In the code window, replace the following code:

    ```cs
    private void button1_Click(object sender, System.EventArgs e)
    {
    }
    
    ```
   with: 
    ```cs
    private void button1_Click(object sender, System.EventArgs e)
    {
    object oMissing = System.Reflection.Missing.Value;
    object oEndOfDoc = "\\endofdoc"; /* \endofdoc is a predefined bookmark */ 
    
    //Start Word and create a new document.
    Word._Application oWord;
    Word._Document oDoc;
    oWord = new Word.Application();
    oWord.Visible = true;
    oDoc = oWord.Documents.Add(ref oMissing, ref oMissing,
    ref oMissing, ref oMissing);
    
    //Insert a paragraph at the beginning of the document.
    Word.Paragraph oPara1;
    oPara1 = oDoc.Content.Paragraphs.Add(ref oMissing);
    oPara1.Range.Text = "Heading 1";
    oPara1.Range.Font.Bold = 1;
    oPara1.Format.SpaceAfter = 24;    //24 pt spacing after paragraph.
    oPara1.Range.InsertParagraphAfter();
    
    //Insert a paragraph at the end of the document.
    Word.Paragraph oPara2;
    object oRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    oPara2 = oDoc.Content.Paragraphs.Add(ref oRng);
    oPara2.Range.Text = "Heading 2";
    oPara2.Format.SpaceAfter = 6;
    oPara2.Range.InsertParagraphAfter();
    
    //Insert another paragraph.
    Word.Paragraph oPara3;
    oRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    oPara3 = oDoc.Content.Paragraphs.Add(ref oRng);
    oPara3.Range.Text = "This is a sentence of normal text. Now here is a table:";
    oPara3.Range.Font.Bold = 0;
    oPara3.Format.SpaceAfter = 24;
    oPara3.Range.InsertParagraphAfter();
    
    //Insert a 3 x 5 table, fill it with data, and make the first row
    //bold and italic.
    Word.Table oTable;
    Word.Range wrdRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    oTable = oDoc.Tables.Add(wrdRng, 3, 5, ref oMissing, ref oMissing);
    oTable.Range.ParagraphFormat.SpaceAfter = 6;
    int r, c;
    string strText;
    for(r = 1; r <= 3; r++)
    for(c = 1; c <= 5; c++)
    {
    strText = "r" + r + "c" + c;
    oTable.Cell(r, c).Range.Text = strText;
    }
    oTable.Rows[1].Range.Font.Bold = 1;
    oTable.Rows[1].Range.Font.Italic = 1;
    
    //Add some text after the table.
    Word.Paragraph oPara4;
    oRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    oPara4 = oDoc.Content.Paragraphs.Add(ref oRng);
    oPara4.Range.InsertParagraphBefore();
    oPara4.Range.Text = "And here's another table:";
    oPara4.Format.SpaceAfter = 24;
    oPara4.Range.InsertParagraphAfter();
    
    //Insert a 5 x 2 table, fill it with data, and change the column widths.
    wrdRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    oTable = oDoc.Tables.Add(wrdRng, 5, 2, ref oMissing, ref oMissing);
    oTable.Range.ParagraphFormat.SpaceAfter = 6;
    for(r = 1; r <= 5; r++)
    for(c = 1; c <= 2; c++)
    {
    strText = "r" + r + "c" + c;
    oTable.Cell(r, c).Range.Text = strText;
    }
    oTable.Columns[1].Width = oWord.InchesToPoints(2); //Change width of columns 1 & 2
    oTable.Columns[2].Width = oWord.InchesToPoints(3);
    
    //Keep inserting text. When you get to 7 inches from top of the
    //document, insert a hard page break.
    object oPos;
    double dPos = oWord.InchesToPoints(7);
    oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range.InsertParagraphAfter();
    do
    {
    wrdRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    wrdRng.ParagraphFormat.SpaceAfter = 6;
    wrdRng.InsertAfter("A line of text");
    wrdRng.InsertParagraphAfter();
    oPos = wrdRng.get_Information
                           (Word.WdInformation.wdVerticalPositionRelativeToPage);
    }
    while(dPos >= Convert.ToDouble(oPos));
    object oCollapseEnd = Word.WdCollapseDirection.wdCollapseEnd;
    object oPageBreak = Word.WdBreakType.wdPageBreak;
    wrdRng.Collapse(ref oCollapseEnd);
    wrdRng.InsertBreak(ref oPageBreak);
    wrdRng.Collapse(ref oCollapseEnd);
    wrdRng.InsertAfter("We're now on page 2. Here's my chart:");
    wrdRng.InsertParagraphAfter();
    
    //Insert a chart.
    Word.InlineShape oShape;
    object oClassType = "MSGraph.Chart.8";
    wrdRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    oShape = wrdRng.InlineShapes.AddOLEObject(ref oClassType, ref oMissing, 
    ref oMissing, ref oMissing, ref oMissing,
    ref oMissing, ref oMissing, ref oMissing);
    
    //Demonstrate use of late bound oChart and oChartApp objects to
    //manipulate the chart object with MSGraph.
    object oChart;
    object oChartApp;
    oChart = oShape.OLEFormat.Object;
    oChartApp = oChart.GetType().InvokeMember("Application",
    BindingFlags.GetProperty, null, oChart, null);
    
    //Change the chart type to Line.
    object[] Parameters = new Object[1];
    Parameters[0] = 4; //xlLine = 4
    oChart.GetType().InvokeMember("ChartType", BindingFlags.SetProperty,
    null, oChart, Parameters);
    
    //Update the chart image and quit MSGraph.
    oChartApp.GetType().InvokeMember("Update",
    BindingFlags.InvokeMethod, null, oChartApp, null);
    oChartApp.GetType().InvokeMember("Quit",
    BindingFlags.InvokeMethod, null, oChartApp, null);
    //... If desired, you can proceed from here using the Microsoft Graph 
    //Object model on the oChart and oChartApp objects to make additional
    //changes to the chart.
    
    //Set the width of the chart.
    oShape.Width = oWord.InchesToPoints(6.25f);
    oShape.Height = oWord.InchesToPoints(3.57f);
    
    //Add text after the chart.
    wrdRng = oDoc.Bookmarks.get_Item(ref oEndOfDoc).Range;
    wrdRng.InsertParagraphAfter();
    wrdRng.InsertAfter("THE END.");
    
    //Close this form.
    this.Close();
    }
    ```

7. Scroll to the top of the code window. Add the following line to the end of the list of using directives:

    ```cs
    using Word = Microsoft.Office.Interop.Word;
    using System.Reflection;
    ```

8. Press F5 to build and to run the program.   
9. Click Button1 to start Word Automation and to create the document.   

After the code completes, examine the document that was created for you. The document contains two pages of formatted paragraphs, tables, and a chart.

### Use a Template

If you are using Automation to build documents that are all in a common format, you can benefit from starting the process with a new document that is based on a preformatted template. Using a template with your Word Automation client has two significant advantages over building a document from nothing: 

- You can have greater control over the formatting and placement of objects throughout your documents.   
- You can build your documents with less code.

By using a template, you can fine-tune the placement of tables, paragraphs, and other objects within the document, as well as include formatting on those objects. By using Automation, you can create a new document based on your template with code such as the following: 

```cs
object oTemplate = "c:\\MyTemplate.dot";
oDoc = oWord.Documents.Add(ref oTemplate, ref oMissing,
ref oMissing, ref oMissing);
```

In your template, you can define bookmarks so that your Automation client can fill in variable text at a specific location in the document, as follows: 

```cs
object oBookMark = "MyBookmark";
oDoc.Bookmarks.Item(ref oBookMark).Range.Text = "Some Text Here";
```
 
Another advantage to using a template is that you can create and store formatting styles that you wish to apply at runtime, as follows: 

```cs
object oStyleName = "MyStyle";
oDoc.Bookmarks.Item(ref oBookMark).Range.set_Style(ref oStyleName);
```

or

```cs
object oStyleName = "MyStyle";
oWord.Selection.set_Style(ref oStyleName);
```

## References

For more information, view the articles in the Microsoft Knowledge Base: 

- [How to automate Microsoft Word to perform Mail Merge from Visual C#](https://support.microsoft.com/help/301659)

- [Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)

- [Word in the Office](https://msdn.microsoft.com/library/aa201330%28office.11%29.aspx)

- [One More Word](https://msdn.microsoft.com/library/aa201332%28office.11%29.aspx)