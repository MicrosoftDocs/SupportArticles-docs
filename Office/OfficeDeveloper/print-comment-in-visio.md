---
title: How to print comments when use Track Markup feature in Visio
description: Contains a macro that you can use to print  comments that are added by reviewers when you use the Track Markup feature in in Visio 2010, in Visio 2007, or in Visio 2003.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to print comments that are inserted by reviewers when you use the Track Markup feature in Visio 2010, in Visio 2007, or in Visio 2003

## INTRODUCTION 

This article describes a macro that you can use to print comments that are inserted by reviewers. You can use this macro when you use the Track Markup feature in Microsoft Visio 2010, in Microsoft Office Visio 2007, or in Microsoft Office Visio 2003. 

## More Information

When you use the Track Markup feature in Visio, users who review the drawing can add proposed changes. Proposed changes are also known as markup. Markup includes shapes, ink shapes, and comments. When you print a drawing that contains markup, the comments that are inserted by the reviewers are not printed. Use the macro that is discussed in this article to print the comments that are inserted by the reviewers.

The macro extracts the comments that are in the drawing, and then inserts the comments in a new shape. The new shape appears outside the drawing page. Resize the shape, and then drag the shape to the drawing page. When you print the drawing, the comments appear in the new shape that you added to the drawing. 

To create and to run the macro, follow these steps.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

1. Create the macro. To do this, follow these steps: 
   1. Start Visio, and then open your drawing.   
   2. Press ALT+F11 to start Microsoft Visual Basic Editor.   
   3. On the **Insert ** menu, click **Module**. 

   4. Copy the following code, and then paste the code in the **FileName** - Module**Number** (Code) window: 
        ```vb
        Public Sub GetComments()
        Dim pagMarkup As Visio.Page
        Dim pag As Visio.Page
        Dim shp As Visio.Shape
        Dim sText As String
        Dim iRow As Integer
        
        Set pag = Visio.ActivePage
        sText = "Reviewer" & vbTab & "Date" & vbTab & "Comment"
        
        If pag.PageSheet.SectionExists(Visio.visSectionAnnotation, Visio.visExistsAnywhere) Then
        For iRow = 0 To pag.PageSheet.RowCount(Visio.visSectionAnnotation) - 1
        sText = sText & vbCrLf & pag.Document.DocumentSheet.CellsSRC(Visio.visSectionReviewer, pag.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationReviewerID).ResultIU - 1, Visio.visReviewerInitials).ResultStr("")
        sText = sText & pag.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationMarkerIndex).ResultIU
        sText = sText & vbTab & Format(pag.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationDate).ResultIU, "ddddd")
        sText = sText & vbTab & pag.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationComment).ResultStr("")
        Next iRow
        End If
        
        For Each pagMarkup In pag.Document.Pages
        If pagMarkup.Type = visTypeMarkup Then
        If pagMarkup.OriginalPage = pag Then
        If pagMarkup.PageSheet.SectionExists(Visio.visSectionAnnotation, Visio.visExistsAnywhere) Then
        sText = sText & vbCrLf
        sText = sText & vbCrLf & pag.Document.DocumentSheet.CellsSRC(Visio.visSectionReviewer, pagMarkup.ReviewerID - 1, Visio.visReviewerName).ResultStr("")
        For iRow = 0 To pagMarkup.PageSheet.RowCount(Visio.visSectionAnnotation) - 1
        sText = sText & vbCrLf & pag.Document.DocumentSheet.CellsSRC(Visio.visSectionReviewer, pagMarkup.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationReviewerID).ResultIU - 1, Visio.visReviewerInitials).ResultStr("")
        sText = sText & pagMarkup.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationMarkerIndex).ResultIU
        sText = sText & vbTab & Format(pagMarkup.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationDate).ResultIU, "ddddd")
        sText = sText & vbTab & pagMarkup.PageSheet.CellsSRC(Visio.visSectionAnnotation, iRow, Visio.visAnnotationComment).ResultStr("")
        Next iRow
        End If
        End If
        End If
        Next pagMarkup
        
        Dim iAutoSize as Integer 'new
        iAutoSize = pag.AutoSize 'new
        pag.AutoSize = 0 'new
        Set shp = pag.DrawRectangle(-pag.PageSheet.Cells("PageWidth").ResultIU, 0, 0, pag.PageSheet.Cells("PageHeight").ResultIU)
        pag.AutoSize = iAutoSize 'new
        shp.AddSection visSectionUser 'new
        shp.AddNamedRow visSectionUser, "msvNoAutoSize", visTagDefault 'new
        shp.CellsU("User.msvNoAutoSize").FormulaU = 1 'new
        shp.Cells("Para.HorzAlign").Formula = "0"
        shp.Cells("VerticalAlign").Formula = "0"
        shp.Name = "Reviewers Comments"
        shp.Text = sText
        End Sub
        ```

   5. Press CTRL+S to save the drawing.    
   6. On the **File** menu, click **Close and Return to Visio**.   
   
2. Run the macro. To do this, follow these steps: 
   1. On the **Tools** menu, point to **Macros**, and then click **Macros**.   
   2. In the **Macro name** list, click the macro that you created in step 1, and then click **Run**. The name of the macro is **FileName**.Module**Number**.GetComments.

    The macro inserts the comments in a new shape that appears to the left of the drawing page.   
   
3.  Resize the shape that contains the comments, and then drag the shape to the drawing page. If you want, format the text in the shape. When you print your drawing, the comments appear in the shape in your drawing.   