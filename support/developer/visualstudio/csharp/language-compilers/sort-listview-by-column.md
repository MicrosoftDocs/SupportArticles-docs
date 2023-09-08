---
title: Sort ListView by using a column in C#
description: Describes how to sort a ListView control by a column in Visual C#. Also provides a code sample to explain the methods.
ms.date: 04/13/2020
ms.topic: how-to
---
# Use Visual C# to sort a ListView control by using a column  

This article provides information about how to sort a ListView control by using a column in Visual C# and also provides a code sample to explain the methods.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 319401

## Summary

When you are working with the ListView control, you may want to sort its contents based on a specific column. An example of this kind of functionality occurs in a Windows Explorer program when you view the contents of a folder on your hard disk. In Details view, Windows Explorer displays information about the files in that folder. For example, you see the file name, the file size, the file type, and the date that the file was modified. When you click one of the column headers, the list is sorted in ascending order based on that column. When you click the same column header again, the column is sorted in descending order.

The example in this article defines a class that inherits from the `IComparer` interface. Additionally, this example uses the `Compare` method of the `CaseInsenstiveComparer` class to perform the actual comparison of the items.

> [!NOTE]
>
> - This method of comparison is not case sensitive.
> - All of the columns in this example are sorted in a *text* manner.

If you want to sort in a different manner (such as numerically), you can replace the following line of code with whichever approach to sorting that you want to use:

```csharp
ObjectCompare.Compare(listviewX.SubItems[ColumnToSort].Text,listviewY.SubItems[ColumnToSort].Text);
```

## Steps to build the sample project

1. Create a new Visual C# Windows application project. *Form1* is created by default.
2. Add a ListView control to *Form1*. Size the form to be several inches wide by several inches tall.
3. Paste the following code into the class for the form:

    ```csharp
    private ListViewColumnSorter lvwColumnSorter;
    ```

4. Paste the following code into the constructor for the form, after the call to the `InitializeComponent` method:

    ```csharp
    // Create an instance of a ListView column sorter and assign it
    // to the ListView control.
    lvwColumnSorter = new ListViewColumnSorter();
    this.listView1.ListViewItemSorter = lvwColumnSorter;
    ```

5. Paste the following code into the `Load` event for the form:

    ```csharp
    ColumnHeader columnheader;// Used for creating column headers.
    ListViewItem listviewitem;// Used for creating listview items.

    // Ensure that the view is set to show details.
    listView1.View = View.Details;

    // Create some listview items consisting of first and last names.
    listviewitem = new ListViewItem("John");
    listviewitem.SubItems.Add("Smith");
    this.listView1.Items.Add(listviewitem);

    listviewitem = new ListViewItem("Bob");
    listviewitem.SubItems.Add("Taylor");
    this.listView1.Items.Add(listviewitem);

    listviewitem = new ListViewItem("Kim");
    listviewitem.SubItems.Add("Zimmerman");
    this.listView1.Items.Add(listviewitem);

    listviewitem = new ListViewItem("Olivia");
    listviewitem.SubItems.Add("Johnson");
    this.listView1.Items.Add(listviewitem);

    // Create some column headers for the data.
    columnheader = new ColumnHeader();
    columnheader.Text = "First Name";
    this.listView1.Columns.Add(columnheader);

    columnheader = new ColumnHeader();
    columnheader.Text = "Last Name";
    this.listView1.Columns.Add(columnheader);

    // Loop through and size each column header to fit the column header text.
    foreach (ColumnHeader ch in this.listView1.Columns)
    {
        ch.Width = -2;
    }
    ```

    > [!NOTE]
    > The code should be changed in Visual Studio. When you create a Windows Forms project, Visual C# adds one form to the project by default. This form is named *Form1*. The two files that represent the form are named *Form1.cs* and *Form1.designer.cs*. You write your code in *Form1.cs*. The *Designer.cs* file is where the Windows Forms Designer writes the code that implements all the actions that you performed by adding controls. For more information about the Windows Forms Designer in Visual C#, visit [Creating a Project (Visual C#)](/previous-versions/visualstudio/visual-studio-2008/ms173077(v=vs.90)).

6. Paste the following code into the `ColumnClick` event for the ListView control:

    ```csharp
    // Determine if clicked column is already the column that is being sorted.
    if (e.Column == lvwColumnSorter.SortColumn)
    {
        // Reverse the current sort direction for this column.
        if (lvwColumnSorter.Order == SortOrder.Ascending)
        {
            lvwColumnSorter.Order = SortOrder.Descending;
        }
        else
        {
            lvwColumnSorter.Order = SortOrder.Ascending;
        }
    }
    else
    {
        // Set the column number that is to be sorted; default to ascending.
        lvwColumnSorter.SortColumn = e.Column;
        lvwColumnSorter.Order = SortOrder.Ascending;
    }

    // Perform the sort with these new sort options.
    this.listView1.Sort();
    ```

7. On the **Project** menu, click **Add Class** to add a new class to the project.
8. Replace all of the default code in the new class with the following code:

    ```csharp
    using System.Collections;
    using System.Windows.Forms;

    /// <summary>
    /// This class is an implementation of the 'IComparer' interface.
    /// </summary>
    public class ListViewColumnSorter : IComparer
    {
        /// <summary>
        /// Specifies the column to be sorted
        /// </summary>
        private int ColumnToSort;

        /// <summary>
        /// Specifies the order in which to sort (i.e. 'Ascending').
        /// </summary>
        private SortOrder OrderOfSort;

        /// <summary>
        /// Case insensitive comparer object
        /// </summary>
        private CaseInsensitiveComparer ObjectCompare;

        /// <summary>
        /// Class constructor. Initializes various elements
        /// </summary>
        public ListViewColumnSorter()
        {
            // Initialize the column to '0'
            ColumnToSort = 0;

            // Initialize the sort order to 'none'
            OrderOfSort = SortOrder.None;

            // Initialize the CaseInsensitiveComparer object
            ObjectCompare = new CaseInsensitiveComparer();
        }

        /// <summary>
        /// This method is inherited from the IComparer interface. It compares the two objects passed using a case insensitive comparison.
        /// </summary>
        /// <param name="x">First object to be compared</param>
        /// <param name="y">Second object to be compared</param>
        /// <returns>The result of the comparison. "0" if equal, negative if 'x' is less than 'y' and positive if 'x' is greater than 'y'</returns>
        public int Compare(object x, object y)
        {
            int compareResult;
            ListViewItem listviewX, listviewY;

            // Cast the objects to be compared to ListViewItem objects
            listviewX = (ListViewItem)x;
            listviewY = (ListViewItem)y;

            // Compare the two items
            compareResult = ObjectCompare.Compare(listviewX.SubItems[ColumnToSort].Text,listviewY.SubItems[ColumnToSort].Text);

            // Calculate correct return value based on object comparison
            if (OrderOfSort == SortOrder.Ascending)
            {
                // Ascending sort is selected, return normal result of compare operation
                return compareResult;
            }
            else if (OrderOfSort == SortOrder.Descending)
            {
                // Descending sort is selected, return negative result of compare operation
                return (-compareResult);
            }
            else
            {
                // Return '0' to indicate they are equal
                return 0;
            }
        }

        /// <summary>
        /// Gets or sets the number of the column to which to apply the sorting operation (Defaults to '0').
        /// </summary>
        public int SortColumn
        {
            set
            {
                ColumnToSort = value;
            }
            get
            {
                return ColumnToSort;
            }
        }

        /// <summary>
        /// Gets or sets the order of sorting to apply (for example, 'Ascending' or 'Descending').
        /// </summary>
        public SortOrder Order
        {
            set
            {
                OrderOfSort = value;
            }
            get
            {
                return OrderOfSort;
            }
        }

    }
    ```

9. Save, build, and then run the sample project.
10. Click the various column headers in the ListView control. When you click the header, the contents of the ListView control are sorted in ascending order based on the column that you click. When you click the same column header again, that column is sorted in descending order.
