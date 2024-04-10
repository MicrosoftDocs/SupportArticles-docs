---
title: WCF Service does not start automatically
description: This article provides resolutions for the problem that occurs when the WCF service does not automatically start because of pending messages in the MSMQ queue.
ms.date: 08/24/2020
ms.reviewer: amymcel, davidqiu
---
# WCF Service does not start automatically when messages are available through MSMQ

This article helps you resolve the problem that occurs when the Windows Communication Foundation (WCF) service does not automatically start because of pending messages in the Message Queuing (MSMQ) queue.

_Original product version:_ &nbsp; Internet Information Services 8.0, Internet Information Services 8.5  
_Original KB number:_ &nbsp; 2974327

## Symptoms

An IIS application pool is hosting two distinct WCF services where one uses the `net.msmq` binding and the other uses `msmq.formatname` binding. When messages to the WCF service that use the `net.msmq` binding are pending in the MSMQ queue, the WCF service will not automatically start.

## Cause

This is by design. WAS is designed so that when a single IIS application pool has multiple WCF services that use mixed msmq binding types, the `msmq.formatname` service takes precedence, and the flag to restart the `net.msmq` service is set to **no**. Therefore only the service that uses `msmq.formatname` will automatically start the w3wp process for that application pool when messages become available in the MSMQ queue.

## Resolution

The workaround is to use two separate application pools for your WCF services, separating the two different msmq bindings.
