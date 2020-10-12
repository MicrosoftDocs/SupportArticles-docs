---
title: Re-register Windows client/server in WSUS
description: Provides the steps to re-register a Windows client/server in WSUS.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Servicing
ms.technology: Deployment
---
# How to re-register Windows client/server in WSUS

This article provides the steps to re-register a Windows client/server in Windows Server Update Services (WSUS).

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 555974

## Summary

This article will help you to re-register a Windows client/server in WSUS.

## Tips

To re-register a Windows client/server in WSUS, review the following instructions:

1. Run `gpupdate /force` command on the Windows client/server that have a registration issue in WSUS.

2. Run `wuauclt /detectnow` command on the Windows client/server that have a registration issue in WSUS.

    > [!TIP]
    > You can use the Event Viewer to review the re-registration.

3. In rare cases, you may need to run `wuauclt.exe /resetauthorization /detectnow` command on the Windows client/server that have a registration issue in WSUS.

### Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained here. All such information and related graphics are provided as is without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained here, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
