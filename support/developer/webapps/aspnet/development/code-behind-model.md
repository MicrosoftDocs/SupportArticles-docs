---
title: ASP.NET Code-behind model overview
description: This article provides information about the code-behind model that is introduced in ASP.NET.
ms.date: 04/02/2020
ms.custom: sap:General Development
ms.topic: concept-article
---
# ASP.NET Code-behind model overview

This article provides a brief overview of the in-line code and Code-behind model in ASP.NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 303247

## Summary

This article refers to the Microsoft .NET Framework class library namespace `System.Web.UI`.

ASP.NET supports two methods to author pages:

- In-line code
- Code-behind

## In-Line code

In-line code is code that is embedded directly within the ASP.NET page. The following code represents a sample ASP.NET page that includes in-line code:

Myinlinecode.aspx

```aspx-csharp
<%@ Language=C# %>
<HTML>
    <script runat="server" language="C#">
        void MyButton_OnClick(Object sender, EventArgs e)
        {
            MyLabel.Text = MyTextbox.Text.ToString();
        }
    </script>
    <body>
        <form id="MyForm" runat="server">
            <asp:textbox id="MyTextbox" text="Hello World" runat="server"></asp:textbox>
            <asp:button id="MyButton" text="Echo Input" OnClick="MyButton_OnClick" runat="server"></asp:button>
            <asp:label id="MyLabel" runat="server"></asp:label>
        </form>
    </body>
</HTML>
```

## Code-behind

Code-behind refers to code for your ASP.NET page that is contained within a separate class file. This allows a clean separation of your HTML from your presentation logic. The following sample illustrates an ASP.NET code-behind page:

- MyCodebehind.aspx

    ```aspx-csharp
    <%@ Language="C#" Inherits="MyStuff.MyClass" %>
    <HTML>
        <body>
            <form id="MyForm" runat="server">
                <asp:textbox id="MyTextBox" text="Hello World" runat="server"></asp:textbox>
                <asp:button id="MyButton" text="Echo Input" Onclick="MyButton_Click" runat="server"></asp:button>
                <asp:label id="MyLabel" runat="server" />
            </form>
        </body>
    </HTML>
    ```

- Mycodebehind.cs

    ```aspx-csharp
    using System;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    namespace MyStuff
    {
        public class MyClass : Page
        {
            protected System.Web.UI.WebControls.Label MyLabel;
            protected System.Web.UI.WebControls.Button MyButton;
            protected System.Web.UI.WebControls.TextBox MyTextBox;

            public void MyButton_Click(Object sender, EventArgs e)
            {
                MyLabel.Text = MyTextBox.Text.ToString();
            }
        }
    }
    ```

In the preceding sample, you can use the following syntax to compile *Mycodebehind.cs*:

```console
csc.exe /out:mycodebehind.dll /t:library mycodebehind.cs
```

When you use the following code, the code-behind page inherits from the Page class. The Page class resides in the `System.Web.UI namespace`:

```aspx-csharp
public class MyClass : Page
```

Inheriting from the `Page` class gives the code-behind page access to the ASP.NET intrinsic objects, such as `Request` and `Response`. In addition, inheriting from the `Page` class provides a framework for handling events for controls within the ASP.NET page.

In the preceding sample, the code-behind page is compiled before ASP.NET runs. Alternatively, you can reference the code-behind class by using an `SRC` tag as follows:

```aspx-csharp
<%@ Language="C#" Inherits="MyStuff.MyClass" src="MyCodebehind.cs" %>
```

In this case, ASP.NET compiles the code-behind page on the fly. This compilation step only occurs when the code-behind file is updated (which is detected through a timestamp change).

## Code-behind support in Visual Studio .NET

When you use Visual Studio .NET to create ASP.NET Web Forms, code-behind pages are the default method. In addition, Visual Studio .NET automatically performs pre-compilation for you when you build your solution.

> [!NOTE]
> Code-behind pages that are created in Visual Studio .NET include a special `page` attribute, `Code-behind`, which Visual Studio .NET uses.
