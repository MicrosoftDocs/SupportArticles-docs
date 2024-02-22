---
title: Clients don't get software updates
description: Fixes an issue in which Configuration Manager version 1702 clients can't get updates from the software update point.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Configuration Manager clients don't get software updates

This article fixes an issue in which Configuration Manager clients can't get updates from the software update point.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1702)  
_Original KB number:_ &nbsp; 4041012

## Symptom

After installing Configuration Manager current branch version 1702, you may see the following symptoms:

- Newly installed clients are unable to get updates from the software update point. This can also occur if the software update point is moved to a different server after installation of version 1702. With verbose client logging enabled, the LocationServices.log file contains an empty value for the `WSUSLocationReply` entry.
- Some computers show in the console as **Unknown State**.

## Cause

Beginning with Configuration Manager current branch version 1702, clients use [boundary groups](/mem/configmgr/core/servers/deploy/configure/boundary-groups) to find a new software update point, and to fallback and find a new software update point if their current one is no longer accessible. If you install a new site that runs version 1702 or later, you must assign software update points to a boundary group before clients can find and use them.

## Resolution

Add the server running the software update point to the default site boundary group for the clients. You can add individual software update points to different boundary groups to control which servers a client can find. For more information, see [software update points](/mem/configmgr/core/servers/deploy/configure/boundary-groups#software-update-points).

To add the software update point to the boundary group, follow these steps:

1. Create a boundary group if none exists, and add all the client machines to the boundary group with the software update point as the site server.
2. Run **Machine Policy Retrieval & Evaluation Cycle** on the Configuration Manager.
3. Check the LocationServices.log on a client machine to confirm the client can connect to the Windows Server Update Services (WSUS) server.

> [!NOTE]
> After doing this, you may experience some temporary timeouts if a large number of clients attempts to connect to the WSUS server. This can also cause high CPU usage on the WSUS server. As the clients connect CPU usage should return to normal. If the high CPU usage persists after all clients are connected, see [Troubleshoot high CPU usage on a WSUS server](troubleshoot-wsus-server-high-cpu-usage.md).
