---
title: ASP.NET inline expressions
description: This article introduces the usage of ASP.NET inline expressions in the .NET Framework.
ms.date: 03/26/2020
ms.custom: sap:General Development
ms.reviewer: wawang
ms.topic: concept-article
---
# ASP.NET inline expressions in the .NET Framework

This article contains an introduction to the following ASP.NET inline expressions:

- <% ... %>
- <%= ... %>
- <%@ ... %>
- <%# ... %>
- <%$ ... %>
- <%-- ... --%>

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 976112

## <% ... %> embedded code blocks

The embedded code block is used to preserve backward compatibility with classical ASP. The code in the block can execute programming statements and call functions in the current page class during the page-rendering phase.

The following example demonstrates an ASP.NET page that has sample Microsoft Visual Basic .NET code in an embedded code block to display the results of a loop:

```aspx-vb
<%@ Page Language="VB" %>
<html>
<body>
    <form id="form1" runat="server">
        <% For i As Integer = 16 To 24 Step 2%>
            <div style="font-size: <% Response.Write(i)%>">
                Hello World<br />
            </div>
        <% Next%>
    </form>
</body>
</html>
```

Because an embedded code block is always mixed with the HyperText Markup Language (HTML) source, it's difficult for developers to read and maintain them.

For more information about embedded code blocks in ASP.NET Web pages, visit [Embedded Code Blocks in ASP.NET Web Forms Pages](/previous-versions/ms178135(v=vs.140)).

## <%= ... %> displaying expression

The `<%= ... %>` displaying expression is an equivalent of the embedded code block that contains only the `Response.Write(...)` statement. It is the simplest way to display information such as a single string, an int variable, or a constant.

For example, the following sample code displays the current time:

```aspx-vb
<%@ Page Language="VB" %>
<html>
    <body>
        <form id="form1" runat="server">
            <%=DateTime.Now.ToString() %>
        </form>
    </body>
</html>
```

Remember that the displaying expression can't be used in the attributes of server controls. It is because the .NET Framework directly compiles the whole expression instead of the displaying content as the value to the attribute.

For more information about how to display information from ASP.NET, visit [Displaying from ASP.NET](/previous-versions/visualstudio/visual-studio-2010/6dwsdcf5(v=vs.100)).

## <%@ ... %> directive expression

The directive expression is the syntax that specifies settings that are used by the page and by user control compilers when they process ASP.NET Web Form (.aspx) pages and User Control (.ascx) files.

The ASP.NET page framework supports the following directives:

|Directive|Description|
|--|--|
|`@ Page`|Defines page-specific attributes that are used by the ASP.NET page parser and compiler. Can be included only in .aspx files.<br/>This directive name can be used only in ASP.NET Web Form pages.|
|`@ Control`|Defines control-specific attributes that are used by the ASP.NET page parser and compiler. Can be included only in .ascx files (user controls).<br/>The directive name can be used only in User Control files.|
|`@ Import`|Explicitly imports a namespace into a page or into a user control.|
|`@ Implements`|Declaratively indicates that a page or a user control implements a specified .NET Framework interface.|
|`@ Register`|Associates aliases with namespaces and with class names. Which enables user controls and custom server controls to be rendered when they are included in a requested page or user control.|
|`@ Assembly`|Links an assembly to the current page during compilation. It makes all the assembly's classes and interfaces available for use on the page.|
|`@ Master`|Identifies an ASP.NET master page.|
|`@ WebHandler`|Identifies an ASP.NET IHttpHandler page.|
|`@ PreviousPageType`|Provides a way to obtain strong typing against the previous page as accessed through the PreviousPage property.|
|`@ MasterType`|Assigns a class name to the Master property of an ASP.NET page. Provides a way to create a strongly typed reference to the ASP.NET master page.|
|`@ OutputCache`|Declaratively controls the output caching policies of a page or of a user control.|
|`@ Reference`|Declaratively links a page or user control to the current page or user control.|
  
For more information about directive syntax, visit [Text Template Directive Syntax](/previous-versions/dotnet/netframework-4.0/xz702w3e(v=vs.100)).

## <%# ... %> data-binding expression

The data-binding expression creates binding between a server control property and a data source when the control's DataBind method of this server control is called on the page.

The following example shows how to use the data-binding expression to bind the string from a function to the Text property of a label:

```aspx-vb
<%@ Page Language="VB" %>
<script runat="server">
    Protected Function SayHello() As String
        Return "Hello World"
    End Function

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        lblHello.DataBind()
    End Sub
</script>
<html>
    <body>
        <form id="form1" runat="server">
            <asp:Label ID="lblHello" runat="server" Text="<%# SayHello%>"></asp:Label>
        </form>
    </body>
</html>
```

For more information about data-binding expression syntax, visit [Data-Binding Expression Syntax](/previous-versions/dotnet/netframework-4.0/bda9bbfx(v=vs.100)).

## <%$ ... %> expression builder

The expression builder is used to set values of control properties based on the information that is contained in an application's configuration or resource files. The following example is the basic syntax of the expression builder:  
`<%$ Expression Prefix: Expression Value %>`

The dollar sign ($) indicates to ASP.NET that the following expression is an expression builder. The expression prefix defines the kind of expression, such as `AppSettings`, `ConnectionStrings`, or `Resources`. Additionally, you can create and define your own expression builder. The expression value that follows the colon (:) is what ASP.NET will actually use as the value of a certain property.

The following demo shows how to use the expression builder to obtain the copyright of a Web site from the `AppSettings` node in the _Web.config_ file and how to set the copyright information as the value of the Literal's Text property.

The `AppSettings` node in _Web.config_ file:

```xml
<appSettings>
    <add key="copyright" value="(c) Copyright 2009 WebSiteName.com"/>
</appSettings>
```

The expression builder in the ASP.NET Web Form page:

```aspx
<div id="footer">
    <asp:Literal ID="Literal1" runat="server" Text="<%$ AppSettings: copyright %>"></asp:Literal>
</div>
```

For more information about ASP.NET expressions, visit [ASP.NET Expressions Overview](/previous-versions/d5bd1tad(v=vs.140)).

## <%-- ... -- %> server-side comments block

The server-side comments block lets developers embed code comments in any location of the HTML source of ASP.NET Web Form pages (except for within `<script>` code blocks). Any content between the opening and closing tags of the server-side comments block won't be processed on the server or rendered on the resulting page.

The following code example shows how to use the server-side comments block in an ASP.NET page:

```aspx-vb
<%@ Page Language="VB" %>
<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strName As String
        strName = Session("userName")
        lblUserName.Text = strName
    End Sub
</script>
<html>
    <body>
        <form id="form1" runat="server">
            <%-- Label for UserName --%>
            <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
        </form>
    </body>
</html>
```

For more information about server-side comments, visit [Server-Side Comments](/previous-versions/dotnet/netframework-4.0/4acf8afk(v=vs.100)).
