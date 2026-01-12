---
title: ASP.NET server controls overview
description: This article describes the information of the ASP.NET server controls.
ms.date: 04/02/2020
ms.custom: sap:General Development
ms.topic: concept-article
---
# ASP.NET server controls overview

This article introduces ASP.NET server controls, such as HTML server controls, Web server controls, List controls etc.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306459

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Web.UI.HtmlControls.HtmlControl`
- `System.Web.UI.WebControls.WebControl`

## Server controls in ASP.NET page framework

The ASP.NET page framework includes a number of built-in server controls that are designed to provide a more structured programming model for the Web. These controls provide the following features:

- Automatic state management.
- Simple access to object values without having to use the `Request` object.
- Ability to react to events in server-side code to create applications that are better structured.
- Common approach to building user interfaces for web pages.
- Output is automatically customized based on the capabilities of the browser.

In addition to the built-in controls, the ASP.NET page framework also provides the ability to create user controls and custom controls. User controls and custom controls can enhance and extend existing controls to build a much richer user interface.

## HTML server controls

The HTML server controls are HTML elements that include a `runat=server` attribute. The HTML server controls have the same HTML output and the same properties as their corresponding HTML tags. In addition, HTML server controls provide automatic state management and server-side events. HTML server controls offer the following advantages:

- The HTML server controls map one to one with their corresponding HTML tags.
- When the ASP.NET application is compiled, the HTML server controls with the `runat=server` attribute are compiled into the assembly.
- Most controls include an `OnServerEvent` for the most commonly used event for the control. For example, the `<input type=button>` control has an `OnServerClick` event.
- The HTML tags that are not implemented as specific HTML server controls can still be used on the server side; however, they are added to the assembly as `HtmlGenericControl`.
- When the ASP.NET page is reposted, the HTML server controls keep their values.

The `System.Web.UI.HtmlControls.HtmlControl` base class contains all of the common properties. HTML server controls derive from this class.

To use an HTML server control, use the following syntax (which uses the `HtmlInputText` control as an example):

```aspx-csharp
<input type="text" value="hello world" runat=server />
```

For more information about individual HTML server controls that are available in ASP.NET, see the following Web sites:

- [HtmlAnchor Control](/previous-versions/dotnet/netframework-1.1/8ff86hxd(v=vs.71))

- [HtmlButton Control](/previous-versions/dotnet/netframework-1.1/a8fd2268(v=vs.71))

- [HtmlForm Control](/previous-versions/dotnet/netframework-1.1/dd120y50(v=vs.71))

- [HtmlImage Control](/previous-versions/dotnet/netframework-1.1/8551b36z(v=vs.71))

- [HtmlInputButton Control](/previous-versions/dotnet/netframework-1.1/s4dyt5wk(v=vs.71))

- [HtmlInputCheckBox Control](/previous-versions/dotnet/netframework-1.1/31d4thc6(v=vs.71))

- [HtmlInputFile Control](/previous-versions/dotnet/netframework-1.1/1s43z4wk(v=vs.71))

- [HtmlInputHidden Control](/previous-versions/dotnet/netframework-1.1/k65s5xs3(v=vs.71))

- [HtmlInputImage Control](/previous-versions/dotnet/netframework-1.1/44z2k814(v=vs.71))

- [HtmlInputRadioButton Control](/previous-versions/dotnet/netframework-1.1/17tk0thz(v=vs.71))

- [HtmlInputText Control](/previous-versions/dotnet/netframework-1.1/f8kdafb5(v=vs.71))

- [HtmlSelect Control](/previous-versions/dotnet/netframework-1.1/807bc327(v=vs.71))

- [HtmlTable Control](/previous-versions/dotnet/netframework-1.1/2962t2k8(v=vs.71))

- [HtmlTableCell Control](/previous-versions/dotnet/netframework-1.1/5wsbhse3(v=vs.71))

- [HtmlTableCell Control](/previous-versions/dotnet/netframework-1.1/405596yw(v=vs.71))

- [HtmlTextArea Control](/previous-versions/dotnet/netframework-1.1/h8ff3dty(v=vs.71))

## Web server controls

Web controls are similar to the HTML server controls such as Button, TextBox, and Hyperlink, except that Web controls have a standardized set of property names. Web server controls offer the following advantages:

- Make it easier for manufacturers and developers to build tools or applications that automatically generate the user interface.
- Simplify the process of creating interactive Web forms, which requires less knowledge of how HTML controls work and make the task of using them less prone to errors.

The `System.Web.UI.WebControls.WebControl` base class contains all of the common properties. Most of the Web server controls derive from this class.

To use a Web server control, use the following syntax (which uses the TextBox control as an example):

```aspx-csharp
<asp:textbox text="hello world" runat=server />
```

Web server controls can be divided into four categories:

- Basic Web Controls
- Validation Controls
- List Controls
- Rich Controls

### Basic web controls

Basic Web controls provide the same functionality as their HTML server control counterparts. However, basic Web controls include additional methods, events, and properties against which you can program.

For more information about individual Web controls that are available in ASP.NET, see the following Web sites:

- [Button Web Server Control](/previous-versions/dotnet/netframework-1.1/dx5ybk93(v=vs.71))

- [CheckBox Web Server Control](/previous-versions/dotnet/netframework-1.1/4s78d0k1(v=vs.71))

- [HyperLink Web Server Control](/previous-versions/dotnet/netframework-1.1/k0b15efk(v=vs.71))

- [Image Web Server Control](/previous-versions/dotnet/netframework-1.1/c6te4s54(v=vs.71))

- [ImageButton Web Server Control](/previous-versions/dotnet/netframework-1.1/1z8fsbyh(v=vs.71))

- [Label Web Server Control](/previous-versions/dotnet/netframework-1.1/2wwfb06z(v=vs.71))

- [LinkButton Web Server Control](/previous-versions/dotnet/netframework-1.1/1cd4z1zs(v=vs.71))

- [Literal Web Server Control](/previous-versions/dotnet/netframework-1.1/cc088zwa(v=vs.71))

- [Panel Web Server Control](/previous-versions/dotnet/netframework-1.1/152e73cy(v=vs.71))

- [PlaceHolder Web Server Control](/previous-versions/dotnet/netframework-1.1/as54k8b6(v=vs.71))

- [RadioButton Web Server Control](/previous-versions/dotnet/netframework-1.1/xke2zw4x(v=vs.71))

- [Table Web Server Control](/previous-versions/dotnet/netframework-1.1/9f65szta(v=vs.71))

- [TableCell Web Server Control](/previous-versions/dotnet/netframework-1.1/x595ddwc(v=vs.71))

- [TableRow Web Server Control](/previous-versions/dotnet/netframework-1.1/tk1zfd2e(v=vs.71))

- [TextBox Web Server Control](/previous-versions/dotnet/netframework-1.1/fhc2c904(v=vs.71))

### Validation controls

Validation controls are used to validate the values that are entered into other controls of the page. Validation controls perform client-side validation, server-side validation, or both, depending on the capabilities of the browser in which the page is displayed. Validation controls offer the following advantages:

- You can associate one or more validation controls with each control that you want to validate.
- The validation is performed when the page form is submitted.
- You can specify programmatically whether validation should occur, which is useful if you want to provide a cancel button so that the user can exit without having to fill valid data in all of the fields.
- The validation controls automatically detect whether validation should be performed on the client side or the server side.

> [!NOTE]
> A client-side validation catches errors before a postback operation is complete. Therefore, if you have combinations of client-side and server-side validation controls on a single page, the server-side validation will be preempted if a client-side validation fails.For more information about individual validation controls that are available in ASP.NET, refer to the following Web sites:

- [RequiredFieldValidator Control](/previous-versions/visualstudio/design-tools/expression-studio-3/cc295489(v=expression.10))

- [RangeValidator Control](/previous-versions/visualstudio/design-tools/expression-studio-3/cc295453(v=expression.10))

- [CompareValidator Control](/previous-versions/visualstudio/design-tools/expression-studio-3/cc295090(v=expression.10))

- [RegularExpressionValidator Control](/previous-versions/visualstudio/design-tools/expression-studio-3/cc295107(v=expression.10))

- [CustomValidator Control](/previous-versions/visualstudio/design-tools/expression-studio-3/cc295446(v=expression.10))

- [ValidationSummary Control](/previous-versions/visualstudio/design-tools/expression-studio-3/cc295561(v=expression.10))

### List controls

List controls are special Web server controls that support binding to collections. You can use list controls to display rows of data in a customized, template's format. All list controls expose DataSource and DataMember properties, which are used to bind to collections.

List controls can bind only to collections that support the IEnumerable, ICollection, or IListSource interfaces. For example, a Visual C# .NET sample page appears as follows:

```aspx-csharp
<%@ Page Language="C#" %>
<script runat="server">
    Public void Page_Load()
    {
        String[] myStringArray = new String[] {"one","two","three"};
        rptr.DataSource = myStringArray;
        rptr.DataBind();
    }
</script>
<html>
    <body>
        <asp:repeater id=rptr runat="server">
            <itemtemplate><%# Container.DataItem %><br></itemtemplate>
        </asp:repeater>
    </body>
</html>
```

A Visual Basic .NET sample page appears as follows:

```aspx-vb
<%@ Page Language="vb" %>
<script runat="server">
    public sub Page_Load()
        Dim myStringArray as String()
        myStringArray = new String() {"one","two","three"}
        rptr.DataSource = myStringArray
        rptr.DataBind()
    end sub
</script>
<html>
    <body>
        <asp:repeater id=rptr runat="server">
            <itemtemplate><%# Container.DataItem %><br></itemtemplate>
        </asp:repeater>
    </body>
</html>
```

The output appears as follows:

- one
- two
- three

For more information about individual list controls that are available in ASP.NET, see the following Web sites:

- [ListBox Web Server Control](/previous-versions/dotnet/netframework-1.1/z4d7ktzs(v=vs.71))

- [CheckBoxList Web Server Control](/previous-versions/dotnet/netframework-1.1/8bw4x4wa(v=vs.71))

- [RadioButtonList Web Server Control](/previous-versions/dotnet/netframework-1.1/y7k30eyz(v=vs.71))

- [Repeater Web Server Control](/previous-versions/dotnet/netframework-1.1/c012haty(v=vs.71))

- [DataList Web Server Control](/previous-versions/dotnet/netframework-1.1/yfx4t9t7(v=vs.71))

- [DataGrid Web Server Control](/previous-versions/dotnet/netframework-1.1/64xx84kc(v=vs.71))

- [DropDownList Web Server Control](/previous-versions/dotnet/netframework-1.1/0dzka5sf(v=vs.71))

### Rich controls

In addition to the preceding controls, the ASP.NET page framework provides a few, task-specific controls called rich controls. Rich controls are built with multiple HTML elements and contain rich functionality. Examples of rich controls are the Calendar control and the AdRotator control.

For more information about individual rich controls that are available in ASP.NET, see the following Web sites:

- [AdRotator Web Server Control](/previous-versions/dotnet/netframework-1.1/s5z9ks4y(v=vs.71))

- [Calendar Web Server Control](/previous-versions/dotnet/netframework-1.1/dxf9k8sh(v=vs.71))

- [Xml Web Server Control](/previous-versions/dotnet/netframework-1.1/day7x985(v=vs.71))

### User controls

Often, you may want to reuse the user interface of your Web Form without having to write any extra code. ASP.NET enables you to do this by converting your Web Forms into user controls. User controls, which have the.ascx file extension, can be used multiple times within a single Web Form.

To convert a Web Form into a user control, follow these steps:

1. Remove all `<html>`, `<head>`, `<body>`, and `<form>` tags.
2. If the `@ Page` directive appears in the page, change it to `@ Control`.
3. Include a `className` attribute in the `@ Control` directive so that the user control is typed strongly when you instantiate it.
4. Give the control a descriptive file name, and change the file extension from .aspx to .ascx.

For more information about user controls, see [Web Forms User Controls](/previous-versions/dotnet/netframework-1.1/y6wb1a0e(v=vs.71)).

### Custom controls

In addition to the built-in Web controls, ASP.NET also allows you to create your own custom controls. It may be useful to develop custom controls if you are faced with one of these scenarios:

- You need to combine the functionality of two or more built-in Web controls.
- You need to extend the functionality of a built-in control.
- You need a control that is different than any of the controls that currently exist.

For more information about developing custom controls, see the following topics:

- [Developing ASP.NET Server Controls](/previous-versions/dotnet/netframework-1.1/aa719973(v=vs.71))

- [Developing Custom Controls: Key Concepts](/previous-versions/dotnet/netframework-1.1/aa720226(v=vs.71))

- [Developing a Composite Control](/previous-versions/dotnet/netframework-1.1/aa719968(v=vs.71))
