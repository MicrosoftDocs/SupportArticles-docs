---
title: Exception when a WPF window is displayed
description: This article provides a resolution for the problem where attempting to instantiate another WPF Window results in an unhandled exception after closing one Windows Presentation Foundation (WPF) Window.
ms.date: 05/06/2020
ms.reviewer: Tatkins
---
# System.ExecutionEngineException occurs when displaying WPF window

This article helps you resolve the problem where attempting to instantiate another WPF Window results in an unhandled exception after closing one Windows Presentation Foundation (WPF) Window.

_Original product version:_ &nbsp; Visual Studio Professional 2010  
_Original KB number:_ &nbsp; 2691806

## Symptom

You have developed a Microsoft .NET 3.5 WPF component and hosting it in a non-WPF based client application, such as a Windows Forms application or native application. The client application calls into the WPF component to instantiate and display a custom WPF Window. The first instantiation of the Windows displays as expected. However, after closing the Window and attempting to instantiate another WPF Window results in an unhandled exception.

If running the application in the Visual Studio IDE, you receive following exception and call stack:

```console
System.ExecutionEngineException: Exception of type 'System.ExecutionEngineException' was thrown.

WindowsBase.dll!MS.Internal.Invariant.FailFast(string message, string detailMessage)
WindowsBase.dll!MS.Internal.Invariant.Assert(bool condition, string invariantMessage)
PresentationFramework.dll!System.Windows.Application.GetResourceOrContentPart(System.Uri uri)
PresentationFramework.dll!System.Windows.Application.LoadComponent(object component, System.Uri resourceLocator)
WPFClassLibrary.dll!WPFClassLibrary.WPFWindow.InitializeComponent()
WPFClassLibrary.dll!WPFClassLibrary.WPFWindow.WPFWindow()
WPFClassLibrary.dll!WPFClassLibrary.WPFManager.ShowWpfWindow()
WindowsFormsApplication1.exe!WindowsFormsApplication1.Form1.button1_Click(object sender, System.EventArgs e)
```

If running the application under a native debugger, such as Windbg, you receive a breakpoint exception with the following call stack.

> eax=00000001 ebx=00000000 ecx=00000001 edx=001becbc esi=79aedfd0 edi=577ac529  
> eip=76c3280c esp=001be81c ebp=001becc8 iopl=0 nv up ei pl nz na po nc  
> cs=0023 ss=002b ds=002b es=002b fs=0053 gs=002b efl=00000202  
> KERNELBASE!DebugBreak+0x2: 76c3280c cc int 3

```console
0:000> knL
# ChildEBP RetAddr
00 001be818 797cd3a7 KERNELBASE!DebugBreak+0x2
01 001becc8 797cd6e0 mscorwks!EEPolicy::LogFatalError+0x2b5
02 001bece0 797d58f4 mscorwks!EEPolicy::HandleFatalError+0x4d
03 001bed94 577ac529 mscorwks!SystemNative::FailFast+0x142
04 001bed9c 57877ec1 WindowsBase_ni!MS.Internal.Invariant.FailFast(System.String, System.String)+0x35
05 001bedbc 55b5ea77 WindowsBase_ni!MS.Internal.Invariant.Assert(Boolean, System.String)+0x219ca1
06 001bedbc 55b5d935 PresentationFramework_ni!System.Windows.Application.GetResourceOrContentPart(System.Uri)+0x87
07 001bede4 003e0589 PresentationFramework_ni!System.Windows.Application.LoadComponent(System.Object, System.Uri)+0xc5
08 001bedfc 003e04f8 WPFClassLibrary!WPFClassLibrary.WPFWindow.InitializeComponent()+0x79
09 001bee08 003e046e WPFClassLibrary!WPFClassLibrary.WPFWindow..ctor()+0x28
0a 001bee24 003e03dc WPFClassLibrary!WPFClassLibrary.WPFManager.ShowWpfWindow()+0x76
0b 001bee34 7aec4170 WindowsFormsApplication1!WindowsFormsApplication1.Form1.button1_Click(System.Object, System.EventArgs)+0x2c
```

## Cause

The crash symptom occurs when the application calls into the `System.Windows.Application.LoadComponent` method to load a XAML file, associated with a WPF Window or UserControl. Eventually, the WPF run-time calls into `System.Windows.Application.GetResourceOrContentPart` to load resource packages associated with the current `System.Windows.Application` object.

This failure occurs because the resource packages associated with the current `System.Windows.Application` object could not be retrieved. This usually occurs because the current `System.Windows.Application` object has already been shut down, either by an explicit or implicit call to `Application.ShutDown`.

This behavior is by design.

## Resolution

When creating the instance of the `System.Windows.Application` object, set its `ShutDownMode` property to `ShutDownMode.OnExplicitShutdown`. This will only allow the `Application` object to be shut down as a result of custom code explicitly calling `Application.ShutDown`.

## More information

When the `Application.ShutDown` method is called, the WPF run-time unloads the resource packages associated with that `Application` object. At some point later, if the application does something that requires accessing the resources associated with the same `Application` object, the `System.Windows.Application.GetResourceOrContentPart` method attempts to load those resource packages, but is unable to because they were previously unloaded. When WPF detects this, it is considered a fatal condition and WPF purposely calls `System.Environment.FailFast`, which throws a `System.ExecutionEngineException` and terminates the process.

A client application is allowed to create one instance of an `System.Windows.Application` (or derived) type per AppDomain. The resources associated with that Application object are unloaded when the `Application.ShutDown` method is called. The `Application.ShutDown` method may be called explicitly by custom code, or it may be called internally by the WPF run-time based on the value of the `Application.ShutDownMode` property. By default, the `ShutDownMode` property of the `Application` object is set to `ShutDownMode.OnLastWindowClose`. This will cause the WPF run-time to shut down the `Application` object automatically after the last WPF window associated with that `Application` object has been closed. In a scenario where a client application has created an instance of a WPF `Application` object and displayed a Window and closed it, that window is deemed to be the last window closed, so WPF will automatically call `Application.ShutDown`.
