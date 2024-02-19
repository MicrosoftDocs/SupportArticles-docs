---
title: Computer crashes with error code 0x113
description: Resolves an issue in which the computer crashes with error code 0x113. This issue occurs if the computer has hybrid graphic cards installed.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, chadbee, tidavis
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop error 0x113 if you use Intel and AMD graphics adapters on a Windows 8.1-based computer

This article provides a workaround for an issue where a computer crashes with error code 0x113.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2990029

## Symptoms  

Assume that you have a Windows 8.1-based computer that has a hybrid graphics configuration that uses both Intel and AMD graphics adapters. In this situation, the computer occasionally crashes when it tries to resume from standby, and you receive the following error message: Bug Check 0x113 (VIDEO_DXGKRNL_FATAL_ERROR)

## Cause

This issue occurs because the AMD driver does not support Runtime Power Management (RTPM), but the Intel driver does support RTPM.

## Workaround

To work around this issue, disable RTPM in the Intel driver.  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
