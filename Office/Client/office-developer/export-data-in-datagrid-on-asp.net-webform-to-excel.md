---
title: How To  Export Data in a DataGrid on an ASP . NET WebForm to Microsoft Excel
description: Describes that how To  Export Data in a DataGrid on an ASP . NET WebForm to Microsoft Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How To Export Data in a DataGrid on an ASP . NET WebForm to Microsoft Excel

## Summary

Use this step-by-step guide to populate a DataGrid Web server control on an ASP.NET WebForm and then export the contents of the DataGrid to Microsoft Excel. 

### Techniques
 
This article describes two techniques for exporting the data in the DataGrid: 

- Using the Excel MIME Type (or Content Type)

    With server-side code, you can bind the DataGrid to your data and have the data open in Excel on a client computer. To do this, set the ContentType to application/vnd.ms-excel. After the client receives the new stream, the data appears in Excel as if the content was opened as a new page in the Web browser.

- Using Excel Automation

    With client-side code, you can extract the HTML from the DataGrid and then Automate Excel to display the HTML in a new workbook. With Excel Automation, the data always appears outside the browser in an Excel application window. One advantage to Automation is that you can programmatically control Excel if you want to modify the workbook after the data is exported. However, because Excel is not marked as safe for scripting, your clients must apply security settings in the Web browser that allow Automation.    

### Step-by-Step

1. Start Visual Studio .NET. On the File menu, point to New, and then click Project.   
2. In the Project Types pane, click Visual Basic Projects. Under Templates, click ASP.NET Web Application. Name the application ExcelExport and then click OK.

    WebForm1 appears in Design view for you.   
3. In Solution Explorer, right-click WebForm1.aspx and then click Rename. Change the name of the file to Bottom.aspx.   
4. On the View menu, click HTML Source to add the following DataGrid between the <form> and </form> tags:
    ```html
    <asp:datagrid id="DataGrid1" runat="server" GridLines="Vertical" CellPadding="3" BackColor="White"
    BorderColor="#999999" BorderWidth="1px" BorderStyle="None" Width="100%" Height="100%" Font-Size="X-Small"
    Font-Names="Verdana">
    <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#008A8C"></SelectedItemStyle>
    <AlternatingItemStyle BackColor="Gainsboro"></AlternatingItemStyle>
    <ItemStyle BorderWidth="2px" ForeColor="Black" BorderStyle="Solid" BorderColor="Black" BackColor="#EEEEEE"></ItemStyle>
    <HeaderStyle Font-Bold="True" HorizontalAlign="Center" BorderWidth="2px" ForeColor="White" BorderStyle="Solid"
    BorderColor="Black" BackColor="#000084"></HeaderStyle>
    <FooterStyle ForeColor="Black" BackColor="#CCCCCC"></FooterStyle>
    <PagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></PagerStyle>
    </asp:datagrid>
    
    ```

5. On the View menu, click Design to return to design view. 

    The DataGrid appears on the WebForm.   
6. On the View menu, click Code to display the code behind the Web Form. Add the following code to the Page_Load event handler: 

    **Note** You must change User ID \<username> and password=\<strong password> to the correct values before you run this code. Make sure that the user account has the correct permissions to perform this operation on the database.
    ```html
    ' Create a connection and open it.
    Dim objConn As New System.Data.SqlClient.SqlConnection("User ID=<username>;Password=<strong password>;Initial Catalog=Northwind;Data Source=SQLServer;")
    objConn.Open()
    
    Dim strSQL As String
    Dim objDataset As New DataSet()
    Dim objAdapter As New System.Data.SqlClient.SqlDataAdapter()
    
    ' Get all the customers from the USA.
    strSQL = "Select * from customers where country='USA'"
    objAdapter.SelectCommand = New System.Data.SqlClient.SqlCommand(strSQL, objConn)
    ' Fill the dataset.
    objAdapter.Fill(objDataset)
    ' Create a new view.
    Dim oView As New DataView(objDataset.Tables(0))
    ' Set up the data grid and bind the data.
    DataGrid1.DataSource = oView
    DataGrid1.DataBind()
    
    ' Verify if the page is to be displayed in Excel.
    If Request.QueryString("bExcel") = "1" Then
        ' Set the content type to Excel.
        Response.ContentType = "application/vnd.ms-excel"
        ' Remove the charset from the Content-Type header.
        Response.Charset = ""
        ' Turn off the view state.
        Me.EnableViewState = False
    
    Dim tw As New System.IO.StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
    
    ' Get the HTML for the control.
        DataGrid1.RenderControl(hw)
        ' Write the HTML back to the browser.
        Response.Write(tw.ToString())
        ' End the response.
        Response.End()
    End If
    
    ```
    **NOTE** Replace SQLServer in the code with the name of your SQL Server. If you do not have access to a SQL Server that contains the Northwind sample database, modify the connection string to use the Microsoft Access 2002 sample Northwind database:

    provider=microsoft.jet.oledb.4.0; data source=C:\Program Files\Microsoft Office\Office10\Samples\Northwind.mdb
    
    If you select this method, modify the aforementioned code to use the OleDbClient namespace rather than the SqlClient namespace.   
7. On the Project menu, click Add HTML Page. Name the page Top.htm and then click Open. 

    Top.htm appears in Design view.   
8. On the View menu, click HTML Source. Replace the contents of the HTML source window with the following code:
    ```html
    <html>
    <script language="vbscript">
      Sub Button1_onclick        
    
    Select Case Select1.selectedIndex
    
    Case 0' Use Automation.
          Dim sHTML
          sHTML = window.parent.frames("bottom").document.forms(0).children("DataGrid1").outerhtml
          Dim oXL, oBook
          Set oXL = CreateObject("Excel.Application")
          Set oBook = oXL.Workbooks.Add
          oBook.HTMLProject.HTMLProjectItems("Sheet1").Text = sHTML
          oBook.HTMLProject.RefreshDocument
          oXL.Visible = true
          oXL.UserControl = true
    
    Case 1' Use MIME Type (In a New Window).
          window.open("bottom.aspx?bExcel=1")
    
    Case 2' Use MIME Type (In the Frame).
          window.parent.frames("bottom").navigate "bottom.aspx?bExcel=1"
      End Select
    End Sub
    </script>
    <body>
    Export to Excel Using:
    <SELECT id="Select1" size="1" name="Select1">
    <OPTION value="0" selected>Automation</OPTION>
    <OPTION value="1">MIME Type (In a New Window)</OPTION>
    <OPTION value="2">MIME Type (In the Frame)</OPTION>
    </SELECT>
    <INPUT id="Button1" type="button" value="Go!" name="Button1">
    </body>
    </html>
    
    ```

9. On the Project menu, click Add HTML Page. Name the page Frameset.htm and then click Open. 

    Frameset.htm opens in Design view.   
10. On the View menu, click HTML Source. Replace the contents of the HTML source window with the following code:
    ```html
    <html>
    <frameset rows="10%,90%">
    <frame noresize="0" scrolling="no" name="top" src="top.htm">
    <frame noresize="0" scrolling="yes" name="bottom" src="bottom.aspx">
    </frameset>
    </html>
    
    ```

11. In Solution Explorer, right-click Frameset.htm and then click **Set As Start Page**.   
12. On the Build menu, click Build Solution.   

### Try It Out!

1. On the Debug menu, click Start Without Debugging to run the application. 

    After the frameset opens in the Web browser, the DataGrid in the bottom frame displays the data from the Northwind database.   
2. In the drop-down list, click Automation, and then click Go. 

    The DataGrid contents are displayed outside the browser in the Microsoft Excel application window.   
3. In the drop-down list, click **MIME Type (In a New Window)**, and then click Go. 

    The DataGrid contents are displayed in Excel hosted in a new Web browser window.

    **NOTE** If you receive a prompt to open or save the Excel file, click Open.   
4. In the drop-down list, click **MIME Type (In the Frame)** and then click Go. 

    The DataGrid contents are displayed in the bottom frame of the frameset in Excel hosted in the Web browser.

    **NOTE** If you receive a prompt to open or save the Excel file, click Open.   

## References

For additional information, view the article in the Microsoft Knowledge Base: 

[296717](https://support.microsoft.com/help/296717) PRB: Internet Explorer Prompts User to Open/Save Office File Streamed from ASP
