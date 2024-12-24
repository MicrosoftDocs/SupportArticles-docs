---
title: Offline Installation of Windows App SDK C# Extension Fails
description: Helps resolve an error that occurs when you install the Windows App SDK C# extension for Visual Studio offline.
ms.date: 12/09/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Offline Install
---
# Offline installation of the Windows App SDK C# extension for Visual Studio fails

_Applies to:_&nbsp; Visual Studio 2022

## Symptoms

When you install the Windows App SDK C# extension for Visual Studio offline, it fails with the following error message:

```output
Install Failed
The install of 'Windows App SDK C# VS2022 Templates' was not successful for all the selected products.
For more information, click on the install log link at the bottom of the dialog.
Windows App SDK C# VS2022 Templates
One or more errors occurred.
```

:::image type="content" source="media/offline-installation-windows-app-sdk-extension/windows-app-sdk-extension-vs-2022-fail.png" alt-text="Screenshot of the error message when you install the Windows App SDK C# extension for Visual Studio 2022 offline.":::

## Resolution

To perform an offline installation of the Windows App SDK extension for Visual Studio, run the following command line:

```cmd
"C:\Program Files (x86)\Microsoft Visual Studio\Installer\resources\app\ServiceHub\Services\Microsoft.VisualStudio.Setup.Service\VSIXInstaller.exe" /noextensionpack <path to the WindowsAppSDK VSIX>
```

Replace `<path to the WindowsAppSDK VSIX>` with the actual file path of the Windows App SDK VSIX extension file. For more information, see [WinApp SDK Dev 17 Offline Install Failure](https://github.com/microsoft/WindowsAppSDK/issues/1846 ).

Additionally, you can use [Create your first WinUI 3 (Windows App SDK) project](/windows/apps/winui/winui3/create-your-first-winui3-app) to test a sample WinUI 3 project using the Windows App SDK.
