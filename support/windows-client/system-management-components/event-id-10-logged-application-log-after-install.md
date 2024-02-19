---
title: Event ID 10 is logged
description: Discusses a problem in which an event ID 10 message is logged in the Application log after you install Windows Vista SP1. Provides a workaround.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, chwall
ms.custom: sap:wmi, csstroubleshoot
---
# Event ID 10 is logged in the Application log

This article provides a resolution for the issue that Event ID 10 is logged in the Application log.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 950375

## Symptoms

After you install Windows Vista Service Pack 1 (SP1) or Windows Server 2008, the following WMI error is logged in the Application log:

When you click the **Details**  tab in the error message and then select the XML view, you receive the following error message:

>Event Xml:  
 \<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`"`>  
 \<System>  
 \<Provider Name="Microsoft-Windows-WMI" Guid="{1edeee53-0afe-4609-b846-d8c0b2075b1f}" EventSourceName="WinMgmt" />  
 \<EventID Qualifiers="49152">10\</EventID>  
 \<Version>0\</Version>  
 \<Level>2\</Level>  
 \<Task>0\</Task>  
 \<Opcode>0\</Opcode>  
 \<Keywords>0x80000000000000\</Keywords>  
 \<TimeCreated SystemTime="2008-01-18T22:37:27.000Z" />  
 \<EventRecordID>187\</EventRecordID>  
 \<Correlation />  
 \<Execution ProcessID="0" ThreadID="0" />  
 \<Channel>Application\</Channel>  
 \<Computer>adsd-PC\</Computer>  
 \<Security />  
 \</System>  
 \<EventData>  
 \<Data>//./root/CIMV2\</Data>  
 \<Data>SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA "Win32_Processor" AND TargetInstance.LoadPercentage &gt; 99\</Data>  
 \<Data>0x80041003\</Data>  
 \</EventData>  
 \</Event>  

## Cause

This problem occurs if the WMI filter is accessed without sufficient permission.

## Resolution

To resolve this problem, run the script that is provided at the following Script Center website:

[Event ID 10 is logged in the Application log on Windows Vista](https://gallery.technet.microsoft.com/scriptcenter/event-id-10-is-logged-in-c5984711)  

This problem also occurs in Windows 7 and Windows Server 2008 R2. To resolve the problem in those systems, use the Fix it solution that is available in the following Microsoft Knowledge Base article:

[2545227 Event ID 10 is logged in the Application log after you install Service Pack 1 for Windows 7 or Windows Server 2008 R2](https://support.microsoft.com/help/2545227)  

## More information

This particular Event ID 10 error message listed above can be safely ignored, it is not indicative of a problem with the Service Pack or with the operating system.
