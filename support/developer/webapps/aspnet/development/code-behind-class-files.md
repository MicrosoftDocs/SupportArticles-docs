---
title: Work with code-behind class files
description: This article describes how to develop .aspx pages that use code-behind class files in Microsoft ASP.NET applications.
ms.date: 07/28/2020
ms.topic: how-to
---
# Use Visual C# .NET to work with code-behind class files in an ASP.NET application

This article describes how to develop .aspx pages that use code-behind class files in Microsoft ASP.NET applications. The code samples in this article include the requirements for both code-behind class files that are precompiled and code-behind class files that are compiled on demand.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 308143

## Requirements

The following list outlines the recommended hardware, software, and network infrastructure that you need:

- Windows
- .NET Framework
- Internet Information Services (IIS)

## Create an ASP.NET web application by using Visual C# .NET

This section demonstrates how to create a new ASP.NET web application that is named *CodeBehindSamples*.

1. Start Visual Studio .NET.
2. On the **File** menu, point to **New**, and then click **Project**.
3. Under **Project Type**, click **Visual C# Projects**. Under **Templates**, click **ASP.NET Web Application**.
4. In the **Name** box, type *CodeBehindSamples*. In the **Location** box, type the *ServerName*. If you are using the local server, leave the **Location** as `http://localhost`.

## Use code-behind class files

If you use code-behind class files with .aspx pages, you can separate the presentation code from the core application logic (or code-behind). The code-behind class file is compiled so that it can be created and used as an object. This allows access to its properties, its methods, and its event handlers. For this to work, the .aspx page must specify to inherit from the code-behind base class. To do this, use the `Inherits` attribute for the `@ Page` directive. The .aspx page inherits from the code-behind class, and the code-behind class inherits from the `Page` class.

By default, if you are using Visual Studio .NET, a `Codebehind` attribute is added to the `@ Page` directive. The .NET Framework does not actually use this attribute. Instead, Visual Studio .NET uses this attribute to maintain a reference to the associated code-behind file for the .aspx page.

To demonstrate how Visual Studio .NET uses the `Codebehind` attribute, remove the `Codebehind` attribute. You can no longer right-click the .aspx page and then click **View Code**. This behavior occurs because Visual Studio .NET no longer contains a reference for the class file it can use for the page. Remember that this is not how the .NET Framework uses code-behind class files, but how Visual Studio .NET manages these project files.

### Use the Inherits attribute with precompiled classes

If you precompile your code-behind classes into an assembly, you can use the `Inherits` attribute to specify the class from which to inherit. In this scenario, you do not have to include the actual code-behind class file when you deploy the application. Instead, you must deploy the assembly and the .aspx page. You must put the assembly in the `Bin` folder for the application when you deploy the application.

This section demonstrates how to create a new Web Form that uses the precompiled approach and inherits from the code-behind class.

1. To add a new Web Form that is named *InheritSample.aspx* to your Visual Studio .NET project, follow these steps:

    1. In **Solution Explorer**, right-click the project node, click **Add**, and then click **Add Web Form**.
    2. In the **Name** box, type *InheritSample.aspx*, and then click **Open**.

2. Switch to **Design** view, and then add a Web Form **Label** control to the .aspx page.
3. Right-click the .aspx page, and then click **View Code**. The code-behind file opens in the editor.
4. In the code-behind file, add the following code to the `Page_Load` event handler:

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        Label1.Text = "(Precompiled): Page_Load fired!";
    }
    ```

    > [!NOTE]
    > This code only demonstrates that the code-behind class is involved in the sample at run time in the later steps.

5. Switch from the code-behind class file to the .aspx page in the editor, and then switch to HTML view.
6. At the top of the page, review the code for the `@ Page` directive. The code should be similar to the following default code:

    ```aspx-csharp
    <%@ Page language="c#" Codebehind="InheritSample.aspx.cs"
    AutoEventWireup="false" Inherits="CodeBehindSamples.InheritSample" %>
    ```

    In this example, the .aspx page inherits from the code-behind class that is named `InheritSamples` in the `CodeBehindSamples` namespace. By default, a web application that is created in Visual Studio .NET uses a `ProjectName.ClassName` structure for the `Inherits` attribute value.

7. On the **File** menu, click **Save All** to save the Web Form and other associated project files.
8. In the Visual Studio .NET IDE, on the **Build** menu, click **Build** to build the project.
9. On the **Project** menu, click **Show All Files**.
10. In **Solution Explorer**, click to expand the `Bin` folder. The assembly that is generated when you compile the project from the previous section (which is *CodeBehindSamples.dll* in this example) appears in the `Bin` folder.
11. In Visual Studio .NET, right-click the page in **Solution Explorer**, and then click **View in Browser** to run the code. The label is populated with the following value:

    `(Precompiled): Page_Load fired!`

### Use the Src attribute and compile on demand

If your code-behind class files will be compiled on demand instead of precompiled, you must use the `Src` attribute to specify the relative path of the code-behind class file. Make sure that you include the actual class file when you use this method to deploy the application.

> [!NOTE]
> For more information about potential issues when developing your applications in Visual Studio .NET with using the `Src` attribute, see the [References](#references) section in this article. Visual Studio .NET is designed to take advantage of precompiling your application code into an assembly instead of using the compile on demand approach that is described in this section.

1. To add a new Web Form that is named *SrcSample.aspx* to your project in Visual Studio .NET, follow these steps:

    1. In **Solution Explorer**, right-click the project node, click **Add**, and then click **Add Web Form**.
    2. In the **Name** box, type *SrcSample.aspx*, and then click **Open**.

2. Switch to **Design** view, and then add a Web Form **Label** control to the .aspx page.
3. Right-click the .aspx page, and then click **View Code**. The code-behind file opens in the editor.
4. In the code-behind file, add the following code to the `Page_Load` event:

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        Label1.Text = "(Src): Page_Load fired!";
    }
    ```

5. Switch from the code-behind class file to the .aspx page in the editor, and then switch to HTML view.
6. At the top of the page, review the code for the `@ Page` directive. The code should be similar to the following default code:

    ```aspx-csharp
    <%@ Page language="c#" Codebehind="SrcSample.aspx.cs"
    AutoEventWireup="false" Inherits="CodeBehindSamples.SrcSample"%>
    ```

7. To simplify this example, delete the *Global.asax* file from your project. This is only done in this example to prevent additional errors that are related to the code-behind page of the *Global.asax* file.
8. On the **File** menu, click **Save All** to save the Web Form and other associated project files.

    > [!NOTE]
    > Because you want the code-behind class file for this sample to compile on demand, do not build the solution now.

9. If you followed the steps that are listed in the [Use the Inherits attribute with precompiled classes](#use-the-inherits-attribute-with-precompiled-classes) section, you must delete the assembly in the `Bin` directory of the application before you follow the rest of the steps in this section.

    For more information, visit the [Troubleshooting](#troubleshooting) section of this article.

10. To run the page, start Internet Explorer and then manually enter the URL of the page. Do not select the **View in Browser** or the **Browse With** options from the Visual Studio .NET IDE. Otherwise, if you are using Visual Studio .NET 2003, the code-behind page will be precompiled into an assembly that is located in the `Bin` directory by default. After viewing the page, you will receive an error message that is similar as below:

    > Could not load type 'CodeBehindSamples.SrcSample'.

    This error occurs because the code-behind class file is not yet compiled, and you have not yet included the `Src` attribute to reference the code-behind class file.

11. Add the `Src` attribute to the `@ Page` directive as follows:

    ```aspx-csharp
    <%@ Page language="c#" Codebehind="SrcSample.aspx.cs"
    AutoEventWireup="false" Inherits="CodeBehindSamples.SrcSample" Src="SrcSample.aspx.cs"%>
    ```

    The `Src` attribute is listed with the relative path of the code-behind class file (*SrcSample.aspx.cs*), and the `Inherits` attribute value is set to reference `CodeBehindSamples.SrcSample`.

12. On the **File** menu, click **Save All** to save the Web Form and other associated project files. Remember, do not build the solution because you want the code-behind class file for this sample to be compiled on demand.

13. To run the page, start Internet Explorer and then manually enter the URL of the page. Do not select the **View in Browser** or the **Browse With** options from the Visual Studio .NET IDE. Otherwise, if you are using Visual Studio .NET 2003, the code-behind page will be precompiled into an assembly that is located in the `Bin` directory by default. At this point, the page should be loaded in the browser, and the label is populated with the following value:

    `(Src): Page_Load fired!`

    The code-behind class file has now been compiled on demand and functions correctly.

## Troubleshooting

- You may receive an error message that is similar to the following if you precompile your application in Visual Studio .NET and then try to apply the compile on demand approach by using the `Src` attribute:

  > Compiler Error Message: CS1595: '*ProjectName.CodeBehindClassName*' is defined in multiple places; using definition from '%windir%:\WINDOWS\Microsoft.NET\Framework\v1.1.4322\Temporary ASP.NET Files\\*YourProjectName*\d1444413\36fce407\assembly\dl2\009389be\231afa2d_d586c301\\*YourAssemblyName*.DLL'

  Keep in mind that the directory names following *YourProjectName* in the path that is listed in the error message will probably be different because ASP.NET automatically handles the building of the directories and their names.

  If you use the `Src` attribute, you must follow these steps to resolve the issue that is associated with the error message:

  1. Delete the *YourProjectName* directory that is referenced in the error message. You may also have to run the `iisreset` command from the command prompt before you complete this step. Otherwise, you may receive the following error message:
  
      > Cannot delete *GeneratedName.dll*: Access is denied.  
      > Make sure the disk is not full or write-protected and that the file is not currently in use.

  2. Delete the assembly in the `Bin` directory of the application.
  3. To run the page, start Internet Explorer and then manually enter the URL to the page. Do not select the **View in Browser** or the **Browse With** options from the Visual Studio .NET IDE. Otherwise, if you use Visual Studio .NET 2003, the code-behind page will be precompiled into an assembly that is located in the `Bin` directory by default.

  > [!NOTE]
  > Microsoft recommends that you use the precompiled approach instead of the compile on demand method (by using the `Src` attribute) if you develop your applications with Visual Studio .NET to avoid these types of issues.

- If you want to or if you must contain your Web Form pages in a single file, develop your .aspx pages to contain your code instead of the code-behind class file.

  For more information about how to develop single-file Web Forms in Visual Studio .NET, see [Visual Studio 2003 Retired Technical documentation](https://www.microsoft.com/download/details.aspx?id=55979).

- If you do not precompile the code-behind class file and if you do not add the `Src` attribute to the `@ Page` directive, or if the virtual path for the attribute is not correct, you will receive the following error message:

  > Could not load type 'CodeBehindSamples.SrcSample'.

- When you deploy .aspx pages, if their associated code-behind class files are precompiled, you only have to deploy the assembly to the `Bin` folder of the application. You do not have to deploy the actual code-behind class files with the application.

- When you deploy .aspx pages, if their associated code-behind class files are not precompiled, you must deploy the code-behind class files with the application. Additionally, you must add the `Src` attribute to the `@ Page` directive because the class file must be available when it is compiled on demand.

## References

- For more information about assemblies, see [Assemblies](/previous-versions/dotnet/netframework-1.1/hk5f40ct(v=vs.71)).

- For more articles, samples, and other resources that are related to ASP.NET programming, see [ASP.NET](/previous-versions/dotnet/articles/aa286485(v=msdn.10)).

- For more information about the @ Page directive and its various attributes, see [@ Page](/previous-versions/dotnet/netframework-1.1/ydy4x04a(v=vs.71)).

- For more information about general Web Forms syntax, see [Web Forms Syntax](/previous-versions/dotnet/netframework-1.1/fy30at8h(v=vs.71)).

- For more information, see [ASP.NET Code-behind model overview](code-behind-model.md).
