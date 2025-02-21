---
title: OpenGL applications don't run on Miracast display
description: Describes a problem in Windows 10 in which OpenGL applications cannot project to a Miracast display.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, ddobyns
ms.custom:
- sap:network connectivity and file sharing\wireless (802.1x,bluetooth,miracast,mobile broadband)
- pcy:WinComm Networking
---
# OpenGL applications do not run on a Miracast wireless display in Windows 10

This article discusses an issue where OpenGL applications don't run on a Miracast wireless display in Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3083829

## Symptoms

OpenGL applications do not run on Miracast wireless display in Windows 10. This problem occurs in the following Miracast configurations:

- Windows 10 is set to project in duplicate mode, and the Miracast display is set as the primary display.
- Windows 10 is set to project in extended mode, and the OpenGL application is on the Miracast display.
- Windows 10 is set to project in second screen-only mode, and the OpenGL application is on the Miracast display.

## Cause

This problem occurs because the Miracast pipeline in Windows 10 does not yet support OpenGL applications on the Miracast video driver (MiraDisp.dll).

## Status

Microsoft has confirmed that this is a problem.
