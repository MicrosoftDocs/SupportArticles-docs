---
title: Wait for shelled apps to finish by Visual C#
description: Describes how to wait for a shelled application to finish by using Visual C#. Also provides a code sample to illustrate how to do this task.
ms.date: 04/16/2020
ms.reviewer: BRODER
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to wait for a shelled application to finish

This article shows you how to use the Microsoft .NET Framework `Process` class to start another application from your code and have the code wait for the other application to close before it continues.

_Original product version:_ &nbsp; Visual C# .NET  
_Original KB number:_ &nbsp; 305369

## Summary

When the code waits for the application to finish, there are two options:

- Wait indefinitely for the other application to either finish or be closed by the user.
- Specify a time-out period after which you can close the application from your code.

This article presents two code samples that demonstrate both approaches. In addition, the time-out example allows the possibility that the other application may have stopped responding (hung) and takes the necessary steps to close the application.

This article refers to the following .NET Framework Class Library namespace `System.Diagnostics`.

## Include namespaces

You should import the namespace for the `Process` class before you run the examples that follow. Place the following line of code before the Namespace or Class declaration that contains the code sample:

```csharp
using System.Diagnostics;
```

## Wait indefinitely for the shelled application to finish

The following code sample starts another application (in this case, Notepad) and waits indefinitely for the application to close:

```csharp
//How to Wait for a Shelled Process to Finish
//Get the path to the system folder.
string sysFolder=
Environment.GetFolderPath(Environment.SpecialFolder.System);
//Create a new process info structure.
ProcessStartInfo pInfo = new ProcessStartInfo();
//Set the file name member of the process info structure.
pInfo.FileName = sysFolder + @"\eula.txt";
//Start the process.
Process p = Process.Start(pInfo);
//Wait for the window to finish loading.
p.WaitForInputIdle();
//Wait for the process to end.
p.WaitForExit();
MessageBox.Show("Code continuing...");
```

## Provide a time-out for the shelled application

The following code sample sets a time-out for the shelled application. The time-out for the example is set to 5 seconds. You may want to adjust this number (which is calculated in milliseconds) for your testing.

```csharp
//Set a time-out value.
int timeOut=5000;
//Get path to system folder.
string sysFolder=
    Environment.GetFolderPath(Environment.SpecialFolder.System);
//Create a new process info structure.
ProcessStartInfo pInfo = new ProcessStartInfo();
//Set file name to open.
pInfo.FileName = sysFolder + @"\eula.txt";
//Start the process.
Process p = Process.Start(pInfo);
//Wait for window to finish loading.
p.WaitForInputIdle();
//Wait for the process to exit or time out.
p.WaitForExit(timeOut);
//Check to see if the process is still running.
if (p.HasExited == false)
    //Process is still running.
    //Test to see if the process is hung up.
    if (p.Responding)
        //Process was responding; close the main window.
        p.CloseMainWindow();
    else
        //Process was not responding; force the process to close.
        p.Kill();
    MessageBox.Show("Code continuing...");
```

## Troubleshooting

Sometimes it may be difficult to choose between these two options. The primary purpose of a time-out is to prevent your application from hanging because the other application has hung. Time-outs are better suited for a shelled application that performs background processing, in which the user may not know the other application has stalled or doesn't have a convenient way to close it.
