---
title: Convert from System String to Char
description: "This article describes several ways to convert from System::String* to char* by using managed extensions in Visual C++."
ms.date: 10/10/2020
ms.custom: sap:Language or Compilers\C#
ms.topic: how-to
---
# Convert from System::String to Char in Visual C++  

This article describes several ways to convert from `System::String*` to `char*` by using managed extensions in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 311259

## Summary

This article refers to the following Microsoft .NET Framework Class Library namespaces:

- `System::Runtime::InteropServices`
- `Msclr::interop`

This article discusses several ways to convert from `System::String*` to `char*` by using the following:

- Managed extensions for C++ in Visual C++ .NET 2002 and in Visual C++ .NET 2003
- C++/CLI in Visual C++ 2005 and in Visual C++ 2008

## Method 1

`PtrToStringChars` gives you an interior pointer to the actual `String` object. If you pass this pointer to an unmanaged function call, you must first pin the pointer to ensure that the object does not move during an asynchronous garbage collection process:

```c++
//#include <vcclr.h>
System::String * str = S"Hello world\n";
const __wchar_t __pin * str1 = PtrToStringChars(str);
wprintf(str1);
```

## Method 2

`StringToHGlobalAnsi` copies the contents of a managed `String` object into native heap, and then converts it into American National Standards Institute (ANSI) format on the fly. This method allocates the required native heap memory:

```c++
//using namespace System::Runtime::InteropServices;
System::String * str = S"Hello world\n";
char* str2 = (char*)(void*)Marshal::StringToHGlobalAnsi(str);
printf(str2);
Marshal::FreeHGlobal(str2);
```

> [!NOTE]
> In Visual C++ 2005 and in Visual C++ 2008, you must add the common language runtime support compiler option (**/clr:oldSyntax**) to successfully compile the previous code sample. To add the common language runtime support compiler option, follow these steps:

1. Click **Project**, and then click **ProjectName Properties**.

   > [!NOTE]
   > ProjectName is a placeholder for the name of the project.

2. Expand **Configuration Properties**, and then click **General**.

3. In the right pane, click to select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** in the **Common Language Runtime support** project settings.

4. Click **Apply**, and then click **OK**.

For more information about common language runtime support compiler options, visit the following Microsoft Developer Network (MSDN) Web site:

[/clr (Common Language Runtime Compilation)](/cpp/build/reference/clr-common-language-runtime-compilation)

These steps apply to the whole article.

## Method 3

The VC7 `CString` class has a constructor that takes a managed String pointer and loads the `CString` with its contents:

```c++
//#include <atlstr.h>
System::String * str = S"Hello world\n";
CString str3(str);
printf(str3);
```

## Method 4

Visual C++ 2008 introduces the `marshal_as<T>` marshal help class and the `marshal_context()` marshal helper class.

```c++
//#include <msclr/marshal.h>
//using namespace msclr::interop;
marshal_context ^ context = gcnew marshal_context();
const char* str4 = context->marshal_as<const char*>(str);
puts(str4);
delete context;
```

> [!NOTE]
> This code does not compile by using managed extensions for C++ in Visual C++ .NET 2002 or in Visual C++ .NET 2003. It uses the new C++/CLI syntax that was introduced in Visual C++ 2005 and the new msclr namespace code that was introduced in Visaul C++ 2008. To successfully compile this code, you must use the /clr C++ compiler switch in Visual C++ 2008.

## Managed Extensions for C++ sample code (Visual C++ 2002 or Visual C++ 2003)

```c++
//compiler option: cl /clr
#include <vcclr.h>
#include <atlstr.h>
#include <stdio.h>
#using <mscorlib.dll>
using namespace System;
using namespace System::Runtime::InteropServices;

int _tmain(void)
{
    System::String * str = S"Hello world\n";

    //method 1
    const __wchar_t __pin * str1 = PtrToStringChars(str);
    wprintf(str1);

    //method 2
    char* str2 = (char*)(void*)Marshal::StringToHGlobalAnsi(str);
    printf(str2);
    Marshal::FreeHGlobal(str2);

    //method 3
    CString str3(str);
    wprintf(str3);

    return 0;
}
```

### C++/CLI sample code (Visual C++ 2005 and Visual C++ 2008)

```c++
//compiler option: cl /clr

#include <atlstr.h>
#include <stdio.h>
#using <mscorlib.dll>

using namespace System;
using namespace System::Runtime::InteropServices;

#if _MSC_VER > 1499 // Visual C++ 2008 only
#include <msclr/marshal.h>
using namespace msclr::interop;
#endif

int _tmain(void)
{
    System::String ^ str = "Hello world\n";

    //method 1
    pin_ptr<const wchar_t> str1 = PtrToStringChars(str);
    wprintf(str1);

    //method 2
    char* str2 = (char*)Marshal::StringToHGlobalAnsi(str).ToPointer();
    printf(str2);
    Marshal::FreeHGlobal((IntPtr)str2);

    //method 3
    CString str3(str);
    wprintf(str3);

    //method 4
    #if _MSC_VER > 1499 // Visual C++ 2008 only
    marshal_context ^ context = gcnew marshal_context();
    const char* str4 = context->marshal_as<const char*>(str);
    puts(str4);
    delete context;
    #endif

    return 0;
}

```
