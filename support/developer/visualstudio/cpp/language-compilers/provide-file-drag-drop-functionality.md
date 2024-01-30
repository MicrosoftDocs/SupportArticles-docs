---
title: Provide file drag and drop functionality
description: This article describes how to provide file drag-and-drop functionality in a Visual C# application. A ListBox control is used as the destination of the file drag-and-drop procedure. This article also provides a code sample to show how to perform this task.
ms.date: 09/24/2020
ms.custom: sap:Language or Compilers
ms.topic: how-to
---
# Provide file drag-and-drop functionality in a Visual C# application

This article shows how to provide file drag-and-drop functionality in a Visual C# application.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 307966

## Summary

The step-by-step procedure that is outlined in this article demonstrates how to provide file drag-and-drop functionality in a Visual C# application. A `ListBox` control is used as the destination of the file drag-and-drop procedure.

## Requirements

This list outlines the recommended hardware, software, network infrastructure, and service packs that you need: Visual C#.

This article assumes that you are familiar with the following topics:

- `Windows Forms ListBox control`
- `Windows Forms event handling`

## Steps to Build the Sample

The ListBox control provides two drag-and-drop events that you need to handle: `DragEnter` and `DragDrop`. The `DragEnter` event occurs when you drag an object within the bounds of the control and is used to determine whether the object that is being dragged is one that you want to allow to be dropped on the control. You handle this event for cases in which a file or files are dragged to the control. This allows the appropriate icon to be displayed when the object is dragged over the control, depending on the object that is being dragged. The `DragDrop` event occurs when the object that is being dragged has been released on the control. You handle this event to retrieve the object. The Data object is used to retrieve the data.

The Data object's `GetData` method returns an array of strings that contain the full path names of the files that were dragged to the `ListBox` control. You can use this file path information to perform whatever operations are needed on the files. For example, you can use classes in the `System.IO` namespace to open and read the files, move the files, or copy the files to a new location. In this example, you just add the full path to the files that are dragged to the `ListBox` control.

To provide file drag-and-drop functionality in a Visual C# application, follow these steps:

1. Create a new Windows Forms application in Visual C# .NET or Visual C# 2005. Form1 is created by default.
2. Use the toolbox to add a `ListBox` control to **Form1**.
3. In the **Properties** window, change the `AllowDrop` property of the `ListBox` control to **True** to allow objects to be dragged onto the control.
4. In Solution Explorer, right-click **Form1**, and then click **View Code**.
5. To handle the `DragEnter` event, add the following method below the code section that the Windows Form Designer generates in the `Form1` class:

    ```cpp
    private void listBox1_DragEnter(object sender, System.Windows.Forms.DragEventArgs e)
    {
        if(e.Data.GetDataPresent(DataFormats.FileDrop))
            e.Effect = DragDropEffects.All;
        else
            e.Effect = DragDropEffects.None;
    }
    ```

6. To handle the `DragDrop` event, add the following method to the `Form1` class immediately following the method that you added in step 5:

    ```cpp
    private void listBox1_DragDrop(object sender, System.Windows.Forms.DragEventArgs e)
    {
        string[] s = (string[]) e.Data.GetData(DataFormats.FileDrop, false);
        int i;
        for(i = 0; i < s.Length; i++)
            listBox1.Items.Add(s[i]);
    }
    ```

7. To associate the two event handlers with the control events, add the following code in the `Form1` constructor after the call to `InitializeComponent`:

    ```cpp
    this.listBox1.DragDrop += new
         System.Windows.Forms.DragEventHandler(this.listBox1_DragDrop);
    this.listBox1.DragEnter += new
         System.Windows.Forms.DragEventHandler(this.listBox1_DragEnter);
    ```

8. Build and run the project.
9. Drag one or more files from either the desktop or another folder to the ListBox control. The full path of the files is added to the `ListBox` control.

## References

For more information, see the following Web sites:

- [Control.DragEnter Event](/dotnet/api/system.windows.forms.control.dragenter)

- [Control.DragDrop Event](/dotnet/api/system.windows.forms.control.dragdrop)
