---
title: Use ComboBox to edit data in ListView
description: Describes how to use a ComboBox control to edit data that is in a ListView control in Visual C#. Also provides a code sample to explain the methods.
ms.date: 04/22/2020
ms.custom: sap:Language or Compilers\C#
ms.topic: how-to
---
# Use a ComboBox control to edit data in a ListView control in Visual CSharp

This article demonstrates how to use a ComboBox control to edit the data in a ListView control. This method replaces the standard text box approach of editing the data in a ListView control.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 320344

## Description of the technique

By using the `LabelEdit` property of the ListView control, you can allow the user to edit the contents of the ListView control. To edit the data in the ListView control, you can use a standard text box. Occasionally, it's useful to have another control to edit the control. This article simulates how to use a ComboBox control to edit the data in a ListView when the ListView is in Details view.

When the user selects a row in the ListView, a calculation is done to locate the bounding rectangle for the first column of the row that is clicked. That calculation takes into account that the column may not be visible or may not be fully visible when the row is clicked and when the ComboBox is sized and displayed appropriately.

In addition to positioning and sizing the ComboBox, this sample also watches for two messages on the ListView control: `WM_VSCROLL` and `WM_HSCROLL`. These messages occur whenever the user scrolls through the ListView control vertically or horizontally. Because the ComboBox isn't physically part of the ListView control, the ComboBox doesn't automatically scroll with the ListView. So whenever either of these two messages occur, the ComboBox must be hidden. To watch for these messages, you create a custom `UserControl` class that inherits from the ListView class. In this custom control, the `WndProc` method is overridden to allow all messages to be checked for scrolling.

## Create the inherited ListView control

1. Start Microsoft Visual Studio .NET.
2. On the **File** menu, point to **New**, and then click **Project**.
3. In the **New Project** dialog box, click **Visual C# Projects** under **Project Types**, and then click **Windows Control Library** under **Templates**.
4. Replace all of the code in the `UserControl` class with the following code:

    ```csharp
    using System;
    using System.Collections;
    using System.ComponentModel;
    using System.Drawing;
    using System.Data;
    using System.Windows.Forms;

    namespace InheritedListView
    {
        /// <summary>
        /// Summary description for UserControl1.
        /// </summary>
        public class MyListView : System.Windows.Forms.ListView
        {
            /// <summary>
            /// Required designer variable.
            /// </summary>
            private System.ComponentModel.Container components = null;

            public MyListView()
            {
                // This call is required by the Windows.Forms Form Designer.
                InitializeComponent();
                // TODO: Add any initialization after the InitForm call
            }

            /// <summary>
            /// Clean up any resources being used.
            /// </summary>
            protected override void Dispose(bool disposing)
            {
                if (disposing)
                {
                    if (components != null)
                        components.Dispose();
                }
                base.Dispose(disposing);
            }

            #region Component Designer generated code
            /// <summary>
            /// Required method for Designer support - do not modify
            /// the contents of this method with the code editor.
            /// </summary>
            private void InitializeComponent()
            {
                components = new System.ComponentModel.Container();
            }
            #endregion

            private const int WM_HSCROLL = 0x114;
            private const int WM_VSCROLL = 0x115;

            protected override void WndProc(ref Message msg)
            {
                // Look for the WM_VSCROLL or the WM_HSCROLL messages.
                if ((msg.Msg == WM_VSCROLL) || (msg.Msg == WM_HSCROLL))
                {
                    // Move focus to the ListView to cause ComboBox to lose focus.
                    this.Focus();
                }

                // Pass message to default handler.
                base.WndProc(ref msg);
            }
        }
    }
    ```

5. Save and build the project.

## Create the sample application

1. Follow these steps to create a new Windows Application in Visual C# .NET:
    1. On the **File** menu, point to **New**, and then click **Project**.
    2. In the **New Project** dialog box, click **Visual C# Projects** under **Project Types**, and then click **Windows Application** under **Templates**. By default, Form1 is created.

2. Follow these steps to add the control that you created in the [Create the inherited ListView control](#create-the-inherited-listview-control) section to your Windows application:
    1. On the **Tools** menu, click **Customize Toolbox**.
    2. On the **.NET Framework Components** tab, click **Browse**.
    3. In the **Open** dialog box, locate the control that you created in the [Create the inherited ListView control](#create-the-inherited-listview-control) section, and then click **Open**. It adds this control to the toolbox so that you can use the control similarly to any other control.
    4. Drag MyListView from the **General** section of the toolbox to Form1.
3. Drag a ComboBox control from the **Windows Forms** section of the toolbox to Form1.
4. In the **Properties** window of ComboBox, change the **Name** property to **cbListViewCombo**, and then set the **Visible** property to **False**.
5. Add the following code to the class of `Form1` above the constructor:

    ```csharp
    private ListViewItem lvItem;
    ```

6. Add the following code to the `Load` event of Form1:

    ```csharp
    // Add a few items to the combo box list.
    this.cbListViewCombo.Items.Add("NC");
    this.cbListViewCombo.Items.Add("WA");

    // Set view of ListView to Details.
    this.myListView1.View = View.Details;

    // Turn on full row select.
    this.myListView1.FullRowSelect = true;

    // Add data to the ListView.
    ColumnHeader columnheader;
    ListViewItem listviewitem;

    // Create sample ListView data.
    listviewitem = new ListViewItem("NC");
    listviewitem.SubItems.Add("North Carolina");
    this.myListView1.Items.Add(listviewitem);

    listviewitem = new ListViewItem("WA");
    listviewitem.SubItems.Add("Washington");
    this.myListView1.Items.Add(listviewitem);

    // Create column headers for the data.
    columnheader = new ColumnHeader();
    columnheader.Text = "State Abbr.";
    this.myListView1.Columns.Add(columnheader);

    columnheader = new ColumnHeader();
    columnheader.Text = "State";
    this.myListView1.Columns.Add(columnheader);

    // Loop through and size each column header to fit the column header text.
    foreach (ColumnHeader ch in this.myListView1.Columns)
    {
       ch.Width = -2;
    }
    ```

7. Add the following code to the `SelectedValueChanged` event of the ComboBox:

    ```csharp
    // Set text of ListView item to match the ComboBox.
    lvItem.Text = this.cbListViewCombo.Text;

    // Hide the ComboBox.
    this.cbListViewCombo.Visible = false;
    ```

8. Add the following code to the `Leave` event of the ComboBox:

    ```csharp
    // Set text of ListView item to match the ComboBox.
    lvItem.Text = this.cbListViewCombo.Text;

    // Hide the ComboBox.
    this.cbListViewCombo.Visible = false;
    ```

9. Add the following code to the `KeyPress` event of the ComboBox:

    ```csharp
    // Verify that the user presses ESC.
    switch (e.KeyChar)
    {
       case (char)(int)Keys.Escape:
       {
          // Reset the original text value, and then hide the ComboBox.
          this.cbListViewCombo.Text = lvItem.Text;
          this.cbListViewCombo.Visible = false;
          break;
       }

       case (char)(int)Keys.Enter:
       {
          // Hide the ComboBox.
          this.cbListViewCombo.Visible = false;
          break;
       }
    }
    ```

10. Add the following code to the `MouseUp` event of `myListView1`:

    ```csharp
    // Get the item on the row that is clicked.
    lvItem = this.myListView1.GetItemAt(e.X, e.Y);

    // Make sure that an item is clicked.
    if (lvItem != null)
    {
        // Get the bounds of the item that is clicked.
        Rectangle ClickedItem = lvItem.Bounds;

        // Verify that the column is completely scrolled off to the left.
        if ((ClickedItem.Left + this.myListView1.Columns[0].Width) < 0)
        {
            // If the cell is out of view to the left, do nothing.
            return;
        }

        // Verify that the column is partially scrolled off to the left.
        else if (ClickedItem.Left < 0)
        {
            // Determine if column extends beyond right side of ListView.
            if ((ClickedItem.Left + this.myListView1.Columns[0].Width) > this.myListView1.Width)
            {
                // Set width of column to match width of ListView.
                ClickedItem.Width = this.myListView1.Width;
                ClickedItem.X = 0;
            }
            else
            {
                // Right side of cell is in view.
                ClickedItem.Width = this.myListView1.Columns[0].Width + ClickedItem.Left;
                ClickedItem.X = 2;
            }
        }
        else if (this.myListView1.Columns[0].Width > this.myListView1.Width)
        {
            ClickedItem.Width = this.myListView1.Width;
        }
        else
        {
            ClickedItem.Width = this.myListView1.Columns[0].Width;
            ClickedItem.X = 2;
        }

        // Adjust the top to account for the location of the ListView.
        ClickedItem.Y += this.myListView1.Top;
        ClickedItem.X += this.myListView1.Left;

        // Assign calculated bounds to the ComboBox.
        this.cbListViewCombo.Bounds = ClickedItem;

        // Set default text for ComboBox to match the item that is clicked.
        this.cbListViewCombo.Text = lvItem.Text;

        // Display the ComboBox, and make sure that it is on top with focus.
        this.cbListViewCombo.Visible = true;
        this.cbListViewCombo.BringToFront();
        this.cbListViewCombo.Focus();
    }
    ```

## Verify that it works

1. Save and run the sample.
2. Click a row in the ListView.

    > [!NOTE]
    > A combo box appears over the location of the first column of the current row.

3. To hide the combo box, click an item in the combo box, press ESC, and then scroll through the ListView or click another control.

    > [!NOTE]
    > The value that you clicked in the combo box is placed in the first column of the clicked row of the ListView.
