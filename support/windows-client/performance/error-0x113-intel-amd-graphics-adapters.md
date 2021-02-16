---
title: Computer crashes with error code 0x113
description: Resolves an issue in which the computer crashes with error code 0x113. This issue occurs if the computer has hybrid graphic cards installed.
ms.data: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, chadbee, tidavis
ms.prod-support-area-path: Blue Screen/Bugcheck
ms.technology: windows-client-performance
---
# Stop error 0x113 if you use Intel and AMD graphics adapters on a Windows 8.1-based computer

This article provides a workaround for an issue where a computer crashes with error code 0x113.

_Original product version:_ &nbsp;Windows 8.1  
_Original KB number:_ &nbsp;2990029

## Symptoms  

Assume that you have a Windows 8.1-based computer that has a hybrid graphics configuration that uses both Intel and AMD graphics adapters. In this situation, the computer occasionally crashes when it tries to resume from standby, and you receive the following error message: Bug Check 0x113 (VIDEO_DXGKRNL_FATAL_ERROR)

## Cause

This issue occurs because the AMD driver does not support Runtime Power Management (RTPM), but the Intel driver does support RTPM.

## Workaround

To work around this issue, disable RTPM in the Intel driver.  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

Third-party information disclaimer  
The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
