---
title: Heap manager may not decommit memory
description: This article describes a problem in which the Low Fragmentation Heap (LFH) may not decommit memory that was freed by using HeapFree.
ms.date: 03/16/2020
ms.custom: sap:System services development
ms.reviewer: jlambert, davean
ms.technology: windows-dev-apps-system-services-dev
---
# Heap manager may not decommit memory after memory is freed

This article describes a problem where the Low Fragmentation Heap (LFH) may not decommit memory that's freed by using `HeapFree`.

_Original product version:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 3073576

## Symptoms

The LFH heap manager may not decommit memory that was freed by using `HeapFree`. Therefore, private bytes may grow even though the memory in the heap was freed.

## Cause

The LFH throttles returning memory to the back-end heap. When an application is in a cycle in which it allocates lots of memories, then frees the memory, and then repeats the process, the LFH intentionally does not return all the committed memory. This occurs because the allocation pattern suggests that the application will have to allocate the memory again shortly. Therefore, the LFH will cache a part of what the application freed to speed up allocations. As the application continues the pattern, the LFH will continue to cache memory, and an increase in private bytes will occur.

The main point is that the LFH (and the heap generally) cannot guarantee that when a block of memory is freed, that block of memory will also be decommitted.

`HeapCompact` can be called to indicate to the heap that it might be a good time to flush out its caches. This may avoid an increase in the private bytes. However, the heap manager still may ignore the request.

## Workaround

Private bytes measure something different from active heap allocations. If you have to have strong control over private bytes, you should consider using the `VirtualAlloc` and `VirtualFree` APIs.
