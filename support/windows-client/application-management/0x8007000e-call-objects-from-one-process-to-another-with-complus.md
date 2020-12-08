---
title: You receive a 
description: Discusses the error message: .
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# You receive a "Not enough storage is available to complete this operation (0x8007000e)" error message when you call many objects from one process to another by using COM+

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 890425

## Symptoms

When you call many objects from one process to another by using Microsoft COM+, you may receive the following error message:Not enough storage is available to complete this operation (0x8007000e)
If you attach a debugger to the client process, you may see 8007000E first chance exceptions reported by the debugger.

## Cause

This problem is caused by the limitation in the remote procedure call (RPC) layer where only 256 unique interfaces can be called from one process to another. This problem typically occurs when you use COM+ or Microsoft Transaction Server with many objects in the program or package.

## Resolution

To resolve this problem, use one of the following methods:
- Split objects between multiple processes.
- Reduce the number of interfaces that are called between one process and another.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
