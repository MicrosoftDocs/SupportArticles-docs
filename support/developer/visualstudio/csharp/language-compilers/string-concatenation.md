---
title: Improve string concatenation performance in C#
description: Describes the benefits of using the StringBuilder class over traditional concatenation techniques.
ms.date: 04/16/2020
ms.reviewer: BRODER
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to improve string concatenation performance

This article provides information about how to improve string concatenation performance in Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 306822

## Summary

This article shows the benefits of using the `StringBuilder` class over traditional concatenation techniques. Strings in the Microsoft .NET Framework are invariant (that is, the referenced text is read-only after the initial allocation). It provides many performance benefits and poses some challenges to the developer who is accustomed to C/C++ string manipulation techniques.

This article refers to the .NET Framework Class Library namespace `System.Text`.

## Description of strings in the .NET Framework

One technique to improve string concatenation over `strcat()` in Visual C/C++ is to allocate a large character array as a buffer and copy string data into the buffer. In the .NET Framework, a string is immutable, it can't be modified in place. The C# `+` concatenation operator builds a new string and causes reduced performance when it concatenates large amounts of text.

However, the .NET Framework includes a `StringBuilder` class that is optimized for string concatenation. It provides the same benefits as using a character array in C/C++, and automatically growing the buffer size (if needed) and tracking the length for you. The sample application in this article demonstrates the use of the `StringBuilder` class and compares the performance to concatenation.

## Build and run a demonstration application

1. Start Visual Studio, and then create a new Visual C# Console application.
2. The following code uses the `+=` concatenation operators and the `StringBuilder` class to time 5,000 concatenations of 30 characters each. Add this code to the main procedure.

    ```csharp
    const int sLen = 30, Loops = 5000;
    int i;
    string sSource = new String('X', sLen);
    string sDest = "";

    // Time string concatenation.
    var stopwatch = System.Diagnostics.Stopwatch.StartNew();
    for (i = 0; i < Loops; i++) sDest += sSource;
    stopwatch.Stop();
    Console.WriteLine($"Concatenation took {stopwatch.ElapsedMilliseconds} ms.");

    // Time StringBuilder.
    stopwatch.Restart();
    System.Text.StringBuilder sb = new System.Text.StringBuilder((int)(sLen * Loops * 1.1));
    for (i = 0; i < Loops; i++) 
        sb.Append(sSource);
    sDest = sb.ToString();
    stopwatch.Stop();
    Console.WriteLine($"String Builder took {stopwatch.ElapsedMilliseconds} ms.");

    // Make the console window stay open
    // so that you can see the results when running from the IDE.
    Console.WriteLine();
    Console.Write("Press Enter to finish ... ");
    Console.Read();
    ```

3. Save the application. Press F5 to compile and then run the application. The console windows should display output similar to the  examples:

    ```console
    Concatenation took 348 ms.
    String Builder took 0 ms.
    Press ENTER to finish...
    ```

4. Press ENTER to stop running the application and to close the console window.

## Troubleshooting

- If you are in an environment that supports streaming the data, such as in an ASPX Web Form or your application is writing the data to disk, consider avoiding the buffer overhead of concatenation or the `StringBuilder`, and write the data directly to the stream through the `Response.Write` method or the appropriate method for the stream in question.

- Try to reuse the existing `StringBuilder class` rather than reallocate each time you need one. Which limits the growth of the heap and reduces garbage collection. In either case, using the `StringBuilder` class makes more efficient use of the heap than using the `+` operator.

## References

The `StringBuilder` class contains many other methods for in-place string manipulation that aren't described in this article. For more information, search for `StringBuilder` in the Online Help.
