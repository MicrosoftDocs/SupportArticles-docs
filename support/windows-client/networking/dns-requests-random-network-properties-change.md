---
title: DNS requests appear to be random after startup or after network properties change
description: In certain circumstances, DNS client may send DNS name resolution requests that appear to be random
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# DNS requests appear to be random after startup or network properties change

This article provides some information about DNS requests that appear to be random after startup or network properties change.  

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4564934

## Summary

You have a computer that runs Windows 8 or a later version, and has at least one network adapter that is configured as follows:
- The adapter is not connected to a domain network
- The adapter does not have a WINS server configured  

After the computer starts or after a network property changes, you may observe that the computer sends out one or two DNS name resolution requests that appear to be random.

## Cause

In certain circumstances, the Windows DNS client may send DNS name resolution requests that appear to be random. These requests serve various purposes, such as detecting network conditions. This Windows request behavior is subject to change.

## More information

When the queries are sent by the Windows DNS client, no action is required. Blocking these queries may affect Windows performance.
