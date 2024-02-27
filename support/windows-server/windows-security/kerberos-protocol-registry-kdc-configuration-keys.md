---
title: Registry entries about Kerberos protocol and Key Distribution Center (KDC)
description: Lists the registry entries in Windows Server that can be used for Kerberos protocol testing and troubleshooting Kerberos authentication issues.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Kerberos protocol registry entries and KDC configuration keys in Windows

This article describes registry entries about Kerberos version 5 authentication protocol and Key Distribution Center (KDC) configuration.

_Applies to:_ &nbsp; Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 837361

## Summary

Kerberos is an authentication mechanism that's used to verify user or host identity. Kerberos is the preferred authentication method for services in Windows.

If you're running Windows, you can modify the Kerberos parameters to help troubleshoot Kerberos authentication issues, or to test the Kerberos protocol. To do so, add or modify the registry entries that are listed in the following sections.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).
  
> [!NOTE]
> After you finish troubleshooting or testing the Kerberos protocol, remove any registry entries that you add. Otherwise, the performance of your computer may be affected.

## Registry entries and values under the Parameters key

The registry entries that are listed in this section must be added to the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`

> [!NOTE]
> If the **Parameters** key isn't listed under **Kerberos**, you must create the key.

- Entry: SkewTime

  - Type: REG_DWORD
  - Default value: 5 (minutes)

    This value is the maximum time difference that's permitted between the client computer and the server that accepts Kerberos authentication or the KDC.

    > [!NOTE]
    > The SkewTime is considered in the determination of Kerberos ticket validity for reuse. A ticket is considered expired if the expiration time is less than the current time + the SkewTime. For example, if the SkewTime is set to 20 minutes and the current time is 08:00, any ticket with an expiration time before 08:20 will be considered expired.

- Entry: LogLevel

  - Type: REG_DWORD
  - Default value: 0

    This value indicates whether events are logged in the system event log. If this value is set to any non-zero value, all Kerberos-related events are logged in the system event log.

    > [!NOTE]
    > The events logged may include false positives where the Kerberos client retries with different request flags that then succeed. Therefore, don't assume that you have a Kerberos problem when you see an event logged based on this setting. For more information, see [How to enable Kerberos event logging](https://support.microsoft.com/help/262177) .

- Entry: MaxPacketSize

  - Type: REG_DWORD
  - Default value: 1465 (bytes)

    This value is the maximum User Datagram Protocol (UDP) packet size. If the packet size exceeds this value, TCP is used.

    The default for this value in Windows Vista and later version of Windows is 0, so UDP is never used by the Windows Kerberos Client.

- Entry: StartupTime

  - Type: REG_DWORD
  - Default value: 120 (seconds)

    This value is the time that Windows waits for the KDC to start before Windows gives up.

- Entry: KdcWaitTime

  - Type: REG_DWORD
  - Default value: 10 (seconds)

    This value is the time Windows waits for a response from a KDC.

- Entry: KdcBackoffTime

  - Type: REG_DWORD
  - Default value: 10 (seconds)

    This value is the time between successive calls to the KDC if the previous call failed.

- Entry: KdcSendRetries

  - Type: REG_DWORD
  - Default value: 3

    This value is the number of times that a client will try to contact a KDC.

- Entry: DefaultEncryptionType

  - Type: REG_DWORD

    This value indicates the default encryption type for pre-authentication.
    Default value for RC4 is 23 (decimal) or 0x17 (hexadecimal)

    When you want to use AES, set the value to one of the following values:

    - aes256-cts-hmac-sha1-96: 18 or 0x12
    - aes128-cts-hmac-sha1-96: 17 or 0x11

    This value indicates the default encryption type for pre-authentication.

- Entry: FarKdcTimeout

  - Type: REG_DWORD
  - Default value: 10 (minutes)

    It's the time-out value that's used to invalidate a domain controller from a different site in the domain controller cache.

- Entry: NearKdcTimeout

  - Type: REG_DWORD
  - Default value: 30 (minutes)

    It's the time-out value that's used to invalidate a domain controller in the same site in the domain controller cache.

- Entry: StronglyEncryptDatagram

  - Type: REG_BOOL
  - Default value: FALSE

    This value contains a flag that indicates whether to use 128-bit encryption for datagram packets.

- Entry: MaxReferralCount

  - Type: REG_DWORD
  - Default value: 6

    This value is the number of KDC referrals that a client pursues before the client gives up.

- Entry: MaxTokenSize

  - Type: REG_DWORD
  - Default value: 12000 (Decimal). Starting Windows Server 2012 and Windows 8, the default value is 48000.

    This value is the maximum value of the Kerberos token. Microsoft recommends that you set this value to less than 65535. For more information, see [Problems with Kerberos authentication when a user belongs to many groups](https://support.microsoft.com/help/327825).

- Entry: SpnCacheTimeout

  - Type: REG_DWORD
  - Default value: 15 minutes

    This value is used by the system when purging Service Principal Names (SPN) cache entries. On domain controllers, the SPN cache is disabled. Clients and member servers use this value to age out and purge negative cache entries (SPN not found). Valid SPN cache entries (for example, not negative cache) aren't deleted after 15 minutes of creation. However, the **SPNCacheTimeout** value is also used to reduce the SPN cache to a manageable size - when the SPN cache reaches 350 entries, the system will use this value to `scavenge / cleanup` old and unused entries.

- Entry: S4UCacheTimeout

  - Type: REG_DWORD
  - Default value: 15 minutes

    This value is the lifetime of the S4U negative cache entries that are used to restrict the number of S4U proxy requests from a particular computer.

- Entry: S4UTicketLifetime

  - Type: REG_DWORD
  - Default value: 15 minutes

    This value is the lifetime of tickets that are obtained by S4U proxy requests.

- Entry: RetryPdc

  - Type: REG_DWORD
  - Default value: 0 (false)
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether the client will contact the primary domain controller for Authentication Service Requests (AS_REQ) if the client receives a password expiration error.

- Entry: RequestOptions

  - Type: REG_DWORD
  - Default value: Any RFC 1510 value

    This value indicates whether there are more options that must be sent as KDC options in Ticket Granting Service requests (TGS_REQ).

- Entry: ClientIpAddresses

  - Type: REG_DWORD
  - Default value: 0 (This setting is 0 because of Dynamic Host Configuration Protocol and network address translation issues.)
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether a client IP address will be added in AS_REQ to force the **`Caddr`** field to contain IP addresses in all tickets.

- Entry: TgtRenewalTime

  - Type: REG_DWORD
  - Default value: 600 seconds

    This value is the time that Kerberos waits before it tries to renew a Ticket Granting Ticket (TGT) before the ticket expires.

- Entry: AllowTgtSessionKey

  - Type: REG_DWORD
  - Default value: 0
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether session keys are exported with initial or with cross realm TGT authentication. The default value is false for security reasons.

    > [!NOTE]
    > With active Credential Guard in Windows 10 and later versions of Windows, you can't enable sharing the TGT session keys with applications anymore.  

## Registry entries and values under the Kdc key

The registry entries that are listed in this section must be added to the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Kdc`

> [!NOTE]
> If the Kdc key isn't listed under Services, you must create the key.

- Entry: KdcUseClientAddresses

  - Type: REG_DWORD
  - Default value: 0
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether IP addresses will be added in the Ticket-Granting Service Reply (TGS_REP).

- Entry: KdcDontCheckAddresses

  - Type: REG_DWORD
  - Default value: 1
  - Possible values: 0 (false) or any non-zero value (true)

    This value indicates whether IP addresses for the TGS_REQ and the TGT **`Caddr`** field will be checked.

- Entry: NewConnectionTimeout

  - Type: REG_DWORD
  - Default value: 10 (seconds)

    This value is the time that an initial TCP endpoint connection will be kept open to receive data before it disconnects.

- Entry: MaxDatagramReplySize

  - Type: REG_DWORD
  - Default value: 1465 (decimal, bytes)

    This value is the maximum UDP packet size in TGS_REP and Authentication Service Replies (AS_REP) messages. If the packet size exceeds this value, the KDC returns a "KRB_ERR_RESPONSE_TOO_BIG" message that requests that the client switches to TCP.

    > [!NOTE]
    > Increasing **MaxDatagramReplySize** may increase the likelihood of Kerberos UDP packets being fragmented.

    For more information about this issue, see [How to force Kerberos to use TCP instead of UDP in Windows](https://support.microsoft.com/help/244474).

- Entry: KdcExtraLogLevel

  - Type: REG_DWORD
  - Default value: 2
  - Possible values:

    - 1 (decimal) or 0x1 (hexadecimal): Audit unknown SPN errors in the security event log. Event ID 4769 is logged with a failed audit.
    - 2 (decimal) or 0x2 (hexadecimal): Log PKINIT errors. This logs a KDC warning event ID 21 (enabled by default) to the system event log. PKINIT is an Internet Engineering Task Force (IETF) Internet draft for _Public Key Cryptography for Initial Authentication in Kerberos_.
    - 4 (decimal) or 0x4 (hexadecimal): Log all KDC errors. This logs a KDC event ID 24 (example of U2U required problems) to the system event log.
    - 8 (decimal) or 0x8 (hexadecimal): Log a KDC warning event ID 25 in the system log when the user who asks for the S4U2Self ticket doesn't have sufficient access to the target user.
    - 16 (decimal) or 0x10 (hexadecimal): Log audit events on encryption type (ETYPE) and bad options errors. This value indicates what information the KDC will write to event logs and to audits in the security event log. Event ID 4769 is logged with a failed audit.
