---
title: Exchange Server transaction logs grow rapidly
description: Describes an issue in which Exchange Server transaction logs grow fast and disabling Exchange ActiveSync causes reduced transaction log volume.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Server transaction logs are generated at a high rate

_Original KB number:_ &nbsp;3060278

## Symptoms

The transaction logs on the Microsoft Exchange Server-based mailbox server are generated at a rate that's higher than you expected. By using the ExMon tool, you verify that one or more users are generating the highest volume of logs. Disabling Exchange ActiveSync for the user or users results in reduced transaction log volume.

## Cause

This issue typically occurs when no filter is applied to one or more folders on a device. This causes the sync state for the folder or folders to grow to several megabytes. Each request that's received by Exchange recommits the sync state, and this creates several new log files every time that a request is received.

## Resolution

To resolve this issue, apply an Exchange ActiveSync mailbox policy that forces a maximum number of days for the sync.

The following example policy changes the maximum email age to two weeks:

```powershell
Set-MobileDeviceMailboxPolicy Default -MaxEmailAgeFilter TwoWeeks
```

```powershell
Set-ActiveSyncMailboxPolicy Default -MaxEmailAgeFilter TwoWeeks
```

## More information

You can use the following Log Parser Studio query to identify users and folders that have large sync states:

```console
/* Sync state greater than 2 MB */
SELECT Count(*) AS Hits,
EXTRACT_VALUE(cs-uri-query,'User') AS User,
EXTRACT_VALUE(cs-uri-query,'DeviceType') AS DeviceType,
EXTRACT_VALUE(cs-uri-query,'DeviceId') AS DeviceId,
EXTRACT_VALUE(cs-uri-query,'Cmd') AS Cmd,
EXTRACT_PREFIX(EXTRACT_SUFFIX(cs-uri-query, 0, '_Fid:'), 0, '_') As FolderId,
AVG(TO_INT(EXTRACT_PREFIX(EXTRACT_SUFFIX(SUBSTR(cs-uri-query, INDEX_OF(cs-uri-query, '_Sst')), 0, '_Sst'), 0, '_'))) AS AvgSyncStateSize,
AVG(TO_INT(EXTRACT_PREFIX(EXTRACT_SUFFIX(SUBSTR(cs-uri-query, INDEX_OF(cs-uri-query, '_SsCmt')), 0, '_SsCmt'), 0, '_'))) AS AvgSyncStateCommitSize,
EXTRACT_PREFIX(EXTRACT_SUFFIX(cs-uri-query, 0, '_Filt'), 0, '_') As Filter,
EXTRACT_PREFIX(EXTRACT_SUFFIX(cs-uri-query, 0, '_Ty:'), 0, '_') As Type
USING
TO_INT(EXTRACT_PREFIX(EXTRACT_SUFFIX(SUBSTR(cs-uri-query, INDEX_OF(cs-uri-query, '_Sst')), 0, '_Sst'), 0, '_')) AS SyncSize
FROM '[LOGFILEPATH]'
WHERE cs-uri-query LIKE '%Cmd=Sync%'
AND SyncSize > 2000
GROUP BY DeviceId, DeviceType, Cmd, User, FolderId, Filter, Type
ORDER BY Hits, AvgSyncStateSize DESC
```
