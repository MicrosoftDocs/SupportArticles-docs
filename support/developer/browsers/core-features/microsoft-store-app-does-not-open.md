---
title: Microsoft Store app does not open
description: This article provides a workaround for the problem where the Microsoft Store device app does not open.
ms.date: 01/21/2021
ms.custom: sap:Core Features
ms.reviewer: 
ms.topic: troubleshooting
---
# Microsoft Store app does not open from Internet Explorer print menu on Windows 8.1

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you work around the problem where the Microsoft Store device app does not open.

_Applies to:_ &nbsp; Windows 8.1, Windows 8.1 Enterprise, Windows 8.1 Pro  
_Original KB number:_ &nbsp; 3079382

## Symptoms

Consider the following scenario:

- You have a Windows 8.1-based system that has a third-party Microsoft Store device app installed.
- The system has a custom paper form.
- You open Internet Explorer and try to print a webpage through the Charms menu (**Devices** > **Print**).
- You select the printer for which the custom paper form is set.
- When the Internet Explorer print menu appears, you select **More Settings** to start the Microsoft Store device app.

In this scenario, the Microsoft Store device app does not open. Instead, the Internet Explorer print menu reappears.

## Cause

The Microsoft Store device app does not open because of an incorrect size calculation in Internet Explorer.

## Workaround

This is a known issue with Windows 8.1 and Internet Explorer.

To work around this issue, reduce the margins of the custom paper form to increase the printable area.
