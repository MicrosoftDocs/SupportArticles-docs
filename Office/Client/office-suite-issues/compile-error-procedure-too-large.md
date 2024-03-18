---
title: Procedure too large error when you run a VBA macro
description: Describes an issue in which you receive an error message when you run a VBA macro in a 32-bit version of an Office 2010 program. Specifically, this issue occurs when the VBA macro was created in a 64-bit version of an Office 2010 program. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: rtaylor
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# "Compile Error: Procedure too large" when you try to run a VBA macro in a 32-bit version of an Office 2010 program

## Symptoms

When you try to run a Visual Basic for Applications (VBA) macro in a 32-bit version of a Microsoft Office 2010 program, you receive the following error message:

"Compile Error: Procedure too large"

## Cause

This issue may occur because the VBA macro was created by using a 64-bit version of an Office 2010 program.

## Workaround

To resolve this issue, create the VBA macro by using a 32-bit version of an Office 2010 program.

## More Information

The 64-bit versions of the Office 2010 program enable you to write a VBA macro that can become too large to use on other computers that are running 32-bit versions of Office programs. This includes 32-bit versions of Office 2010 or earlier versions of Office. A VBA macro that was created for a 32-bit version of an Office application can run on the same 64-bit version of an Office 2010 program and most VBA macros written for the 64-bit version of a program will run on the 32-bit version of the program. However, a macro that is too large will fail together with the Visual Basic for Applications error message that is mentioned in the "Symptoms" section.

As a macro developer, you have to be aware that Visual Basic for Applications 7.0 only guarantees compatibility when the macro is moved from a 32-bit version of an Office 2010 program to a 64-bit version of an Office 2010 program. There is no compatibility when you move from a 64-bit version of an Office 2010 program to a 32-bit version of an Office 2010 program. This means that a macro created on a 32-bit version of Office 2010 can run on a 64-bit version of Office 2010, but macros created on a 64-bit version of Office 2010 may run, but are not guaranteed to run, on a 32-bit version of Office 2010. Developers who create Office 2010 macros should develop them on 32-bit versions of Office 2010 to achieve full compatibility on both 32-bit and 64-bit versions of Office 2010.
