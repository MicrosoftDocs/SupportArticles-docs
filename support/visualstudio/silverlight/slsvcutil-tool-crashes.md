---
title: SlSvcUtil tool crashes
description: This article resolves an error that may be thrown when you use the slsvcutil.exe command line tool to generate a proxy for Windows Phone.
ms.date: 04/30/2020
ms.prod-support-area-path: Silverlight
ms.reviewer: kagatlin
---
# The slsvcutil tool crashes when Silverlight 5 is installed

This article helps you resolve an error that may be thrown when you use the slsvcutil.exe command line tool to generate a proxy for Windows Phone.

_Original product version:_ &nbsp; Silverlight 5  
_Original KB number:_ &nbsp; 2694961

## Symptoms

When you attempt to use the slsvcutil.exe command line tool to generate a proxy for Windows Phone, you get an error that looks like:

> Error: An error occurred in the tool.  
> Error: Could not load file or assembly C:\Program Files (x86)\Microsoft Silverlight\5.0.61118.0\System.Runtime.Serialization.dll or one of its dependencies. This assembly is built by a runtime newer than the currently loaded runtime and cannot be loaded.

## Cause

It's caused if the developer has the Windows Phone SDK 7.1 and [Windows Phone SDK 7.1.1 Update](https://www.microsoft.com/download/details.aspx?id=29233) and Microsoft Siliverlight 5 installed on the developer computer. Silverlight 5 changes a registry key that slsvcutil relies on to determine which assemblies to load.

## Resolution

The fix is to explicitly use a config file to specify the supported runtime version. The developer should supply a config file alongside the actual slsvcutil.exe file in the Windows Phone 7.1 tools folder (for example, `C:\Program Files (x86)\Microsoft SDKs\Windows Phone\v7.1\Tools`). This config file should be named *slsvcutil.exe.config* and should have the following contents:

```xml
<?xml version ="1.0"?>
<configuration>
    <startup>
        <supportedRuntime version="v4.0"/>
        <supportedRuntime version="v2.0.50727"/>
    </startup>
</configuration>
```

After ensuring a file with these contents with the name *slsvcutil.exe.config* are in the same directory as slsvcutil.exe, then invoking slsvcutil.exe should work properly.
