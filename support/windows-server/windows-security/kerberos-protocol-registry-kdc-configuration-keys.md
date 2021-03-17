---
title: Registry entries about Kerberos protocol and Key Distribution Center (KDC)
description: Lists the registry entries in Windows Server that can be used for Kerberos protocol testing and troubleshooting Kerberos authentication issues.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Kerberos authentication
ms.technology: windows-server-security
---
# Kerberos protocol registry entries and KDC configuration keys in Windows

This article describes registry entries about Kerberos version 5 authentication protocol and Key Distribution Center (KDC) configuration.

_Original product version:_ &nbsp; Windows 10, version 2004, Windows 7 Service Pack 1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 837361

## Summary

Kerberos is an authentication mechanism that is used to verify user or host identity. Kerberos is the preferred authentication method for services in Windows.

If you are running Windows, you can modify Kerberos parameters to help troubleshoot Kerberos authentication issues, or to test the Kerberos protocol. To do so, add or modify the registry entries that are listed in the following sections.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).
  
> [!NOTE]
> After you finish troubleshooting or testing the Kerberos protocol, remove any registry entries that you add. Otherwise, performance of your computer may be affected.

## Registry entries and values under the Parameters key

The registry entries that are listed in this section must be added to the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`

> [!NOTE]
> If the **Parameters** key isn't listed under **Kerberos**, you must create the key.

- Entry: SkewTime

  - Type: REG_DWORD
  - Default Value: 5 (minutes)

    This value is the maximum time difference that's permitted between the client computer and the server that accepts Kerberos authentication.

- Entry: LogLevel

  - Type: REG_DWORD
  - Default Value: 0

    This value indicates whether events are logged in the system event log. If this value is set to any non-zero value, all Kerberos-related events are logged in the system event log.

    > [!NOTE]
    > The events logged may include false positives where the Kerberos client retries with different request flags that then succeed. Therefore, do not assume that you have a Kerberos problem when you see an event logged based on this setting. See [How to enable Kerberos event logging](https://support.microsoft.com/help/262177) for more information.

- Entry: MaxPacketSize

  - Type: REG_DWORD
  - Default Value: 1465 (bytes)

    This value is the maximum User Datagram Protocol (UDP) packet size. If the packet size exceeds this value, TCP is used.

    The default for this value in Windows Vista and later version of Windows is 0, so UDP is never used by the Windows Kerberos Client.

- Entry: StartupTime

  - Type: REG_DWORD
  - Default Value: 120 (seconds)

    This value is the time that Windows waits for the KDC to start before Windows gives up.

- Entry: KdcWaitTime

  - Type: REG_DWORD
  - Default Value: 10 (seconds)

    This value is the time Windows waits for a response from a KDC.

- Entry: KdcBackoffTime

  - Type: REG_DWORD
  - Default Value: 10 (seconds)

    This value is the time between successive calls to the KDC if the previous call failed.

- Entry: KdcSendRetries

  - Type: REG_DWORD
  - Default Value: 3

    This value is the number of times that a client will try to contact a KDC.

- Entry: DefaultEncryptionType

  - Type: REG_DWORD

    This value indicates the default encryption type for pre-authentication.
    Default value is RC4 is 23 (decimal) or 0x17 (hexadecimal)

    When you want to use AES, set the value to the following:

    - aes256-cts-hmac-sha1-96: 18 or 0x12
    - aes128-cts-hmac-sha1-96: 17 or 0x11

    This value indicates the default encryption type for pre-authentication.

- Entry: FarKdcTimeout

  - Type: REG_DWORD
  - Default Value: 10 (minutes)

    This is the time-out value that is used to invalidate a domain controller from a different site in the domain controller cache.

- Entry: NearKdcTimeout

  - Type: REG_DWORD
  - Default Value: 30 (minutes)

    This is the time-out value that is used to invalidate a domain controller in the same site in the domain controller cache.

- Entry: StronglyEncryptDatagram

  - Type: REG_BOOL
  - Default Value: FALSE

    This value contains a flag that indicates whether to use 128-bit encryption for datagram packets.

- Entry: MaxReferralCount

  - Type: REG_DWORD
  - Default Value: 6

    This value is the number of KDC referrals that a client pursues before the client gives up.

- Entry: KerbDebugLevel

  - Type: REG_DWORD
  - Default Value: 0xFFFFFFFF

    This value is a list of flags that indicate the type and the level of logging that is requested. This kind of logging can be collected on the component level of Kerberos by bitwise or by one or more of the macros that are described in the following table. Some of the below output requires checked version of kerberos.dll (for example the DEB_TRACE_SPN_CACHE). If this level of troubleshooting is required, contact microsoft support for assistance.

    |Macro Name|Value|Note|
    |---|---|---|
    |DEB_ERROR|0x00000001|This is the default InfoLevel for checked builds. This produces error messages across components.|
    |DEB_WARN|0x00000002|This macro generates warning messages across components. In some cases, these messages can be ignored.|
    |DEB_TRACE|0x00000004|This macro enables general tracing events.|
    |DEB_TRACE_API|0x00000008|This macro enables user API tracing events that are logged on entry and on exit to an externally exported function that is implemented through SSPI.|
    |DEB_TRACE_CRED|0x00000010|This macro enables credentials tracing.|
    |DEB_TRACE_CTXT|0x00000020|This macro enables context tracing.|
    |DEB_TRACE_LSESS|0x00000040|This macro enables logon session tracing.|
    |DEB_TRACE_TCACHE|0x00000080|Not implemented|
    |DEB_TRACE_LOGON|0x00000100|This macro enables logon tracing such as in `LsaApLogonUserEx2()`.|
    |DEB_TRACE_KDC|0x00000200|This macro enables tracing before and after calls to `KerbMakeKdcCall()`.|
    |DEB_TRACE_CTXT2|0x00000400|This macro enables extra context tracing.|
    |DEB_TRACE_TIME|0x00000800|This macro enables the time skew tracing that is found in Timesync.cxx.|
    |DEB_TRACE_USER|0x00001000|This macro enables user API tracing that is used together with DEB_TRACE_API and that is found mostly in Userapi.cxx.|
    |DEB_TRACE_LEAKS|0x00002000| |
    |DEB_TRACE_SOCK|0x00004000|This macro enables Winsock-related events.|
    |DEB_TRACE_SPN_CACHE|0x00008000|This macro enables events that are related to SPN cache hits and misses.|
    |DEB_S4U_ERROR|0x00010000|Not implemented|
    |DEB_TRACE_S4U|0x00020000| |
    |DEB_TRACE_BND_CACHE|0x00040000| |
    |DEB_TRACE_LOOPBACK|0x00080000| |
    |DEB_TRACE_TKT_RENEWAL|0x00100000| |
    |DEB_TRACE_U2U|0x00200000| |
    |DEB_TRACE_LOCKS|0x01000000| |
    |DEB_USE_LOG_FILE|0x02000000|Not implemented|
    ||||

- Entry: MaxTokenSize

  - Type: REG_DWORD
  - Default Value: 12000 (Decimal). Starting Windows Server 2012 and Windows 8, the default value is 48000.

    This value is the maximum value of the Kerberos token. Microsoft recommends that you set this value to less than 65535. For more information, see [Problems with Kerberos authentication when a user belongs to many groups](https://support.microsoft.com/help/327825).

- Entry: SpnCacheTimeout

  - Type: REG_DWORD
  - Default Value: 15 minutes

    This value is used by the system when purging Service Principal Names (SPN) cache entries. On domain controllers, the SPN cache is disabled. Clients and member servers use this value to age out and purge negative cache entries (SPN not found). Valid SPN cache entries (for example, not negative cache) are not deleted after 15 minutes of creation. However, the **SPNCacheTimeout** value is also used to reduce the SPN cache to a manageable size - when the SPN cache reaches 350 entries the system will use this value to `scavenge / cleanup` old and unused entries.

- Entry: S4UCacheTimeout

  - Type: REG_DWORD
  - Default Value: 15 minutes

    This value is the lifetime of the S4U negative cache entries that are used to restrict the number of S4U proxy requests from a particular computer.

- Entry: S4UTicketLifetime

  - Type: REG_DWORD
  - Default Value: 15 minutes

    This value is the lifetime of tickets that are obtained by S4U proxy requests.

- Entry: RetryPdc

  - Type: REG_DWORD
  - Default Value: 0 (false)
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether the client will contact the primary domain controller for Authentication Service Requests (AS_REQ) if the client receives a password expiration error.

- Entry: RequestOptions

  - Type: REG_DWORD
  - Default Value: Any RFC 1510 value

    This value indicates whether there are more options that must be sent as KDC options in Ticket Granting Service requests (TGS_REQ).

- Entry: ClientIpAddress

  - Type: REG_DWORD
  - Default Value: 0 (This setting is 0 because of Dynamic Host Configuration Protocol and network address translation issues.)
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether a client IP address will be added in AS_REQ to force the **`Caddr`** field to contain IP addresses in all tickets.

- Entry: TgtRenewalTime

  - Type: REG_DWORD
  - Default Value: 600 seconds

    This value is the time that Kerberos waits before it tries to renew a Ticket Granting Ticket (TGT) before the ticket expires.

- Entry: AllowTgtSessionKey

  - Type: REG_DWORD
  - Default Value: 0
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether session keys are exported with initial or with cross realm TGT authentication. The default value is false for security reasons.

    > [!NOTE]
    > With active Credential Guard in Windows 10 and later versions of Windows, you cannot enable sharing the TGT session keys with applications anymore.  

## Registry entries and values under the Kdc key

The registry entries that are listed in this section must be added to the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Kdc`

> [!NOTE]
> If the Kdc key is not listed under Services, you must create the key.

- Entry: KdcUseClientAddresses

  - Type: REG_DWORD
  - Default Value: 0
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether IP addresses will be added in the Ticket-Granting Service Reply (TGS_REP).

- Entry: KdcDontCheckAddresses

  - Type: REG_DWORD
  - Default Value: 1
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether IP addresses for the TGS_REQ and the TGT **`Caddr`** field will be checked.

- Entry: NewConnectionTimeout

  - Type: REG_DWORD
  - Default Value: 10 (seconds)

    This value is the time that an initial TCP endpoint connection will be kept open to receive data before it disconnects.

- Entry: MaxDatagramReplySize

  - Type: REG_DWORD
  - Default Value: 1465 (decimal, bytes)

    This value is the maximum UDP packet size in TGS_REP and Authentication Service Replies (AS_REP) messages. If the packet size exceeds this value, the KDC returns a **KRB_ERR_RESPONSE_TOO_BIG** message that requests that the client switch to TCP.

    > [!NOTE]
    > Increasing **MaxDatagramReplySize** may increase the likelihood of Kerberos UDP packets being fragmented.

    For more information about this issue, see [How to force Kerberos to use TCP instead of UDP in Windows](https://support.microsoft.com/help/244474).

- Entry: KdcExtraLogLevel

  - Type: REG_DWORD
  - Default Value: 2
  - Possible values:

    - 1 (decimal) or 0x1 (hexadecimal): Audit SPN unknown errors.
    - 2 (decimal) or 0x2 (hexadecimal): Log PKINIT errors. (PKINIT is an Internet Engineering Task Force (IETF) Internet draft for *Public Key Cryptography for Initial Authentication in Kerberos*.)
    - 4 (decimal) or 0x4 (hexadecimal): Log all KDC errors.
    - 8 (decimal) or 0x8 (hexadecimal): Log KDC warning event 25 in the system log when user asking for S4U2Self ticket doesn't have sufficient access to target user.
    - 16 (decimal) or 0x10 (hexadecimal): Log audit events on encryption type (ETYPE) and bad options errors. This value indicates what information the KDC will write to event logs and to audits.

- Entry: KdcDebugLevel

  - Type: REG_DWORD
  - Default Value: 1 for checked build, 0 for free build

    This value indicates whether debug logging is on (1) or off (0).

    If the value is set to **0x10000000** (hexadecimal) or **268435456** (decimal), specific file or line information will be returned in the **edata** field of **KERB_ERRORS** as **PKERB_EXT_ERROR** errors during a KDC processing failure.
