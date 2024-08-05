---
title: Use Visual C# method to start browser
description: Describes how to start the default Internet browser programmatically by using Visual C#. Also provides a code example to illustrate how to do this task.
ms.date: 05/30/2022
ms.reviewer: BRODER
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to start the default Internet browser programmatically

This article shows how to start the default Internet browser by using Visual C#.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 305703

> [!NOTE]
>
> - This article refers to the Microsoft .NET Framework Class Library namespace `System.Diagnostics`.
> - For a Visual C++ .NET version of this article, see [How to programmatically start the default Internet browser by using Visual C++](https://support.microsoft.com/help/307382).

## Specify the URL, FTP, or file to open

You can specify a URL, a file, or a File Transfer Protocol (FTP) address. All three of these assignments are valid:

```csharp
string target= "http://www.microsoft.com";
string target = "ftp://ftp.microsoft.com";
string target = "C:\\Program Files\\Microsoft Visual Studio\\INSTALL.HTM";
```

## Use the Process class Start method to start the browser

The `Process` class contains a static `Start` method. Because it's a static method, you can call `Start` without having an instance of a `Process` class.

```csharp
System.Diagnostics.Process.Start(target);
```

For more information about the `Process` class, see [Process Class](/dotnet/api/system.diagnostics.process).

## Provide exception handling

Because you take advantage of [the default `UseShellExecute` property](/dotnet/api/system.diagnostics.processstartinfo.useshellexecute#property-value) when you call the `Start` method, you don't have to explicitly query the registry to determine which browser is the default. However, if you use this approach on a computer that doesn't have a browser installed, an exception occurs. This exception must be caught so that the appropriate action can be taken.

This example explicitly trap for an error that's generated when the necessary registry key isn't found and indicates that no browser is installed. Additionally, a general exception handler is provided for other errors that may occur. The `try...catch` block is demonstrated in the complete code listing.

## Complete code sample

```csharp
string target= "http://www.microsoft.com";
//Use no more than one assignment when you test this code.
//string target = "ftp://ftp.microsoft.com";
//string target = "C:\\Program Files\\Microsoft Visual Studio\\INSTALL.HTM";
try
{
    System.Diagnostics.Process.Start(target);
}
catch (System.ComponentModel.Win32Exception noBrowser)
{
    if (noBrowser.ErrorCode==-2147467259)
    MessageBox.Show(noBrowser.Message);
}
catch (System.Exception other)
{
    MessageBox.Show(other.Message);
}
```

## Troubleshooting

This code is highly dependent on the application-file type associations in the HKEY_CLASSES_ROOT (HKCR) hive of the registry. It can lead to unexpected results and exceptions if the registry is damaged. Additionally, file types and extensions may be associated with applications other than the browser. For example, HTM or HTML files may be associated with Web development software instead of the browser.
