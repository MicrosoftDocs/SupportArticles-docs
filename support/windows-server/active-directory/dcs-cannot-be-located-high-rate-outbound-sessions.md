---
title: DCs can't be located and high-rate outbound sessions
description: Provides some resolutions for the issue in which a machine creates outbound sessions at a high rate. When this issue occurs, the Netlogon service can't locate DCs and many UDP ports are used by the LSASS process.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# Domain controllers can't be located and high-rate outbound sessions

This article describes how to troubleshoot the issue that a machine creates outbound sessions at a high rate.

_Original KB number:_ &nbsp; 4458261

When this issue occurs, the Netlogon service tries to locate domain controllers (DCs) for domain users and resources, and establish the trust path between the users and the resource domains.  

In some scenarios, the issue may affect the communication between application servers (For example, Exchange servers), or the communication between application servers and backend servers (For example, web, database, or reporting servers). If the level of application activity crosses a threshold, the application servers will fail to have sessions with each other or backend servers.

## Many UDP ports are used by the LSASS process

There are many User Datagram Protocol (UDP) ports that are used by the Local Security Authority Subsystem Service (LSASS) process.

```output
[lsass.exe]
  UDP    0.0.0.0:54335          *:*                                    908
```

In the Netlogon log file (*netlogon.log*), many entries that resemble the following are recorded:

```output
[CRITICAL] NetpDcPingListIp: INTERNAL.CONTOSO.COM: Cannot LdapOpen ip address XX.YY.ZZ.26: 58 
[CRITICAL] NetpDcPingListIp: INTERNAL.CONTOSO.COM: Cannot LdapOpen ip address XX.YY.ZZ.70: 58 
[CRITICAL] NetpDcPingListIp: INTERNAL.CONTOSO.COM: Cannot LdapOpen ip address XX.YY.ZZ.119: 58 
```

You also find requests time out. When you relate the thread ID, you can find what kind of requests time out. See the following logs for an example:

```output
[MAILSLOT] [32192] NetpDcPingListIp: INTERNAL.CONTOSO.COM: Sent UDP ping to XX.YY.ZZ.119
…
[CRITICAL] [32192] NetpDcGetPingResponse: it took 117063 msecs to poll| 
```

Eventually, the requests to locate DCs fail, and the following logs are recorded:

```output
[MISC] [32192] DsGetDcName function called: client PID=180, Dom:INTERNAL.CONTOSO.COM Acct:(null) Flags: IP KDC  
… 
[MISC] [32192] DsGetDcName function returns 1355 (client PID=180): Dom:INTERNAL.CONTOSO.COM Acct:(null) Flags: IP KDC 
```

You can check more requests to establish patterns to identify which domains are affected the most, and whether all the requests fail in the *netlogon.log* file. To search a pattern, use a command as follows:

```console
findstr DsGetDcName netlogon.log | findstr /i /c:"internal." > netlogon-internal-calls.txt
```

It helps to determine whether a DC is requested frequently because another DC is unresponsive. If you identify a DC that works slowly or unresponsive, reestablish the communication to the DCs of the domain or improve the performance.

In a memory dump of the LSASS process, threads are waiting with stack as follows:

```output
# Call Site
00 ntdll!RtlLeaveCriticalSection+0x29
01 Wldap32!ReferenceLdapRequest+0x44
02 Wldap32!LdapGetResponseFromServer+0x207
03 Wldap32!LdapWaitForResponseFromServer+0x27a
04 Wldap32!ldap_result_with_error+0x293
05 Wldap32!ldap_result+0x74
06 netlogon!NetpDcGetPingResponse+0xec
07 netlogon!NetpDcPingListIp+0x1df
08 netlogon!NetpDcGetNameSiteIp+0xa3
09 netlogon!NetpDcGetNameIp+0x188
0a netlogon!NetpDcGetName+0x11bb
0b netlogon!DsIGetDcName+0x463
0c netlogon!DsrGetDcNameEx2+0x3a0 
0d kerberos!KerbGetKdcBinding+0x8e8
0e kerberos!KerbMakeSocketCall+0x165
0f kerberos!KerbGetTgsTicketEx+0x9ee
10 kerberos!KerbGetTgsTicket+0x84
11 kerberos!KerbGetServiceTicketInternal+0x739
12 kerberos!KerbGetServiceTicket+0xca
13 kerberos!KerbILogonUserEx2+0x1b2f
14 kerberos!LsaApLogonUserEx2+0xa6
15 lsasrv!NegLogonUserEx2Worker+0x7c7
16 lsasrv!NegLogonUserEx2+0x673
17 lsasrv!LsapCallAuthPackageForLogon+0xd0
18 lsasrv!LsapAuApiDispatchLogonUser+0x4ab
19 lsasrv!SspiExLogonUser+0x20e
1a sspisrv!SspirLogonUser+0x1eb
1b rpcrt4!Invoke+0x65 
```

## UDP sockets exhaustion

When a UDP port is used, the connection is in a TIME_WAIT state before it can be reused. If applications on the system use different UDP sockets at a high rate, or if new sockets are required at a rate higher than the rate at which unused sockets are cleaned up, the system may run out of sockets. The system may go into a state that never recovers, especially if the applications retry the communication attempt frequently. In this scenario, the Netlogon service uses a new UDP socket for each DC discovery attempt.

> [!NOTE]
> The default socket range is 16384 sockets since Windows Vista.

When a DC isn't responsive (for example, DCs are offline or blocked by a firewall), the Netlogon service backs up a queue of threads waiting to resolve DCs.

## Allow more UDP sockets and reuse old sockets earlier

Configure the registry to allow more UDP sockets to be used for application requests. In addition, shorten the length of time that a connection stays in the TIME_WAIT state, so that the Transmission Control Protocol/Internet Protocol (TCP/IP) protocol can reuse old sockets earlier. Here are the steps:

1. Open **Registry Editor**.
2. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`.
3. Modify or create the registry entries as follows:

    |Value name  |Value data  |
    |---------|---------|
    |`TcpTimedWaitDelay`     |**30**         |
    |`MaxUserPort`     |**65000**         |
    |`StrictTimeWaitSeqCheck`     |**1**         |

Windows Server 2019 introduces a new registry entry that enables the Netlogon service not to use a new socket for each DC discovery attempt. The entry named `DCLocatorLdapConnectionCacheEnabled` is in the registry path `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`. The value data can be set to **1** for enabling this feature.

> [!NOTE]
> You can set the value data to **0** to disable the feature.
