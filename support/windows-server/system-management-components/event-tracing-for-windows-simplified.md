---
title: Event Tracing for Windows is simplified
description: Describes simplified Event Tracing for Windows (ETW).
ms.date: 01/21/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:event-viewer, csstroubleshoot
ms.technology: windows-server-system-management-components
---
# Event Tracing for Windows Simplified

This article describes simplified Event Tracing for Windows (ETW).

_Original KB number:_ &nbsp; 2593157

## Summary

Event Tracing for Windows (ETW) serves the purpose of providing component level logging. As mentioned in the article [About Event Tracing](/windows/win32/etw/about-event-tracing), ETW provides:

*A tracing mechanism for events raised by both user-mode applications and kernel-mode device drivers. Additionally, ETW gives you the ability to enable and disable logging dynamically, making it easy to perform detailed tracing in production environments without requiring reboots or application restarts. This allows large-scale server applications to write events with minimum disturbance*.

As a quick overview: an *event provider*  writes events to an ETW session (it can be any user-mode application, managed application, driver etc.). When events are written, ETW adds more information about the time it took place, process, and thread ID that generated it, processor number, and CPU usage data of the logging thread. This info is used by the *event consumers;*  application that reads log files or listens to a session for real-time events and processes them.

A sample output from the *logman query providers* command:

> Provider   GUID
>
> .NET Common Language Runtime  {E13C0D23-CCBC-4E12-931B-D9CC2EEE27E4}  
ACPI Driver Trace Provider {DAB01D4D-2D48-477D-B1C3-DAAD0CE6F06B}  
Active Directory Domain Services: SAM {8E598056-8993-11D2-819E-0000F875A064}  
Active Directory: Kerberos Client {BBA3ADD2-C229-4CDB-AE2B-57EB6966B0C4}  
Active Directory: NetLogon {F33959B4-DBEC-11D2-895B-00C04F79AB69}  
Application-Addon-Event-Provider {A83FA99F-C356-4DED-9FD6-5A5EB8546D68}  
ASP.NET Events {AFF081FE-0247-4275-9C4E-021F3DC1DA35}  
ATA Port Driver Tracing Provider {D08BD885-501E-489A-BAC6-B7D24BFE6BBF}  
AuthFw NetShell Plugin {935F4AE6-845D-41C6-97FA-380DAD429B72}  
BFE Trace Provider {106B464A-8043-46B1-8CB8-E92A0CD7A560}  
BITS Service Trace {4A8AAA94-CFC4-46A7-8E4E-17BC45608F0A}  
Certificate Services Client CredentialRoaming Trace {EF4109DC-68FC-45AF-B329-CA2825437209}  
Certificate Services Client Trace {F01B7774-7ED7-401E-8088-B576793D7841}  
Circular Kernel Session Provider {54DEA73A-ED1F-42A4-AF71-3E63D056F174}  
Classpnp Driver Tracing Provider {FA8DE7C4-ACDE-4443-9994-C4E2359A9EDB}  
Critical Section Trace Provider {3AC66736-CC59-4CFF-8115-8DF50E39816B}  
Device Task Enumerator {0E9E7909-00AA-42CF-9502-2C490471E598}  
Disk Class Driver Tracing Provider {945186BF-3DD6-4F3F-9C8E-9EDD3FC9D558}  
Downlevel IPsec API {94335EB3-79EA-44D5-8EA9-306F49B3A041}

Various utilities are available at the Microsoft Download Center in order to parse .etl files, for instance Network Monitor v3.4. However, the sample script below would not need an installation of any of those.

## More information

The script below will generate an ETL trace; in this example, data for the Provider - Microsoft-Windows-TerminalServices-RemoteConnectionManager.

```console
@echo off
ECHO These commands will enable tracing:
@echo on
logman create trace admin_wmi -ow -o c:\admin_wmi.etl -p " Microsoft-Windows-TerminalServices-RemoteConnectionManager " 0xffffffffffffffff 0xff -nb 16 16 -bs 1024 -mode 0x2 -max 2048
logman start admin_wmi
@echo off
echo
ECHO Reproduce your issue and enter any key to stop tracing
@echo on
pause
logman stop admin_wmi
logman delete admin_wmi
@echo off
echo Tracing has been captured and saved successfully at c:\admin_wmi.etl
```

Save the above mentioned script as a batch file (.bat) and run it with elevated privilege to generate the.etl file.

> [!NOTE]
> This script can be modified to generate traces for any provider depending on the need. You can get the provider name from the logman query providers command as mentioned above.You may replace the highlighted field with any *event provider*, and it will generate an issue-specific trace within minutes.

In order to parse the resultant .etl trace, use the built-in tracerpt.exe utility to generate an .evtx file that can be used for further interpretation.  

An example of this command is:

```console
tracerpt c:\admin_wmi.etl -o c:\admin_wmi.etl.evtx -of EVTX
```
