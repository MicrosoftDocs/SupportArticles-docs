---
title: Issues after enabling data deduplication
description: Describes some known issues that may occur after you enable data deduplication on Cluster Shared Volumes (CSV).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, vimalsh
ms.custom: sap:deduplication, csstroubleshoot
---
# Known issues after you enable data deduplication on CSV

This article describes some known issues that may occur after you enable data deduplication on CSV.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2906888

## Summary

Data deduplication in Windows Server 2012 R2 supports optimization of storage for Virtual Desktop Infrastructure (VDI) deployments and optimization of Cluster Shared Volumes (CSV). Data deduplication is supported on NTFS-formatted CSV and is not supported on Resilient File System (ReFS)-formatted CSV.

## Known Issues

- Issue 1  

    The LastWriteTime  property of a file is changed to the time when the file is processed by a data deduplication optimization job. Additionally, the archive bit of the file is reset when the data deduplication optimization job is finished.

    This behavior does not affect production performance or limit access to the files that are stored on the CSV. However, this behavior may affect some backup applications that use the archive bit or the LastWriteTime property to detect incremental changes of files. For example, when the file properties are changed by a data deduplication optimization job, the backup application may be triggered to back up the files again.

- Issue 2

    When you use the `Update-DedupStatus` cmdlet to query a data deduplication job status on a CSV volume from a passive (non-coordinator) cluster node, you receive an error that resembles the following:

    > Update-DedupStatus : MSFT_DedupVolumeStatus.Volume='\<CSV volume path>' - HRESULT 0x80565364, 0x80565304, 0x8056536B

    Additionally, you receive one of the following error messages:

    > Data deduplication cannot run this job on this CSV volume on this node. Try running the job on the CSV volume resource owner node.
    >
    > Data deduplication cannot run this cmdlet on this CSV volume on this node. Try running the cmdlet on the CSV volume resource owner node.

    This behavior is expected because the job status can be queried only from the coordinator node. To obtain the status of the data deduplication job, log on to the coordinator node, and then run the `Update-DedupStatus` cmdlet.

## More information

Data deduplication was introduced in Windows Server 2012. Enabling data deduplication reduces the number of duplicate blocks of data in the storage so that more data can be stored. Data deduplication is highly scalable, resource efficient, and nonintrusive and can run on dozens of large volumes of primary data at the same time and yet have only a minimal effect on the server workload. For more information, see [Data Deduplication Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831602(v=ws.11)) and [About Data Deduplication](/previous-versions/windows/desktop/dedup/about-data-deduplication).
