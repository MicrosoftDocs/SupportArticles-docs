---
title: Cannot record in VDI environments Citrix or RDP
description: Provides a resolution for the issue that you can't record in a VDI environment such as Citrix or RDP.
ms.reviewer: pefelesk
ms.date: 09/13/2022
ms.subservice: power-automate-desktop-flows
---
# Can't record in a VDI environment such as Citrix or RDP

This article provides a resolution to an issue where you can't record in a Virtual desktop infrastructure (VDI) environment such as Citrix or Remote Desktop Protocol (RDP) in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4599050

## Symptoms

The desktop recorder can't identify and access the elements of an application that is only accessible through a VDI environment. This can be a Citrix, RDP or any other environment that returns an image of the desktop of the remote machine.

## Verifying issue

Power Automate for desktop is installed on the local machine, but the application that you try to automate is located in the remote machine.

## Cause

Power Automate for desktop can access the elements of a desktop application programmatically, through their accessibility application programming interface (API). However, when the application is only accessible through a VDI, then Power Automate for desktop can access only the image of the desktop of the remote machine and not the actual application that is stored locally.

## Resolution

To solve this issue, build your desktop flow manually, with surface automation instead. Common surface automation technics include Image Recognition, Mouse and Keyboard automation, and Wait for text on screen (OCR).
