---
title: Missing registry data causes issues with object model
description: Description of an error conditions attempting to access the Outlook object model, and steps to resolve them.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Developer Issues\Macros
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Missing registry information can cause problems with the Outlook object model

_Original KB number:_ &nbsp; 2827747

## Symptoms

Missing registry information can cause problems with the Outlook object model. Here is an example:

- You attempt to programmatically call into the Outlook object model, such as creating an instance of Outlook using code similar to the following:

  Set ol = CreateObject("Outlook.Application")

  When you run the code example, you receive the following error:

  > Error: ActiveX component can't create object:  
    'Outlook.Application'  
    Code: 800A01AD  
    Microsoft VBScript runtime error

## Cause

This behavior can occur if the following registry keys are missing or incomplete:

`HKEY_CLASSES_ROOT\Outlook.Application`  
`HKEY_CLASSES_ROOT\Interface\{000C0339-0000-0000-C000-000000000046}`

Note, on machines with a 32-bit version of Office and a 64-bit version of Windows, the above keypath is instead:

`HKEY_CLASSES_ROOT\Wow6432Node\Interface\{000C0339-0000-0000-C000-000000000046}`

## Resolution

To correct the behavior, run a Repair of Microsoft Office.
