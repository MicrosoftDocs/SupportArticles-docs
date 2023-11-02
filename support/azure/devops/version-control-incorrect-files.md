---
title: Version control download returns incorrect files
description: This article provides resolutions to the error that occurs after you restore a Team Project Collection from a backup.
ms.date: 08/18/2020
ms.custom: sap:Repos
ms.reviewer: mmitrik, remilema, congyiw
ms.service: azure-devops
ms.subservice: ts-repos
---
# Version control download returns incorrect files after restoring Team Project Collection database

This article helps you resolve the problem that occurs after you restore a Team Project Collection (TPC) from a backup.

_Original product version:_ &nbsp; Microsoft Team Foundation Server  
_Original KB number:_ &nbsp; 2025763  

## Symptoms

After restoring a TPC from a backup, files downloaded from Team Foundation Server through version control operations may have incorrect contents.

## Cause

To improve download performance for files in version control, the Team Foundation Server application tier (AT) utilizes a file cache for files retrieved from the data tier (DT). Anytime files are cached on the AT, they are identified by a FileID that is supplied to new files at check-in time. In the event of a TPC restore, it is possible that files added since the last backup was taken will be cached on the AT with a FileID that was assigned between the time backup was taken and the restore was applied. If the version control cache was not purged prior to the TPC restore, FileIDs that were reassigned to new files may result in false positive cache-hits, leading to the download of incorrect file contents.

## Resolution

After any restoration of a Team Foundation Server database (TPC restore, TPC Move), the administrator will need to purge the version control file cache on all Team Foundation Server ATs and all Team Foundation Server proxy servers that service the Team Foundation Server instance prior to putting the TPC back online.

For each application tier and each proxy server, the administrator needs to do the following to purge the cache:

1. Log on to the AT machine.

2. Navigate to the cache folder. (the default is `C:\Program Files\Microsoft Team Foundation Server 2013\Application Tier\Web Services\_tfs_data\%tfsInstanceGuid%\Proxy`) If you do not know the GUID for the TPC, just purge everything under the __tfs_data_ folder.

> [!IMPORTANT]
> If the cache for every AT and proxy is not purged prior to restoration, it is possible that some users will continue to experience the symptoms above.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
