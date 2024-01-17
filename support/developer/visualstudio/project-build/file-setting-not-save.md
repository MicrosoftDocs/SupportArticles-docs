---
title: Can't save file setting in a C++ project
description: This article describes a problem that prevents you from saving a file setting in a Visual C++ project. Workarounds are provided. This problem is fixed on Visual Studio 2015.
ms.date: 04/27/2020
ms.custom: sap:Project/Build System
ms.reviewer: eddo, yaarai
---
# Can't save a file setting in a Visual C++ 2013 project

This article provide workarounds for a problem where prevents you from saving a file setting in a Visual C++ project.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 3097181

## Symptoms

Consider the following scenario:

- In a Visual C++ project in Microsoft Visual Studio 2013 Update 2 or later, you use Configuration Manager to create a configuration that's named *Release Temp*.

    > [!NOTE]
    > *Release Temp* is forward-matching with another configuration's name, for example, with a configuration that's named *Release*.

- For a .cpp file in the Visual C++ project, you set the configuration setting to *Release Temp*.
- You modify a property value for the .cpp file, and then you save it.

In this scenario, the property value change is applied not only to the *Release Temp* configuration but also to *Release*.

## Cause

Visual Studio 2013 Update 2 includes some changes in the way that property values are set in a Visual C++ project. The Visual Studio IDE searches for a configuration setting by using a configuration's name and forward-matching functionality.

Because of this change, modified property values for *Release Temp* are unexpectedly saved in *Release*, and vice versa.

## Workaround

To work around this issue, use one of the following methods:

- Don't give any configuration a name that might be a partial match with the name of another configuration.
- Use a version of Visual Studio 2013 that's earlier than Update 2 (such as the RTM version).

This problem is fixed in Visual Studio 2015.
