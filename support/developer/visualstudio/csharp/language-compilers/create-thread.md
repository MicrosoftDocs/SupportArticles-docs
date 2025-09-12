---
title: How to create a thread by using Visual C#
description: Describes how to create a thread by using Visual C#. Contains sample steps to explain related information.
ms.date: 04/22/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to create a thread

You can write multithreaded applications in Microsoft Visual C# .NET or in Visual C#. This article describes how a simple Visual C# application can create and manage threads.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 815804

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you need:

- Windows or Windows Server
- Visual C# .NET or Visual C#

This article assumes that you are familiar with the following topics:

- Visual C# programming
- Visual Studio .NET Integrated Development Environment (IDE) or Visual Studio IDE

This article refers to the .NET Framework Class Library namespace `System.Threading`.

## Create a Visual C# application with threads

1. Start Visual Studio .NET, Visual Studio, or Visual C# Express Edition.
2. Create a new Visual C# Windows Application project named *ThreadWinApp*.
3. Add a Button control to the form. By default, the button is named *Button1*.
4. Add a ProgressBar component to the form. By default, the progress bar is named *ProgressBar1*.
5. Right-click the form, and then click **View Code**.
6. Add the following statement to the beginning of the file:

    ```cs
    using System.Threading;
    ```

7. Add the following `button1_Click` event handler for Button1:

    ```cs
    private void button1_Click(object sender, System.EventArgs e)
    {
        MessageBox.Show("This is the main thread");
    }
    ```

8. Add the following variable to the `Form1` class:

    ```cs
    private Thread trd;
    ```

9. Add the following method to the `Form1` class:

    ```cs
    private void ThreadTask ()
    {
        int stp;
        int newval;
        Random rnd = new Random ();

        while (true)
        {
            stp = this.progressBar1.Step * rnd.Next (-1, 2);
            newval = this.progressBar1.Value + stp;
            if (newval > this.progressBar1.Maximum)
                newval = this.progressBar1.Maximum;
            else if (newval < this.progressBar1.Minimum)
                newval = this.progressBar1.Minimum;
            this.progressBar1.Value = newval;
            Thread.Sleep (100);
        }
    }
    ```

    > [!NOTE]
    > This is the code that underlies the thread. This code is an infinite loop that randomly increments or decrements the value in ProgressBar1, and then waits 100 milliseconds before it continues.

10. Add the following `Form1_Load` event handler for Form1. This code creates a new thread, makes the thread a background thread, and then starts the thread.

    ```cs
    private void Form1_Load(object sender, System.EventArgs e)
    {
        Thread trd = new Thread(new ThreadStart(this.ThreadTask));
        trd.IsBackground = true;
        trd.Start();
    }
    ```

### Verify that it works

1. Build and run the application. Notice that the value in ProgressBar1 changes randomly. This is the new thread in operation.

2. To demonstrate that the main thread is independent of the thread that changes the value of ProgressBar1, click the button on the form. You receive a dialog box with the following error message:

    > This is the main thread

Wait for input. Notice that the value in ProgressBar1continues to change.

## Troubleshoot

In more complex applications, make sure that you synchronize multiple threads when you access shared variables. For more information, see the lock statement and related topics in the Visual C# .NET online help documentation.

## References

For more information, see [Thread Class](/dotnet/api/system.threading.thread).
