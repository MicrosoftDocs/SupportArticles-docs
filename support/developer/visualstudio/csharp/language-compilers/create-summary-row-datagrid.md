---
title: Create a summary row for a DataGrid control
description: Describes how to create a summary row for a DataGrid control in ASP.NET by using Visual C#.
ms.date: 04/22/2020
ms.reviewer: anandh
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Create a summary row for a DataGrid control by using Visual C# in ASP.NET

This article describes how to create a summary row for a DataGrid control by using Visual C# in ASP.NET.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 326339

## Summary

In this article, you create a Visual C# .NET project, add code to access the **Sales Totals by Amount** view from the *Northwind* database, and then bind the **Sales Totals by Amount** view to the DataGrid. This sample uses the `ItemDataBound` event of the DataGrid to total the `SaleAmount` field when you bind the data to the DataGrid. This sample also uses the footer of the DataGrid to display the summary or the totals.

For a Microsoft Visual Basic .NET version of this article, see [How to create a summary row for a DataGrid in ASP.NET by using Visual Basic .NET](https://support.microsoft.com/help/313154).

This article refers to the following .NET Framework Class Library namespace `System.Data.SqlClient`.

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that are required:

- Windows
- .NET Framework
- Visual Studio .NET
- Internet Information Services (IIS)
- SQL Server 7.0 or later, and the *Northwind* database

> [!NOTE]
> The *Northwind* database is included with SQL Server 7.0 and later.

## Create a Visual C# .NET project and add the DataGrid control

In this section, you create a Visual C# .NET project, select a format for the DataGrid, and then set the DataGrid to display the footer. Because you use the footer to display the summary, it is important that you display the footer.

> [!NOTE]
> By default, the **ShowFooter** property is turned off.

1. Start Visual Studio .NET. The Visual Studio .NET integrated development environment (IDE) appears.
2. On the **File** menu, point to **New**, and then click **Project**.
3. In the **New Project** dialog box, click **Visual C# Projects** under **Project Types**, and then click **ASP.NET Web Application** under **Templates**.

4. In the **New Project** dialog box, notice that the **Name** box is unavailable (it appears dimmed). The **Location** box contains the text (or similar) `http://localhost/WebApplication1`.

   Change the location to `http://localhost/SummaryRow`, and then click **OK**. A new project is created, which includes a Web Form that is named *WebForm1.aspx*.

5. In Solution Explorer, double-click *WebForm1.aspx*.
6. Drag a DataGrid control from the toolbox to the form.
7. Right-click DataGrid, and then click **Auto Format**. Click **Colorful 1**, and then click **OK**.
8. Right-click DataGrid, and then click **Properties**. In the **Properties** dialog box, change the value of the **ShowFooter** property to **True**.

## Write code to access the database

In this section, you use the **Sales Totals by Amount** view that is located in the *Northwind* database to calculate the summary for the `SaleAmount` field. The **Sales Totals by Amount** view includes the `Orders`, the `CompanyName`, and the `SaleAmount` fields.

1. In the Visual Studio .NET IDE, right-click the Web Form, and then click **View Code**.
2. In the code-behind window, add the following code to the top of the page:

    ```cs
    using System.Data.SqlClient;
    ```

3. Add the following code in the class declaration section:

    ```cs
    private double myTotal; //This variable tracks the running total.
    ```

4. Replace the code in the `Page_Load` event with the following code:

    ```cs
    private void Page_Load (object sender, System.EventArgs e)
    {
        //Connect to the database, retrieve data, and then fill the data in the DataSet.
        SqlConnection myConnection = new SqlConnection ("server=(local);uid=sa;" +
                        "pwd=password;database=northwind");
        SqlDataAdapter myDataAdapter = new SqlDataAdapter ("SELECT top 15 [OrderID], [CompanyName], " +
                        "[SaleAmount] FROM [Northwind].[dbo].[Sales Totals by Amount]", myConnection);
        DataSet myDataSet = new DataSet ();
        myDataAdapter.Fill (myDataSet);

        //Set the DataSource for the DataGrid, and then bind the data.
        DataGrid1.DataSource = myDataSet;
        DataGrid1.DataBind ();
    }
    ```

5. Modify the connection string as appropriate for your environment.
6. Expand the *Web Form Designer generated code* region, and then add the following statement in the `InitializeComponent` function:

    ```cs
    this.DataGrid1.ItemDataBound
    += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid1_ItemDataBound);
    ```

## Use the ItemDataBound event

The `ItemDataBound` event is raised after an item is data bound to the DataGrid control. This event gives you with the last opportunity to access the data item before it appears on the client. After this event is raised, the data item is null and is no longer available.

For each item that is data bound, you must check the `ItemType` property. If `ItemType` is of type `Item` or `AlternatingItem`, you receive the value from the last cell of the item, which contains the `SaleAmount` value. In this sample, you add this value to the running summary variable. When the `ItemType` is `Footer`, you receive the total from all of the rows. Therefore, you assign the value of the summary variable to the text value of the last cell.

> [!NOTE]
> This code uses formatting expressions to provide a uniform look for the `SaleAmount` data.

Add the following code after the `Page_Load` event:

```cs
private void DataGrid1_ItemDataBound (object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
{
    switch ((int) (e.Item.ItemType))
    {
        case (int) ListItemType.Item:
        case (int) ListItemType.AlternatingItem:
            //Calculate total for the field of each row and alternating row.
            myTotal += Convert.ToDouble (e.Item.Cells[2].Text);
            //Format the data, and then align the text of each cell to the right.
            e.Item.Cells[2].Text = Convert.ToDouble (e.Item.Cells[2].Text).ToString ("##,##0.00");
            e.Item.Cells[2].Attributes.Add ("align", "right");
            break;
        case (int) ListItemType.Footer:
            //Use the footer to display the summary row.
            e.Item.Cells[1].Text = "Total Sales";
            e.Item.Cells[1].Attributes.Add ("align", "left");
            e.Item.Cells[2].Attributes.Add ("align", "right");
            e.Item.Cells[2].Text = myTotal.ToString ("c");
            break;
    }
}
```

## Build the project and test the code

1. On the **File** menu, click **Save All**.
2. On the **Build** menu, click **Build Solution**.
3. In Solution Explorer, right-click the .aspx page, and then click **View in Browser**. The .aspx page appears in the browser, and the DataGrid displays the **OrderID**, the **CompanyName**, and the **SaleAmount** columns. Notice that the footer displays the total of the **SaleAmount** column.

## References

- [DataGrid.ItemDataBound Event](/dotnet/api/system.web.ui.webcontrols.datagrid.itemdatabound)

- [DataGrid Class](/dotnet/api/system.web.ui.webcontrols.datagrid)

- [Formatting Overview)](/previous-versions/dotnet/netframework-1.1/26etazsy(v=vs.71))
