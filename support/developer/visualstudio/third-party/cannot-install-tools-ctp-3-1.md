---
title: Can't install tools for Apache Cordova CTP 3.1
description: This article describes a problem in which you can't install Visual Studio Tools for Apache Cordova CTP 3.1 in Visual Studio 2013.
ms.date: 04/27/2020
ms.custom: sap:Third Party Tools installed with Visual Studio\Other
ms.reviewer: pchapman
---
# You can't install Visual Studio Tools for Apache Cordova CTP 3.1 in Visual Studio 2013

This article helps you resolve the problem where you can't install Visual Studio Tools for Apache Cordova community technology preview (CTP) 3.1 in Microsoft Visual Studio 2013.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 3014133

## Symptoms

When you try to install Visual Studio Tools for Apache Cordova CTP 3.1, you receive the following error message:

> You must manually uninstall the older version of Visual Studio Tools for Apache Cordova (Multi Device Hybrid Apps) by using the command prompt before continuing with this installation.

Additionally, if you try to uninstall Visual Studio Tools for Apache Cordova by using **Programs and Features** in the Control Panel, the installer may report it successfully uninstalled. However, the program will remain listed in **Programs and Features** and on your hard disk.

## Resolution

To resolve this issue, follow these steps to uninstall tools for Apache Cordova CTP 3.0 and any earlier version CTP that you've installed:

1. Open a Command Prompt window as an administrator.
2. Run the following commands in the given order.

    > [!IMPORTANT]
    > The commands will terminate immediately if the matching CTP is not installed.

    ```console
    "%ProgramData%\Package Cache\{f2f851cc-42a1-41f2-a2cd-a0e4627a60cb}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={53d408db-eb91-43fb-9d8f-167681c19763};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{dc616193-a63d-4e9f-9e09-31d7e01dd13b}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={53d408db-eb91-43fb-9d8f-167681c19763};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{f2f851cc-42a1-41f2-a2cd-a0e4627a60cb}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={cf552a8c-484b-4e33-afe7-c81dfadb0cfc};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{dc616193-a63d-4e9f-9e09-31d7e01dd13b}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={cf552a8c-484b-4e33-afe7-c81dfadb0cfc};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{f2f851cc-42a1-41f2-a2cd-a0e4627a60cb}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={ee836379-0143-481a-97c9-d577d049e22a};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{dc616193-a63d-4e9f-9e09-31d7e01dd13b}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={ee836379-0143-481a-97c9-d577d049e22a};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{dea88246-f74a-4171-ad6c-d9c978bf2973}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={53d408db-eb91-43fb-9d8f-167681c19763};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{38f367f1-1468-4f16-a4c4-29747084003b}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={53d408db-eb91-43fb-9d8f-167681c19763};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{f2f64182-6e0b-4aa2-a549-5e1ccb0bcb57}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={53d408db-eb91-43fb-9d8f-167681c19763};vsupdate_KB2829760
    "%ProgramData%\Package Cache\{ba4644db-5579-4db0-9bed-df3bac7f293c}\vs2013mda_0.1.exe" /uninstall /passive /force /burn.ignoredependencies={53d408db-eb91-43fb-9d8f-167681c19763};vsupdate_KB2829760
    ```

3. Run Vs2013mda_0.3.exe again to install Visual Studio Tools for Apache Cordova CTP 3.1.
