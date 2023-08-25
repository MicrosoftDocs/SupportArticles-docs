---
title: Troubleshooting XAML Hot Reload
description: Fix problems that you may encounter with XAML Hot Reload.
ms.date: 03/02/2022
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: maleger
---
# Troubleshoot XAML Hot Reload

_Applies to:_&nbsp;Visual Studio 2019 and later versions

This troubleshooting guide includes detailed instructions that should resolve most issues that prevent XAML Hot Reload from working correctly.

XAML Hot Reload is supported for WPF and UWP apps. For details on operating system and tooling requirements, see [Write and debug running XAML code with XAML Hot Reload](/visualstudio/xaml-tools/xaml-hot-reload).

## If Hot Reload isn't available

If you see the message `Hot Reload is not available` in the in-app toolbar while debugging your app, follow the instructions described in this article to resolve the issue.

### Verify that XAML Hot Reload is enabled

The feature is enabled by default in Visual Studio 2019 and later versions. When you start debugging your app, make sure you see the in-app toolbar, which confirms that XAML Hot Reload is available.

Visual Studio 2019:

:::image type="content" source="media/xaml-hot-reload-troubleshooting/xaml-hot-reload-available-2019.png" alt-text="Screenshot of the 'XAML Hot Reload available' toolbar in Visual Studio 2019.":::

Visual Studio 2022:

:::image type="content" source="media/xaml-hot-reload-troubleshooting/xaml-hot-reload-available-2022.png" alt-text="Screenshot of the 'XAML Hot Reload available' toolbar in Visual Studio 2022.":::

If you don't see the in-app toolbar, then select **Debug** > **Options** > **XAML Hot Reload** from the Visual Studio menu bar. Next, in the **Options** dialog box, make sure that the **Enable XAML Hot Reload** option is selected.

:::image type="content" source="media/xaml-hot-reload-troubleshooting/xaml-hot-reload-enable-2022.png" alt-text="Screenshot of the Visual Studio Debug Options window, with the Enable XAML Hot Reload option highlighted.":::

### Verify that you use Start Debugging rather than Attach to Process

XAML Hot Reload requires that the environment variable `ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO` is set to `1` at the time application starts. Visual Studio sets the value automatically as part of the **Debug** > **Start Debugging** (or **F5**) command. If you want to use XAML Hot Reload with the **Debug** > **Attach to Process** command instead, then set the environment variable yourself.

> [!NOTE]
> To set an environment variable, use the Start button to search for _environment variable_ and choose **Edit the system environment variables**. In the dialog box that opens, choose **Environment Variables**, then add it as a user variable, and set the value to `1`. To clean up, remove the variable when you are finished debugging.

### Verify that your MSBuild properties are correct

By default, source info is included in a Debug configuration. It is controlled by MSBuild properties in your project files (such as _*.csproj_). For WPF, the property is `XamlDebuggingInformation`, which must be set to `True`. For UWP, the property is `DisableXbfLineInfo`, which must be set to `False`. For example:

WPF:

`<XamlDebuggingInformation>True</XamlDebuggingInformation>`

UWP:

`<DisableXbfLineInfo>False</DisableXbfLineInfo>`

### Verify that you're using the correct build configuration name

You must either manually set the correct MSBuild property to support XAML Hot Reload (see previous section), or you must use the default build configuration name (Debug). If you don't set the MSBuild property correctly, a custom build configuration name won't work, nor will a Release build.

### Ensure your program is not running elevated

XAML Hot Reload is not supported in apps that run elevated/run as administrator.

### Verify that your XAML file has no errors

If your XAML file shows errors in the **Error List**, then XAML Hot Reload may not work.

### Enable more thorough search to update resource references and styles in Visual Studio 2022

Setting the `XAML_HOT_RELOAD_ACCURACY_OVER_PERF` environment variable to `1` enables a more extensive search to update resource references and styles in WPF applications. Be aware that some applications, such as those that use third-party toolkits, can experience significant delays with XAML Hot Reload. When a delay occurs, a Hot Reload progress timer appears in Editor status bar.

:::image type="content" source="media/xaml-hot-reload-troubleshooting/xaml-hot-reload-long-2022.gif" alt-text="Screenshot of the 'XAML Hot Reload progress timer' in Visual Studio 2022.":::

## Known limitations

The following are known limitations of XAML Hot Reload. To work around any limitation that you run into, just stop the debugger, and then complete the operation.

| Limitation | WPF | UWP | Notes |
|---|---|---|---|
| Wiring events to controls while the app is running | Not Supported | Not supported | See error: _Ensure Event Failed_. In WPF, you can reference an existing event handler. In UWP apps, referencing an existing event handler isn't supported. |
| Creating resource objects in a resource dictionary such as in your app's Page/Window or _App.xaml_ | Supported starting in Visual Studio 2019 [version 16.2](/visualstudio/releases/2019/release-notes-v16.2) and later | Supported | Examples: </br>- Adding a `SolidColorBrush` into a resource dictionary for use as a `StaticResource`.</br>Note: Static resources, style converters, and other elements written into a resource dictionary can be applied/used while using XAML Hot Reload. Only the creation of the resource isn't supported.</br> - Changing the resource dictionary `Source` property. |
| Adding new controls, classes, windows, or other files to your project while the app is running | Not Supported | Not Supported | None |
| Managing NuGet packages (adding/removing/updating packages) | Not Supported | Not Supported | None |
| Changing data binding that uses the {x:Bind} markup extension | N/A | Supported starting in Visual Studio 2019 | This requires Windows 10 version 1809 (build 10.0.17763) and later. Not supported in Visual Studio 2017 or previous versions. |
| Changing x:Uid directives | N/A | Not Supported | None |
| Using multiple processes | Supported | Supported | Supported in Visual Studio 2019 [version 16.6](/visualstudio/releases/2019/release-notes-v16.6) and later. |
| Editing Styles in _themes\generic.xaml_ | Not Supported | Not supported | XAML Hot Reload creates new styles; the original ones are sealed. Platforms cache styles from generic.xaml after they're applied to controls, which makes them inaccessible for replacement. |

## Error messages

You might come across the following errors while using XAML Hot Reload.

| Error message | Description |
|---|---|
| Ensure Event Failed | Error indicates you're attempting to wire an event to one of your controls, which isn't supported while your application is running. |
| This change isn't supported by XAML Hot Reload and won't be applied during the debugging session. | Error indicates that the change you're attempting isn't supported by XAML Hot Reload. Stop the debugging session, make the change, and then restart the debugging session. |

If you find an unsupported scenario that you'd like to see supported, let us know by using our [Suggest a feature](/visualstudio/ide/suggest-a-feature) option.
