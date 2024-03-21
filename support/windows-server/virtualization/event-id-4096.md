---
title: Event ID 4096 is logged in Hyper-V host
description: Discusses that Microsoft-Windows-Hyper-V-Integration-KvpExchange is logged on a Windows Server 2012 R2 and Windows Server 2012 Hyper-V host. This event can safely be ignored.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ryhayash, v-jesits
ms.custom: sap:Virtualization and Hyper-V\Integration components, csstroubleshoot
---
# Event ID 4096 (Microsoft-Windows-Hyper-V-Integration-KvpExchange) is logged

This article discusses that Microsoft-Windows-Hyper-V-Integration-KvpExchange is logged on a Windows Server 2012 R2 Hyper-V host.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2989430

## Symptoms

On a Windows Server 2012 R2 or Windows Server 2012 Hyper-V host, the following Microsoft-Windows-Hyper-V-Integration-KVPExchange event ID 4096 is logged:

> Log Name : Microsoft-Windows-Hyper-V-Integration/Admin  
Source: Microsoft-Windows-Hyper-V-Integration-KvpExchange  
Event ID: 4096  
Level: Error  
Message: 'VM Name': The Data Exchange integration service is either not enabled, not running or not initialized. (Virtual machine ID \<VM GUID>)

## Cause

This Error event may be logged when a virtual machine (VM) saves, starts, or stops, and there is a concurrent request to retrieve a KVP item, such as the IP address or the system version.

## More information

Although this event is logged, the error causes no harm to the Hyper-V host. Typically, event ID 4096 is not logged regularly. Therefore, you can safely ignore it because KVP items can be retrieved after a VM starts. If you do see this event logged regularly, it may indicate another problem. In that, we recommend that you contact [Microsoft Support](https://support.microsoft.com/contactus).

## References

For more information, see the following MSDN topic:

[Msvm_KvpExchangeComponent class](https://msdn.microsoft.com/library/hh850169%28v=vs.85%29.aspx)
