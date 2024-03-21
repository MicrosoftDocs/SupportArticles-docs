---
title: Error 0x000000D1 when you enabled storage controller
description: Discusses that Windows Server 2012 R2 runs a bugcheck and you receive Step error 0x000000D1 when you enable a storage controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jaysenb
ms.custom: sap:System Performance\System Reliability (crash, errors, bug check or Blue Screen, unexpected reboot), csstroubleshoot
---
# Stop error 0x000000D1 and Windows Server runs a bugcheck when you enable a storage controller

This article discusses an issue where Windows Server runs a bugcheck and you receive Stop error 0x000000D1 when you enable a storage controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2916984

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows Server 2012 R2.
- The system is configured by having hot pluggable Solid State Drives (SSDs).
- You disable the storage controller for one or more of the SSDs through Device Manager.
- You physically eject the SSDs that are attached to the disabled controllers.
- You re-enable the previously disabled storage controller through Device Manager.

In this scenario, Windows Server runs a bugcheck. Additionally, you receive a Stop error message that resembles the following message:

> STOP: 0x000000D1 (parameter 1, parameter 2, parameter 3, parameter 4)

This problem has also been seen in scenarios in which a surprise removal is performed on the SSD when the storage controller driver is being installed or enabled.

> [!NOTE]
>
> - This Stop error describes a DRIVER_IRQL_NOT_LESS_OR_EQUAL error.
> - The parameters in this Stop error message vary, depending on the configuration of the computer.
> - Not all Stop 0x000000D1 errors are caused by this issue.

## Cause

This problem occurs because the StorPort driver forwards a Plug and Play (PnP) IRP to the storage controller that is no longer initialized.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

Microsoft regularly releases software updates to address specific bugs. If Microsoft releases a software update to resolve this bug, this article will be updated with additional information.
