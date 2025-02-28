---
title: Examine CheckBox control values in a DataGrid column
description: This article describes how to loop through each row of an ASP.NET DataGrid control. It also describes how to determine if the ASP.NET CheckBox server control that is used to identify the row has been selected.
ms.date: 04/22/2020
ms.reviewer: RADOMIRZ
ms.topic: how-to
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
---
# Loop through and examine CheckBox control values in a DataGrid column by using ASP.NET and Visual Basic .NET

This article describes how to loop through each row of an ASP.NET DataGrid control and how to determine if the ASP.NET CheckBox server control that is used to identify the row has been selected.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 321881

## Summary

The sample code in this article uses the Microsoft SQL Server Northwind database to populate the DataGrid control and then adds a CheckBox server control to the initial column for each row. This is a common technique that allows users to select multiple, specific rows in a DataGrid.

This article refers to the following .NET Framework Class Library namespaces:

- `System.Data.SqlClient`
- `System.Text`

## Requirements

- Windows
- .NET Framework
- Internet Information Services (IIS)
- Visual Studio .NET

## Create an ASP.NET web application by using Visual Basic .NET

1. Start Visual Studio .NET.
2. On the **File** menu, point to **New**, and then select **Project**.
3. In the **New Project** dialog box, select **Visual Basic Projects** under **Project Types**, and then select **ASP.NET Web Application** under **Templates**.
4. In the **Location** box, replace the *WebApplication#* default name with *MyWebApp*. If you're using the local server, you can leave the server name as `http://localhost`. The resulting **Location** box appears as `http://localhost/MyWebApp`.

## Create the sample Web Form page

1. Add a new Web Form to the ASP.NET Web application as follows:
   1. Right-click the project node in Solution Explorer, point to **Add**, and then click **Add Web Form**.
   2. In the **Name** box, type *MySample.aspx*, and then select **Open**.

2. In the **Properties** window, change the **pageLayout** property for the document to **FlowLayout**. Although you don't have to do this to use the sample code, this will make the presentation appear cleaner.

3. Add a DataGrid, a Button, and a Label server control to the page as follows:
   1. Drag an ASP.NET DataGrid server control from the Web Forms toolbox onto the page.
   2. In the **Properties** window, change the **ID** of the DataGrid control to *DemoGrid*.
   3. Drag an ASP.NET Button server control from the Web Forms toolbox onto the page below the DataGrid.
   4. In the **Properties** window, change the **ID** of the Button control to *GetSelections*, and then change the **Text** property to *Get Selections*.
   5. Drag an ASP.NET Label server control from the Web Forms toolbox onto the page below the Button control.
   6. In the **Properties** window, change the **ID** of the Label control to *ResultsInfo*, and then delete any text in the **Text** property.

4. Switch to HTML view in the editor. Add the code to the default DataGrid template to construct the columns. The resulting code for the control should appear as follows:

    ```aspx
    <asp:DataGrid id="DemoGrid" runat="server" DataKeyField="CustomerID">
        <Columns>
            <asp:TemplateColumn HeaderText="Customer">
                <ItemTemplate>
                    <asp:CheckBox ID="myCheckbox" Runat="server" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    ```

5. Right-click the page, and then click **View Code**. This opens the code-behind class file in the editor. Add the following namespace references to the code-behind class file:

    ```vb
    Imports System.Data.SqlClient
    Imports System.Text
    ```

6. Replace the existing code for the `Page_Load` event handler with the following code:

    ```vb
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
       If Not IsPostBack Then
          'Create a SqlConnection object.
          'Modify the connection string as necessary for your environment.
          Dim cn As SqlConnection = New SqlConnection("Server=localhost;database=Northwind;UID=sa;PWD=")
          Dim cmd As SqlCommand = New SqlCommand("SELECT * FROM Customers", cn)
          cn.Open()
          Dim reader As SqlDataReader = cmd.ExecuteReader()
          DemoGrid.DataSource = reader
          DataBind()
          reader.Close()
          cn.Close()
       End If
    End Sub
    ```

7. Switch to Design view, and then double-click **GetSelections**. This opens the code-behind class file in the editor. Replace the existing code in the `GetSelections_Click` event handler with the following code:

    ```vb
    Private Sub GetSelections_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GetSelections.Click
        Dim rowCount As Integer = 0
        Dim gridSelections As StringBuilder = New StringBuilder()'Loop through each DataGridItem, and determine which CheckBox controls
        'have been selected.
        Dim DemoGridItem As DataGridItem
        For Each DemoGridItem In DemoGrid.Items

            Dim myCheckbox As CheckBox = CType(DemoGridItem.Cells(0).Controls(1), CheckBox)
            If myCheckbox.Checked = True Then
                rowCount += 1
                gridSelections.AppendFormat("The checkbox for {0} was selected<br>", _
                DemoGrid.DataKeys(DemoGridItem.ItemIndex).ToString())
            End If
        Next
        gridSelections.Append("<hr>")
        gridSelections.AppendFormat("Total number selected is: {0}<br>", rowCount.ToString())
        ResultsInfo.Text = gridSelections.ToString()
    End Sub
    ```

## Verify that it works

1. On the **File** menu, click **Save All** to save the Web Form and other files that are associated with the project.

2. On the **Build** menu in the Visual Studio .NET integrated development environment (IDE), click **Build Solution**.

3. In Solution Explorer, right-click the Web Form page (*MySample.aspx*), and then click **View in Browser**. Notice that the page displays the data in the grid. Additionally, a check box appears in the first column of each row. The user can click to select this check box to mark specific rows.

4. Click to select a few of the check boxes for the rows, and then click **Get Selections**.

    After the page makes a round trip to the server and executes the code in the `GetSelections_Click` event handler, a list of the items that you selected in the previous step appears. The code in the `GetSelections_Click` event handler loops through each `DataGridItem` in your ASP.NET DataGrid server control, determines whether the **Checked** property of the related CheckBox control is true, and then records the associated key value at that specific position for the `DataKeys` of the DataGrid.

## References

- [DataGrid Class](/dotnet/api/system.web.ui.webcontrols.datagrid?&view=netframework-4.8&preserve-view=true)

- [Server-Side ASP.NET Data Binding](/archive/msdn-magazine/2001/april/cutting-edge-server-side-asp-net-data-binding-part-2-customizing-the-datagrid-control)

- [DataGrid In-place Editing](/archive/msdn-magazine/2001/june/cutting-edge-datagrid-in-place-editing)
