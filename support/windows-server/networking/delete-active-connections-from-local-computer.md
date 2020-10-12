---
title: Delete all active connections from local computer
description: Describes how you can delete active or remembered connections on a local computer.
ms.date: 09/24/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-nirmsh
ms.prod-support-area-path: TCP/IP communications
ms.technology: Networking
---
# Delete all the active connections from local computer

This article explains how you can delete active or remembered connections on a local computer.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 556001

## Command to delete active connections

You can use the `Net Use * /delete` command to delete active connections on a local computer.

The command deletes all the active connections on local computer.

> [!NOTE]
> This command can also be used on remote computers. See the **Net help use** for more options.

### Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained here. All such information and related graphics are provided as is without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained here, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
