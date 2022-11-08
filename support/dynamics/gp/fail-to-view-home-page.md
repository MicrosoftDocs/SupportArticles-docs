---
title: Error when you view the home page in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you view the home page in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: kyouells
ms.date: 03/31/2021
---
# Error message when you view the home page in Microsoft Dynamics GP: "Metrics are not available because Microsoft Office Chart..."

This article provides a solution to an error that occurs when you view the home page in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916673

## Symptoms

When you view the home page in Microsoft Dynamics GP, you may receive the following error message in the **Metrics** area:

> Metrics are not available because Microsoft Office Chart...

## Cause

The problem occurs because the Microsoft Office Web Components are not installed.

> [!NOTE]
> Microsoft Dynamics GP 10.0 supports the 2007 Microsoft Office programs.

Microsoft Dynamics GP 2010 supports the 2007 Microsoft Office programs and 2010 Microsoft Office programs.

## Resolution

To resolve this problem, install the Office Web Components. If you use the 2007 Office programs, you must install the Office Web Components for Office 2003 and Office XP. If you use Office 2000, you must install the Office Web Components for Office XP.

> [!NOTE]
> The Office Web Components for Office 2007 are a service pack for the Office Web Components for Office 2003. You must install Office Web Components for Office 2003 before you install this service pack.

For the following types of systems, you can install both sets of the Web components to resolve error messages that occur on the home page:

- Systems that use Internet Explorer 7
- Systems that have several Office products installed
