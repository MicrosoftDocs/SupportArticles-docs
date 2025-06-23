---
title: ''
description: ''
ms.date: 06/23/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: ''
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
---
# Event ID 7 is logged on a Windows Server 2025-based DC

Active Directory domain controllers (DCs) that are running Windows Server 2025 might intermittently log event ID 7. This article provides suggestions for this error.

## Event sample:

The following is a sample of the event:

Log Name: System
Source: Microsoft-Windows-Kerberos-Key-Distribution-Center
Date: 3/11/2025 10:07:03 AM
Event ID: 7
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: 2025DC1.contoso.com
Description:
The Security Account Manager failed a KDC request in an unexpected way. The error is in the data field. The account name was and lookup type 0x108.
Event Xml:
<Event
xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
 <System>
 <Provider Name="Microsoft-Windows-Kerberos-Key-Distribution-Center" Guid="{3FD9DA1A-5A54-46C5-9A26-9BD7C0685056}" EventSourceName="KDC" />
 <EventID Qualifiers="49152">7</EventID>
 <Version>0</Version>
 <Level>2</Level>
 <Task>0</Task>
 <Opcode>0</Opcode>
 <Keywords>0x80000000000000</Keywords>
 <TimeCreated SystemTime="2025-03-11T07:07:03.7950701Z" />
 <EventRecordID>29550</EventRecordID>
 <Correlation />
 <Execution ProcessID="896" ThreadID="0" />
 <Channel>System</Channel>
 <Computer>2025DC1.contoso.com</Computer>
 <Security />
 </System>
 <EventData>
 <Data Name="AccountName">
 </Data>
 <Data Name="LookupType">0x108</Data>
 <Binary>0D0000C0</Binary>
 </EventData>
</Event>

> [!IMPORTANT]

The text of the event has a blank account name: "The account name was ..."

If the event ID lists a different account name or lookup type, it may be a separate issue and may require investigation.

## Resolution

This is only considered a cosmetic bug that can be safely ignored when the account name is blank.

## State

This only impacts Windows Server 2025 when running as an Active Directory KDC. No other versions of Windows Server have this issue.

The Windows Product Group has acknowledged that this is a cosmetic bug and that these events can be safely ignored.
