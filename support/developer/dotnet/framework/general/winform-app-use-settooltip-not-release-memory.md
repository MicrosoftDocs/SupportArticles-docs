---
title: Application that uses ToolTip doesn't release memory
description: A .NET Windows Forms application may not release memory if using the ToolTip.SetToolTip method incorrectly.
ms.date: 05/11/2020
ms.reviewer: Tatkins
---
# Memory not freed if Windows Forms application uses ToolTip.SetToolTip

This article helps you resolve the problem where Windows Forms application might not release memory if using the `ToolTip.SetToolTip` method incorrectly.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 2749543

## Symptoms

You've developed a .NET Windows Forms application, which uses the `ToolTip.SetToolTip` method to associate a ToolTip control with a Windows Forms control. When programmatically removing the associated Windows Forms control from the Form and Disposing of it, the control isn't released from the managed heap. Over time, if repeatedly adding and removing controls that are associated with a `ToolTip` using `ToolTip.SetToolTip`, memory usage continues to increase and may eventually result in a `System.OutOfMemoryException`.

## Cause

When calling `ToolTip.SetToolTip` to associate a `ToolTip` with a Windows Forms control, the `ToolTip` object stores internal information, including a reference to the control, within an internal HashTable. If using a single ToolTip control and associating it with many controls, then a reference to each control and its `ToolTip` information is stored within the HashTable. Neither calling a control's `Dispose` method or removing it from the `Controls` collection of its container disassociates the control from its `ToolTip`. So in a scenario where the application is adding controls dynamically to a Form, associating them with a `ToolTip`, and removing and disposing of them; the control is still rooted in memory and the application's managed memory heap will continue to grow over time.

## Resolution

Depending on the application design, there are several ways to resolve this problem.

If the application is using one ToolTip control for many Windows Forms controls, then you can disassociate a particular Windows Forms control from the ToolTip by calling `ToolTip.SetToolTip` and passing a reference to the control and an empty string for the `ToolTip` caption. When an empty string is passed for the `ToolTip` caption, the `SetToolTip` method removes the reference to the Windows Forms control from within the internal HashTable of `ToolTip`.

> [!NOTE]
> You can also call the `ToolTip.RemoveAll` to remove all `ToolTip` text and disassociate the ToolTip control from all Windows Forms controls.

If the application isn't associating multiple Windows Forms controls with a single ToolTip, then you can call the `Dispose` method of `ToolTip`.

## More information

This behavior is by design.

Consider the following sample code in a Windows Forms application. The code in the `CreateControls()` method creates a number of TextBox controls, calls `ToolTip.SetToolTip` to assign a `ToolTip` caption to each Control, and adds the control to an internal `ObservableCollection`, and to the `Controls` collection. The code in the `RemoveControls()` method walks over the `ObservableCollection`, gets a reference to each control, and then removes it from the `ObservableCollection` and the Form's `Controls` collection, and then calls its `Dispose` method. It results in each of the TextBox controls being removed from the Form and disposed, but the instance of each TextBox and associated `ToolTipInfo` are still rooted in the managed heap. Uncommenting the specified line in the `RemoveControls()` method disassociates the TextBox from the `ToolTip` and allows it to be garbage collected.

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Collections.ObjectModel;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        ObservableCollection<TextBox> list;
        ToolTip toolTip;
        public Form1()
        {
            InitializeComponent();
            toolTip = new ToolTip();
            list = new ObservableCollection<TextBox>();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            CreateControls();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            RemoveControls();
        }
        private void CreateControls()
        {
            for (int i = 0; i < 100; i++)
            {
                TextBox t = new TextBox();
                toolTip.SetToolTip(t, i.ToString());
                t.Left = (t.Width * i) + 5;
                list.Add(t);
                this.Controls.Add(t);
            }
        }
        private void RemoveControls()
        {
            for (int i = list.Count-1;i>=0;i--)
            {
                TextBox tb = list[i];
                this.Controls.Remove(tb);
                list.Remove(tb);
                //Uncomment this line to disassociate the ToolTip control from the Windows Forms Control
                //toolTip.SetToolTip(tb, "");
                tb.Dispose();
            }
        }
    }
}
```
