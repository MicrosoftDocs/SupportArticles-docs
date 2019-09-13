---
title: Use automation to create and show a presentation by using Visual Basic .NET
description: Describes how to use automation to create and to show a Microsoft PowerPoint presentation by using Microsoft Visual Basic .NET 2002 or Visual Basic .NET 2003.
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
- Microsoft PowerPoint
---

# How to use automation to create and to show a PowerPoint presentation by using Visual Basic .NET 2002 or Visual Basic .NET 2003

## Summary

This article describes how to use automation to create and to show a Microsoft PowerPoint presentation by using Microsoft Visual Basic .NET 2002 or Visual Basic .NET 2003.

## More Information

## Create an automation client for Microsoft PowerPoint

1. Start Microsoft Visual Studio .NET 2002 or Visual Studio .NET 2003. On the File menu, click New and then click Project. Select Windows Application from the Visual Basic Projects types. Form1 is created by default.   
2. Add a reference to the Microsoft PowerPoint Object Library and the Microsoft Graph Object Library. To do this, follow these steps:

   1. On the **Project** menu, click **Add Reference**.   
   2. On the **COM** tab, locate the
 **Microsoft PowerPoint Object Library**, and then click
 **Select**. Also locate the **Microsoft Graph Object Library**, and then click **Select**.

    **Note** Microsoft Office 2003 and later versions of Microsoft Office includes Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they may be downloaded.

3. Click **OK** in the **Add References** dialog box to accept your selections.    
   
3. On the **View** menu, select
**Toolbox** to display the Toolbox and add a button to Form1.   
4. Double-click **Button1**. The code window for the form appears.   
5. In the code window, locate the following code
    ```vb
        Private Sub Button1_Click(ByVal sender As System.Object, _
            ByVal e As System.EventArgs) Handles Button1.Click
    
    End Sub
    
    ```
     Replace with the following code: 
    ```vb
        Private Sub Button1_Click(ByVal sender As System.Object, _
            ByVal e As System.EventArgs) Handles Button1.Click
    
    Const sTemplate = _
               "C:\Program Files\Microsoft Office\Templates\Presentation Designs\Blends.pot"
            Const sPic = "C:\WINNT\Soap Bubbles.bmp"
    
    Dim oApp As PowerPoint.Application
            Dim oPres As PowerPoint.Presentation
            Dim oSlide As PowerPoint.Slide
            Dim bAssistantOn As Boolean
    
    'Start Powerpoint and make its window visible but minimized.
            oApp = New PowerPoint.Application()
            oApp.Visible = True
            oApp.WindowState = PowerPoint.PpWindowState.ppWindowMinimized
    
    'Create a new presentation based on the specified template.
            oPres = oApp.Presentations.Open(sTemplate, , , True)
    
    'Build Slide #1:
            'Add text to the slide, change the font and insert/position a 
            'picture on the first slide.
            oSlide = oPres.Slides.Add(1, PowerPoint.PpSlideLayout.ppLayoutTitleOnly)
            With oSlide.Shapes.Item(1).TextFrame.TextRange
                .Text = "My Sample Presentation"
                .Font.Name = "Comic Sans MS"
                .Font.Size = 48
            End With
            oSlide.Shapes.AddPicture(sPic, False, True, 150, 150, 500, 350)
            oSlide = Nothing
    
    'Build Slide #2:
            'Add text to the slide title, format the text. Also add a chart to the
            'slide and change the chart type to a 3D pie chart.
            oSlide = oPres.Slides.Add(2, PowerPoint.PpSlideLayout.ppLayoutTitleOnly)
            With oSlide.Shapes.Item(1).TextFrame.TextRange
                .Text = "My Chart"
                .Font.Name = "Comic Sans MS"
                .Font.Size = 48
            End With
            Dim oChart As Graph.Chart
            oChart = oSlide.Shapes.AddOLEObject(150, 150, 480, 320, _
                        "MSGraph.Chart.8").OLEFormat.Object
            oChart.ChartType = Graph.XlChartType.xl3DPie
            oChart = Nothing
            oSlide = Nothing
    
    'Build Slide #3:
            'Add a text effect to the slide and apply shadows to the text effect.
            oSlide = oPres.Slides.Add(3, PowerPoint.PpSlideLayout.ppLayoutBlank)
            oSlide.FollowMasterBackground = False
            Dim oShape As PowerPoint.Shape
            oShape = oSlide.Shapes.AddTextEffect(Office.MsoPresetTextEffect.msoTextEffect27, _
                "The End", "Impact", 96, False, False, 230, 200)
            oShape.Shadow.ForeColor.SchemeColor = PowerPoint.PpColorSchemeIndex.ppForeground
            oShape.Shadow.Visible = True
            oShape.Shadow.OffsetX = 3
            oShape.Shadow.OffsetY = 3
            oShape = Nothing
            oSlide = Nothing
    
    'Modify the slide show transition settings for all 3 slides in
            'the presentation.
            Dim SlideIdx(3) As Integer
            SlideIdx(0) = 1
            SlideIdx(1) = 2
            SlideIdx(2) = 3
            With oPres.Slides.Range(SlideIdx).SlideShowTransition
                .AdvanceOnTime = True
                .AdvanceTime = 3
                .EntryEffect = PowerPoint.PpEntryEffect.ppEffectBoxOut
            End With
            Dim oSettings As PowerPoint.SlideShowSettings
            oSettings = oPres.SlideShowSettings
            oSettings.StartingSlide = 1
            oSettings.EndingSlide = 3
    
    'Prevent Office Assistant from displaying alert messages.
            bAssistantOn = oApp.Assistant.On
            oApp.Assistant.On = False
    
    'Run the slide show and wait for the slide show to end.
            oSettings.Run()
            Do While oApp.SlideShowWindows.Count >= 1
                System.Windows.Forms.Application.DoEvents()
            Loop
            oSettings = Nothing
    
    'Reenable Office Assisant, if it was on.
            If bAssistantOn Then
                oApp.Assistant.On = True
                oApp.Assistant.Visible = False
            End If
    
    'Close the presentation without saving changes and quit PowerPoint.
            oPres.Saved = True
            oPres.Close()
            oPres = Nothing
            oApp.Quit()
            oApp = Nothing
            GC.Collect()
        End Sub
    
    ```
    **Note** In this code, the sTemplate and sPic constants represent the full path and filename to a PowerPoint template and a picture, respectively. Modify these paths as needed to use a template or picture that is installed on your system.   
6. Add the following code to the top of Form1.vb:
    ```vb
    Imports Office = Microsoft.Office.Core
    Imports Graph = Microsoft.Office.Interop.Graph
    Imports PowerPoint = Microsoft.Office.Interop.PowerPoint
    ```

7. Press F5 to build and then run the program.   
8. Click Button1 on the form to create and then show a PowerPoint presentation.  

## References

For more information, see the following Microsoft Developer Network (MSDN) Web site: [Visual Studio Tools for the Microsoft Office System 2003 Training
](https://msdn.microsoft.com/library/aa167948%28office.11%29.aspx)