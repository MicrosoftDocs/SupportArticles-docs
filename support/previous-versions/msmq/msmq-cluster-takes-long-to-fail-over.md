---
title: Cluster resource takes long time to fail over
description: This article describes an issue where an MSMQ cluster resource takes longer than one minute to fail over.
ms.date: 07/23/2020
ms.prod-support-area-path: 
ms.topic: article
---
# MSMQ cluster resource takes longer than a minute to fail over

This article describes an issue where a Microsoft Message Queuing (MSMQ) cluster resource takes longer than one minute to fail over.

_Original product version:_ &nbsp; Windows Server 2012 Datacenter, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows Server 2012 Standard  
_Original KB number:_ &nbsp; 3003681

## Symptoms

In Windows Server 2012 and Windows Server 2012 R2, an MSMQ cluster resource takes longer than a minute to fail over.

## Cause

This issue occurs because the MSMQ resource tries to make sure that the IP resources on which MSMQ is dependent, are online and registered before the MSMQ resource itself is brought online.

As this process does not occur in a reasonable time period, the resource fails and it goes into retries. This causes the one-minute delay.

## Resolution

This behavior is considered by design. There is currently no workaround.

## More information

One common concern for customers is that the delay might be even longer when servers are in production. Our research indicates that will not be the case. It was verified that this 60-second delay will not cause any longer delays because of load.
