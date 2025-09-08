---
title: Event 142 time service stopped advertising
description: Provides a resolution for event 142 that the time service has stopped advertising as a time source.
ms.date: 03/20/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
---
# Event 142: The time service has stopped advertising as a time source

This article provides a resolution for event 142: The time service has stopped advertising as a time source.

_Applies to:_ &nbsp; Windows Server (All supported versions)  
_Original KB number:_ &nbsp; 2468336

## Symptoms

Microsoft-Windows-Time-Service Event 142 is logged with one of four error strings listed in the table below (less the event_\<hex error> string:  
>Log Name:      System  
 Source:        Microsoft-Windows-Time-Service  
 Date:          \<date> \<time>  
 Event ID:      142  
 Task Category: None  
 Level:         Warning  
 Keywords:  
 User:          LOCAL SERVICE  
 Computer:      \<hostname>.\<domain name>.\<top level domain>  
 Description:  

|Error status| Error string |
|---|---|
|event_0x0038| The time service has stopped advertising as a time source because the local machine is not an Active Directory Domain Controller. |
|event_0x0039| The time service has stopped advertising as a time source because there are no providers running. |
|event_0x003A| The time service has stopped advertising as a time source because there are no providers running. |
|event_0x003B| The time service has stopped advertising as a good time source. |
|| The local clock is not synchronized |

>Event Xml:  
 \<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`">  
   \<System>  
     \<Provider Name="Microsoft-Windows-Time-Service" Guid="{06EDCFEB-0FD0-4E53-ACCA-A6F8BBF81BCB}" />  
     \<EventID>142\</EventID>  
     \<Version>0\</Version>  
     \<Level>3\</Level>  
     \<Task>0\</Task>  
     \<Opcode>0\</Opcode>  
     \<Keywords>0x8000000000000000\</Keywords>  
     \<TimeCreated SystemTime="YYYY-MM-DDTHH:MM:SS.MSZ" />  
     \<EventRecordID>3965\</EventRecordID>  
     \<Correlation />  
     \<Execution ProcessID="\<PID\>" ThreadID="\<TID\>" />  
     \<Channel>System\</Channel>  
     \<Computer>`DC1.contoso.com`\</Computer>  
     \<Security UserID="\<SID\>" />  
   \</System>  
   \<EventData Name="TMP_EVENT_STOP_ADVERTISING">  
   \</EventData>  
 \</Event>  

## Cause

| Error string| Cause |
|---|---|
| The time service has stopped advertising as a time source because the local machine is not an Active Directory Domain Controller.| The local machine no longer host the DC role or there is a configuration problem with the local machine. |
| The time service has stopped advertising as a time source because there are no providers running.|  The NTP client service has stopped or is non-responsive |
| The time service has stopped advertising as a time source because there are no providers running.|  Time on the local computer has fallen out of sync with its peer |
| The time service has stopped advertising as a good time source.|  The local DC is unable to locate a time server |
  
## Resolution

The dominant error string logged by Microsoft-Windows-Time-Service Event 142 is the third example:
>"The time service has stopped advertising as a time source because there are no providers running."  

1. Execute the action plan in Technet's "[Event ID 142 - Time Service Advertisement](https://technet.microsoft.com/library/cc756500%28WS.10%29.aspx)"

2. Verify that the forest root PDC is online, healthy and that the current root domain PDC is both (1.) correctly configured to sync time with an external time source and (2.) able to reliably source time from that source.

3. Verify service startup values and service state: automatic + running

4. Verify that the DC logging the 142 event can discovery a time server using `DCLocator`

    >nltest /dsgetdc:\<dns domain> /timeserv /force  
    >nltest /dsgetdc:\<dns domain> /gtimeserv /force <- if a gtimesrv is configured in the environment

5. Verify port and protocol connectivity to peer time servers

    >w32tm /query /source

6. Check for the use of dueling time protocols by looking for the following events:  

    |Microsoft-Windows-Time-Service event 35|note the protocol + source DC in event|
    |---|---|
    |Microsoft-Windows-Time-Service event 37|\<note the protocol + source DC in event|
    |Microsoft-Windows-Kernel-General event 1.| The Microsoft-Windows-Kernel-General event 1 indicates that time has been changed in the VM. Every time W32time updates the clock, this event is logged. Every time Hyper-V Time Synch updates the clock, Microsoft-Windows-Kernel-General event 1 is logged. This event is not specific to VMs as it is also logged in physical machines when w32time updates the clock |

7. Other root causes

    AnnounceFlags = 10 on forest-root PDC. This setting may be explicitly set or in the registry or defined in group policy.

    If the computer logging Microsoft-Windows-Time-Service event 142 is a virtualized guest computer residing on a Hyper-V host, disable VMICTimeSync on the Hyper-V host.

## More information

Real-world customer experience  
RDP logons from `\\workstation1`  (joined to the `fabrikam.com` domain) to `\\DC1`  in the untrusted `contoso.com` domain fails with the following error:  

>Title Bar text: Remote Desktop Connection  
>
>Dialog message text: Remote Desktop cannot verify the identity of the remote computer because there is a time or date difference between your computer and the remote computer. Make sure your computer's clock is set to the correct time, and then try the connecting again. If the problem occurs again, contact your network administrator or the owner of the remote computer  

The `contoso.com` domain contains two virtualized DCs, `\\DC1`and `\\DC2` running on the same W2K8 R2 Hyper-V host. The Hyper-V host computer for `\\DC1` and `\\DC2` is a member server in the `fabrikam.com` domain  - that is, the same domain as the RDCP client, `\\workstation1`.

The system time on `\\workstation1` is reported as being seconds apart from the system time on `\\DC1`.
The system time on `\\DC2.contoso.com` domain was reported as being 45 minutes from current time and the time that existed on `\\DC1`.

For more information about how to troubleshoot the error, see ["Remote Desktop cannot verify the identity of the remote computer" when connecting to a remote machine](../remote/remote-desktop-cannot-verify-identity-connecting-remote-machine.md).

A review of the SYSTEM event log to look for Kerberos and Time-related errors showed the following events.

Microsoft-Windows-Time-Service Event 142 was logged on `\\DC2.contoso.com`. The primary cause if the 142 error is the inability to locate a time server or sync from a peer server.  

>Log Name:      System  
 Source:        Microsoft-Windows-Time-Service  
 Date:          \<date> \<time>  
 Event ID:      142  
 Task Category: None  
 Level:         Warning  
 Keywords:  
 User:          LOCAL SERVICE  
 Computer:      `DC2.contoso.com`  
 Description:  
 The time service has stopped advertising as a time source because the local clock is not synchronized.  
 Event Xml:  
 \<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`">  
   \<System>  
     \<Provider Name="Microsoft-Windows-Time-Service" Guid="{*\<GUID>*}" />  
     \<EventID>142\</EventID>  
     \<Version>0\</Version>  
     \<Level>3\</Level>  
     \<Task>0\</Task>  
     \<Opcode>0\</Opcode>  
     \<Keywords>0x8000000000000000\</Keywords>  
     \<TimeCreated SystemTime="YYYY-MM-DDTHH:MM:SS.MSZ" />  
     \<EventRecordID>3965</EventRecordID>  
     \<Correlation />  
     \<Execution ProcessID="\<PID\>" ThreadID="\<TID\>" />  
     \<Channel>System\</Channel>  
     \<Computer>DC1.contoso.com\</Computer>  
     \<Security UserID="\<SID\>" />  
   \</System>  
   \<EventData Name="TMP_EVENT_STOP_ADVERTISING">  
   \</EventData>  
 \</Event>  

Microsoft-WIndows-Time-Service event 35 logged on the console of `\\DC1.contoso.com` indicates that PDC `\\DC1` is using the VM IC time sync provider to sync time.  

>Log Name:      System  
 Source:        Microsoft-Windows-Time-Service  
 Date:          \<date> \<time>  
 Event ID:      35  
 Task Category: None  
 Level:         Information  
 Keywords:  
 User:          LOCAL SERVICE  
 Computer:      `dc1.contoso.com`  
 Description:  
 The time service is now synchronizing the system time with the time source VM IC Time Synchronization Provider.  
 Event Xml:  
 \<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`"  
   \<System>  
     \<Provider Name="Microsoft-Windows-Time-Service" Guid="{*\<GUID>*}" />  
     \<EventID>35\</EventID>  
     \<Version>0\</Version>  
     \<Level>4\</Level>  
     \<Task>0\</Task>  
     \<Opcode>0\</Opcode>  
     \<Keywords>0x8000000000000000\</Keywords>  
     \<TimeCreated SystemTime="*\<DateTime>*" />  
     \<EventRecordID>2614\</EventRecordID>  
     \<Correlation />  
     \<Execution ProcessID="1012" ThreadID="2508" />  
     \<Channel>System\</Channel>  
    \<Computer>dc1.contoso.com\</Computer>  
     \<Security UserID="\<sid>" />  
   \</System>  
   \<EventData Name="TMP_EVENT_TIME_SOURCE_CHOSEN">  
     \<Data Name="TimeSource">VM IC Time Synchronization Provider</Data>  
   \</EventData>  
 \</Event>  

 Microsoft-WIndows-Time-Service event 37 logged on the console `\\DC2.contoso.com` indicates that `\\DC2` is also sourcing NTP time from `\\DC1.contoso.com`  

>Log Name:      System  
 Source:        Microsoft-Windows-Time-Service  
 Date:          \<date>\<time>  
 Event ID:      37  
 Task Category: None  
 Level:         Information  
 Keywords:  
 User:          LOCAL SERVICE  
 Computer:      `DC2.contoso.com`  
 Description:  
 The time provider NtpClient is currently receiving valid time data from `jwesth-t1.jwesth.nttest.microsoft.com` (ntp.d|[::]:123->[2001:4898:1b:4:6dd6:3c5c:699d:38cd]:123).  
 Event Xml:  
 \<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`">  
   \<System>  
     \<Provider Name="Microsoft-Windows-Time-Service" Guid="{*\<GUID>*}" />  
     \<EventID>37</EventID>  
     \<Version>0</Version>  
     \<Level>4</Level>  
     \<Task>0</Task>  
     \<Opcode>0</Opcode>  
     \<Keywords>0x8000000000000000\</Keywords>  
     \<TimeCreated SystemTime="*\<DateTime>*" />  
     \<EventRecordID>3972</EventRecordID>  
     \<Correlation />  
     \<Execution ProcessID="1012" ThreadID="1596" />  
     \<Channel>System\</Channel>  
     \<Computer>DC2.contoso.com\</Computer>  
     \<Security UserID="\<sid>" />  
   \</System>  
   \<EventData Name="TMP_EVENT_TIME_SOURCE_REACHABLE">  
     \<Data Name="TimeSource">`dc1.contoso.com` (ntp.d|[::]:123-&gt;[2001:4898:1b:4:6dd6:3c5c:699d:38cd]:123)</Data>  
   \</EventData>  
 \</Event>  

Another event, Microsoft-Windows-Kernel-General, which was not logged in this particular case, indicates that the Hyper-V host computer may be changing time on VM guests computers. A sample event is shown below.  

>Log Name:      System  
Source:        Microsoft-Windows-Kernel-General  
Date:          \<date> \<time>  
Event ID:      1  
Task Category: None  
Level:         Information  
Keywords:      Time  
User:          LOCAL SERVICE  
Computer:      \<hostname>.\<DNS domain>.\<top level domain>  
Description:  
The system time has changed to ‎\<new time in the format "like" 2010‎-‎08‎-‎26T20:40:07.210000000Z > from \<old time in the format "like" ‎2010‎-‎08‎-‎26T20:40:07.210642400Z>.  

 That Microsoft-Windows-Kernel-General event 1 indicates that time has been changed in the VM. Every time W32time updates the clock, this event is logged. Every time Hyper-V Time Synch updates the clock, Microsoft-Windows-Kernel-General event 1 is logged. This event is not specific to VMs as it is also logged in physical machines when w32time updates the clock.

## Problem Summary

The RDP client is believed to depend on SPNego that picks the best authentication mechanism available, and in this case used Kerberos, event though there was no trust between the fabrikam and `contoso.com` forests. Kerberos auth requires that the clocks of the two machines to be less than 5 minutes apart but does not care about the clock accuracy.

The RDP logon failure is caused by the authenticating DC in the `contoso.com` domain (DC1) refusing to authenticate the RDP client logon request because the client's time doesn't match the server's time. Either the client, or the server, or both could have an unsynchronized clock.

The time difference in this case was exacerbated by several factors  

1. The RDP Client and KDC / RDP Server existed in two different forests with each forest using different time sourcing configurations

2. The KDC and RDP Server used by the RDC client are both virtualized domain controllers that require additional configuration changes to accurately source time then DCs running on physical hardware.

3. The virtual host computer was a domain-joined member server in a different domain than the Hyper-V hosts

    Time accuracy on virtual host computers is important because VM guest computers initially derive time from virtual host computer during OS startup.

    Two negative factors for `\\DC1` and \|DC2 is that member computers poll time less frequently by default than domain controllers. Secondly, the Hyper-V host computer was joined to a different domain than the DC guests and was subject to different time source configurations

    Finally, the VMICTimeSync was used by `\\DC2` to source time that is not recommended for virtualized computers hosting the DC role computers.

4. The forest root PDC in the `contoso.com` domain was not configured to source time from an external time source

In this case, the use of multiple time providers in the `contoso.com` domain (`ntp`, VMICTimeSync) was deemed to be the root cause of the inaccurate time that lead to the RDP logon failure.

There are differing opinions about how to configure time in host and guest computers within the AD and Hyper-V teams. Ryan Sizemores recommendation as of `2010.11.22` was to leave VMIC enabled but pay close attention to the configuration and accuracy of time on the host computer. For example, the "Configuring the Windows Time service for Windows Server 2008 and Windows Server 2008 R2" section of "[Deploying W2K8 and W2K8 R2 DCs in existing domains](https://technet.microsoft.com/library/upgrade-domain-controllers-to-windows-server-2008-r2%28WS.10%29.aspx#BKMK_VM)" recommends that virtual host computers be configured with "DC-like" polling intervals and max*phase correction settings + an accurate time server, similar to what you'd do on a forest-root PDC.

The use of different time providers and time sources on the virtual host and virtual guest environments can lead to a situation where time on the guest computer will ping pong between the VMIC values passed from the host computer. This condition may exist when virtualized DC guests in one forest are hosted by virtual hosts computers in another forests or even a workgroup computer where each uses a different time source / time configuration and the time samples are different between the two.  

The Hyper-V team recommends that you don't disable VMICTimeSync as it provides protection against time synchronization issues if you used saved state. The key issue here is not the use of VMICTimeSync - but the fact that if you are running a domain controller **something** needs to be getting accurate time from a remote server. You can do it by either configurating a remote time source inside the virtual machine, or by leaving the VMICTimeSync enabled and configuring the host to use a reliable time source.  

By setting up a virtual machine with VMICTimeSync disabled - and no external time source the domain controller will use local time - which is the one thing that is always guaranteed to be wrong in a virtual machine.  

Recommendations from the Microsoft Windows time team to correct this environment consisted of:  

1. Configure the forest root PDC with an NTP Server.

2. Configure a GTIMEServer in the forest root domain as a backup

3. If using virtualization, disable VMICTimeSync (it is being evaluated

4. Configure Hyper-V hosts with an external time server

5. Configure Hyper-V hosts with the same polling intervals as domain controllers

6. Enable time rollback protection on Hyper-V hosts.

 **Useful commands**  (source: Carlos Trueba Salinas)

`net stop vmictimesync`  
`sc config vmictimesync start= disabled`  
`reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\VMICTimeProvider" /f`  
`w32tm /config /manualpeerlist:ntdev-dc-05.ntdev.corp.microsoft.com /syncfromflags:MANUAL /update`  
 `net stop w32time & net start w32time`  
 `w32tm /query /source`  
`w32tm /resync /force`  

[Event ID 142](https://technet.microsoft.com/library/cc756500%28WS.10%29.aspx) - Time Service Advertisement  
 [Time Service Advertisement](https://technet.microsoft.com/library/cc756435%28WS.10%29.aspx)  - Technet  
 [Configuring the Windows time service on the PDC emulator in the Forest root domain](https://technet.microsoft.com/library/upgrade-domain-controllers-to-windows-server-2008-r2%28WS.10%29.aspx#BKMK_VM)  
 [Configuring the Windows Time service for Windows Server 2008 and Windows Server 2008 R2](https://technet.microsoft.com/library/upgrade-domain-controllers-to-windows-server-2008-r2%28WS.10%29.aspx#BKMK_VM)  
 [Running Domain Controllers in Hyper-V](https://go.microsoft.com/fwlink/?LinkID=139651)  
 [Configuring the Windows Time Service in an Active Directory Forest - A Step by Step with a Contingency Plan](https://social.technet.microsoft.com/wiki/contents/articles/27659.configuring-the-windows-time-service-in-an-active-directory-forest-a-step-by-step-with-a-contingency-plan.aspx) 
