---
title: Error in XAML or WPF designer view
description: Fixes an issue in which you receive a Cannot find resource named error when you open an XAML or WPF file in Design view in Visual Studio 2017.
ms.date: 04/20/2020
ms.prod-support-area-path: 
ms.reviewer: tatkins
---
# Cannot find resource error in XAML or WPF designer in Visual Studio 2017

This article provides information about the issue that you receive a **Cannot find resource** error when you open an eXtensible Application Markup Language (XAML) or Windows Presentation Foundation (WPF) file in Design view in Visual Studio 2017.

_Original product version:_ &nbsp; Microsoft Visual Studio 2017  
_Original KB number:_ &nbsp; 4057582

## Symptoms

When you open an XAML or WPF file in Design view in Microsoft Visual Studio 2017, you receive the following error message:

> Cannot find resource named \<Resource name\>. Resource names are case sensitive.

> [!NOTE]
>
> - The static resource keys of the UI components that display error messages in Design view can be found in the application resource dictionary.
> - This issue doesn't occur at run time.
> - This issue doesn't occur if project code is disabled.

## Cause

This issue occurs because of the interaction between the WPF runtime and a designer performance optimization that was introduced in Visual Studio 2015.

If the performance optimization is enabled, the designer waits until resources are used before it instantiates the values of the resources instead of creating all resources during designer load. This can cause a small reduction in designer load time. However, this process doesn't work well if the referenced projects are unloaded.

## Resolution

To fix this issue, follow these steps:

1. Install the latest Visual Studio 2017 update (must be later than version 15.5).

2. Set the `VSXAML_DISABLE_ON_DEMAND_RESOURCE_VALUES` environment variable to 1. To do this, run the following command at a command prompt:

    ```console
    setx VSXAML_DISABLE_ON_DEMAND_RESOURCE_VALUES 1
    ```
