---
title: Troubleshoot issues with IntelliSense code snippets
description: Learn how to troubleshoot problems with IntelliSense code snippets that are typically caused by bad content in the snippet file or a corrupt snippet file.
ms.date: 11/04/2016
author: aartig13
ms.author: aartigoyle
ms.reviewer: tglee
ms.custom: sap:Integrated Development Environment (IDE)\Code Editor
---
# Troubleshoot issues with IntelliSense code snippets

_Applies to:_&nbsp;Visual Studio

This article helps you troubleshoot problems with IntelliSense [code snippets](/VisualStudio/ide/code-snippets). The issues are typically caused by:

- A corrupt snippet file.
- Bad content in the snippet file.

## The snippet can't be dragged from File Explorer to a Visual Studio source file

- The XML in the snippet file may be corrupt. The **XML Editor** in Visual Studio can locate problems in the XML structure.
- The snippet file may not conform to the snippet schema. The **XML Editor** in Visual Studio can locate problems in the XML structure.

## The code has compiler errors that aren't highlighted

- You may be missing a project reference. Examine the documentation about the snippet. If the reference isn't found on the computer, you'll need to install it. Inserting a snippet should add any references needed to the project. If the snippet is missing the reference information, it can be reported to the snippet creator as an error.
- A variable may be undefined. Undefined variables in a snippet should be highlighted. If not, that can be reported to the snippet creator as an error.
