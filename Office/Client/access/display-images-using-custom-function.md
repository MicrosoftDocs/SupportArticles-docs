---
title: Create a custom function to display images
description: Describes how to manage and store images when you have lots of images or when the images are very large.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: cmathews
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---

# How to display images from a folder in a form, a report, or a data access page

_Original KB number:_ &nbsp; 285820

> [!NOTE]
> Requires expert coding, interoperability, and multiuser skills. This article applies to a Microsoft Access database (.mdb/.accdb) and to a Microsoft Access project (.adp).

## Summary

Sometimes, it's not practical to store images in a Microsoft Access table. If you have many images, or if each of your image files is large, the size of the Microsoft Access database file can quickly increase.

This article demonstrates a custom function that you can use to:

- Store file paths and names of images in a table.
- Display images by using an image control.
- Hide the image control if no image is available.
- Provide feedback on the display status of the image.

This article also contains sample Visual Basic script that you can use to display the images in a data access page.

> [!NOTE]
> Although this example use bitmap images (.bmp), you can also use other image types, such as .jpg, .pcx, and .gif.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

## Creating the table to store file and path data

1. Open the sample database, Northwind.mdb, or the sample project, NorthwindCS.adp.
2. Create the following table either in Northwind.mdb or in NorthwindCS.adp.

   In Northwind.mdb:

   ```console
   Table: tblImage
   ----------------------------
   Field Name: ImageID
   Data Type: AutoNumber
   Indexed: Yes (No Duplicates)

   Field Name: txtImageName
   Data Type: Text

   Table Properties: tblImage
   --------------------------
   PrimaryKey: ImageID
   ```

   In NorthwindCS.adp:

   ```console
   Table: tblImage
   -----------------------
   Column Name: ImageID
   Datatype: Int
   Allow Nulls: Unchecked
   Identity: Yes

   Column Name: txtImageName
   Datatype: varchar

   Table Properties: ImageTable
   -------------------------------
   Primary Key Constraint: ImageID
   ```

3. Open the tblImage table in Datasheet view, and then add the path and name of a bitmap file to each record. The following table of examples shows how the records might look:

   | Type| Example|
   |-----|-----|
   | Absolute (Local)| C:\Windows\Zapotec.bmp|
   | Absolute (UNC Path)|\\\Servername\sharename\Zapotec.bmp|
   | Relative|Zapotec.bmp|

## Creating the custom function

1. Create a new module, and then paste or type the following code:

   ```vb
   Option Compare Database
   Option Explicit

   Public Function DisplayImage(ctlImageControl As Control, strImagePath As Variant) As String
   On Error GoTo Err_DisplayImage

   Dim strResult As String
   Dim strDatabasePath As String
   Dim intSlashLocation As Integer

   With ctlImageControl
    If IsNull(strImagePath) Then
        .Visible = False
        strResult = "No image name specified."
    Else
        If InStr(1, strImagePath, "\") = 0 Then
            ' Path is relative
            strDatabasePath = CurrentProject.FullName
            intSlashLocation = InStrRev(strDatabasePath, "\", Len(strDatabasePath))
            strDatabasePath = Left(strDatabasePath, intSlashLocation)
            strImagePath = strDatabasePath & strImagePath
        End If
        .Visible = True
        .Picture = strImagePath
        strResult = "Image found and displayed."
    End If
   End With

   Exit_DisplayImage:
    DisplayImage = strResult
    Exit Function

   Err_DisplayImage:
    Select Case Err.Number
        Case 2220       ' Can't find the picture.
            ctlImageControl.Visible = False
            strResult = "Can't find image in the specified name."
            Resume Exit_DisplayImage:
        Case Else       ' Some other error.
            MsgBox Err.Number & " " & Err.Description
            strResult = "An error occurred displaying image."
            Resume Exit_DisplayImage:
    End Select
   End Function
   ```

2. Save the module as Module1.

## Using the custom function in a form

1. Create the following new form that is based on the tblImage table.

   ```console
   Form: frmImage
   ----------------------
   Caption: Image Form
   RecordSource: tblImage

   Image Control
   ---------------------------------
   Name: ImageFrame
   Picture: "C:\Windows\Zapotec.bmp"

   Text box
   ----------------------
   Name: txtImageID
   ControlSource: ImageID

   Text box
   ---------------------------
   Name: txtImageName
   ControlSource: txtImageName

   Text box
   ---------------------------
   Name: txtImageNote
   ControlSource: <Blank>
   ```

   > [!NOTE]
   > If you do not want the path to appear in the form, you can set the `Visible` property of the `txtImageName` control to **False**.

2. On the **View** menu, click **Code**, and then paste or type the following code:

   ```vb
   Option Compare Database
   Option Explicit

   Private Sub Form_AfterUpdate()
    CallDisplayImage
   End Sub

   Private Sub Form_Current()
    CallDisplayImage
   End Sub

   Private Sub txtImageName_AfterUpdate()
    CallDisplayImage
   End Sub

   Private Sub CallDisplayImage()
    Me!txtImageNote = DisplayImage(Me!ImageFrame, Me!txtImageName)
   End Sub
   ```

3. Open the frmImage form in Form view. Note that the form displays the corresponding bitmap for each record. If the `txtImageName` field is blank or if the image cannot be found, you receive appropriate messages instead of the image frame.

## Using the custom function in a report

1. Create the following new report that is based on the ImageTable table.

   ```console
   Report: rptImage
   ----------------------
   Caption: Image Report
   RecordSource: tblImage

   Image Control
   ---------------------------------
   Name: ImageFrame
   Picture: "C:\Windows\Zapotec.bmp"

   Text box
   ----------------------
   Name: txtImageID
   ControlSource: ImageID

   Text box
   ---------------------------
   Name: txtImageName
   ControlSource: txtImageName

   Text box
   ---------------------------
   Name: txtImageNote
   ControlSource: <Blank>
   ```

   > [!NOTE]
   > If you do not want the path to appear in the report, you can set the `Visible` property of the `txtImageName` control to **False**.

2. On the **View** menu, click **Code**, and then paste or type the following code:

   ```vb
   Option Compare Database
   Option Explicit

   Private Sub Detail_Print(Cancel As Integer, PrintCount As Integer)
    Me!txtImageNote = DisplayImage(Me!ImageFrame, Me!txtImageName)
   End Sub
   ```

3. Open the rptImage report in print preview. Note that the report displays the corresponding bitmap for each record. If the `txtImageName` field is blank or if the image cannot be found, you receive appropriate messages instead of the image frame.

## Duplicating the custom function in a data access page

1. Create the following new data access page that is based on the tblImage table.

   ```console
   Data Access Page: dapImage
   -----------------------------
   Title: Image Data Access Page

   Image Control
   ---------------------------------
   ID: ImageFrame

   Text box
   ----------------------
   ID: txtImageID
   ControlSource: ImageID

   Text box
   ---------------------------
   ID: txtImageName
   ControlSource: txtImageName
   ```

   > [!NOTE]
   > If you do not want the path to appear in the page, you can set the `Visibility` property of the `txtImageName` control to **Hidden**.

2. On the **Tools** menu, point to **Macros**, and then click **Microsoft Script Editor**.
3. Add the following script to the Current event of the MSODSC in the HEAD tag portion of the HTML document.

   > [!NOTE]
   > You must pass in a parameter in order for the event to be triggered.
   
   ```vbs
   <SCRIPT language=vbscript event=Current(oEventInfo) for=MSODSC>
   <!--
   ImageFrame.src=txtImageName.value
   -->
   </SCRIPT>
   ```

4. Open the dapImage page in Page view. Note that the page displays the corresponding bitmap for each record. If the txtImageName field is blank, a control icon is displayed. If the image cannot be found, an X icon appears in the image control.

### Use an http:// path in a form

To use an http:// path in a form, use the Web browser control (shdocvw.dll) as follows:

1. Add a Microsoft Web Browser control to the form and name it WebBrowser.
2. Add the following code to a module:

   ```vb
   Public Function DisplayImageWeb(ctlBrowserControl As Control, _
   strImagePath As Variant)

   On Error GoTo Err_DisplayImage

   Dim strDatabasePath As String
   Dim intSlashLocation As Integer

   With ctlBrowserControl
    If IsNull(strImagePath) Then
    ElseIf Left(strImagePath, 4) = "http" Then
        .Navigate (strImagePath)
    Else
        If InStr(1, strImagePath, "\") = 0 Then
            ' Path is relative
            strDatabasePath = CurrentProject.FullName
            intSlashLocation = InStrRev(strDatabasePath, "\", Len(strDatabasePath))
            strDatabasePath = Left(strDatabasePath, intSlashLocation)
            strImagePath = strDatabasePath & strImagePath
        End If
        .Navigate (strImagePath)
    End If
   End With

   Exit_DisplayImage:
    Exit Function

   Err_DisplayImage:
    Select Case Err.Number
        Case Else
            MsgBox Err.Number & " " & Err.Description
            Resume Exit_DisplayImage:
    End Select
   End Function
   ```

3. Add the following code behind the form:

   ```vb
   Option Compare Database
   Option Explicit

   Private Sub Form_AfterUpdate()
    CallDisplayImage
   End Sub

   Private Sub Form_Current()
    CallDisplayImage
   End Sub

   Private Sub txtImageName_AfterUpdate()
    CallDisplayImage
   End Sub

   Private Sub CallDisplayImage()
    DisplayImageWeb Me.WebBrowser9, Me.txtImageName
   End Sub
   ```
