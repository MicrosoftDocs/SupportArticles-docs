---
title: Status Code 0x32 and You Can't Join a Domain
description: Helps resolve an issue in which you can't join a domain with status code 0x32. This issue is related to the failure to establish an SMB session to a DC.
ms.date: 03/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Status code 0x32 and you can't join a domain

This article helps resolve an issue in which you can't join a domain with status code 0x32. This issue is related to the failure to establish a Server Message Block (SMB) session to a domain controller (DC).

You fail to join a domain and receive one of the following error messages:

- > Can't join this domain. Contact your IT admin for more info.

- > The following error occurred attempting to join the domain "adatum.com":
  >
  > The request is not supported.

When you check the **NetSetup.log** file, you see the following entries:

```output
NetpDsGetDcName: failed to find a DC having account 'CLIENT101$': 0x525, last error is 0x0
NetpDsGetDcName: status of verifying DNS A record name resolution for 'AdatumDC2.adatum.com': 0x0
NetpDsGetDcName: found DC '\\AdatumDC2.adatum.com' in the specified domain
NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
NetpDisableIDNEncoding: using FQDN adatum.com from dcinfo
NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on 'adatum.com' succeeded
NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
NetUseAdd to \\AdatumDC2.adatum.com\IPC$ returned 50
NetpJoinDomainOnDs: status of connecting to dc '\\AdatumDC2.adatum.com': 0x32
NetpJoinDomainOnDs: Function exits with status of: 0x32
NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on 'adatum.com' returned 0x0
NetpJoinDomainOnDs: NetpResetIDNEncoding on 'adatum.com': 0x0
NetpDoDomainJoin: status: 0x32
```

Here's more information about the error code:

|Hexadecimal error  |Decimal error  |Symbolic error string  |Error description  |
|---------|---------|---------|---------|
|0x32     |50         |ERROR_NOT_SUPPORTED         |The request is not supported.         |

## The security policy is set incorrectly

The **NetSetup.log** file shows that the client can't establish an SMB session with the DC. In the network trace, the SMB SESSION SETUP response has an error `NT Status: System – Error. Code  = (187) STATUS_NOT_SUPPORTED`. It indicates that the DC returns `STATUS_NOT_SUPPORTED` to the C SESSION SETUP request from the client. The DC rejects the client's credentials in the C SESSION SETUP request, which is the initial step of NT LAN Manager (NTLM) authentication.

```output
192.168.100.13	192.168.100.10	TCP	TCP:Flags=......S., SrcPort=56384, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4103153181, Ack=0, Win=65535
192.168.100.10	192.168.100.13	TCP	TCP:Flags=...A..S., SrcPort=Microsoft-DS(445), DstPort=56384, PayloadLen=0, Seq=74752361, Ack=4103153182, Win=65535
192.168.100.13	192.168.100.10	TCP	TCP:Flags=...A...., SrcPort=56384, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4103153182, Ack=74752362, Win=255
192.168.100.13	192.168.100.10	SMB	SMB:C; Negotiate, Dialect = NT LM 0.12, SMB 2.002, SMB 2.???
192.168.100.10	192.168.100.13	SMB2	SMB2:R   NEGOTIATE (0x0), GUID={<GUID>}
192.168.100.13	192.168.100.10	SMB2	SMB2:C   NEGOTIATE (0x0), GUID={<GUID>}
192.168.100.10	192.168.100.13	SMB2	SMB2:R   NEGOTIATE (0x0), GUID={<GUID>}
192.168.100.13	192.168.100.10	SMB2	SMB2:C   SESSION SETUP (0x1)
192.168.100.10	192.168.100.13	SMB2	SMB2:R  - NT Status: System - Error, Code = (187) STATUS_NOT_SUPPORTED  SESSION SETUP (0x1)
192.168.100.13	192.168.100.10	TCP	TCP:Flags=...A.R.., SrcPort=56384, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4103153717, Ack=74753066, Win=0
```

If you establish an SMB session to the DC from a workstation in the domain, it succeeds by using the hostname and fails by using the IP. For example:

```console
C:\users\administrator.adatum>net use \\192.168.2.254\ipc$
System error 53 has occurred.

The network path was not found.

C:\users\administrator.adatum>net use \\adatumdc2\ipc$
The operation completed successfully.
```

> [!NOTE]
> You might also get error 67 when using the IP.

However, the network trace pattern shows the same. It seems that the DC doesn't accept NTLM authentication. Status code 0x32 occurs because the security policy **Network security: Restrict NTLM: Incoming NTLM traffic** is incorrectly set to **Deny all accounts**.

## Change the security policy setting

To resolve this error, change the security policy setting to **Allow all** and refresh the group policy on that DC.

## More information

There are seven security policies related to NTLM.

- For auditing purposes:

  - **Network security: Restrict NTLM: Audit Incoming NTLM Traffic**
  - **Network security: Restrict NTLM: Audit NTLM authentication in this domain**

- For exceptions:

  - **Network security: Restrict NTLM: Add remote server exceptions for NTLM authentication**
  - **Network security: Restrict NTLM: Add server exceptions in this domain**

    > [!NOTE]
    > The two exception lists are for the client and the DC, respectively. There's no exception list for the server role in NTLM authentication.

- To control whether NTLM is allowed or not at each of the three roles in a complete NTLM authentication process:

  - The client, which initiates the outgoing connection using NTLM

    **Network security: Restrict NTLM: Outgoing NTLM traffic to remote servers**
  - The server, which accepts the incoming connection using NTLM

    **Network security: Restrict NTLM: Incoming NTLM traffic**
  - The DC, which validates the NTLM authentication request from the server

    **Network security: Restrict NTLM:  NTLM authentication in this domain**
