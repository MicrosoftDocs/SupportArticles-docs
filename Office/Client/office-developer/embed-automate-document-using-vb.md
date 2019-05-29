---
title: How To embed and automate Office documents with Visual Basic
description: Demonstrates how to dynamically create and Automate an Office document using the OLE Container Control.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How To embed and automate Office documents with Visual Basic

## Summary

When developing an application that uses data in an Office document, it might be beneficial to have that data presented directly within your Visual Basic application so that the user can see and edit the data without having to switch to the Office application. You can accomplish this in Visual Basic using the OLE Container Control.

This article demonstrates how to dynamically create and Automate an Office document using the OLE Container Control. 

## More Information

The ability to insert an Office document into Visual Basic is made possible by Microsoft's Object Linking and Embedding (OLE) technology. OLE is designed to let one application host an object belonging to another application in a manner that is convenient for the end user, but doesn't require the applications involved to know the internal details of the other. Visual Basic provides the OLE Container Control to let Visual Basic programmers add OLE objects to a form.

Once the object is embedded, most OLE servers support Automation to let the host application programmatically change or manipulate the object from code. To get a reference to the Automation object, use the Object property of the OLE container. This property returns the Automation object that closely matches the particular item embedded. 

### Create a Visual Basic application that hosts an Excel workbook


1. Start Visual Basic and create a new standard project. Form1 is created by default.   
2. From the control toolbox, add three Command Buttons to Form1. Then add an instance of the OLE Container control. When the OLE Container control is placed on the form, it prompts you for the type of object you want to insert. For this sample, you need to add the object dynamically, so click Cancel to dismiss the dialog without adding an object.   
3. In the Code window for Form1, add the following code:
    ```vb
    Option Explicit
    
    Dim oBook As Object
    Dim oSheet As Object
    
    Private Sub Command1_Click()
       On Error GoTo Err_Handler
    
    ' Create a new Excel worksheet...
       OLE1.CreateEmbed vbNullString, "Excel.Sheet"
    
    ' Now, pre-fill it with some data you
     ' can use. The OLE.Object property returns a
     ' workbook object, and you can use Sheets(1)
     ' to get the first sheet.
       Dim arrData(1 To 5, 1 To 5) As Variant
       Dim i As Long, j As Long
    
    Set oBook = OLE1.object
       Set oSheet = oBook.Sheets(1)
    
    ' It is much more efficient to use an array to
     ' pass data to Excel than to push data over
     ' cell-by-cell, so you can use an array.
    
    ' Add some column headers to the array...
       arrData(1, 2) = "April"
       arrData(1, 3) = "May"
       arrData(1, 4) = "June"
       arrData(1, 5) = "July"
    
    ' Add some row headers...
       arrData(2, 1) = "John"
       arrData(3, 1) = "Sally"
       arrData(4, 1) = "Charles"
       arrData(5, 1) = "Toni"
    
    ' Now add some data...
       For i = 2 To 5
          For j = 2 To 5
             arrData(i, j) = 350 + ((i + j) Mod 3)
          Next j
       Next i
    
    ' Assign the data to Excel...
       oSheet.Range("A3:E7").Value = arrData
    
    oSheet.Cells(1, 1).Value = "Test Data"
       oSheet.Range("B9:E9").FormulaR1C1 = "=SUM(R[-5]C:R[-2]C)"
    
    ' Do some auto formatting...
       oSheet.Range("A1:E9").Select
       oBook.Application.Selection.AutoFormat
    
    Command1.Enabled = False
       Command2.Enabled = False
       Command3.Enabled = True
       Exit Sub
    
    Err_Handler:
       MsgBox "An error occurred: " & Err.Description, vbCritical
    End Sub
    
    Private Sub Command2_Click()
       On Error GoTo Err_Handler
    
    ' Create an embedded object using the data
     ' stored in Test.xls.<?xm-insertion_mark_start author="v-thomr" time="20070327T040420-0600"?> If this code is run in Microsoft Office
     ' Excel 2007, <?xm-insertion_mark_end?><?xm-deletion_mark author="v-thomr" time="20070327T040345-0600" data=".."?><?xm-insertion_mark_start author="v-thomr" time="20070327T040422-0600"?>change the file name to Test.xlsx.<?xm-insertion_mark_end?>
       OLE1.CreateEmbed "C:\Test.xls"
    
    Command1.Enabled = False
       Command2.Enabled = False
       Command3.Enabled = True
       Exit Sub
    
    Err_Handler:
       MsgBox "The file 'C:\Test.xls' does not exist" & _
              " or cannot be opened.", vbCritical
    End Sub
    
    Private Sub Command3_Click()
       On Error Resume Next
    
    ' Delete the existing test file (if any)...
       Kill "C:\Test.xls"
    
    ' Save the file as a native XLS file...
       oBook.SaveAs "C:\Test.xls"
       Set oBook = Nothing
       Set oSheet = Nothing
    
    ' Close the OLE object and remove it...
       OLE1.Close
       OLE1.Delete
    
    Command1.Enabled = True
       Command2.Enabled = True
       Command3.Enabled = False
    End Sub
    
    Private Sub Form_Load()
       Command1.Caption = "Create"
       Command2.Caption = "Open"
       Command3.Caption = "Save"
       Command3.Enabled = False
    End Sub
    
    ```

4. Press the F5 key to run the program. Click the Create button. This embeds a new worksheet and Automates Excel to add data directly to the sheet. Note that if you double-click the object, it activates in-place and the user can edit the data directly. Now click Save to save the data to a file and close the OLE object. The Open button lets you open a copy of a previously saved file.   

### Create a Visual Basic application that hosts a Word document

1. Start Visual Basic and create a new standard project. Form1 is created by default.   
2. From the control toolbox, add three Command Buttons to Form1. Then add an instance of the OLE Container control. When the OLE Container control is placed on the form, it prompts you for the type of object you want to insert. For this sample, we need to add the object dynamically, so click Cancel to dismiss the dialog without adding an object.   
3. In the Code window for Form1, add the following code:
    ```vb
    Option Explicit
    
    Dim oDocument As Object
    
    Private Sub Command1_Click()
       On Error GoTo Err_Handler
    
    ' Create a new Word Document...
       OLE1.CreateEmbed vbNullString, "Word.Document"
    
    ' Add some text to the document. The OLE.Object
     ' property returns the document object...
       Set oDocument = OLE1.object
    
    oDocument.Content.Select
       With oDocument.Application.Selection
    
    ' Add a heading at the top of the document...
          .Style = oDocument.Styles("Heading 1")
          .Font.Color = &HFF0000
          .TypeText "Blue Sky Airlines"
          .ParagraphFormat.Alignment = 1 '[wdAlignParagraphCenter]
          .TypeParagraph
          .TypeParagraph
    
    ' Now add some text...
          .TypeText "Dear Mr. Smith,"
          .TypeParagraph
          .TypeParagraph
          .TypeText "Thank you for your interest in our current fares " & _
                    "from Oakland to Sacramento. We guarantee to be " & _
                    "the lowest price for local flights, or we'll " & _
                    "offer to make your next flight FREE!"
          .TypeParagraph
          .TypeParagraph
          .TypeText "The current fare for a flight leaving Oakland " & _
                    "on October 4, 1999 and arriving in Sacramento " & _
                    "the same day is $54.00."
          .TypeParagraph
          .TypeParagraph
          .TypeText "We hope you will choose to fly Blue Sky Airlines."
          .TypeParagraph
          .TypeParagraph
          .TypeText "Sincerely,"
          .TypeParagraph
          .TypeParagraph
          .TypeParagraph
          .TypeText "John Taylor"
          .TypeParagraph
          .Font.Italic = True
          .TypeText "Regional Sales Manager"
          .TypeParagraph
    
    End With
    
    ' Zoom to see entire document...
       OLE1.SizeMode = 3
       OLE1.DoVerb -1
    
    Command1.Enabled = False
       Command2.Enabled = False
       Command3.Enabled = True
       Exit Sub
    
    Err_Handler:
       MsgBox "An error occurred: " & Err.Description, vbCritical
    End Sub
    
    Private Sub Command2_Click()
       On Error GoTo Err_Handler
    
    ' Create an embedded object using the data
     ' stored in Test.doc.<?xm-insertion_mark_start author="v-thomr" time="20070327T040719-0600"?> If this code is run in Microsoft Office
     ' Word 2007, change the file name to Test.docx.<?xm-insertion_mark_end?><?xm-deletion_mark author="v-thomr" time="20070327T040717-0600" data=".."?>
       OLE1.CreateEmbed "C:\Test.doc"
    
    Command1.Enabled = False
       Command2.Enabled = False
       Command3.Enabled = True
       Exit Sub
    
    Err_Handler:
       MsgBox "The file 'C:\Test.doc' does not exist" & _
              " or cannot be opened.", vbCritical
    End Sub
    
    Private Sub Command3_Click()
       On Error Resume Next
    
    ' Delete the existinf test file (if any)...
       Kill "C:\Test.doc"
    
    ' Save the file as a native Word DOC file...
       oDocument.SaveAs "C:\Test.doc"
       Set oDocument = Nothing
    
    ' Close the OLE object and remove it...
       OLE1.Close
       OLE1.Delete
    
    Command1.Enabled = True
       Command2.Enabled = True
       Command3.Enabled = False
    End Sub
    
    Private Sub Form_Load()
       Command1.Caption = "Create"
       Command2.Caption = "Open"
       Command3.Caption = "Save"
       Command3.Enabled = False
    End Sub
    
    ```

4. Press the F5 key to run the program. Click the Create button. This embeds a new document and Automates Word to add data directly to the document. Note that if you double-click the object, it activates in-place and the user can edit the data directly. Now click Save to save the data to a file and close the OLE object. The Open button lets you open a copy of a previously saved file.   

### Considerations when using the OLE container

- If you are embedding from an existing file, the data seen inside the OLE Container is a copy of the data on file. Any changes you make are not automatically saved to the same file. While you can use a technique similar to the one above to save the results back to a specific file, not all OLE servers support this capability. It is not considered normal OLE object behavior.   
- If you are "linking" to a file, the object cannot be activated in-place. Instead, when the user double-clicks the object, the object is opened in the window of the server application. Only embedded objects can be activated in-place.   
- The OLE Container control is data bound aware. If you have an Access 97 or Access 2000 database, you can bind the control to an OLE Object field in the database. When the form is displayed, the data is pulled from the database and displayed for the user to edit. Any editing changes made by the user are automatically saved back to the database when the OLE object is closed.

    To make the OLE Container control data bound, add a Visual Basic Data control and set its DatabaseName property to the database path. Then set the RecordSource to an existing table in the database. Use the OLE control's DataSource property to bind the control to the Visual Basic Data control, and then set the DataField property to point to a particular field in the recordset that contains the OLE object. Visual Basic does the rest.   
- The size and position of the hatched border that displays when the container is made in-place active is determined by the size of the object and the options selected for the OLE control. This border is displayed to mark the boundaries of the editing window. The boundaries of the editing window often do not match the boundaries of the OLE container itself; this behavior is normal for an OLE object. The editing window cannot be programmatically altered from Visual Basic.   
- Some Automation methods might fail to work correctly unless the object has been made in-place active. To programmatically activate an OLE object, use the DoVerb method and specify vbOLEShow (-1) as the verb.   
- You can determine whether a linked or embedded object's menu appears in the container form by setting a form's NegotiateMenus property. If the child form's NegotiateMenus property is set to True and the container has a menu bar defined, the object's menus are placed on the container's menu bar when the object is activated. If the container has no menu bar, or the NegotiateMenus property is set to False, the object's menus do not appear when it is activated. Note that the NegotiateMenus property does not apply to MDI Forms so an MDI Form's menu cannot be merged with those of the activated object. To illustrate menu negotiation, try the following with the sample application you created in the previous section:

   1. Run the application and click the Create button to embed a new document in the OLE container.   
   2. Right-click the OLE container and select Edit to in-place activate the object. Note that the menus for the object's application appear because the NegotiateMenus property of Form1 is set to True by default.   
   3. Close the Form to end the application.   
   4. With Form1 selected, click Menu Editor on the Tools menu.   
   5. Create a new top-level menu with the caption
 File and the name mnuFile. Set the NegotiatePosition property of this menu to "1-Left." Create a menu item with the caption Open and the name
 mnuOpen.    
   6. Click OK to close the menu editor.   
   7. Once again, run the application and click the Create button to embed a new document in the OLE container.   
   8. Right-click the OLE container and select Edit to in-place activate the object. Notice that the menu for Form1 has been merged with the menus for the object's application.   

    Visual Basic does not let you control the menu merging process or make changes to the server's menu items when added. However, you can change or modify an Office application's menus through Automation using code similar to the following: 

    ```vb
     ' This code disables the Insert|Object item on the merged menu...
       Dim oMenuBar As Object
       Set oMenuBar = oBook.Application.CommandBars("Worksheet Menu Bar")
       oMenuBar.Controls("&Insert").Controls("&Object...").Enabled = False
    
    ```

    Please note that some changes might need to be made before the object is made in-place active, otherwise the changes might fail to appear in the merged menu.

    **Note** This bullet point does NOT apply to Microsoft Office Excel 2007 or to Microsoft Office Word 2007. 
  
- Visual Basic does not currently support assignment of toolbar space. Thus, docked toolbars do not normally appear when the object is activated. However, it might be possible to display a floating tool window with automation:
    ```vb
       OLE1.DoVerb -1 '[vbOLEShow]
       With oBook.Application.CommandBars("Standard")
          .Position = 4 '[msoBarFloating]
          .Visible = True
       End With
    
    ```
    **Note** This bullet point does NOT apply to Microsoft Office Excel 2007 or to Microsoft Office Word 2007.   
- For programs that require an object to remain in-place active at all times, Microsoft has provided the ActiveX Documents technology. Not all OLE servers are ActiveX Document servers; Microsoft Word, Microsoft Excel and Microsoft PowerPoint are ActiveX Document servers.

    Visual Basic does not support a native control to host ActiveX Documents. However, the WebBrowser control that comes with Internet Explorer (version 3.0 and higher) does support this form of in-place containment. It is possible to use this control to open an Office document as an ActiveX Document. For more information about using the WebBrowser control, please see the following article:

    [243058](https://support.microsoft.com/help/243058) How To Use the WebBrowser Control to Open an Office Document

- The SaveToFile method of the OLE container creates a file that can be opened in the OLE container. However, files that are saved with the OLE container's SaveToFile method cannot be opened directly in the corresponding Office application. If you want to save your embedded document to disk so that document can be opened in the target application, use the application's document SaveAs method: 
    ```vb
    OLE1.object.SaveAs ("C:\MyNewFile.doc")
    ```