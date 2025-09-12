---
title: Match a pattern via regular expressions
description: This article describes how to create and use regular expressions to determine whether strings match certain patterns.
ms.date: 04/22/2020
ms.reviewer: felipeme, broder
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Match a pattern by using Visual C# and regular expressions

This step-by-step article introduces how to create and use regular expressions to determine whether strings match certain patterns.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 308252

## Summary

Regular expressions allow for easy parsing and matching of strings to a specific pattern. Using the objects available in the `RegularExpressions` namespace, you can compare a string against a given pattern, replace a string pattern with another string, or retrieve only portions of a formatted string. In this example, we will construct a pattern to validate an e-mail address. This article refers to the Microsoft .NET Framework Class Library namespace `System.Text.RegularExpressions`.

## Requirements

This article assumes that you are familiar with the following topics:

- Visual C#
- Regular expression syntax

## Use regular expressions to match a pattern

1. Start Visual C#.
2. Create a new Visual C# Console Application.
3. Specify the using keyword on the `Text.RegularExpressions` namespace so that you will not be required to qualify declarations in those namespaces later in your code. The using statement must be used prior to any other declarations:

    ```csharp
    using System.Text.RegularExpressions;
    ```

4. Define a new regular expression that will use a pattern match to validate an e-mail address. The following regular expression is structured to accomplish three things:

   1. Capture the substring before the `@` symbol and put that into the `user` group.
   2. Capture the substring after the `@` symbol and put that into the `host` group.
   3. Make sure that the first half of the string does not have an `@` symbol.

    ```csharp
    Regex emailregex = new Regex("(?<user>[^@]+)@(?<host>.+)");
    ```

5. Define a new string containing a valid e-mail address. This provides a default value if the method's command-line argument is empty:

    ```csharp
    String s = "johndoe@tempuri.org";
    ```

6. Check to see if there are any command-line parameters; if there are, retrieve the first parameter, and assign it to the variable `s`.

    ```csharp
    if (args.Length > 0) {
        s = args[0];
    }
    ```

7. Use the `Match` method to pass in the e-mail address variable and return a new `Match` object. The `Match` object will return regardless of whether any matches were found in the source string.

    ```cs
    Match m = emailregex.Match(s);
    ```

8. By examining the `Success` property, we can decide whether to continue processing the `Match` object or to print an error message. If successful, display the `user` and `host` named groups within the `Groups` collection of the `Match` object.

    ```csharp
    if (m.Success)
    {
        Console.WriteLine ("User: " + m.Groups["user"].Value);
        Console.WriteLine ("Host: " + m.Groups["host"].Value);
    }
    else
    {
        Console.WriteLine (s + " is not a valid email address");
    }
    Console.WriteLine ();
    ```

9. To keep the console window open after running the application, add the following lines of code:

    ```csharp
    System.Console.WriteLine("Press Enter to Continue...");
    System.Console.ReadLine();
    ```

10. Build your project.
11. To run the application in the development environment using the default e-mail address specified in the code, press F5 or select **Start** from the **Debug** menu. To start the application with a command-line argument, there are three options:

    - On the **Project** menu, click **Properties**, and then click **Debug**. In the **Start Options** section in the right pane, specify the e-mail address that you want to test. Press F5, or click **Start** on the **Debug** menu to run the application.
    - Start a command window and navigate to the *bin* or *debug* folder under the folder in which your project resides. Then type in the name of the executable followed by the e-mail address you wish to test.
    - Locate the executable file for this project, and drag it to the **Start...Run** window on the taskbar. Add the e-mail address to verify, and click **OK**.

## References

- [Introduction to Regular Expressions (JavaScript)](/previous-versions/6wzad2b2(v=vs.100))
- [Regular Expression Language Elements](/previous-versions/dotnet/netframework-1.1/az24scfc(v=vs.71))
