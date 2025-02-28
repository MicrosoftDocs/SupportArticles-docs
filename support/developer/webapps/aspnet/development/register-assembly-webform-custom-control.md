---
title: Register assembly to use custom control
description: This article explains how to register an assembly in a WebForm to use a custom control.
ms.date: 03/25/2020
ms.custom: sap:General Development
ms.reviewer: pattim
ms.topic: how-to
---
# Register an assembly in a WebForm to use a custom control  

This article provides information to make and register an assembly available in a WebForm to use with ASP.NET custom server controls.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 321749

## Sample assembly properties

To be represented as a Custom Server Control, the assembly must have a class that directly or indirectly derives from `System.Web.UI.Control` and you must enclose the class in a namespace. Samples in this article assume that the class is enclosed in the `CustomControlNamespace` namespace, and that the assembly was successfully compiled in a file named *CustomControl.dll*.

## Make an assembly available to ASP.NET application

To make an assembly available for an ASP.NET application, you must place the assembly's .dll into the `/bin` folder of the application.

1. Navigate to the root directory of the application in Windows Explorer.

    To find out what the application project folder is:

    1. In the .NET environment, under the **View** menu, select **Solution Explorer**.
    2. Right-click a project main item in **Solution Explorer** and  select **Properties**.
    3. In the **Project Properties** dialog box, select **Common Properties** and select **General**.

    In the tree pane, you see the list with the **Project Folder** property. This is typically the root directory of the application.
2. In a Web Application project folder, create a folder named *bin* if it doesn't exist.
3. Copy or move the assembly's .dll in this folder. You can now use the control from any ASP.NET page in your application's root directory (or any of its subfolders).

## Register the assembly in an ASP.NET application web form

In a .NET programming environment, open the *Form.aspx* source window and add the following tag at top of the code:

```aspx
<%@ Register TagPrefix="Custom" Namespace="CustomControlNamespace" Assembly= "CustomControl" %>
```

In the code above:

- `Custom` is an alias that you associate with a namespace.
- `CustomControlNamespace` is a namespace in which classes of an assembly are enclosed.
- `CustomControl` is the name of the assembly file without an extension (.dll).

In your code, change these parameters to the appropriate names for your assembly.

Now the assembly is registered in a Web Form. You can use this registered assembly in your ASP.NET code with the chosen names. For example, the tag could be:

```aspx
<Custom:CustomControl id="CustomControl1" parameter1="value1" parameter2="value2" runat="server"/>
```

In the tag above, `Custom` is the chosen name for the assembly's namespace, `CustomControl` is the custom server control name, and `parameter 1` and `parameter2` are optional control properties that vary based on your actual code.
