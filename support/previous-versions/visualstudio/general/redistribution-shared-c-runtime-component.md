---
title: Redistribution of shared C runtime component
description: Describes how to redistribute the shared C runtime component in Visual C++.
ms.date: 06/11/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Redistribution of the shared C runtime component in Visual C++

This article describes how to redistribute the shared C runtime component in Visual C++.

_Original product version:_ &nbsp; Visual Studio, .NET Framework  
_Original KB number:_ &nbsp; 326922

## Summary

When you build an application in Microsoft Visual Studio, and the application uses the C run-time libraries (CRT), distribute the appropriate CRT dynamic link library (DLL) from the following list with your application:

- Msvcr90.dll for Microsoft Visual C++ 2008
- Msvcr80.dll for Microsoft Visual C++ 2005
- Msvcr71.dll for Microsoft Visual C++ .NET 2003 with the Microsoft .NET Framework 1.1
- Msvcr70.dll for Microsoft Visual C++ .NET 2002 with the Microsoft .NET Framework 1.0

For Msvcr70.dll or for Msvcr71.dll, you should install the CRT DLL into your application program files directory. You may not install these files into the Windows system directories. For Msvcr80.dll and for Msvcr90.dll, you should install the CRT as Windows side-by-side assemblies.

## DLL conflict

The shared CRT DLL has been distributed by Microsoft in the past as a shared system component. It may cause problems when you run applications that are linked to a different version of the CRT on computers that don't have the correct versions of the CRT DLL installed. It's commonly referred to as the *DLL Conflict* problem.

To address this issue, the CRT DLL is no longer considered a system file, so distributing the CRT DLL with any application that relies on it. Because it's no longer a system component, install it in your applications Program Files directory with other application-specific code. Which prevents your application from using other versions of the CRT library that may be installed on the system paths.

Visual C++ .NET 2003 or Visual C++ .NET 2002 installs the CRT DLL in the System32 directory on a development system. Which is installed as a convenience for the developer. Otherwise, all projects that are built with Visual C++ that link with the shared CRT require a copy of the DLL in the build directory for debugging and execution. Visual C++ 2005 and Visual C++ 2008 install the CRT DLL as a Windows side-by-side assembly on Windows XP and later operating systems. Windows 2000 doesn't support side-by-side assemblies. On Windows 2000, the CRT DLL is installed in the System32 directory.

When you distribute applications that require the Shared CRT library in the CRT DLL, we recommend that you use the CRT.msm merge module, which is included with Visual C++ instead of directly distributing the DLL file.

## Windows side-by-side assemblies

Msvcr80.dll with Visual C++ 2005 and Msvcr90.dll with Visual C++ 2008 are redistributed as Windows side-by-side assemblies except on Windows 2000. You can install these versions of the CRT on target computers by running the Vcredist_x86.exe application that is included with Visual Studio. There are installers for the x64 and IA-64 platforms also. Instead, you can use the CRT msm merge module, which is supplied with Visual Studio to package the CRT installer into your own setup application. Which will make the CRT available as a shared assembly to all applications because it's installed in the `\windows\winsxs` directory on supported operating systems.

## References

- [Side-by-side Assemblies](/previous-versions//aa376307(v=vs.85))

- [Visual C++ Libraries as Shared Side-by-Side Assemblies](/previous-versions/ms235624(v=vs.100))

- [Troubleshooting C/C++ Isolated Applications and Side-by-side Assemblies](/cpp/build/troubleshooting-c-cpp-isolated-applications-and-side-by-side-assemblies)
