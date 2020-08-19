---
title: Service is unavailable for clustered application
description: This article helps to fix the Microsoft Message Queuing (MSMQ) service unavailable error that occurs when clustered application uses MSMQ to send or receive messages.
ms.date: 07/23/2020
ms.prod-support-area-path: 
---
# Clustered application reports error that Message Queuing (MSMQ) service is unavailable

This article helps to fix the Microsoft Message Queuing (MSMQ) service unavailable error that occurs when clustered application uses MSMQ to send or receive messages.

_Original product version:_ &nbsp; Message Queuing (MSMQ)  
_Original KB number:_ &nbsp; 2658108

## Symptoms

You have a Windows Cluster with an MSMQ Cluster Resource. You also have an application that is clustered and it uses MSMQ to send or receive messages. Every time your application executes an MSMQ Send Message or Receive Message call, you get an error stating that the Message Queuing Service is unavailable even though the MSMQ Resource is online.

## Cause

This problem is by-design. Both the MSMQ Clustered Resource and the clustered application are dependent on different network name. As a result, the cluster application is trying to use MSMQ that is loaded under the network name instance that the clustered application is using. Since MSMQ is not running under that network name instance, we get the MSMQ service is unavailable error.

## Resolution

MSMQ and the clustered application both need to be dependent on same network name resource.
