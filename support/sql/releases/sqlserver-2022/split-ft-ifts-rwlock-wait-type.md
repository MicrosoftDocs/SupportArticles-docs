---
title: Split the FT_IFTS_RWLOCK wait type into more granular wait types
description: Describes the improvement to split the FT_IFTS_RWLOCK wait type into more granular wait types for better supportability.
ms.date: 02/15/2023
ms.custom: KB5023453
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# KB5023453 - Improvement: Split the FT_IFTS_RWLOCK wait type into more granular wait types for better supportability

## Summary

This improvement splits the `FT_IFTS_RWLOCK` wait type into more granular wait types, which can help debug issues on what resource you are waiting for.

The following table lists the wait types:

|Wait Type|Description|
|---|----|
| FT_IFTS_ASYNC_WRITE_PIPE |  |
| FT_IFTS_BLOB_HASH |  |
| FT_IFTS_CATEALOG_SOURCE |  |
| FT_IFTS_CHUNK_BUFFER_CLIENT_MANAGER |  |
| FT_IFTS_CHUNK_BUFFER_PROTO_WORD_LIST |  |
| FT_IFTS_COMP_DESC_MANAGER |  |
| FT_IFTS_CONSUMER_PLUGIN |  |
| FT_IFTS_CRAWL_BATCH_LIST |  |
| FT_IFTS_CRAWL_CHILDREN |  |
| FT_IFTS_DOCID_INTERFACE_LIST |  |
| FT_IFTS_DOCID_LIST |  |
| FT_IFTS_FP_INFO_LIST |  |
| FT_IFTS_HOST_CONTROLLER    |  |
| FT_IFTS_MASTER_MERGE_TASK_LIST |  |
| FT_IFTS_MEMREGPOOL |  |
| FT_IFTS_MERGE_FRAGMENT_SYNC |  |
| FT_IFTS_NOISE_WORDS_COLLECTION_CACHE |  |
| FT_IFTS_NOISE_WORDS_RESOURCE |  |
| FT_IFTS_OCCURRENCE_BUFFER_POOL |  |
| FT_IFTS_PIPELINE |  |
| FT_IFTS_PIPELINE_LIST |  |
| FT_IFTS_PIPELINE_MANAGER |  |
| FT_IFTS_PROJECT_FD_INFO_MAP |  |
| FT_IFTS_SCHEDULER |  |
| FT_IFTS_SHARED_MEMORY |  |
| FT_IFTS_SHUTDOWN_PIPE |  |
| FT_IFTS_SRCH_FD_MANAGER |  |
| FT_IFTS_SRCH_FD_SERVICE |  |
| FT_IFTS_STOPLIST_CACHE_MANAGER |  |
| FT_IFTS_THESAURUS |  |
| FT_IFTS_VERSION_MANAGER |  |
| FT_IFTS_WORK_QUEUE |  |

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
