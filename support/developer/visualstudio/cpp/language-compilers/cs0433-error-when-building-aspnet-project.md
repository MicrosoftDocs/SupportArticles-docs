---
title: ASP.NET project suffers CS0433 compiler error
description: This article describes scenarios when you build an ASP.NET project in Visual Studio.
ms.date: 01/23/2020
ms.custom: sap:Language or Compilers\C++
---
# Building an ASP.NET project in Visual Studio results in Compiler Error Message CS0433

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 2028526

## Summary

When building an ASP.NET project by using Microsoft Visual Studio, you may randomly see an error message like the following:

> Compiler Error Message: CS0433: The type 'ASP.summary_common_controls_notes_ascx' exists in both 'c:\Windows\Microsoft.NET\Framework64\v2.0.50727\Temporary ASP.NET Files\Book_Details\abc12345\def8910\App_Web_msftx123.dll' and 'c:\Windows\Microsoft.NET\Framework64\v2.0.50727\Temporary ASP.NET Files\Book_Details\abc12345\def8910\App_Web_msfty456.dll'
>
> Description: An error occurred during the compilation of a resource required to service this request. Please review the following specific error details and modify your source code appropriately.
>
> Source Error:
> Line 100:                 \</div\>
>
> Line 101:                          \<h3 class="entry"\>New Notes\</h3\>
>
> Line 102:                          \<bni:details id="details" runat="server" /\>
>
> Line 103:                          \<span class="RedZone"\>1450\</span\>
>
> Line 104:                          \<p\>Summary.\</p\>
>
> Source File: d:\http\post\publisher\default.aspx
> Line: 102

Common scenarios where this error can occur are discussed in the following sections.

## Scenario 1: Two assemblies in the same bin folder

**Description:** A common cause of this error is when there are two assemblies in the same web application bin folder containing two class definitions, but that have the same class name. This can happen if more than one Default.aspx was compiled into a single assembly. Commonly, this occurs when the Master page (Default.master) and the Default ASPX page (Default.aspx) both declare a \_Default class.

**Solution:** Change the class name of the master page (from \_Default in most cases), and rebuild the project. It is important to resolve any naming conflict between classes.

## Scenario 2: Multiple references to the same assembly

**Description:** The Reference Paths in Visual Studio is used to specify the folder path for assembly references used by the project. It is possible that the path contains an assembly, and that the assembly contains the same class name. It may be there are multiple References added to the same assembly (possibly different in version or name) causing a naming conflict.

**Solution:** Remove the old version reference. In Visual Studio, right-click your web site, and check the _References_ in the properties.

## Scenario 3: Changes in default permissions

**Description:** By default, when an ASP.NET Web application is compiled, the compiled code is placed in the Temporary ASP.NET Files folder. By default, the access permissions are given to the ASP.NET local user account. The account has the high-trust permissions needed to access compiled code. It is possible there were some changes in the default permissions, and the changes might cause versioning conflicts. Another possibility is that anti-virus software might lock an assembly inadvertently.

**Solution:** Clear the Temporary ASP.NET Files Folder of all contents.

## Scenario 4: Batch compilation

**Description:** When the batch attribute in the web.config file is set to True, it eliminates the delay caused by the compilation required when you access a file for the first time. ASP.NET pre-compiles all the non-compiled files in a batch mode. This batch mode causes delays the first time the files are compiled.

Setting the batch attribute to False may expose any masked compilation errors that exist in the application, but are not reported. More importantly, it tells ASP.NET to dynamically compile individual .aspx/.ascx files into separate assemblies, instead of into a single assembly.

**Solution:** Set batch=False in the \<compilation\> section in web.config. This action should be considered a temporary solution. Batch=False in the compilation section has a significant performance impact on build times for the application in Visual Studio.

## Scenario 5: Edit of web.config restarts the AppDomain

**Description:** Modifying the web.config file for an ASP.NET application, or changing a file in the bin folder (such as adding, deleting, or renaming), causes the AppDomain to restart. When these actions occur, all session state is lost, and cached items are removed from the cache as the website restarts. The problem might be caused by an inconsistent state in the web application.

**Solution:** Trigger an AppDomain restart by touching (editing) the web.config file.

## Scenario 6: Changed source code not yet dynamically recompiled

**Description:** You can store source code in the App_Code folder, and the code will be automatically compiled at run time. The resulting assembly is accessible to any other code in the Web application. The App_Code folder therefore works much like the Bin folder, except that you can store source code in it instead of compiled code. The class will be recompiled when there is a change in the source file. If there is conflict due to an outdated assembly, forcing a recompile may resolve the problem.

**Solution:** Touch a file in the Bin or App_Code folders to trigger a full recompilation.
