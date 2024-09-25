---
title: Add static items from data binding to DropDownList
description: This article describes how to add static items and results from data binding to a DropDownList control by using Visual C#.
ms.date: 04/22/2020
ms.reviewer: josborne, earlb
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Add static items and results by using Visual C# from data binding to a DropDownList control

This article demonstrates how to add static items and data-bound items to a DropDownList control. The sample in this article populates a DropDownList control with an initial item.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 312489

## Requirements

The following list outlines the recommended hardware and software that you need:

- Microsoft Windows
- .NET Framework
- Visual Studio .NET
- Internet Information Services (IIS)
- SQL Server

This article refers to the following .NET Framework Class Library namespace `System.Data.SqlClient`.

## Use Visual C# to create an ASP.NET web application

To create a new ASP.NET web application that is named *DDLSample*, follow these steps:

1. Open Visual Studio .NET.
2. On the **File** menu, point to **New**, and then select **Project**.
3. In the **New Project** dialog box, select **Visual C# Projects** under **Project Types**, and then select **ASP.NET Web Application** under **Templates**.
4. In the **Location** box, replace *WebApplication1* in the default URL with *DDLSample*. If you are using the local server, you can leave the server name as `http://localhost` so that the **Location** box displays `http://localhost/DDLSample`.

## Create the sample

In the following steps, you create an .aspx page that contains a DropDownList control. The DropDownList control is data bound to columns of the `Authors` table from the SQL Server *Pubs* database.

1. To add a Web Form to the project, follow these steps:

   1. Right-click the project node in Solution Explorer, select **Add**, and then select **Add Web Form**.
   2. Name the .aspx page *DropDown.aspx*, and then select **Open**.

2. Make sure that the page is open in Design view in the editor. Add a DropDownList control to the page. In the **Properties** pane, change the **ID** of the control to **AuthorList**.

3. Add a Label control to the page after the DropDownList control. In the **Properties** pane, change the **ID** of the control to **CurrentItem**.

4. Add a Button control to the page after the Label control. In the **Properties** pane, change the **ID** of the control to **GetItem**, and then change the **Text** property to **Get Item**.

5. Right-click the page, and then select **View Code**. This opens the code-behind class file in the editor.

6. Add the `System.Data.SqlClient` namespace to the code-behind class file so that the sample code functions properly. The complete list of namespaces should appear as follows.

    ```cs
    using System;
    using System.Collections;
    using System.ComponentModel;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.SessionState;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using System.Data.SqlClient;
    ```

7. Add the following code to the `Page_Load` event.

    ```cs
    private void Page_Load (object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection myConn = new SqlConnection (
                "Server=localhost;Database=Pubs;Integrated Security=SSPI");
            SqlCommand myCmd = new SqlCommand (
                "SELECT au_id, au_lname FROM Authors", myConn);
            myConn.Open ();
            SqlDataReader myReader = myCmd.ExecuteReader ();

            //Set up the data binding.
            AuthorList.DataSource = myReader;
            AuthorList.DataTextField = "au_lname";
            AuthorList.DataValueField = "au_id";
            AuthorList.DataBind ();

            //Close the connection.
            myConn.Close ();
            myReader.Close ();

            //Add the item at the first position.
            AuthorList.Items.Insert (0, "<-- Select -->");
        }
    }
    ```

    To use Integrated Security in the connect string, change the *Web.config* file for the application and set the `impersonate` attribute of the `identity` configuration element to **true**, as shown in the following example.

    ```xml
    <configuration>
        <system.web>
            <identity impersonate="true" />
        </system.web>
    </configuration>
    ```

    For more information, see [ASP.NET Impersonation](/previous-versions/dotnet/netframework-1.1/xh507fc5(v=vs.71)).

8. Modify the connection string as appropriate for your environment.

9. Switch to the Design view in the editor for the .aspx page. Double-click **GetItem**. Add the following code to the `GetItem_Click` event in the code-behind class file.

    ```cs
    private void GetItem_Click (object sender, System.EventArgs e)
    {
        string itemText = AuthorList.SelectedItem.Text;
        string itemValue = AuthorList.SelectedItem.Value;
        CurrentItem.Text = string.Format (
            "Selected Text is {0}, and Value is {1}", itemText, itemValue);
    }
    ```

10. On the **File** menu, select **Save All** to save the Web Form and other associated project files.
11. On the **Build** menu in the Visual Studio .NET Integrated Development Environment (IDE), select **Build** to build the project.
12. In Solution Explorer, right-click the .aspx page, and then select **View In Browser**. Notice that the page opens in the browser and that the drop-down list box is populated with the initial data.
13. Select an item in the drop-down list box. Notice that the *CurrentItem* Label control displays the item that you selected. In addition, notice that the list retains the current position and the static entry.

## Troubleshooting

- You must place the code to add the static item to the `ListItem` collection of the control after the data binding code. If you don't add the code in this order, the list is re-created with the data binding code, which overwrites the static entry.
- The sample code checks the `IsPostBack` property to prevent the list from being re-created. In addition, this code checks `IsPostBack` to retain the selected item in the current position of the list between round trips to the server.

## References

- [ASP.NET server controls overview](https://support.microsoft.com/help/306459)

- [DropDownList Class](/dotnet/api/system.web.ui.webcontrols.dropdownlist)

- [Tutorial: Get started with ASP.NET Core](/aspnet/core/getting-started)
