---
title: API call to performance counters is delayed
description: Fixes an issue in which API calls of performance counters are delayed 3 or 5 minutes inside a container.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, roumaago, v-lianna
ms.custom:
- sap:containers\management of containers
- pcy:WinComm Storage High Avail
---
# Application Programming Interface (API) call of performance counters is delayed inside a container

## Symptoms

Application calls to API performance counters inside a container running a Windows full image are delayed by 3 to 5 minutes. For example:  

>10:32:55.858 Tid=1, PerformanceCounterCategory.CounterExists – BEGIN  
10:36:32.140 Tid=1, PerformanceCounterCategory.CounterExists – END

## Cause

The broker infrastructure service is disabled on the full container image.  

## Resolution

Set the startup type of the broker infrastructure service (display name of the service is **Background Tasks Infrastructure Service**) to **Automatic** before starting the API call. To do this, add this line to the dockerfile:  

```dockerfile
RUN powershell -Command Set-Itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure' -Name 'Start' -value 2
```  
