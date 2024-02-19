---
title: WSAEMSGSIZE - Error 10040 in Winsock 2.0
description: Describes how to fix WSAEMSGSIZE - Error 10040 in Winsock 2.0
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# WSAEMSGSIZE - Error 10040 in Winsock 2.0

This article helps to fix WSAEMSGSIZE - Error 10040 in Winsock 2.0.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 225004

## Symptoms

The Microsoft Winsock 2.0 WSARecvFrom() function does not function and may display the following error message when used in a User Datagram Protocol (UDP) socket program:

>WSAEMSGSIZE - Error 10040  

The WSARecvFrom function does not function when a buffer counter greater than one is specified and the receiving datagram size exceeds 1,470 bytes.

The WSAEMSGSIZE error message may appear when the buffer size is not large enough to accommodate the receiving datagram.

## Cause

If the datagram is fragmented, then the TCP driver does not fill the second Memory Descriptor List (MDL) in the I/O Request packet chain.

## Resolution

### Windows NT Server or Workstation 4.0

To resolve this problem, obtain the latest service pack for Windows NT 4.0 or the individual software update.

For information on obtaining the individual software update, contact Microsoft Product Support Services. For a complete list of Microsoft Product Support Services phone numbers and information on support costs, please go to the following address on the World Wide Web:

[Global Customer Service phone numbers](https://support.microsoft.com/help/4051701)  

### Windows NT Server 4.0, Terminal Server Edition

To resolve this problem, obtain the latest service pack for Windows NT Server 4.0, Terminal Server Edition.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows NT Server version 4.0, Terminal Server Edition Service Pack 6.
