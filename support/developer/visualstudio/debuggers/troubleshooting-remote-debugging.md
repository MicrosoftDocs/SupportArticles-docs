---
title: Troubleshoot remote debugging
description: Learn how to resolve some of the common issues with remote debugging.
ms.date: 08/03/2022
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: mikejo
ms.custom: sap:Debuggers and Analyzers\Visual Studio Remote Debugger
---
# Troubleshoot remote debugging

_Applies to:_&nbsp;Visual Studio

This article introduces troubleshooting steps and solutions of some common issues with [remote debugging](/visualstudio/debugger/remote-debugging).

To troubleshoot remote debugging issues, the first step is to check for error messages and investigate. The message may include a link with more information.

Next, verify that the app is running correctly on the server before trying to debug it.

Otherwise, here are the most common issues and solutions:

## Incorrect version of the remote debugger installed

For scenarios where you manually install the remote debugger on a remote machine, make sure the installed version matches your version of Visual Studio. For current links to download the remote debugger, see [Remote Debugger](/visualstudio/debugger/remote-debugging).

## A release build is deployed to the server instead of a debug build

The Publish tool and some other publishing options have a separate debug configuration setting that you need to set. (You may be choosing a debug build when you run the app in Visual Studio, but that doesn't mean you installed a debug build on the server.)

## You can attach to the remote application, but you can't hit breakpoints (or debugging symbols won't load)

For this issue, you may see a message **No symbols are loaded**.

Use the [Modules window](/visualstudio/debugger/how-to-use-the-modules-window) to find out the symbol loading status for your module, and which modules the debugger is treating as user code, or [My Code](/visualstudio/debugger/just-my-code).

- The **Symbol Status** column indicates whether symbols loaded correctly for the module.
- The **User code** column indicates whether the module you're trying to debug is classified as My Code. If it's showing incorrectly as My Code, you probably have a release build deployed to the server. Release binaries are optimized and are never considered as My Code, so either disable Just My Code or deploy a debug build to the server.
- If the **User code** setting is correct, but symbols aren't loaded, verify that the debugger is using the correct symbol files. The debugger only loads symbols (.pdb files) that exactly match the .pdb files created when an app was built (that is, the original .pdb files or copies). For remote Windows debugging, by default PDB files are read on the Visual Studio machine and not from the server. (However, msvsmon has a command line argument to enable falling back to remote .pdb files.)

For more information, see [Troubleshoot breakpoints](./troubleshooting-breakpoints.md).

## (ASP.NET) The version of ASP.NET running on the server isn't the same as the version configured for your app

You may need to install the correct version of ASP.NET or ASP.NET Core on either the server or on your local machine. To check your app version of ASP.NET, right click the project in Solution Explorer and choose **Properties**. Check the Build tab. The configuration of ASP.NET on the server is specific to the scenario. For ASP.NET Framework apps, you may need to set the framework version in your _web.config_ file.

## You don't see the process you need in the Attach to Process dialog box

Some scenarios require you to manually attach to the correct process. If you're using [Attach to Process](/visualstudio/debugger/attach-to-running-processes-with-the-visual-studio-debugger) for your scenario, and don't see the process you're expecting:

- If the search process filter was previously set, check if you need to clear it.
- Select **Show processes for all users** to show processes running under other user accounts.
- For slow connections, you might want to disable the **Automatic refresh**.
- If they're changed from defaults, the **Connection type** and **Attach to** fields may limit which processes appear in the list.

## You aren't attaching to the correct process

If you're using attach to process, make sure you're attaching to the correct process. For more information, see [Common debugging scenarios](/visualstudio/debugger/attach-to-running-processes-with-the-visual-studio-debugger#common-debugging-scenarios).

## A required port isn't open

In most ASP.NET setups, required ports are opened by the installation of ASP.NET and the remote debugger. However, you may need to verify that ports are open. For example, in Azure VM scenarios, you probably need to open the [remote debugger port](/visualstudio/debugger/remote-debugger-port-assignments) and the server port (for example, IIS uses port 80).

## Elevated privileges for the remote debugger may be required

In some scenarios, you may need to run the remote debugger as an Administrator. For more information, see [Run the remote debugger as an administrator](/visualstudio/debugger/remote-debugging-errors-and-troubleshooting#run-the-remote-debugger-as-an-administrator).
