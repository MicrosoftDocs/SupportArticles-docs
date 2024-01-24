---
title: Error when you configure 32-bit managed handlers
description: This article provides workarounds for the problem that occurs when you try to add a managed module or handler to a website or web application configuration through IIS Manager. You encounter an error when you try this on a 64-bit computer.
ms.date: 12/11/2020
ms.custom: sap:WWW Administration and Management
ms.reviewer: paulboc
ms.technology: www-administration-management
---
# Error when you configure 32-bit managed handlers in the IIS console

This article helps you work around the problem that occurs when you try to add a managed module or handler to a website or web application configuration through Internet Information Services (IIS) Manager.

_Original product version:_ &nbsp; Internet Information Services 8.0, Internet Information Services 8.5  
_Original KB number:_ &nbsp; 3194551

## Symptoms

Consider the following scenario:

- You want to add a managed handler or a managed module to the configuration of one of your IIS websites or web applications on an IIS web server.

- To do this, you select the target website or web application in the IIS Manager console, click the Handler mappings or Module mappings icon, and then click the **Add Managed Handler** or **Add Managed Module** links in the pane on the right side of the console.

If the server is running a 64-bit OS, and the .NET assembly that contains the managed handler or managed module implementation that you're trying to add to the handlers or modules list is an assembly compiled to target only 32-bit environments, you receive the following error message from the IIS Manager console:

> There was an error performing this operation  
Details: This method cannot be called during the application's pre-start initialization phase

## Cause

When you try to add a managed handler or managed module, the IIS Manager console builds a list of all the classes that are located in the .NET assemblies that come from the `/bin` folder of your application and their dependencies. Also in this list is any other .NET-referenced assemblies. IIS does this in order to determine which of these implements either IHttpHandler or IHttpModule interfaces, depending on whether you're dealing with handlers or modules, respectively. In order to inspect all classes from all assemblies that come from the `/bin` folder of your application, the IIS Manager console creates a child .NET application domain inside the inetmgr.exe process into which these classes will be loaded and inspected for implementation of the aforementioned interfaces.

Normally, a .NET assembly is compiled down to Microsoft Intermediary Language (MSIL) and is designed to be platform-neutral (meaning it can run on both 64-bit and 32-bit platforms). You can compile a .NET assembly to target only 32-bit platforms or only 64-bit platforms. In this case, the MSIL is further compiled down to native code that's specific for that platform's processor instruction set. When you do this, the assembly cannot load in a process that does not match the compilation's target bitness: trying to load an assembly targeting a 64-bit platform inside a 32-bit process returns an error.

Because the IIS Manager console runs inside a 64-bit process on a version of Windows that's 64-bit (by default), the child .NET application domain will be created inside a 64-bit process. There is no way for the IIS Manager console to know that some of the .NET assemblies that are inside the /bin folder of your application are compiled to target only 32-bit platforms when it tries to load them to perform the configuration changes. If an assembly targeting a 32-bit platform is encountered, the loading of assemblies in the child .NET application domain inside the inetmgr.exe process stops, and the error that's described in the [Symptoms](#symptoms) section is displayed in the IIS console.

This behavior is by design, because the IIS Manager console cannot determine the target bitness for .NET assemblies for your application. Therefore, it assumes that all assemblies are compiled down to MSIL and are platform-independent that they can run on both 32-bit and 64-bit versions of Windows.

## Workaround

To work around this issue, match the bitness of the inetmgr.exe process to the bitness of the target assembly that must be loaded inside the child .NET application domain. To do this on a 64-bit version of Windows, run the following command line from an elevated command prompt:

```console
mmc.exe /32 iis.msc 
```

This will load the Microsoft Management Console (MMC) in 32-bit mode and will also load the IIS Manager console snap-in to the MMC. Because the IIS console is now running in a 32-bit process, the .NET child application domain is created inside a 32-bit process, which will match the target bitness of the assembly that you're trying to configure as a managed handler or managed module.

## Steps to reproduce

1. Create a class that implements `IHttpModule` or `IHttpHandler` and then compile the class library project from Visual Studio to target 32-bit platforms (Platform Target: x86 in the project build settings).

1. Take the resulting .NET assembly and deploy it to the bin folder of an existing web-application or website on a 64-bit OS that also is running IIS.

1. Go into the IIS manager and attempt to add either a managed handler or managed module via the interface and you will receive the error.
