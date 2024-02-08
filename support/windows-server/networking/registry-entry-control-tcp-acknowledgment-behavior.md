---
title: New registry entry for controlling TCP ACK
description: Introduces the TcpAckFrequency, a new registry entry that determines the number of TCP acknowledgments (ACKs).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: mkoduri, kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# New registry entry for controlling the TCP Acknowledgment (ACK) behavior in Windows

This article introduces the TcpAckFrequency, a new registry entry that determines the number of TCP acknowledgments (ACKs).

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 328890

## Summary

**TcpAckFrequency** is a registry entry that determines the number of TCP acknowledgments (ACKs) that will be outstanding before the delayed ACK timer is ignored.

## More information

As specified in RFC 1122, TCP uses delayed acknowledgments to reduce the number of packets that are sent on the media. Instead of sending an acknowledgment for each TCP segment received, TCP in Windows takes a common approach to implementing delayed acknowledgments. As data is received by TCP on a particular connection, it sends an acknowledgment back only if one of the following conditions is true:

- No acknowledgment was sent for the previous segment received.
- A segment is received, but no other segment arrives within 200 milliseconds for that connection.

Typically, an acknowledgment is sent for every other TCP segment that is received on a connection unless the delayed ACK timer (200 milliseconds) expires. You can adjust the delayed ACK timer by editing the following registry entry.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows
  
Subkey: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\\\<Interface GUID>**  
Entry: **TcpAckFrequency**  
Value Type: REG_DWORD, number  
Valid Range: 0-255  
Default: 2  
Description: Specifies the number of ACKs that will be outstanding before the delayed ACK timer is ignored. Microsoft does not recommend changing the default value without careful study of the environment.

If you set the value to 1, every packet is acknowledged immediately because there's only one outstanding TCP ACK as a segment is just received. The value of 0 (zero) isn't valid and is treated as the default, 2. The only time the ACK number is 0 when a segment isn't received and the host isn't going to acknowledge the data.
