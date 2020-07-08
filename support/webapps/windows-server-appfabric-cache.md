---
title: Windows Server AppFabric Cache diagnostic
description: Describes the information that's collected from a computer that's running AppFabric Cache for Windows Server.
ms.date: 03/20/2020
ms.prod-support-area-path:
---
# Windows Server AppFabric Cache diagnostic

This article describes the information collected from a computer that is running AppFabric Cache for Windows Server.

_Original product version:_ &nbsp; Windows Server AppFabric  
_Original KB number:_ &nbsp; 2883284

AppFabric Cache for Windows Server data collector gathers the following information that is commonly used to investigate Cache Cluster related issues.

## Cache cluster current status output

|Description| File name |
|---|---|
|Analysis summary:|{Computername}_CacheCluster_PSOutput.TXT|
|||

## Event logs

|Description| File name |
|---|---|
|Application log:|ApplicationLog.evtx|
|System log:|SystemLog.evtx|
|AppFabric Cache Admin log:|CacheAdminLog.evtx|
|AppFabric Cache Operational log:|CacheOperationalLog.evtx|
|AppFabric Cache Debug log:|CacheDebugLog.evtx|
|||

## Cache cluster configuration data

|Description| File name |
|---|---|
|Cache Cluster Configuration:|CacheClusterConfigExported.xml|
|||

## Installation and administration logs

|Description| File name |
|---|---|
|Installation Logs|AppServerSetup{DateTimestamp}.log|
|Command history|DCache{OperationalClass+Timestamp}.log|
|||

## Registry keys

|Description| File name |
|---|---|
|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppFabric`|AppFabricReg.TXT|
|||
