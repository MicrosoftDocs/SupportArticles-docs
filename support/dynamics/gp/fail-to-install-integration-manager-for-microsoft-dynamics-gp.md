---
title: Error when you install Integration Manager for Microsoft Dynamics GP
description: This article provides steps to resolve the error message when you install Integration Manager for Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, dlanglie
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Error "Failed Registering Assemblies for Com+ Application" is received when Integration Manager for Microsoft Dynamics GP 10.0 is installed

This article provides a solution to an error that occurs when you install Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970852

## Symptoms

When you install Integration Manager for Microsoft Dynamics GP 10.0, you may receive the following error when the Microsoft Dynamics eConnect adapter tries to install. The Microsoft Dynamics GP adapter will install fine but the eConnect adapter will not be installed.

> Failed Registering Assemblies for COM+ Application.

## Resolution

This error message was resolved by completely uninstalling all .NET frameworks from the computer. As soon as you have them uninstalled, then reinstall all versions of the [.NET Framework](https://dotnet.microsoft.com/download/dotnet-framework).

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
