---
title: Display hierarchical data with Repeater controls
description: Describes how to display hierarchical data by using nested Repeater Controls and Visual C# .NET.
ms.date: 04/20/2020
ms.reviewer: patcole, jallen
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Display hierarchical data by using nested Repeater controls and Visual C# .NET  

This article provides information about how to display hierarchical data by using nested Repeater controls and Visual C# .NET.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 306154

## Summary

This article describes how to use nested Repeater controls to display hierarchical data. You can apply this concept to other list-bound controls.

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Data`
- `System.Data.SqlClient`

## Bind to the parent table

1. Start Visual Studio .NET.
2. On the **File** menu, point to **New**, and then click **Project**.
3. Click **Visual C# Projects** under **Project Types**, and then click **ASP.NET Web Application** under **Templates**.
4. In the **Location** box, delete the *WebApplication#*, and then type *NestedRepeater*. If you use the local server, leave the server name as `http://localhost`. The `http://localhost/NestedRepeater` path appears in the **Location** box. Click **OK**.
5. In Solution Explorer, right-click the NestedRepeater project name node, point to **Add**, and then click **Add Web Form**.
6. To name the Web Form, type *NestedRepeater*, and click **Open**.
7. The new Web Form is created. It opens in Design View in the Integrated Development Environment (IDE) of Visual Studio .NET. From the Toolbox, select the Repeater control, and then drag it to the Web Form page.
8. Change the **ID** property of this Repeater control to *parentRepeater*.
9. Switch to the HTML view for this Web Form. To do so, click the **HTML** tab in the lower-left corner of the Designer. The Repeater control generates the following HTML code:

    ```aspx
    <asp:Repeater id="parentRepeater" runat="server"></asp:Repeater>
    ```

10. Add the following code in the `Repeater` tags:

    ```aspx
    <itemtemplate>
        <b>
            <%# DataBinder.Eval(Container.DataItem, "au_id") %>
        </b>
        <br>
    </itemtemplate>
    ```

    After you do that, the HTML code for the Repeater is as follows:

    ```aspx
    <asp:Repeater id="parentRepeater" runat="server">
        <itemtemplate>
            <b>
                <%# DataBinder.Eval(Container.DataItem, "au_id") %>
            </b>
            <br>
        </itemtemplate>
    </asp:Repeater>
    ```

11. In Solution Explorer, right-click *NestedRepeater.aspx*, and then click **View Code** to switch to the *NestedRepeater.aspx.cs* code-behind file.

12. Add the following namespace declaration to the top of the file:

    ```csharp
    using System.Data;
    using System.Data.SqlClient;
    ```

13. Add the following code to the `Page_Load` event to create a connection to the *Pubs* database, and then to bind the `Authors` table to the Repeater control:

    ```csharp
     public void Page_Load(object sender, EventArgs e)
     {
         //Create the connection and DataAdapter for the Authors table.
         SqlConnection cnn = new SqlConnection("server=(local);database=pubs; Integrated Security=SSPI");
         SqlDataAdapter cmd1 = new SqlDataAdapter("select * from authors",cnn);

         //Create and fill the DataSet.
         DataSet ds = new DataSet();
         cmd1.Fill(ds,"authors");
         //Insert code in step 4 of the next section here.
         //Bind the Authors table to the parent Repeater control, and call DataBind.
         parentRepeater.DataSource = ds.Tables["authors"];
         Page.DataBind();

         //Close the connection.
         cnn.Close();
     }
    ```

    > [!NOTE]
    > You may have to modify the database connection string as appropriate for your environment.

14. Save all of the files.
15. In Solution Explorer, right-click the *NestedRepeater.aspx*, and then click **Set As Start Page**.
16. On the **Build** menu, click **Build Solution** to compile the project.
17. View the .aspx page in the browser, and then verify that the page works thus far. The output should appear as follows:

    ```console
    172-32-1176
    213-46-8915
    238-95-7766
    267-41-2394
    ...
    ```

## Bind to the child table

1. In the HTML view of the *NestedRepeater.aspx* page, locate the following line of code:

    ```aspx
    <b>
        <%# DataBinder.Eval(Container.DataItem, "au_id") %>
    </b>
    <br>
    ```

    Add the following code after this code:

    ```aspx
    <asp:repeater id="childRepeater" runat="server">
        <itemtemplate>
            <%# DataBinder.Eval(Container.DataItem, "[\"title_id\"]")%>
            <br>
        </itemtemplate>
    </asp:repeater>
    ```

    This new code adds a second Repeater control to the `ItemTemplate` property of the parent Repeater control.

2. Set the `DataSource` property for the child Repeater control as follows:

    ```aspx
    <asp:repeater ... datasource='<%# ((DataRowView)Container.DataItem).Row.GetChildRows("myrelation") %>' >
    ```

    After you set the `DataSource` property for the child Repeater control, the HTML code for the two Repeater controls (parent and child) appears as follows:

    ```aspx-csharp
    <asp:Repeater id="parentRepeater" runat="server">
        <itemtemplate>
            <b>
                <%# DataBinder.Eval(Container.DataItem, "au_id") %>
            </b>
            <br>
            <asp:repeater id="childRepeater" runat="server"
            datasource='<%# ((DataRowView)Container.DataItem).Row.GetChildRows("myrelation") %>' >
                <itemtemplate>
                    <%# DataBinder.Eval(Container.DataItem, "[\"title_id\"]")%><br>
                </itemtemplate>
            </asp:Repeater>
        </itemtemplate>
    </asp:Repeater>
    ```

3. Add the following page directive to the top of the page:

    ```aspx-csharp
    <%@ Import Namespace="System.Data" %>
    ```

4. In the code-behind page, replace the following line in the `Page_Load` event:

    ```csharp
    //Insert code in step 4 of the next section here.
  
    //Create a second DataAdapter for the Titles table.
    SqlDataAdapter cmd2 = new SqlDataAdapter("select * from titleauthor",cnn);
    cmd2.Fill(ds,"titles");

    //Create the relation between the Authors and Titles tables.
    ds.Relations.Add("myrelation",
    ds.Tables["authors"].Columns["au_id"],
    ds.Tables["titles"].Columns["au_id"]);
    ```

    This adds the `Titles` table to the DataSet, and then adds the relationships between the `Authors` and `Titles` tables.

5. Save and compile the application.
6. View the page in the browser, and then verify that the page works so far. The output should appear as follows:

    ```console
    172-32-1176
    PS3333
    213-46-8915
    BU1032
    BU2075
    238-95-7766
    PC1035
    267-41-2394
    BU1111
    TC7777
    ```

## Nestedrepeater.aspx code

```aspx-csharp
<%@ Page language="c#" Codebehind="NestedRepeater.aspx.cs" AutoEventWireup="false" Inherits="NestedRepeater.NestedRepeater" %>
<%@ Import Namespace="System.Data" %>

<html>
    <body>
        <form runat=server>
            <!-- start parent repeater -->
            <asp:repeater id="parentRepeater" runat="server">
                <itemtemplate>
                    <b>
                        <%# DataBinder.Eval(Container.DataItem,"au_id") %>
                    </b>
                    <br>
                    <!-- start child repeater -->
                    <asp:repeater id="childRepeater" datasource='<%# ((DataRowView)Container.DataItem).Row.GetChildRows("myrelation") %>' runat="server">
                        <itemtemplate>
                            <%# DataBinder.Eval(Container.DataItem, "[\"title_id\"]")%><br>
                        </itemtemplate>
                    </asp:repeater>
                    <!-- end child repeater -->
                </itemtemplate>
            </asp:repeater>
            <!-- end parent repeater -->
        </form>
    </body>
</html>
```

## Nestedrepeater.aspx.cs code

```csharp
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NestedRepeater
{
    public class NestedRepeater : System.Web.UI.Page
    {
        protected System.Web.UI.WebControls.Repeater parentRepeater;
        public NestedRepeater()
        {
            Page.Init += new System.EventHandler(Page_Init);
        }
        public void Page_Load(object sender, EventArgs e)
        {
            //Create the connection and DataAdapter for the Authors table.
            SqlConnection cnn = new SqlConnection("server=(local);database=pubs; Integrated Security=SSPI ;");
            SqlDataAdapter cmd1 = new SqlDataAdapter("select * from authors",cnn);

            //Create and fill the DataSet.
            DataSet ds = new DataSet();
            cmd1.Fill(ds,"authors");

            //Create a second DataAdapter for the Titles table.
            SqlDataAdapter cmd2 = new SqlDataAdapter("select * from titleauthor",cnn);
            cmd2.Fill(ds,"titles");

            //Create the relation bewtween the Authors and Titles tables.
            ds.Relations.Add("myrelation",
            ds.Tables["authors"].Columns["au_id"],
            ds.Tables["titles"].Columns["au_id"]);

            //Bind the Authors table to the parent Repeater control, and call DataBind.
            parentRepeater.DataSource = ds.Tables["authors"];
            Page.DataBind();

            //Close the connection.
            cnn.Close();
        }
        private void Page_Init(object sender, EventArgs e)
        {
            InitializeComponent();
        }
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
        }
    }
}
```

## More information

For more information, see [Repeater Web Server Control](/previous-versions/dotnet/netframework-3.0/6weyd81h(v=vs.85)).
