---
title: Add controls to Windows forms by Visual C#
description: This article describes how to programmatically add controls to Windows forms at run time by using Visual C#, and also includes a code sample to explain the methods.
ms.date: 04/17/2020
ms.reviewer: DATBUI
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to programmatically add controls to Windows forms at run time

This article helps you programmatically add and configure controls on a Windows form by using Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 319266

## Summary

This step-by-step article shows you how to programmatically add and configure a few commonly used controls on a Windows form. Event handling has been omitted from the sample code.

The Microsoft .NET Framework Software Development Kit (SDK) provides many visual controls that you can use to build a Windows Forms application. You can add and configure controls at design time in Visual Studio .NET or in Visual Studio. You can add and configure controls programmatically at run time.

## Requirements

This article assumes that you're familiar with the following topics:

- Visual C# syntax
- The Visual Studio .NET environment, the Visual Studio environment
- Purpose of common Visual C# controls

## Create a Windows Forms application

1. Start Visual Studio .NET or Visual Studio, and create a new Visual C# Windows Application project named *WinControls*. Form1 is added to the project by default.
2. Double-click Form1 to create and view the `Form1_Load` event procedure.
3. Add private instance variables to the `Form1` class to work with common Windows controls. The `Form1` class starts as follows:

    ```csharp
    public class Form1 : System.Windows.Forms.Form
    {
         //Controls.
         private TextBox txtBox = new TextBox();
         private Button btnAdd = new Button();
         private ListBox lstBox = new ListBox();
         private CheckBox chkBox = new CheckBox();
         private Label lblCount = new Label();
        //Other code.
    }
    ```

    > [!NOTE]
    > The code should be changed in Visual Studio. When you create a Windows Forms project, Visual C# adds one form to the project by default. This form is named *Form1*. The two files that represent the form are named *Form1.cs* and *Form1.designer.cs*. You write your code in *Form1.cs*. The *Designer.cs* file is where the Windows Forms Designer writes the code that implements all the actions that you performed by adding controls. For more information about the Windows Forms Designer in Visual C#, see [Creating a Project (Visual C#)](/previous-versions/visualstudio/visual-studio-2008/ms173077(v=vs.90)).

## Customize form and control properties

1. Locate the `Form1_Load` event procedure, and add the following code to the procedure to customize the appearance of the Form control:

    ```csharp
     //Set up the form.
     this.MaximizeBox = false;
     this.MinimizeBox = false;
     this.BackColor = Color.White;
     this.ForeColor = Color.Black;
     this.Size = new System.Drawing.Size(155, 265);
     this.Text = "Run-time Controls";
     this.FormBorderStyle = FormBorderStyle.FixedDialog;
     this.StartPosition = FormStartPosition.CenterScreen;
    ```

2. Add the following code to the `Form1_Load` event procedure to customize the appearance of the Button control:

    ```csharp
     //Format controls. Note: Controls inherit color from parent form.
     this.btnAdd.BackColor = Color.Gray;
     this.btnAdd.Text = "Add";
     this.btnAdd.Location = new System.Drawing.Point(90, 25);
     this.btnAdd.Size = new System.Drawing.Size(50, 25);
    ```

3. Add the following code to customize the appearance of the TextBox control in `Form1_Load`:

    ```csharp
     this.txtBox.Text = "Text";
     this.txtBox.Location = new System.Drawing.Point(10, 25);
     this.txtBox.Size = new System.Drawing.Size(70, 20);
    ```

4. Add the following code to customize the appearance of the ListBox control in `Form1_Load`:

    ```csharp
     this.lstBox.Items.Add("One");
     this.lstBox.Items.Add("Two");
     this.lstBox.Items.Add("Three");
     this.lstBox.Items.Add("Four");
     this.lstBox.Sorted = true;
     this.lstBox.Location = new System.Drawing.Point(10, 55);
     this.lstBox.Size = new System.Drawing.Size(130, 95);
    ```

5. Add the following code to customize the appearance of the CheckBox control in `Form1_Load`:

    ```csharp
     this.chkBox.Text = "Disable";
     this.chkBox.Location = new System.Drawing.Point(15, 190);
     this.chkBox.Size = new System.Drawing.Size(110, 30);
    ```

6. Add the following code to customize the appearance of the Label control in `Form1_Load`:

    ```csharp
     this.lblCount.Text = lstBox.Items.Count.ToString() + " items";
     this.lblCount.Location = new System.Drawing.Point(55, 160);
     this.lblCount.Size = new System.Drawing.Size(65, 15);
    ```

## Add controls to the form

1. Add the following code to add each object to the `Controls` array of the form at the end of `Form1_Load`:

    ```csharp
     //Add controls to the form.
     this.Controls.Add(btnAdd);
     this.Controls.Add(txtBox);
     this.Controls.Add(lstBox);
     this.Controls.Add(chkBox);
     this.Controls.Add(lblCount);
    ```

2. Save the project.

## Verify that it works

To verify that the sample works, select **Start** on the **Debug** menu.

> [!NOTE]
>
> - Although the form and the controls appear, they currently do nothing because you have not written any event handlers.
> - Remember that the positions of these controls are static. To make them more robust when the form is stretched, make the points dynamic relative to the form position. If the controls are static, stretching the form may interfere with the display of other controls on the form.

## References

For more information about using controls programmatically, see the **Windows Applications** topic in the Visual C# section of the Visual Studio .NET Online Help documentation, or the Visual Studio Online Help documentation.
