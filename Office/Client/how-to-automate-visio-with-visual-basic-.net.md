---
title: How to automate Visio with Visual Basic .NET
description: Demonstrates how to automate Visio using Visual Basic .NET.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to automate Visio with Visual Basic .NET

## Summary

This article demonstrates how to automate Visio using Visual Basic .NET. 

## More Information

The sample automation code in this article does the following: 

- Draws a simple flowchart on the Visio drawing page that is based on data that is contained in an array.   
- Names the page.   
- Saves the document.   
 
The array is two-dimensional: The first element contains the name of the shape, and the second element contains the text of the shape. 

### Steps to Create the Sample Visual Basic .NET Application

1. Start Microsoft Visual Studio .NET. On the File menu, click New and then click Project. Under Project types click Visual Basic Projects, then click Windows Application under Templates. Form1 is created by default.   
2. Add a reference to the Visio object library. To do this, follow these steps:

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, click one of the following options, and click Select: 
      - For Visio 2007, click **Microsoft Visio 12.0 Type Library**.   
      - For Visio 2003, click **Microsoft Visio 11.0 Type Library**.   
      - For Visio 2002, click **Microsoft Visio 2002 Type Library**.   
    
    **Note** If you have not already done so, Microsoft recommends that you download and install the Microsoft Office XP Primary Interop Assemblies (PIAs).

3. Click OK in the Add References dialog box to accept your selections. If you receive a prompt to generate wrappers for the libraries that you selected, click Yes.   
   
3. On the View menu, click ToolBox. Add a button to Form1.   
4. Double-click Button1. The code window opens at the Click event for Button1.   
5. In the code window, replace the following code
    ```vb
    Private Sub Button1_Click(ByVal sender As System.Object, _
       ByVal e As System.EventArgs) Handles Button1.Click
    End Sub
    
    ```
     with: 
    ```vb
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As
          System.EventArgs) Handles Button1.Click
       fBuildArray()
       fBuildFlowchart()
    End Sub
    
    ```

6. On the Project menu, click Add Module.    
7. Replace the contents of Module1 with the following:
    ```vb
    Module Module1
       Public aryValues(5, 2) As String
       Sub fBuildArray()
          aryValues(0, 0) = "Terminator"
          aryValues(1, 0) = "Document"
          aryValues(2, 0) = "Decision"
          aryValues(3, 0) = "Process"
          aryValues(4, 0) = "Terminator"
    
    aryValues(0, 1) = "Begin Routing Process"
          aryValues(1, 1) = "Gather Customer Data"
          aryValues(2, 1) = "Supported Issue?"
          aryValues(3, 1) = "Dispatch to Queue"
          aryValues(4, 1) = "End Routing Process"
       End Sub
    
    Sub fBuildFlowchart()
          Dim vApp As Visio.Application
          Dim vDoc As Visio.Document
          Dim vFromShape As Visio.Shape
          Dim vToShape As Visio.Shape
          Dim vConnector As Visio.Shape
          Dim vFlowChartMaster As Visio.Master
          Dim vConnectorMaster As Visio.Master
          Dim vStencil As Visio.Document
          Dim dblXLocation As Double
          Dim dblYLocation As Double
          Dim vBeginCell As Visio.Cell
          Dim vEndCell As Visio.Cell
          Dim iCount As Integer
          Const TEMPLATEPATH = "C:\Program Files\Microsoft Office\Visio10\1033\" _
             & "Solutions\Flowchart\Basic Flowchart Shapes (US units).vss"
    
    ' Change this constant to match your choice of location and file name.
          Const SAVENEWFILE = "C:\Simpleflowchart.vsd"
    
    ' Start point measured from the bottom left corner.
          dblXLocation = 4.25
          dblYLocation = 8.5
    
    vApp = New Visio.Application()
          'Create a new document; note the empty string.
          vDoc = vApp.Documents.Add("")
          vStencil = vApp.Documents.OpenEx(TEMPLATEPATH, 4)
    
    For iCount = LBound(aryValues) To UBound(aryValues) - 1
             vFlowChartMaster = vStencil.Masters(aryValues(iCount, 0))
             vToShape = vApp.ActivePage.Drop(vFlowChartMaster, _
                dblXLocation, dblYLocation)
             vToShape.Text = aryValues(iCount, 1)
             If Not vFromShape Is Nothing Then
                If vConnectorMaster Is Nothing Then
                   vConnectorMaster = vStencil.Masters("Dynamic Connector")
                End If
                vConnector = vApp.ActivePage.Drop(vConnectorMaster, 0, 0)
                vBeginCell = vConnector.Cells("BeginX")
                vBeginCell.GlueTo(vFromShape.Cells("AlignBottom"))
                vEndCell = vConnector.Cells("EndX")
                vEndCell.GlueTo(vToShape.Cells("AlignTop"))
                vConnector.SendToBack()
             End If
             vFromShape = vToShape
             vToShape = Nothing
             dblYLocation = dblYLocation - 1.5
          Next
          vDoc.Pages(1).Name = "Flowchart Example"
          Try
             ' Delete the previous version of the file.
             Kill(SAVENEWFILE)
          Catch
          End Try
          vDoc.SaveAs(SAVENEWFILE)
          vDoc.Close()
          vApp.Quit()
          vDoc = Nothing
          vApp = Nothing
          GC.Collect()
       End Sub
    End Module
    
    ```
    **Note** Modify the TEMPLATEPATH constant to point to your Visio installation folder. By default, the location is one of the following: 
      - For Office Visio 2007, the default location is C:\Program Files\Microsoft Office\Visio12\1033\BASFLO_U.VSS.

      - For Visio 2003, the default location for this file is C:\Program Files\Microsoft Office\Visio11\1033\BASFLO_U.VSS   
     - For Visio 2002, the default location for this file is C:\Program Files\Microsoft Visio\Visio10\1033\Solutions\Flowchart\Basic Flowchart Shapes (US units).vss.   
   
8. On the Debug menu, click Start.   
9. Open C:\Simpleflowchart.vsd in Visio to see the results.   

## References

For more information, see the following Microsoft Developer Network (MSDN) Web site: 

[Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489%28office.10%29.aspx)