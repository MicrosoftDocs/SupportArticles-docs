---
title: A black screen appears while sign-in
description: Provides a solution to an issue that a black screen may appear while sign-in by using remote desktop.
ms.date: 10/10/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Administration
ms.technology: RDS
---
# A black screen may appear while sign-in by using remote desktop

This article provides a solution to an issue that a black screen may appear while sign-in by using remote desktop.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555840

## Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event should microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained here, whether based on contract, tort, negligence, strict liability or otherwise, even if microsoft or any of its suppliers has been advised of the possibility of damages.

## Summary

The following knowledge base can help you to resolve the issue of a black screen may appear while sign-in by using remote desktop.

## Symptoms

While sign in into a remote server by using remote desktop, the following issues may occur:

1. A slow sign-in process.

2. A black screen appears for a while, until the regular desktop appear.

## Resolution

1. Disable the use of **Bitmap Caching** on the Remote Desktop Protocol (RDP) client.

2. Verity that the server, client, and the network equipment using the "**MTU**" size.

## More information

Configure bitmap caching

Troubleshooting Specific Remote Desktop problems.
