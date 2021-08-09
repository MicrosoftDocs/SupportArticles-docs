---
title: No warning for events with Obsolete
description: Describes Visual Studio does not throw a warning during build for events marked Obsolete.
ms.date: 04/27/2020
ms.prod-support-area-path: Language or compilers
ms.reviewer: irfanahm
---
# Visual Studio does not throw a warning during build for events marked Obsolete

This article describes the issue where Microsoft Visual Studio doesn't throw a warning during build for events marked `Obsolete`.

_Original product version:_ &nbsp; Visual Studio Professional 2010, Visual Studio Premium 2012  
_Original KB number:_ &nbsp; 2832705

## Symptoms  

You have a C# Class library project with a class containing an event and you marked the event with the `Obsolete` attribute. When you add reference to this class library in other project, for example a Console application and subscribe to that event, no warning is generated in the latter project.

Typically a warning CS0618 should be generated during compilation in Visual Studio when a method, event or property is marked with the `Obsolete` attribute.

`Obsolete` attribute is applicable to all program elements except assemblies, modules, parameters or return values and works as expected.

## Cause  

This is a known issue with C# compiler.

## Status

This issue is observed in all editions of Visual Studio.
