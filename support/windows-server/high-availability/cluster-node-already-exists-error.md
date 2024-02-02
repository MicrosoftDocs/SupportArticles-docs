---
title: Error (The cluster node already exists) occurs during cluster setup
description: Provides a solution to the error (The cluster node already exists) that occurs during cluster setup.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
---
# Error (The cluster node already exists) may appear during cluster setup

This article provides a solution to the error (The cluster node already exists) that occurs during cluster setup.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555216

## Symptoms

During create new cluster via Cluster Administrator or cluster.exe command line, the following error may appear:

> The cluster node already exists

## Cause

If the current server is member of exiting cluster, or/and the current resource (most often quorum disk) is available.

## Resolution

The resolution process depends on the current status of the cluster member:

1. If the current server should belong to exiting cluster, verity that quorum disk in online and all cluster resource available for regular use. The server should not be used as a new cluster member.

2. If the current shouldn't belong to exiting cluster or/and the cluster configuration cannot be restored or be fixed, follow the following instructions:

    The following process is irreversible, and may require reinstall the cluster.

    1. Go to **Start** > **Run**.
    2. Write *Cmd* and press on Enter button.
    3. Write `cluster node nodename /forcecleanup` and press Enter.
    4. The message should be appear after a few seconds: Clean up successfully completed.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
