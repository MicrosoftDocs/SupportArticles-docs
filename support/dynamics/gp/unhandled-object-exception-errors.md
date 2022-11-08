---
title: Unhandled object exception errors
description: Provides a solution to errors that occur when you start Microsoft Dynamics GP.
ms.reviewer: kyouells, lmiller
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Unhandled object exception" Error messages when you start Microsoft Dynamics GP

This article provides a solution to errors that occur when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 928531

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error messages.

Error message 1
> Unhandled object exception: ClassFactory cannot supply requested class

Error message 2
> Unhandled object exception: Error calling method 'createProcessingInstruction'

## Cause

This problem occurs because the MSXML3.dll file isn't registered.

## Resolution

To resolve this problem, reregister the MSXML3.dll file. To do it, follow these steps:

1. Exit Microsoft Dynamics GP.
2. Select **Start**, select **Run**, type **cmd**, and then select **OK**.
3. At the command prompt, type **regsvr32 MSXML3.dll**, and then press ENTER.
4. Start Microsoft Dynamics GP.
