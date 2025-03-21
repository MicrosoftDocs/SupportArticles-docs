---
title: Status code 0x32 and you can't join a domain
description: Helps resolve an issue in which you can't join a domain with status code 0x32. This issue is related to the failure to establish a Server Message Block (SMB) session to the domain controller (DC).
ms.date: 03/21/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Status code 0x32 and you can't join a domain

This article helps resolve an issue in which you can't join a domain with status code 0x32. This issue is related to the failure to establish a Server Message Block (SMB) session to the domain controller (DC).

You fail to join a domain and receive one of the following error messages:

- > Can't join this domain. Contact your IT admin for more info.

    :::image type="content" source="media/status-code-0x32-cannot-join-domain/cannot-join-domain-contact-it.png" alt-text="Screenshot of the error message showing that you can't join a domain and need to contact IT.":::

- > The following error occurred attempting to join the domain "adatum.com":
  >
  > The request is not supported.

    :::image type="content" source="media/status-code-0x32-cannot-join-domain/error-occurred-request-not-support.png" alt-text="Screenshot of the error message showing that an error occurred and the request isn't supported.":::

When you check the **NetSetup.log** file, you see the following entries:

```output
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: failed to find a DC having account 'CLIENT101$': 0x525, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: status of verifying DNS A record name resolution for 'AdatumDC2.adatum.com': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: found DC '\\AdatumDC2.adatum.com' in the specified domain
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDisableIDNEncoding: using FQDN adatum.com from dcinfo
mm/dd/yyyy hh:mm:ss:ms NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on 'adatum.com' succeeded
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
mm/dd/yyyy hh:mm:ss:ms NetUseAdd to \\AdatumDC2.adatum.com\IPC$ returned 50
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of connecting to dc '\\AdatumDC2.adatum.com': 0x32
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x32
mm/dd/yyyy hh:mm:ss:ms NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on 'adatum.com' returned 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpResetIDNEncoding on 'adatum.com': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x32
```

Here's more information about the error code:

|HEX error  |Decimal error  |Symbolic error string  |Error description  |
|---------|---------|---------|---------|
|0x32     |50         |ERROR_NOT_SUPPORTED         |The request is not supported.         |

## The security policy is set incorrectly

The **NetSetup.log** file shows that the client fails to establish an SMB session with the DC. If you examine the network trace, it indicates that the DC returns STATUS_NOT_SUPPORTED to the C SESSION SETUP request from the client. The DC rejects the client's credential in the C SESSION SETUP request, which is the initial step of NT LAN Manager (NTLM) authentication.

:::image type="content" source="media/status-code-0x32-cannot-join-domain/network-trace-ntlm-authentication.png" alt-text="Screenshot of the network trace showing the DC returns STATUS_NOT_SUPPORTED to the C SESSION SETUP request from the client.":::

If you establish an SMB session to the DC from a workstation in the domain, it succeeds by using the hostname and fails by using the IP.

:::image type="content" source="media/status-code-0x32-cannot-join-domain/succeed-hostname-fails-ip.png" alt-text="Screenshot of a command window showing that establishing an SMB session succeeds by using the hostname and fails by using the IP.":::

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
