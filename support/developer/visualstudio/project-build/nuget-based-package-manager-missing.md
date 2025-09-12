---
title: NuGet-Based Package Manager is missing
description: This article describes a problem where NuGet-Based Microsoft Package Manager 1.5 or later isn't installed on a computer, and provides a resolution.
ms.date: 04/27/2020
ms.custom: sap:Project - Build System\Build Issues
ms.reviewer: riande
---
# NuGet-Based Microsoft Package Manager is missing or out of date

This article helps you resolve a problem where NuGet-Based Package Manager 1.5 or later isn't installed on a computer that is running Visual Studio or Visual Web Developer Express.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 2635185

## Symptoms

The following error is displayed when NuGet-Based Package Manager 1.5 or later isn't installed on a computer that is running Visual Studio or Visual Web Developer Express:

> Could not create a new [ASP.NET, ASP.NET MVC, etc.] project because the required component NuGet Package Manager is missing or out of date. Please install it and try again.

## Cause

Visual Studio or Visual Web Developer Express require NuGet 1.5 or later to be installed.

## Resolution

Update NuGet to version 1.5 or later. To do so, follow these steps:

1. Start Visual Studio or Visual Web Developer Express as an Administrator. In the **Tools** menu of Visual Studio, select **Extension Manager**.
2. In the **Extension Manager** dialog box, click the **Uninstall** button for NuGet Package Manager. If NuGet-Based Package Manager doesn't appear, NuGet isn't installed. Follow the instructions below.
3. In the **Extension Manager** dialog box, click **Restart Now**.
