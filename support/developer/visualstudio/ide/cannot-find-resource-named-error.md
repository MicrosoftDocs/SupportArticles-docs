---
title: Error in the XAML or WPF designer view
description: This article resolves an error (Cannot find resource named) when you open an XAML or WPF file in Design view in Visual Studio 2017.
ms.date: 04/20/2020
ms.reviewer: tatkins
ms.custom: sap:Integrated Development Environment (IDE)\Designers (WPF, WinForms, XAML, etc.)
---
# Error (Cannot find resource) in Visual Studio 2017 XAML or WPF designer

This article helps you resolve an error (Cannot find resource) that occurs when you open an Extensible Application Markup Language (XAML) or Windows Presentation Foundation (WPF) file in Design view in Visual Studio 2017.

_Original product version:_ &nbsp; Visual Studio 2017  
_Original KB number:_ &nbsp; 4057582

## Symptoms

When you open an XAML or WPF file in Design view in Microsoft Visual Studio 2017, you receive the following error message:

> Cannot find resource named \<Resource name\>. Resource names are case sensitive.

> [!NOTE]
>
> - The static resource keys of the UI components that display error messages in Design view can be found in the application resource dictionary.
> - This issue doesn't occur at run time.
> - This issue doesn't occur if project code is disabled.

## Cause

This problem occurs because of the interaction between the WPF runtime and a designer performance optimization that was introduced in Visual Studio 2015.

If the performance optimization is enabled, the designer waits until resources are used before it instantiates the values of the resources instead of creating all resources during designer load. This can cause a small reduction in designer load time. However, this process doesn't work well if the referenced projects are unloaded.

## Resolution

To fix this problem, follow these steps:

1. Install the latest Visual Studio 2017 update (must be later than version 15.5).

2. Set the `VSXAML_DISABLE_ON_DEMAND_RESOURCE_VALUES` environment variable to 1. To do this, run the following command at a command prompt:

    ```console
    setx VSXAML_DISABLE_ON_DEMAND_RESOURCE_VALUES 1
    ```
