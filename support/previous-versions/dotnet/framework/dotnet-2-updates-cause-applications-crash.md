---
title: .NET Framework 2.0 updates cause apps to crash
description: This article provides a workaround to resolve a problem in which updates to the .NET Framework 2.0 by using Windows Update may cause some .NET Framework applications to crash.
ms.date: 06/17/2020
ms.prod-support-area-path:
ms.reviewer: leecow
---
# Updates to .NET Framework 2.0 by using Windows Update may cause some .NET Framework applications to crash

This article helps you resolve the problem that updates to Microsoft .NET Framework 2.0 by using Windows Update cause some .NET Framework applications to crash.

_Original product version:_ &nbsp; .NET Framework 2.0  
_Original KB number:_ &nbsp; 2677528

## Symptoms

Consider the following scenario:

- You install an update for .NET Framework 2.0 by using Windows Update.
- You run a .NET Framework 2.0 application, a .NET Framework 3.0 application, or a .NET Framework 3.5 application.
- You leave the computer on which your application is running idle for some time. When the computer is idle, the native images for the .NET Framework are automatically regenerated.

In this scenario, when you resume work in the .NET Framework application, the application may crash. Additionally, you may receive an error message that resembles the following one:

> Exception type: System.IO.FileLoadException  
> Message: Loading this assembly would produce a different grant set from other instances. (Exception from HRESULT: 0x80131401)

## Workaround

To work around this problem, use one of the following methods:

- Restart the application.
- Run the Native Image Generator (Ngen.exe) tool to update the native images on your computer, and then restart the application. To update the native images, at a command prompt, run the following command by using administrative credentials:

    ```console
    %WINDIR%\Microsoft.NET\Framework\v2.0.50727\ngen update
    ```

    Additionally, on a 64-bit computer, run the following command:

    ```console
    %WINDIR%\Microsoft.NET\Framework64\v2.0.50727\ngen update
    ```

## Status

Microsoft has confirmed that it's a problem.

## More information

For more information about the Ngen.exe tool, visit [Native Image Generator (Ngen.exe)](/previous-versions/dotnet/netframework-2.0/6t9t5wcf(v=vs.80))
