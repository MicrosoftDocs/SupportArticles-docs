---
title: Data corruption on IO write
description: This article describes data corruption on IO if the storage driver reads (write IO) the pages multiple times in a successive manor to the storage medium.
ms.date: 09/01/2020
ms.custom: sap:Storage Driver
ms.reviewer: ronh
ms.topic: concept-article
---
# Storage developer may experience what appears as data corruption on IO writes

This article describes data corruption on IO if the storage driver reads (write IO) the pages multiple times in a successive manor to the storage medium.

_Original product version:_ &nbsp; Modified Page Writer  
_Original KB number:_ &nbsp; 2713398

## Summary

The Modified Page Writer (referred to in this article as MPW) is one of two system worker threads that are part of the memory manager. These worker threads are allowed to run under a variety of conditions. One of these conditions is the `Flush All pages` request, which is sent when the system is preparing for shutdown or hibernation.

The Modified Page Writer scans all dirty pages that are page file backed and tracked by the Memory manager. This scanning of physical pages is process agnostic. In cache coherent systems, hardware and software work together to ensure modified data is written to the paging file in a timely yet non-impactful way to maintain data integrity.

## More information

Microprocessor hardware will update specialized data structures managed by the memory manager pages that have been written to. These specialized data structures, referred to as Page Table Entries (PTE) are updated to reflect the page as being dirty and not yet written to backing storage (The PTE dirty bit is cleared by the memory manager).

Conditions that can release the MPW thread are: Requests from the working set manager if the zeroed and standby lists are below a threshold to free up pages; A `flush all pages` request is received or the number of available pages are below a threshold.

The MPW scans the Page Frame Number (PFN) data base looking for pages on the modified page list(s) that are contiguous as possible for batching of IO. In pre-Vista, this was typically in 64k sized I/O's. In Vista and above, this is typically 1-MB worth of pages.

An IRP is allocated and an MDL describing the pages is created and sent to the Storage stack to be written to the backing page file. Once the I/O is completed, the pages are placed at the tail end of the Standby list if there are no other references to the page (refcount == 0).

Storage drivers written to emulate select types of RAID are susceptible to seeing what appears as buffer corruption. This appearance is due to the fact the MPW doesn't freeze other processors from running any thread in the system or prevents modifying pages that are selected for this paging IO being written to disk. After the MPW creates and issues the IRP to the storage stack, any running thread in the system could modify that page at any instant in time. The hardware will ensure the page is then marked dirty again and the MPW will ensure the dirtied page is again sent to the page file sometime later when the MPW is again woken to repeat the described steps.

Storage HBA miniport drivers program the hardware to read the source buffer pages and write them to the storage medium via DMA. In RAID-1 as an example needs to do the I/O twice to different Storage medium pairs and write multiple times for the write I/O out to storage hardware. This is the most efficient way to do this. The oversight is to assume this buffer will not change over time. There is no page write prevention to protect the memory page from being written to while the I/O is in flight. The page is locked in memory so it can't be freed while the I/O is active, but the R/W attributes of the page are not changed.

A more real world example of this is: A developer writes a RAID 1 Mirroring miniport driver. StorPort sends an I/O request at T1 time-frame, the miniport would instruct a write operation to the HBA that would issue DMA read on the source buffer to write the data pages to backing storage and during this I/O DMA sequence the page can become altered again. If the driver then initiates another I/O based on the same MDL, and used the source system buffer at a later time, say T2, this I/O could contain different data and thus in a Raid-1 mirror set for example; The second drive would contain different data than the first.

Drivers most susceptible are RAID Miniport implementations that enhance performance by using source buffer multiple times to increase IO per second and lower IO latency vs. copying the buffer internally first and use this copy multiple times in succession over the course of IO processing..
