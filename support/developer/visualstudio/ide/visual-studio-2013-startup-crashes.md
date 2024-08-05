---
title: Visual Studio 2013 crashes at startup
description: This article provides information about resolving a problem that Visual Studio 2013 crashes at startup because of CLR runtime settings repeatedly.
ms.date: 04/27/2020
ms.custom: sap:Integrated Development Environment (IDE)\Other
ms.reviewer: Selma Ikiz
---
# Visual Studio 2013 crashes at startup because of CLR runtime settings

This article helps you resolve a problem where Microsoft Visual Studio 2013 crashes at startup because of common language runtime (CLR) runtime settings.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2979939

## Symptoms

This problem may occur after you make changes to the DevEnv.Exe.Config (or its express equivalent) file. The changes are unsupported and can introduce instabilities into Visual Studio. So you shouldn't make any changes to the configuration files unless directed by a Microsoft support engineer to do it.

## Resolution

To resolve this problem, remove the entries that you changed from the configuration file. For example, you can remove the CLR setting entry `NetFx40_LegacySecurityPolicy` that is known to crash Microsoft Visual Studio 2013 in the configuration file.

You can find the configuration files (\<**App Id**>.exe.config) under the following folders:

- `%PROGRAMFILES%\Microsoft Visual Studio 12.0\Common7\IDE`
- `%ProgramFiles(x86)%\Microsoft Visual Studio 12.0\Common7\IDE`
- `%LOCALAPPDATA%\Microsoft\VisualStudio\12.0`

## Status

Microsoft has confirmed that this is a problem in the products that are listed in the **Applies to** section below.

## Applies to

- Visual Studio Ultimate 2013
- Visual Studio Premium 2013
- Visual Studio Professional 2013
- Visual Studio Express 2013 for Web
- Visual Studio Express 2013 for Windows
