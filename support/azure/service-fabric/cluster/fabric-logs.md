---
title: Microsoft Azure Service Fabric Logs
description: Lists the Microsoft Azure Service Fabric logs and diagnostic information that is collected during troubleshooting.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-service-fabric
ms.date: 08/14/2020
ms.reviewer: 
ms.custom: sap:Cluster related issues
---
# Microsoft Azure Service Fabric Logs

_Original product version:_ &nbsp; Service Fabric  
_Original KB number:_ &nbsp; 3200697

## Summary

In order to troubleshoot most issues that are related to Service Fabric, Service Fabric engineering and customer support can, with your permission, download diagnostic logs that are uploaded to your Service Fabric diagnostic storage account.  Microsoft may access (including making temporary copies of) the data in this diagnostic storage account to assist with resolving your support incident.

## More information

The following log files and PerfCounter files are captured by Service Fabric and uploaded to your Service Fabric diagnostic storage account.

| Description| File name |
|---|---|
|Service Fabric System Diagnostic Logs<br/>(recursively collected from log directory)|{ServiceFabricLogsDirectory}\*.dtr & {ServiceFabricLogsDirectory}\*.etl|
|Example|D:\SvcFab\Log\*.dtr|
|Service Fabric Installation Diagnostic Logs<br/>(recursively collected from log root)|{ServiceFabricLogsDirectory}\*.trace|
|Example|D:\SvcFab\Log\*.trace|
|Service Fabric and Windows Perf Counters<br/>(recursively collected from log root)|{ServiceFabricLogsDirectory}\*.blg|
|Example|D:\SvcFab\Log\*.blg|

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
