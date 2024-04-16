---
title: The scroll position is not maintained
description: This article provides a workaround for the problem that occurs when you clear and then redraw an auto-scrollable Panel control that contains child controls.
ms.date: 10/10/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
---
# The scroll position is not maintained in an auto-scrollable Panel control in a Windows Forms application

This article provides a workaround for the problem that occurs when you clear and then redraw an autoscrollable Panel control that contains child controls.

_Original product version:_ &nbsp; Visual Basic .NET  
_Original KB number:_ &nbsp; 829417

## Symptoms

In a Microsoft Windows Forms application, if you clear and then redraw an auto-scrollable Panel control that contains child controls, the scroll position is not maintained.

## Cause

Sometimes, you must clear the contents of the Panel control and then redraw the contents of the Panel control. For example, you must do this if the auto-scrollable Panel control contains a collection of controls that have a specific order. Typically, these controls are user controls.

However, the application does not store the value of the `AutoScrollPosition` property of the Panel control. Therefore, the scroll position is not maintained when the contents of the Panel control are redrawn.

## Workaround

To work around this behavior, use a `System.Drawing.Point` structure to store value of the `AutoScrollPosition` property of the Panel control.

After the Panel control is redrawn, you can retrieve the value of the `AutoScrollPosition` property by using a new instance of the `System.Drawing.Point` structure.

The get method of the `Panel.AutoScrollPosition.X` property and the get method of the `Panel.AutoScrollPosition.Y` property return negative values. However, positive values are required. You can use the `Math.Abs` function to obtain a positive value from the `Panel.AutoScrollPosition.X` property and the `Panel.AutoScrollPosition.Y` property, as in the following line of code:

Visual Basic .NET or Visual Basic 2005 code

```vbnet
Panel1.AutoScrollPosition = New Point(Math.Abs(Panel1.AutoScrollPosition.X), Math.Abs(CurrentPoint.Y))
```

Visual C# .NET Visual C# 2005 code

```csharp
panel1.AutoScrollPosition = new Point(Math.Abs(panel1.AutoScrollPosition.X), Math.Abs(CurrentPoint.Y));
```

## Sample application

To use this workaround in a sample application, follow these steps:

1. Click **Start**, point to **Programs**, point to **Microsoft Visual Studio .NET**, and then click **Microsoft Visual Studio .NET** or **Microsoft Visual Studio 2005**.
2. On the **File** menu, point to **New**, and then click **Project**. The **New Project** dialog box appears.
3. Under **Project Types**, click **Visual Basic Projects** or click **Visual C# Projects**.

   > [!NOTE]
   > In Visual Studio 2005, click **Visual C#**.

4. Under **Templates**, click **Windows Application**.
5. In the **Name** box, type *SampleWinApp*, and then click **OK**. By default, a form that is named Form1 is created.
6. Add a Button control and a Panel control to the Form1 form.

   > [!NOTE]
   > Do not insert the Button control inside the Panel control.

7. Right-click the **Panel** control, and then click **Properties**.
8. Set the Auto-Scroll property to True.
9. In the *Form1.vb* file, add the following code before the `End` Class statement:

    Visual Basic .NET or Visual Basic 2005 code

    ```vbnet
    Private count As Integer
    Private arrayctl As New ArrayList

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim newtxt As New TextBox
        newtxt.Text = count
        count += 1
        arrayctl.Add(newtxt)
        DrawControls()
    End Sub

    Private Sub DrawControls()
        Dim txt As TextBox

        Dim CurrentPoint As System.Drawing.Point
        CurrentPoint = Panel1.AutoScrollPosition()

        Dim i As Integer = 0
        Panel1.Controls.Clear()
        Panel1.SuspendLayout()
        For Each txt In arrayctl
        Panel1.Controls.Add(txt)

        txt.Width = Panel1.ClientRectangle.Width
        txt.Top = i
        i += txt.Height
        Next
        Panel1.ResumeLayout()
        Panel1.AutoScrollPosition = New Point(Math.Abs(Panel1.AutoScrollPosition.X), Math.Abs(CurrentPoint.Y))

    End Sub
    ```

    Visual C# .NET or Visual C# 2005 code

    ```csharp
    private int count;
    private ArrayList arrayctl = new ArrayList();
    private void button1_Click(object sender, System.EventArgs e)
    {
        TextBox newtxt = new TextBox();
        newtxt.Text = count.ToString();
        count++; arrayctl.Add(newtxt);
        DrawControls();
    }

    private void DrawControls()
    {
        System.Drawing.Point CurrentPoint; CurrentPoint = panel1.AutoScrollPosition;
        int i = 0;
        panel1.Controls.Clear();
        panel1.SuspendLayout();
        foreach (TextBox txt in arrayctl)
        {
            panel1.Controls.Add(txt);
            txt.Width = panel1.ClientRectangle.Width;
            txt.Top = i; i += txt.Height;
        }
        panel1.ResumeLayout();
        panel1.AutoScrollPosition = new Point(Math.Abs(panel1.AutoScrollPosition.X), Math.Abs(CurrentPoint.Y));
    }
    ```

10. On the **Debug** menu, click **Start**.
11. In the Form1 form, click **Button1** repeatedly to make the scroll bar appear in the Panel control.

    > [!NOTE]
    > The scroll position is maintained in the Panel control.

## References

[ScrollableControl.AutoScrollPosition Property Definition](/dotnet/api/system.windows.forms.scrollablecontrol.autoscrollposition)
