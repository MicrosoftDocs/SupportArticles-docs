---
title: Troubleshoot Class Designer errors
description: Learn how to resolve Class Design errors by dragging the modified or relocated source code to the class diagram again to display it.
ms.date: 11/04/2016
f1_keywords:
- vs.classdesigner.CPlusPlusViewInDiagramNoTypeFound
- vs.classdesigner.CPlusPlusNoTypeFound
- vs.classdesigner.CannotShowBaseType
- vs.classdesigner.MatchOrphanTypesAtLoad
- vs.classdesigner.CannotShowType
- vs.classdesigner.AssociationTypeNotFoundError
- vs.classdesigner.ViewInDiagramNoTypesFound
- vs.classdesigner.CannotImplementInterface
- vs.classdesigner.CannotShowImplementedInterface
- vs.classdesigner.ViewInDiagramUnparsableTypeFound
- vs.classdesigner.AssociationTypeNotFound
- vs.classdesigner.CPlusPlusTypeCannotBeAdded
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: tglee
ms.custom: sap:Integrated Development Environment (IDE)\Designers (WPF, WinForms, XAML, etc.)
---
# Class Designer errors

_Applies to:_&nbsp;Visual Studio

This article introduces how to resolve Class Designer issues in Visual Studio.

## Symptoms

After you modify the source type of a typedef, base classes, or association types, you might receive the following error:

> Class Designer is unable to display this type.

## Cause

**Class Designer** does not track the location of your source files, so modifying your project structure or moving source files in the project can cause **Class Designer** to lose track of the type.

## Resolution

To resolve the error, drag the modified or relocated source code to the class diagram again to display it.

## Resources

You can find assistance with other errors and warnings in the following resources:

- [Work with Visual C++ code](/visualstudio/ide/class-designer/working-with-visual-cpp-code) includes troubleshooting information about displaying C++ in a class diagram.
- [Visual Studio Class Designer forum](https://social.msdn.microsoft.com/Forums/en-US/home?forum=vsclassdesigner) provides a forum for questions about **Class Designer**.

## References

- [Design and view classes and types](/visualstudio/ide/class-designer/designing-and-viewing-classes-and-types)
