---
title: Trace and debug
description: This article describes how to trace and debug in Visual C# and provides some sample steps to explain related information.
ms.date: 10/09/2020
ms.custom: sap:Language or Compilers
ms.topic: how-to
---
# Trace and debug in Visual C sharp

This article describes how to trace and debug in Visual C# and provides some sample steps to explain related information.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 815788

## Summary

For a Microsoft Visual Basic .NET version of this article, see [Use Trace and Debug classes in Visual Basic .NET](../../visual-basic/language-compilers/trace-debug.md).  

This article refers to the .NET Framework Class Library namespace System. Diagnostics and describes how to use the `Debug` and the `Trace` classes. These classes are available in the .NET Framework. You can use these classes to provide information about the performance of an application either during application development, or after deployment to production. These classes are only one part of the instrumentation features that are available in the .NET Framework.

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need:

- Microsoft Windows
- Microsoft Visual C#

This article also assumes that you are familiar with program debugging.

## Description of technique

The steps in the [Create a Sample with the Debug Class](#create-a-sample-with-the-debug-class) section demonstrate how to create a console application that uses the `Debug` class to provide information about the program execution.

When the program is run, you can use methods of the `Debug` class to produce messages that help you to monitor the program execution sequence, to detect malfunctions, or to provide performance measurement information. By default, the messages that the `Debug` class produces appear in the Output window of the Visual Studio Integrated Development Environment (IDE).

The sample code uses the `WriteLine` method to produce a message that is followed by a line terminator. When you use this method to produce a message, each message appears on a separate line in the Output window.

When you use the `Assert` method of the `Debug` class, the Output window displays a message only if a specified condition evaluates to false. The message also appears in a modal dialog box to the user. The dialog box includes the message, the project name, and the `Debug`. Assert statement number. The dialog box also includes the following three command buttons:

- **Abort:** The application stops running.

- **Retry:** The application enters debug mode.

- **Ignore:** The application proceeds. The user must click one of these buttons before the application can continue.

You can also direct output from the `Debug` class to destinations other than the Output window. The `Debug` class has a Listeners collection that includes `Listener` objects.

Each Listener object monitors `Debug` output and directs the output to a specified target.

Each Listener in the Listener collection receives any output that the `Debug` class generates. Use the `TextWriterTraceListener` class to define `Listener` objects. You can specify the target for a `TextWriterTraceListener` class through its constructor.

Some possible output targets include the following:

- The Console window by using the `System.Console.Out` property.
- A text (.txt) file by using the `System.IO.File.CreateText("FileName.txt")` statement. After you create a `TextWriterTraceListener` object, you must add the object to the `Debug`. Listeners collection to receive `Debug` output.

## Create a sample with the Debug Class

1. Start Visual Studio or Visual C# Express Edition.
2. Create a new Visual C# Console Application project named *conInfo*. Class1 is created in Visual Studio .NET. Program.cs is created in Visual Studio 2005.
3. Add the following namespace at top in Class1 or Program.cs.

    ```csharp
    using System.Diagnostics;
    ```

4. To initialize variables to contain information about a product, add the following declaration statements to Main method:

    ```chsarp
    string sProdName = "Widget";
    int iUnitQty = 100;
    double dUnitCost = 1.03;
    ```

5. Specify the message that the class produces as the first input parameter of the `WriteLine` method. Press the **CTRL+ALT+O** key combination to make sure that the Output window is visible.

    ```csharp
    Debug.WriteLine("Debug Information-Product Starting ");
    ```

6. For readability, use the `Indent` method to indent subsequent messages in the Output window:

    ```csharp
    Debug.Indent();
    ```

7. To display the content of selected variables, use the `WriteLine` method as follows:

    ```csharp
    Debug.WriteLine("The product name is " + sProdName);
    Debug.WriteLine("The available units on hand are" + iUnitQty.ToString());
    Debug.WriteLine("The per unit cost is " + dUnitCost.ToString());
    ```

8. You can also use the `WriteLine` method to display the namespace and the class name for an existent object. For example, the following code displays the `System.Xml.XmlDocument` namespace in the Output window:

    ```csharp
    System.Xml.XmlDocument oxml = new System.Xml.XmlDocument();
    Debug.WriteLine(oxml);
    ```

9. To organize the output, you can include a category as an optional, second input parameter of the `WriteLine` method. If you specify a category, the format of the Output window message is "category: message." For example, the first line of the following code displays "Field: The product name is Widget" in the Output window:

    ```csharp
    Debug.WriteLine("The product name is " + sProdName,"Field");
    Debug.WriteLine("The units on hand are" + iUnitQty,"Field");
    Debug.WriteLine("The per unit cost is" + dUnitCost.ToString(),"Field");
    Debug.WriteLine("Total Cost is " + (iUnitQty * dUnitCost),"Calc");
    ```

10. The Output window can display messages only if a designated condition evaluates to true by using the `WriteLineIf` method of the `Debug` class. The condition to be evaluated is the first input parameter of the `WriteLineIf` method. The second parameter of `WriteLineIf` is the message that appears only if the condition in the first parameter evaluates to true.

    ```csharp
    Debug.WriteLineIf(iUnitQty > 50, "This message WILL appear");
    Debug.WriteLineIf(iUnitQty < 50, "This message will NOT appear");
    ```

11. Use the Assert method of the `Debug` class so that the Output window displays the message only if a specified condition evaluates to false:

    ```csharp
    Debug.Assert(dUnitCost > 1, "Message will NOT appear");
    Debug.Assert(dUnitCost < 1, "Message will appear since dUnitcost < 1 is false");
    ```

12. Create the `TextWriterTraceListener` objects for the Console window (tr1) and for a text file named *Output.txt* (tr2), and then add each object to the Debug Listeners collection:

    ```csharp
    TextWriterTraceListener tr1 = new TextWriterTraceListener(System.Console.Out);
    Debug.Listeners.Add(tr1);

    TextWriterTraceListener tr2 = new TextWriterTraceListener(System.IO.File.CreateText("Output.txt"));
    Debug.Listeners.Add(tr2);
    ```

13. For readability, use the `Unindent` method to remove the indentation for subsequent messages that the `Debug` class generates. When you use the `Indent` and the `Unindent` methods together, the reader can distinguish the output as group.

    ```csharp
    Debug.Unindent();
    Debug.WriteLine("Debug Information-Product Ending");
    ```

14. To make sure that each `Listener` object receives all its output, call the Flush method for the `Debug` class buffers:

    ```csharp
    Debug.Flush();
    ```

### Using the Trace Class

You can also use the `Trace` class to produce messages that monitor the execution of an application. The `Trace` and `Debug` classes share most of the same methods to produce output, including the following:

- **WriteLine**  
- **WriteLineIf**  
- **Indent**  
- **Unindent**  
- **Assert**  
- **Flush**

You can use the `Trace` and the `Debug` classes separately or together in the same application. In a Debug Solution Configuration project, both `Trace` and `Debug` output are active. The project generates output from both of these classes to all `Listener` objects. However, a Release Solution Configuration project only generates output from a `Trace` class. The Release Solution Configuration project ignores any `Debug` class method invocations.

```csharp
Trace.WriteLine("Trace Information-Product Starting ");
Trace.Indent();

Trace.WriteLine("The product name is "+sProdName);
Trace.WriteLine("The product name is"+sProdName,"Field" );
Trace.WriteLineIf(iUnitQty > 50, "This message WILL appear");
Trace.Assert(dUnitCost > 1, "Message will NOT appear");

Trace.Unindent();
Trace.WriteLine("Trace Information-Product Ending");

Trace.Flush();

Console.ReadLine();
```

## Verify that it works

1. Make sure that Debug is the current solution configuration.
2. If the **Solution Explorer** window is not visible, press the **CTRL+ALT+L** key combination to display this window.
3. Right-click **conInfo**, and then click **Properties**.
4. In the left pane of the **conInfo** property page, under the **Configuration** folder, make sure that the arrow points to **Debugging**.

    > [!NOTE]
    > In Visual C# 2005 and in Visual C# 2005 Express Edition, click **Debug** in the **conInfo** page.

5. Above the **Configuration** folder, in the **Configuration** drop-down list box, click **Active (Debug)** or **Debug**, and then click **OK**. In Visual C# 2005 and in Visual C# 2005 Express Edition, click **Active (Debug)** or **Debug** in the **Configuration** drop-down list box in the **Debug** page, and then click **Save** on the **File** menu.
6. Press **CTRL+ALT+O** to display the **Output** window.
7. Press the **F5** key to run the code. When the **Assertion Failed** dialog box appears, click **Ignore**.
8. In the **Console** window, press **ENTER**. The program should finish, and the **Output** window should display the output that resembles the following:

    ```console
    Debug Information-Product Starting
    The product name is Widget
    The available units on hand are100
    The per unit cost is 1.03
    System.Xml.XmlDocument
    Field: The product name is Widget
    Field: The units on hand are100
    Field: The per unit cost is1.03
    Calc: Total Cost is 103
    This message WILL appear
    ---- DEBUG ASSERTION FAILED ----
    ---- Assert Short Message ----
    Message will appear since dUnitcost < 1 is false
    ---- Assert Long Message ----

    at Class1.Main(String[] args) <%Path%>\class1.cs(34)

    The product name is Widget
    The available units on hand are100
    The per unit cost is 1.03
    Debug Information-Product Ending
    Trace Information-Product Starting
    The product name is Widget
    Field: The product name isWidget
    This message WILL appear
    Trace Information-Product Ending
    ```

9. The **Console** window and the *Output.txt* file should display the following output:

    ```console
    The product name is Widget
    The available units on hand are 100
    The per unit cost is 1.03
    Debug Information-Product Ending
    Trace Information-Product Starting
    The product name is Widget
    Field: The product name is Widget
    This message WILL appear
    Trace Information-Product Ending
    ```

> [!NOTE]
> The *Output.txt* file is located in the same directory as the conInfo executable (conInfo.exe). Typically, this is the \bin folder where the project source is stored. By default, this is `C:\Documents and Settings\User login\My Documents\Visual Studio Projects\conInfo\bin`. In Visual C# 2005 and in Visual C# 2005 Express Edition, the *Output.txt* file is located in the folder: `C:\Documents and Settings\User login\My Documents\Visual Studio 2005\Projects\conInfo\conInfo\bin\Debug`.

## Complete Code Listing

```csharp
using System;
using System.Diagnostics;

class Class1
{
    [STAThread]
    static void Main(string[] args)
    {
        string sProdName = "Widget";
        int iUnitQty = 100;
        double dUnitCost = 1.03;
        Debug.WriteLine("Debug Information-Product Starting ");
        Debug.Indent();
        Debug.WriteLine("The product name is "+sProdName);
        Debug.WriteLine("The available units on hand are"+iUnitQty.ToString());
        Debug.WriteLine("The per unit cost is "+ dUnitCost.ToString());

        System.Xml.XmlDocument oxml = new System.Xml.XmlDocument();
        Debug.WriteLine(oxml);

        Debug.WriteLine("The product name is "+sProdName,"Field");
        Debug.WriteLine("The units on hand are"+iUnitQty,"Field");
        Debug.WriteLine("The per unit cost is"+dUnitCost.ToString(),"Field");
        Debug.WriteLine("Total Cost is "+(iUnitQty * dUnitCost),"Calc");

        Debug.WriteLineIf(iUnitQty > 50, "This message WILL appear");
        Debug.WriteLineIf(iUnitQty < 50, "This message will NOT appear");

        Debug.Assert(dUnitCost > 1, "Message will NOT appear");
        Debug.Assert(dUnitCost < 1, "Message will appear since dUnitcost < 1 is false");

        TextWriterTraceListener tr1 = new TextWriterTraceListener(System.Console.Out);
        Debug.Listeners.Add(tr1);

        TextWriterTraceListener tr2 = new TextWriterTraceListener(System.IO.File.CreateText("Output.txt"));
        Debug.Listeners.Add(tr2);

        Debug.WriteLine("The product name is "+sProdName);
        Debug.WriteLine("The available units on hand are"+iUnitQty);
        Debug.WriteLine("The per unit cost is "+dUnitCost);
        Debug.Unindent();
        Debug.WriteLine("Debug Information-Product Ending");
        Debug.Flush();

        Trace.WriteLine("Trace Information-Product Starting ");
        Trace.Indent();

        Trace.WriteLine("The product name is "+sProdName);
        Trace.WriteLine("The product name is"+sProdName,"Field" );
        Trace.WriteLineIf(iUnitQty > 50, "This message WILL appear");
        Trace.Assert(dUnitCost > 1, "Message will NOT appear");

        Trace.Unindent();
        Trace.WriteLine("Trace Information-Product Ending");

        Trace.Flush();

        Console.ReadLine();
    }
}
```

## Troubleshoot

- If the solution configuration type is Release, the `Debug` class output is ignored.

- After you create a `TextWriterTraceListener` class for a particular target, `TextWriterTraceListener` receives output from the `Trace` and the `Debug` classes. This occurs regardless of whether you use the `Add` method of the `Trace` or the `Debug` class to add `TextWriterTraceListener` to the `Listeners` class.

- If you add a `Listeners` object for the same target in the `Trace` and the `Debug` classes, each line of output is duplicated, regardless of whether `Debug` or `Trace` generates the output.

    ```csharp
    TextWriterTraceListener myWriter = new TextWriterTraceListener(System.Console.Out);
    Debug.Listeners.Add(myWriter);

    TextWriterTraceListener myCreator = new TextWriterTraceListener(System.Console.Out);
    Trace.Listeners.Add(myCreator);
    ```

## References

- [Trace Class](/dotnet/api/system.diagnostics.trace)
- [Debug Class](/dotnet/api/system.diagnostics.debug)
- [How to: Compile Conditionally with Trace and Debug](/dotnet/framework/debug-trace-profile/how-to-compile-conditionally-with-trace-and-debug)
