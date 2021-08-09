---
title: Can't back up deduplicated volumes on a secondary DPM server
description: Describes a backup failure occurs on a secondary DPM 2016 server when you try to back up a deduplicated volume that's protected by the primary DPM server.
ms.date: 07/27/2020
ms.prod-support-area-path:
ms.reviewer: mjacquet
---
# Backup of deduplicated volumes fails on a secondary DPM 2016 server

This article describes a by-design behavior that a backup failure occurs on a secondary Data Protection Manager (DPM) server when you try to back up a deduplicated volume that's protected by the primary DPM server.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager  
_Original KB number:_ &nbsp; 4037310

## Symptoms

Consider the following scenario:

- In Microsoft System Center 2016, you have a primary DPM server (DPM1) to protect the data resources.
- You have a secondary DPM server (DPM2) to protect DPM1.
- You try to use DPM2 to back up a deduplicated volume that's protected by DPM1.

In this scenario, you receive the following error message:

> The DPM service was unable to communicate with the protection agent.

## Cause  

This behavior is by design. After a deduplicated file system is protected by a primary DPM server, it's no longer supported to be protected by a secondary DPM server. For more information, see [Deduplication issues](/system-center/dpm/dpm-support-issues#BKMK_Dedup).
