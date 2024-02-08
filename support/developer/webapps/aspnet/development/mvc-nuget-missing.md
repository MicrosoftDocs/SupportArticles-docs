---
title: MVC3 NuGet Package Manager is missing
description: This article provides resolutions for the problem that you might receive the error message that could not create a new ASP.NET MVC project because the required component NuGet Package Manager is missing or out of date. Install it and try again.
ms.date: 04/07/2020
ms.custom: sap:Development
ms.reviewer: mlaing
---
# ASP.NET MVC 3 NuGet Package Manager is missing or out of date

This article helps you resolve the problem that ASP.NET MVC 3 Tools Update displays errors when Microsoft Package Manager for .NET (NuGet) 1.2 or later is not installed.

_Original product version:_ &nbsp; ASP.NET MVC 3.0  
_Original KB number:_ &nbsp; 2527621

## Symptoms

ASP.NET MVC 3 Tools Update displays the following error when Microsoft Package Manager for .NET (NuGet) 1.2 or later is not installed on a computer running Visual Studio or Visual Web Developer Express:

> Could not create a new ASP.NET MVC project because the required component NuGet Package Manager is missing or out of date. Please install it and try again.

## Cause

The ASP.NET MVC 3 project templates require the installation of NuGet 1.2 or later.

## Resolution

Update NuGet to version 1.2 or later:

1. Start Visual Studio or Visual Web Developer Express as an Administrator. In the **Tools** menu of Visual Studio, select **Extension Manager**.

2. In the **Extension Manager** dialog box, select the **Uninstall** button for NuGet Package Manager. If NuGet Package Manager doesn't appear, NuGet isn't installed. Follow the instructions under Installing NuGet.

3. In the **Extension Manager** dialog box, select **Restart Now**.
