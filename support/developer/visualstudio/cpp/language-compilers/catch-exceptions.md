---
title: How to catch exceptions in Visual C++
description: Describes how to use a try-catch-finally block to catch an exception. A try-catch-finally block is a wrapper that you put around any code where an exception might occur.
ms.date: 04/22/2020
ms.custom: sap:Language or Compilers\C++
ms.topic: how-to
---
# Catch exceptions in Visual C++

This article describes how to use a `try-catch-finally` block to catch an exception.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 815662

## Summary

A `try-catch-finally` block is a wrapper that you put around any code where an exception might occur. Catching and dealing with exceptions are standard programming tasks.

A `try-catch-finally` block is made up of the following sections:

- Any code that may throw an exception is placed inside the try block.
- If an exception is thrown, the `catch` block is entered, and the program can do the appropriate operation to recover or to alert the user.
- The code in the `finally` block is always executed and can do clean up after an exception occurs. The `finally` block is optional.

This article refers to the following Microsoft .NET Framework Class Library namespaces: `System.IO` and `System.Security`.

## Catch exceptions in Visual C++ .NET

1. Start Visual Studio .NET.
2. On the **File** menu, point to **New**, and then click **Project**.
3. In Visual C++, click **Visual C++** under **Project Types**, and then click **CLR Console Application** under **Templates**.
4. In the **Name** box, type *Q815662*, and then click **OK**.
5. Replace all the code in the *Q815662.cpp* code window with the following code. The code declares and initializes three variables. The initialization of *k* causes an error.

    ```cpp
    #include "stdafx.h"
    #using <mscorlib.dll>
    #include <tchar.h>
    using namespace System;
    void _tmain(void)
    {
        Console::WriteLine("We're going to divide 10 by 0 and see what happens...");
        Console::WriteLine();
        int i = 10;
        int j = 0;
        int k = i/j; //Error on this line.
    }
    ```

6. Press F5. You receive a `System.DivideByZeroException` exception.
7. Wrap a `try-catch` statement around your code to capture the error. The following code catches all errors that are thrown in the code and displays a generic error message. Replace the code in the *Q815662.cpp* code window with the following code:

    ```cpp
    #include "stdafx.h"
    #using <mscorlib.dll>
    #include <tchar.h>
    using namespace System;
    void _tmain(void)
    {
        try
        {
            Console::WriteLine("We're going to divide 10 by 0 and see what happens...");
            Console::WriteLine();
            int i = 10;
            int j = 0;
            int k = i/j; //Error on this line.
        }
        catch(...)
        {
            Console::WriteLine("An error occurred.");
        }
    }
    ```

8. Press CTRL+F5 to run the application.

    > [!NOTE]
    > The error message from the `catch` block is displayed instead of the system exception error message.

9. If you must do clean up or post-processing regardless of an error, use the `__finally` part of the `try-catch-finally` statement. The code in the finally part of the statement is always executed, regardless of an exception. The following code displays the following message in the console, even if no error occurred:

    ```console
    This statement is always printed.  
    ```

    Replace the code in the *Q815662.cpp* code window with the following code:

    ```cpp
    #include "stdafx.h"
    #using <mscorlib.dll>
    #include <tchar.h>
    using namespace System;
    void _tmain(void)
    {
        try
        {
            Console::WriteLine("We're going to divide 10 by 0 and see what happens...");
            Console::WriteLine();
            int i = 10;
            int j = 0;
            int k = i/j; //Error on this line.
        }
        catch(...)
        {
            Console::WriteLine("An error occurred.");
        }
        __finally //This section is performed regardless of the above processing.
        {
            Console::WriteLine();
            Console::WriteLine("This statement is always printed");
        }
    }
    ```

10. Press CTRL+F5 to run the project.
11. You can use the exception object with the catch statement to retrieve details about the exception. An exception object has a number of properties that can help you to identify the source, and has stack information about an exception. This information can be useful to help track down the original cause of the exception, or can provide a better explanation of its source. The following sample catches an exception and gives a specific error message. Replace the code in the *Q815662.cpp* code window with the following code:

    ```cpp
    #include "stdafx.h"
    #using <mscorlib.dll>
    #include <tchar.h>
    using namespace System;
    using namespace System::Reflection;
    void _tmain(void)
    {
        try
        {
            Console::WriteLine("We're going to divide 10 by 0 and see what happens...");
            Console::WriteLine();
            int i = 10;
            int j = 0;
            int k = i/j; //Error on this line.
        }
        catch(Exception *e)
        {
            Console::WriteLine("An error occurred.");
            Console::WriteLine(e->Message); // Print the error message.
            Console::WriteLine(e->StackTrace); //String that contains the stack trace for this exception.
        }
        __finally //This section is performed regardless of the above processing.
        {
            Console::WriteLine();
            Console::WriteLine("This statement is always printed");
        }
        Console::ReadLine();
    }
    ```

12. Until this point, you've dealt with a non-specific exception. However, if you know in advance what kind of exception is going to occur, you can catch the expected exception, and process it accordingly. Use the multiple catch blocks that are described in the following code to catch all other exceptions and deal with them:

    ```cpp
    #include "stdafx.h"
    #using <mscorlib.dll>
    #include <tchar.h>
    using namespace System;
    using namespace System::IO;
    using namespace System::Security;
    void _tmain(void)
    {
        try
        {
            File::Create("c:\\temp\\testapp.txt"); //Can fail for a number of resons
        }
        // This error may occur if the temp folder does not exist.
        catch(IOException *ioe)
        {
            Console::WriteLine("An IOException exception occurred!");
            Console::WriteLine(ioe->ToString());
        }
        // You do not have the appropriate permission to take this action.
        catch(SecurityException *se)
        {
            Console::WriteLine("An SecurityException exception occur")
        }
        // Catch all exceptions
        catch(Exception *e)
        {
            Console::WriteLine(e->ToString());
        }
    }
    ```

    Because computer configurations may be different, the sample in this step may or may not throw an exception. If you want to force an input/output (IO) exception, change the file path to a folder that doesn't exist on your computer.
