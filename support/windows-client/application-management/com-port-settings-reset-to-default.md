---
title: Com port settings reset to default after making changes in Device Manager
description: Describes an issue where the communications port (COM port) settings revert to the default when you restart the computer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:com-and-com+-performance-and-stability, csstroubleshoot
---
# Com port settings reset to default after making changes in Device Manager

This article describes an issue where the communications port (COM port) settings revert to the default when you restart the computer.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 293762

## Symptoms

When you restart the computer, communications port (COM port) settings revert to the default. This issue occurs even though you've changed the settings in Device Manager. For example, if you run a command prompt in Windows 2000, you may notice that the default settings for com 1 are:

`Baud rate=1200; Parity=None; Data Bits=7; Stop Bits=1`

You may have a program that requires different settings, such as:

`Baud rate=9600; Parity=None; Data Bits=8; Stop Bits=1`

You can manually set com 1 to function at the settings you want by using this command:

`Mode Com1: 9600,n,8,1`  

However, when you restart the system, you find that the setting reverts back to the default:

`Baud rate=1200; Parity=None; Data Bits=7; Stop Bits=1`

## Cause

In Microsoft Windows 2000, COM port settings for command functions are maintained only for the active Windows session. Custom settings are discarded at shutdown.

## Resolution

To resolve this issue, create a startup task that sets the COM port to the settings that you want. The task can be set to run minimized with the **close window on exit** setting selected.

A sample shortcut has this command line:

`C:\winnt\system32\mode.com com1: 9600,n,8,1`
