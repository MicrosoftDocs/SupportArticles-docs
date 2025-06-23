---
title: Event ID 7 is intermittently logged on a Windows Server 2025-based DC
description: Introduces the issue in which event ID 7 is intermittently logged on a Windows Server 2025-based DC.
ms.date: 06/23/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: jories
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
---
# Event ID 7 is intermittently logged on a Windows Server 2025-based DC

Active Directory domain controllers (DCs) that are running Windows Server 2025 might intermittently log event ID 7. This article provides suggestions for this error.

## Event sample

Here's a sample of the event:

> Log Name: System  
> Source: Microsoft-Windows-Kerberos-Key-Distribution-Center  
> Date: \<date time\>  
> Event ID: 7  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<dc fqdn\>  
> Description:  
> The Security Account Manager failed a KDC request in an unexpected way. The error is in the data field. The account name was and lookup type 0x108.

Event Xml:

```xml
<Event
xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
 <System>
 <Provider Name="Microsoft-Windows-Kerberos-Key-Distribution-Center" Guid="**guid**" EventSourceName="KDC" />
 <EventID Qualifiers="49152">7</EventID>
 <Version>0</Version>
 <Level>2</Level>
 <Task>0</Task>
 <Opcode>0</Opcode>
 <Keywords>0x80000000000000</Keywords>
 <TimeCreated SystemTime="**date time**" />
 <EventRecordID>29550</EventRecordID>
 <Correlation />
 <Execution ProcessID="896" ThreadID="0" />
 <Channel>System</Channel>
 <Computer>**dc fqdn**</Computer>
 <Security />
 </System>
 <EventData>
 <Data Name="AccountName">
 </Data>
 <Data Name="LookupType">0x108</Data>
 <Binary>0D0000C0</Binary>
 </EventData>
</Event>
```

> [!IMPORTANT]
> The text of the event has a blank account name: **The account name was ...**.
>
> If the event ID lists a different account name or lookup type, it might be a separate issue that requires investigation.

## Resolution

This issue doesn't affect computer functionality or performance. These events can be safely ignored when the account name is blank.

## More information

This issue only impacts Windows Server 2025 when running as an Active Directory Key Distribution Center (KDC). No other versions of Windows Server have this issue.

Microsoft has acknowledged this issue. These events can be safely ignored.
