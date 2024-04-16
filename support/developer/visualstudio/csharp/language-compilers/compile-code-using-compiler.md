---
title: Compile code by using C# compiler
description: Describes how to compile code from a text source by using C# compiler.
ms.date: 04/13/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Compile code programmatically by using C# compiler

This article describes how to compile code from a text source by using C# compiler.

_Original product version:_ &nbsp; Visual Studio, .NET Framework  
_Original KB number:_ &nbsp; 304655

## Summary

The Microsoft .NET Framework exposes classes that allow you to programmatically access the C# language compiler. This might be useful if you want to write your own code-compiling utilities. This article provides sample code that enables you to compile code from a text source. The application allows you to either just build the executable or build the executable and run it. Any errors that occur during the compilation process are displayed on the form.

## Requirements

- Visual Studio
- Visual C# language compiler

## Compile code by using C# compiler

The .NET Framework provides the `ICodeCompiler` compiler execution interface. The `CSharpCodeProvider` class implements this interface and provides access to instances of the C# code generator and code compiler. The following sample code creates an instance of `CSharpCodeProvider` and uses it to get a reference to a `ICodeCompiler` interface.

```csharp
CSharpCodeProvider codeProvider = new CSharpCodeProvider();
ICodeCompiler icc = codeProvider.CreateCompiler();
```

Once you have a reference to an `ICodeCompiler` interface, you can use it to compile your source code. You'll pass parameters to the compiler by using the `CompilerParameters` class. Here is an example:

```csharp
System.CodeDom.Compiler.CompilerParameters parameters = new CompilerParameters();
parameters.GenerateExecutable = true;
parameters.OutputAssembly = Output;
CompilerResults results = icc.CompileAssemblyFromSource(parameters,SourceString);
```

The code above uses the `CompilerParameters` object to tell the compiler that you want to generate an executable file (as opposed to a DLL) and that you want to output the resulting assembly to disk. The call to `CompileAssemblyFromSource` is where the assembly gets compiled. This method takes the parameters object and the source code, which is a string. After you compile your code, you can check to see if there were any compilation errors. You use the return value from `CompileAssemblyFromSource`, which is a `CompilerResults` object. This object contains an errors collection, which contains any errors that occurred during the compile.

```csharp
if (results.Errors.Count > 0)
{
    foreach(CompilerError CompErr in results.Errors)
    {
        textBox2.Text = textBox2.Text +
            "Line number " + CompErr.Line +
            ", Error Number: " + CompErr.ErrorNumber +
            ", '" + CompErr.ErrorText + ";" +
            Environment.NewLine + Environment.NewLine;
    }
}
```

There are other options for compiling, such as compiling from a file. You can also batch compile, which means you can compile multiple files or sources at the same time.

## Step-by-step procedure example

1. Create a new Visual C# .NET Windows application. *Form1* is created by default.
2. Add a Button control to *Form1*, and then change its **Text** property to **Build**.
3. Add another Button control to *Form1*, and then change its **Text** property to **Run**.
4. Add two TextBox controls to *Form1*, set the **Multiline** property for both controls to **True**, and then size these controls so that you can paste multiple lines of text into each one.
5. In the code editor, open the *Form1.cs* source file.
6. In the `Form1` class, paste the following button click handler.

    ```csharp
    private void button1_Click(object sender, System.EventArgs e)
    {
        CSharpCodeProvider codeProvider = new CSharpCodeProvider();
        ICodeCompiler icc = codeProvider.CreateCompiler();
        string Output = "Out.exe";
        Button ButtonObject = (Button)sender;

        textBox2.Text = "";
        System.CodeDom.Compiler.CompilerParameters parameters = new CompilerParameters();
        //Make sure we generate an EXE, not a DLL
        parameters.GenerateExecutable = true;
        parameters.OutputAssembly = Output;
        CompilerResults results = icc.CompileAssemblyFromSource(parameters, textBox1.Text);

        if (results.Errors.Count > 0)
        {
            textBox2.ForeColor = Color.Red;
            foreach (CompilerError CompErr in results.Errors)
            {
                textBox2.Text = textBox2.Text +
                            "Line number " + CompErr.Line +
                            ", Error Number: " + CompErr.ErrorNumber +
                            ", '" + CompErr.ErrorText + ";" +
                            Environment.NewLine + Environment.NewLine;
            }
        }
        else
        {
            //Successful Compile
            textBox2.ForeColor = Color.Blue;
            textBox2.Text = "Success!";
            //If we clicked run then launch our EXE
            if (ButtonObject.Text == "Run") Process.Start(Output);
        }
    }
    ```

    At the beginning of the file, add these `using` statements:

    ```csharp
    using System.CodeDom.Compiler;
    using System.Diagnostics;
    using Microsoft.CSharp;
    ```

7. In *Form1.cs*, locate the `Form1` constructor.
8. After the call to `InitializeComponent` in the `Form1` constructor, add the following code to wire the button click handler to both buttons that you added to Form1.

    ```csharp
    public Form1()
    {
        InitializeComponent();
        this.button1.Click += new System.EventHandler(this.button1_Click);
        this.button2.Click += new System.EventHandler(this.button1_Click);
    }
    ```

9. Run the project. After *Form1* loads, click the **Build** button.

    > [!NOTE]
    > You get a compiler error.

10. Next, copy the following text into the textbox, replacing any existing text:

    ```csharp
    using System;
    namespace HelloWorld
    {
        /// <summary>
        /// Summary description for Class1.
        /// </summary>
        class HelloWorldClass
        {
            static void Main(string[] args)
            {
                Console.WriteLine("Hello World!");
                Console.ReadLine();
            }
        }
    }
    ```

11. Click **Build** again. The compile should be successful.
12. Click **Run**, and it will compile the code and run the resulting executable file. The compile creates an executable file called *Out.exe*, which is saved in the same folder as the application that you're running.

    > [!NOTE]
    > You can modify the code in the textbox to see different compiler errors. For example, delete one of the semi-colons and rebuild the code.

13. Lastly, modify the code in the textbox to output another line of text to the console window. Click **Run** to see the output.

## References

- [CSharpCodeProvider Class](/dotnet/api/microsoft.csharp.csharpcodeprovider)

- [ICodeCompiler Interface](/dotnet/api/system.codedom.compiler.icodecompiler)
