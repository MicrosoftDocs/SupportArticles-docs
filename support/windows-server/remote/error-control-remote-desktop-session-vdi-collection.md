---
title: This computer name is invalid error when you try to shadow a remote session in Windows Server 2012 R2
description: Describes an issue that occurs when you try to remotely control a remote desktop session in a Virtual Desktop Infrastructure (VDI) collection. Provides a resolution.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: rkiran, jerrycif, kaushika
ms.custom: sap:virtual-desktop-infrastructure-vdi, csstroubleshoot
---
# Error message when you try to shadow a remote session in Windows Server 2012 R2: This computer name is invalid

This article describes an issue that occurs when you try to remotely control a remote desktop session in a Virtual Desktop Infrastructure (VDI) collection.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2897666

## Symptoms

When you try to shadow (that is, remotely control) a remote desktop session in a Virtual Desktop Infrastructure (VDI) collection from a Windows Server 2012 R2-based computer, you receive the following error message in the **Shadow Error** dialog box:

> This computer name is invalid.

> [!NOTE]
> This issue occurs regardless of whether you select **View** or **Control** for the remote session and regardless of whether you select **Prompt for user consent**.

## Cause

This issue occurs on the virtual machine that is being remotely controlled because File and Printer Sharing isn't turned on.

## Resolution

To resolve the issue, make sure that the virtual machine in the VDI collection is running Remote Desktop Client 8.1 and that File and Printer Sharing is turned on on the virtual machine.
