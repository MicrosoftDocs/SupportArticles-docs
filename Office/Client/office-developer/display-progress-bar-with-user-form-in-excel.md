---
title: How to display a progress bar with a user form in Excel
description: Describes how to display a progress bar with a user form in Excel.
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
- Excel 2010
- Office Excel 2003
---

# How to display a progress bar with a user form in Excel

## Summary

If you have a Microsoft Visual Basic for Applications macro that takes a long time to finish, you may want to give the user an indication that the macro is progressing correctly. This article describes how to create a progress bar with a user form in Microsoft Excel.

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Create the User Form

In the following example, a Visual Basic subroutine populates a large range of cells with a random number. The indicator shows you that the macro is running correctly.

1. Open a new workbook in Excel.   
2. In Microsoft Office Excel 2003 and in earlier versions of Excel, click **Tools**, point to **Macro**, and then click **Visual Basic Editor**.

    In Microsoft Office Excel 2007, click **Visual Basic** in the **Code** group on the **Developer** tab. 
    
    **Note** To display the **Developer** tab in the Ribbon, follow these steps:
      1. Start Excel 2007, click the **Microsoft Office Button**, and then click **Excel Options**.    
      2. In the **Excel Options** dialog box, click **Popular**, and then click to select the **Show Developer tab in the Ribbon** check box.   
   
3. On the Insert menu, click UserForm.   
4. Draw a Label control on the user form.   
5. Change the following properties of the Label control to the following values:
     |Property| Value|
     |---------------|-----------------------------|
     |Caption| Now updating. Please wait...|
     **Note** If the **Properties** window is not visible, click **Properties Window** on the **View** menu.   
6. Draw a Frame control on the user form.   
7. Change the following properties of the Frame control to the following values: 
     |Property |Value|
     |---------|--------------------|
     |Name FrameProgress|

8. Draw a Label control on the Frame control.

9. Change the following properties of the Label control to the following values:
     |Property| Value|
     |----------|---------------------------|
     |Name |LabelProgress|
     |BackColor |&H000000FF&|
     |SpecialEffect |fmSpecialEffectRaised|

### Type the Macro Code

1. Double-click the user form to open the **Code** window for the user form.   
2. In the module, type the following code for the **UserForm_Activate** event:
    ```vb
    Private Sub UserForm_Activate()
        ' Set the width of the progress bar to 0.
        UserForm1.LabelProgress.Width = 0
    
    ' Call the main subroutine.
        Call Main
    End Sub
    
    ```

3. On the Insert menu, click Module.

4. In the **Code** window for the module, type the following code:
    ```vb
    Sub ShowUserForm()
        UserForm1.Show
    End Sub
    
    Sub Main()
        Dim Counter As Integer
        Dim RowMax As Integer, ColMax As Integer
        Dim r As Integer, c As Integer
        Dim PctDone As Single
    
    Application.ScreenUpdating = False
        ' Initialize variables.
        Counter = 1
        RowMax = 100
        ColMax = 25
    
    ' Loop through cells.
        For r = 1 To RowMax
            For c = 1 To ColMax
                'Put a random number in a cell
                Cells(r, c) = Int(Rnd * 1000)
                Counter = Counter + 1
            Next c
    
    ' Update the percentage completed.
            PctDone = Counter / (RowMax * ColMax)
    
    ' Call subroutine that updates the progress bar.
            UpdateProgressBar PctDone
        Next r
        ' The task is finished, so unload the UserForm.
        Unload UserForm1
    End Sub
    
    Sub UpdateProgressBar(PctDone As Single)
        With UserForm1
    
    ' Update the Caption property of the Frame control.
            .FrameProgress.Caption = Format(PctDone, "0%")
    
    ' Widen the Label control.
            .LabelProgress.Width = PctDone * _
                (.FrameProgress.Width - 10)
        End With
    
    ' The DoEvents allows the UserForm to update.
        DoEvents
    End Sub
    
    ```

5. Return to Excel.

6. In Excel 2003 and in earlier versions of Excel, point to **Macro** on the **Tools** menu, and then click **Macros**.

    In Excel 2007, click **Macros** in the **Code** group on the **Developer** tab.   
7. In the **Macro** dialog box, click to select **ShowUserForm**, and then click **Run**.   

A dialog box that has a red progress bar appears. The progress bar increases as the **Main** subroutine populates the cells on the worksheet.

The **ShowUserForm** subroutine shows the user form. The procedure that is attached to the **Activate** event of the user form calls the **Main** subroutine. The **Main** subroutine populates cells with random numbers. Additionally, the subroutine calls the **UpdateProgressBar** subroutine that updates the Label control on the user form.

**Note** When you use this technique, your macro takes just a bit longer to finish its intended tasks.