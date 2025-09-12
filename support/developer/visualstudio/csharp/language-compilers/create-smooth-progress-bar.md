---
title: Create a smooth progress bar by using C#
description: Describes how to create a simple, custom UserControl to create a smooth, scrolling ProgressBar control.
ms.date: 04/13/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to create a smooth progress bar

This article provides information about how to create a custom UserControl to create a smooth, scrolling ProgressBar control.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 323116

## Summary

This article demonstrates how to create a simple, custom UserControl to create a smooth, scrolling ProgressBar control.

In earlier versions of the ProgressBar control, such as the version that is provided with the Microsoft Windows Common Controls ActiveX control, you can view the progress in two different views. To control these views, you use the Scrolling property, which includes standard and smooth settings. Smooth scrolling produces a solid block of color that represents the progress, and standard scrolling appears segmented and is made up of a series of small blocks or rectangles.

The ProgressBar control that is included with Microsoft Visual C# supports only the standard setting.

The sample code in this article illustrates how to create a control that supports the following properties:

- Minimum: This property obtains or sets the lower value for the range of valid values for progress. The default value of this property is zero (0); you cannot set this property to a negative value.
- Maximum: This property obtains or sets the upper value for the range of valid values for progress. The default value of this property is 100.
- Value: This property obtains or sets the current level of progress. The value must be in the range that the Minimum and the Maximum properties define.
- ProgressBarColor: This property obtains or sets the color of the progress bar.

## Create a custom ProgressBar control

1. Follow these steps to create a new Windows Control Library project in Visual C#:

    1. Start Microsoft Visual Studio.
    2. On the **File** menu, point to **New**, and then click **Project**.
    3. In the **New Project** dialog box, click **Visual C#** under **Project Types**, and then click **Windows Forms Control Library** under **Templates**.

    4. In the **Name** box, type *SmoothProgressBar*, and then click **OK**.
    5. In **Project Explorer**, rename the default class module from *UserControl1.cs* to *SmoothProgressBar.cs*.
    6. In the **Properties** window for the UserControl object, change the **Name** property from **UserControl1** to **SmoothProgressBar**.

2. At this point, you typically inherit from the class of that control and then add the additional functionality to extend an existing control. However, the ProgressBar class is *sealed* and cannot be inherited. Therefore, you must build the control from the beginning.

    Add the following code to the *SmoothProgressBar.cs* file, in the class that is derived from UserControl.

    ```csharp
    int min = 0;// Minimum value for progress range
    int max = 100;// Maximum value for progress range
    int val = 0;// Current progress
    Color BarColor = Color.Blue;// Color of progress meter

    protected override void OnResize(EventArgs e)
    {
        // Invalidate the control to get a repaint.
        this.Invalidate();
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        Graphics g = e.Graphics;
        SolidBrush brush = new SolidBrush(BarColor);
        float percent = (float)(val - min) / (float)(max - min);
        Rectangle rect = this.ClientRectangle;

        // Calculate area for drawing the progress.
        rect.Width = (int)((float)rect.Width * percent);

        // Draw the progress meter.
        g.FillRectangle(brush, rect);

        // Draw a three-dimensional border around the control.
        Draw3DBorder(g);

        // Clean up.
        brush.Dispose();
        g.Dispose();
    }

    public int Minimum
    {
        get
        {
            return min;
        }

        set
        {
            // Prevent a negative value.
            if (value < 0)
            {
                value = 0;
            }

            // Make sure that the minimum value is never set higher than the maximum value.
            if (value > max)
            {
                max = value;
            }
            
            min = value;

            // Ensure value is still in range
            if (val < min)
            {
                val = min;
            }

            // Invalidate the control to get a repaint.
            this.Invalidate();
        }
    }

    public int Maximum
    {
        get
        {
            return max;
        }

        set
        {
            // Make sure that the maximum value is never set lower than the minimum value.
            if (value < min)
            {
                min = value;
            }

            max = value;

            // Make sure that value is still in range.
            if (val > max)
            {
                val = max;
            }

            // Invalidate the control to get a repaint.
            this.Invalidate();
        }
    }

    public int Value
    {
        get
        {
            return val;
        }

        set
        {
            int oldValue = val;

            // Make sure that the value does not stray outside the valid range.
            if (value < min)
            {
                val = min;
            }
            else if (value > max)
            {
                val = max;
            }
            else
            {
                val = value;
            }

            // Invalidate only the changed area.
            float percent;

            Rectangle newValueRect = this.ClientRectangle;
            Rectangle oldValueRect = this.ClientRectangle;

            // Use a new value to calculate the rectangle for progress.
            percent = (float)(val - min) / (float)(max - min);
            newValueRect.Width = (int)((float)newValueRect.Width * percent);

            // Use an old value to calculate the rectangle for progress.
            percent = (float)(oldValue - min) / (float)(max - min);
            oldValueRect.Width = (int)((float)oldValueRect.Width * percent);

            Rectangle updateRect = new Rectangle();

            // Find only the part of the screen that must be updated.
            if (newValueRect.Width > oldValueRect.Width)
            {
                updateRect.X = oldValueRect.Size.Width;
                updateRect.Width = newValueRect.Width - oldValueRect.Width;
            }
            else
            {
                updateRect.X = newValueRect.Size.Width;
                updateRect.Width = oldValueRect.Width - newValueRect.Width;
            }

            updateRect.Height = this.Height;

            // Invalidate the intersection region only.
            this.Invalidate(updateRect);
        }
    }

    public Color ProgressBarColor
    {
        get
        {
            return BarColor;
        }

        set
        {
            BarColor = value;

            // Invalidate the control to get a repaint.
            this.Invalidate();
        }
    }

    private void Draw3DBorder(Graphics g)
    {
        int PenWidth = (int)Pens.White.Width;

        g.DrawLine(Pens.DarkGray,
        new Point(this.ClientRectangle.Left, this.ClientRectangle.Top),
        new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Top));
        g.DrawLine(Pens.DarkGray,
        new Point(this.ClientRectangle.Left, this.ClientRectangle.Top),
        new Point(this.ClientRectangle.Left, this.ClientRectangle.Height - PenWidth));
        g.DrawLine(Pens.White,
        new Point(this.ClientRectangle.Left, this.ClientRectangle.Height - PenWidth),
        new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Height - PenWidth));
        g.DrawLine(Pens.White,
        new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Top),
        new Point(this.ClientRectangle.Width - PenWidth, this.ClientRectangle.Height - PenWidth));
    }
    ```

3. On the **Build** menu, click **Build Solution** to compile the project.

## Create a sample client application

1. On the **File** menu, point to **New**, and then click **Project**.
2. In the **Add New Project** dialog box, click **Visual C#** under **Project Types**, click **Windows Forms Application** under **Templates**, and then click **OK**.

3. Follow these steps to add two instances of the SmoothProgressBar control to the form:

    1. On the **Tools** menu, click **Choose Toolbox Items**.
    2. Click the **.NET Framework Components** tab.
    3. Click **Browse**, and then locate the *SmoothProgressBar.dll* file, which you created in the [Create a custom ProgressBar control](#create-a-custom-progressbar-control) section.
    4. Click **OK**.

        > [!NOTE]
        > The SmoothProgressBar control is added to the toolbox.

    5. Drag two instances of the SmoothProgressBar control from the toolbox to the default form of the Windows Application project.

4. Drag a Timer control from the toolbox to the form.
5. Add the following code to the `Tick` event of the Timer control:

    ```csharp
    if (this.smoothProgressBar1.Value > 0)
    {
        this.smoothProgressBar1.Value--;
        this.smoothProgressBar2.Value++;
    }
    else
    {
        this.timer1.Enabled = false;
    }
    ```

6. Drag a Button control from the toolbox to the form.
7. Add the following code to the `Click` event of the Button control:

    ```csharp
    this.smoothProgressBar1.Value = 100;
    this.smoothProgressBar2.Value = 0;

    this.timer1.Interval = 1;
    this.timer1.Enabled = true;
    ```

8. On the **Debug** menu, click **Start** to run the sample project.
9. Click the button.

    > [!NOTE]
    > The two progress indicators display the text *progress*. One progress indicator displays the progress in an increasing manner, and the other progress indicator displays the progress in a decreasing or a countdown manner.
