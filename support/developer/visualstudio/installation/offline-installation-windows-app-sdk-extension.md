---
title: Offline Installation of Windows App SDK C# Extension Failed
description: Helps resolve an error that occurs when you install the Windows App SDK C# extension for Visual Studio 2022 offline.
ms.date: 11/22/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Offline Install
---

# Offline installation of the Windows App SDK C# extension for Visual Studio 2022 failed

## Symptoms

When you install the Windows App SDK C# extension for Visual Studio 2022 offline, it fails with the following error message:

## Resolution

To perform an offline installation of the Windows App SDK extension for Visual Studio 2019, use the following command line:

```cmd
"C:\Program Files (x86)\Microsoft Visual Studio\Installer\resources\app\ServiceHub\Services\Microsoft.VisualStudio.Setup.Service\VSIXInstaller.exe" /noextensionpack <path to the WindowsAppSDK VSIX>
```

Replace `<path to the WindowsAppSDK VSIX>` with the actual file path of the Windows App SDK VSIX extension file. For more information, see [WinApp SDK Dev 17 Offline Install Failure](https://github.com/microsoft/WindowsAppSDK/issues/1846 ).

Additionally, you can use [Create your first WinUI 3 (Windows App SDK) project]/windows/apps/winui/winui3/create-your-first-winui3-app) to test a sample WinUI 3 project using the Windows App SDK.
