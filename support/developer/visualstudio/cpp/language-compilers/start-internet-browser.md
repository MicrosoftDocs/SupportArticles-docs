---
title: "Start default browser by the Process::Start method"
description: Describes how to start the default Internet browser by using managed extensions for Visual C++. This article also provides a code sample to show how to do this task.
ms.date: 05/30/2022
ms.topic: how-to
ms.custom: sap:Language or Compilers\C++
---
# Start the default Internet browser programmatically by using Visual C++  

This article demonstrates how to start the default Internet browser by using managed extensions for Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 307382

> [!NOTE]
>
> - For a Microsoft Visual C# .NET version of this article, see
[How to start the default Internet browser programmatically by using Visual C#](https://support.microsoft.com/help/305703).
> - This article refers to the .NET Framework Class Library namespaces `System.Diagnostics.Process` and `System.Windows.Forms`.

## Specify the URL, FTP, or file to open

You can specify a Uniform Resource Locator (URL), a file, or a File Transfer Protocol (FTP) address. All three of these assignments are valid:

```cpp
System::String * target= "http://www.microsoft.com";
System::String * target = "ftp://ftp.microsoft.com";
System::String * target = "C:\\Program Files\\Microsoft Visual Studio\\INSTALL.HTM";
```

## Use the Process class Start method to start the browser

The `Process` class contains a static `Start` method. Because it's a static method, you can call `Start` without having an instance of a `Process` class.

```cpp
System::Diagnostics::Process::Start(target);
```

## Provide exception handling

Because you take advantage of [the default `UseShellExecute` property](/dotnet/api/system.diagnostics.processstartinfo.useshellexecute#property-value) when you call the `Start` method, you don't have to explicitly query the registry to determine which browser is the default. However, if you use this approach on a computer that doesn't have a browser installed, an exception occurs. This exception must be caught so that the appropriate action can be taken. This example explicitly traps for an error that is generated when the necessary registry key isn't found and indicates that no browser is installed. In addition, a general exception handler is provided for other errors that may occur. The `try...catch` block is demonstrated in the complete code sample.

## Complete code sample

```cpp
#using <mscorlib.dll>
#using <system.dll>
#using <System.Windows.Forms.dll>
int main()
{
    //Use no more than one assignment when you test this code.
    //System::String * target= "http://www.microsoft.com";
    //System::String * target = "ftp://ftp.microsoft.com";
    System::String * target = "C:\\Program Files\\Microsoft Visual Studio\\INSTALL.HTM";
    try
    {
        System::Diagnostics::Process::Start(target);
    }
    catch (System::ComponentModel::Win32Exception * noBrowser)
    {
        if (noBrowser->ErrorCode==-2147467259)
           System::Windows::Forms::MessageBox::Show(noBrowser->Message);
    }
    catch (System::Exception * other)
    {
        System::Windows::Forms::MessageBox::Show(other->Message);
    }
    return 0;
}
```

## Troubleshooting

This code is highly dependent on the application-file type associations in the HKEY_CLASSES_ROOT hive of the registry. Which can lead to unexpected results and exceptions if the registry is damaged. In addition, file types and extensions may be associated with applications other than the browser. For example, HTM or Hyper Text Markup Language (HTML) files may be associated with Web development software instead of the browser.
