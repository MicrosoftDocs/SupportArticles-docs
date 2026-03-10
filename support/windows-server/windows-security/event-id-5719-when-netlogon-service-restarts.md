---
title: Event ID 5719 - STATUS_INTERNAL_ERROR Occurs When the NetLogon Service Restarts
description: Helps you diagnose Event ID 5719 when it includes the STATUS_INTERNAL_ERROR code. Windows might log this event when the NetLogon service restarts on Windows Server 2025.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, raviks, arrenc, v-appelgatet
ms.custom:
- sap:windows security\NetLogon, secure channel, dc locator
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Event ID 5719 (STATUS_INTERNAL_ERROR) occurs when the NetLogon service restarts

This article helps you diagnose and understand the NetLogon service Event ID 5719, when the event includes the `0xC00000E5 (STATUS_INTERNAL_ERROR)` error code. Windows logs this event when the NetLogon service restarts on Windows Server systems. The event typically appears when Windows Server 2025-based member servers interact with domain controllers (DCs) that run earlier Windows Server versions.

> [!IMPORTANT]  
> This article specifically addresses the case in which Event ID 5719 includes the `0xC00000E5 (STATUS_INTERNAL_ERROR)` error code. Event 5719 can contain other error codes. and might occur in combination with other events. Those cases are outside the scope of this article. For an example of Event ID 5719 that's related to a different issue, see [Netlogon event ID 5719 or Group Policy event 1129 is logged when you start a domain member](../group-policy/netlogon-event-id-5719-or-group-policy-event-1129.md).

## Symptoms

Each time the NetLogon service restarts on a Windows Server 2025 system, Windows logs Event ID 5719 (STATUS_INTERNAL_ERROR) in the System event log. The event text resembles the following excerpt:

> This computer was not able to set up a secure session with a DC in domain [domain name] due to the following: An internal error occurred.

The event text includes the `0xC00000E5 (STATUS_INTERNAL_ERROR)` code.

The event doesn't persist. Windows establishes the secure channel to the DC. Then, normal domain operations resume.

The event occurs even though you didn't make any recent configuration, update, or software changes. Typically, you only see this behavior in particular environments:

| Member server | Authenticating DC | Event and code |
| - | - | - |
| Windows Server 2025 | Windows Server 2025 | No Event ID 5719 |
| Windows Server 2025 | Windows Server 2022 | Event ID 5719, `0xC00000E5 (STATUS_INTERNAL_ERROR)` |
| Windows Server 2025 | Windows Server 2019 | Event ID 5719, `0xC00000E5 (STATUS_INTERNAL_ERROR)` |

## Cause

When the NetLogon service restarts in mixed Windows Server environments (Windows Server 2025 member servers and Windows Server 2022 or Windows Server 2019 DCs), Windows generates Event ID 5719 (STATUS_INTERNAL_ERROR). As long as the secure channel is established, this event is expected and harmless.

The error occurs because of protocol differences in Kerberos authentication support. The error doesn't indicate a functional problem unless it keeps occurring in circumstances other than the circumstances that this article discusses.

When a Windows Server 2025 member server tries to establish a secure channel to a DC that runs Windows Server 2022 or an earlier version, it starts the connection by using the new Kerberos authentication method. Older DCs don't support this new authentication Remote Procedure Call (RPC) call. Because of this lack of support, authentication fails and Windows logs Event ID 5719 (STATUS_INTERNAL_ERROR). In this situation, the system automatically falls back to the legacy NetLogon method to successfully establish the secure channel.

This sequence causes a single, harmless error event. You can safely ignore this event unless you also see ongoing authentication or connectivity problems.

## Resolution

Event ID 5719 (STATUS_INTERNAL_ERROR) might occur only one time when NetLogon restarts and the secure channel is established (domain operations proceed without any issues). In this case, the event is harmless. Don't try remediation unless you see other persistent authentication or secure channel issues.

Microsoft recognizes this event as expected in mixed-version environments. Microsoft might suppress or clarify this event in future updates or documentation.

> [!IMPORTANT]  
> If the error recurs outside of NetLogon restarts, or it coincides with domain trust or authentication failures, investigate further. Collect the log data, as described in [Collecting log data](#collecting-log-data), and then contact Microsoft Support.

### Workaround (optional)

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

As part of the transition to Windows Server 2025 or newer DCs that support Kerberos for secure channel setup, temporarily configure the following registry setting. Configure this setting on Kerberos-capable member computers that also run NetLogon.

This change suppresses the logging of Event ID 5719 (STATUS_INTERNAL_ERROR). After you deploy enough Windows Server 2025 or newer Kerberos-capable DCs in the domain to ensure reliable Kerberos-based secure channel establishment, remove the registry setting.

- **Registry subkey**: `HKLM\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters`

- **Registry entry details**:

  - Name: `UseKerberosForSecureChannels`
  - Type: `REG_DWORD`
  - Value: `0`

To use a Windows command-line prompt to apply this change, run the following command:

```console
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters" /v UseKerberosForSecureChannels /t REG_DWORD /d 0 /f
```

To use a Windows PowerShell prompt to apply this fix, run the following command:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters" -Name "UseKerberosForSecureChannels" -Value 0 -Type DWord
```

Apply this configuration only temporarily. After the domain environment is adequately updated, remove the registry change.

## Collecting log data

Collect the following logs:

- **System event logs**. Focus on entries for Event ID 5719 (Source: NetLogon).

- **NetLogon service logs**. If you need deeper analysis, turn on NetLogon debugging.

### Collecting system event logs

```console
wevtutil qe System "/q:*[System[(EventID=5719)]]" /f:text /c:50
```

### Enabling NetLogon debug logging

```console
nltest /dbflag:0x2080ffff
```

Windows writes these log entries to %systemroot%\debug\NetLogon.log.

To turn off logging, run the `nltest /dbflag:0x0` command.

## More information

The event is specific to Windows Server 2025 member servers that authenticate by using DCs that run earlier versions of Windows. In the same scenario, Windows Server 2019 and Windows Server 2022 member servers don't log Event ID 5719 (STATUS_INTERNAL_ERROR).

Windows Server 2025 systems that authenticate by using Windows Server 2025 DCs don't log Event ID 5719 (STATUS_INTERNAL_ERROR).

### Log entries in NetLogon.log that trace the secure channel process

When Windows initially tries to establish the secure channel, it uses Kerberos. Windows logs an entry that resembles the following excerpt:

```output
 [INIT] [10664]    UseKerberosForSecureChannels = TRUE
```

The DC refuses this first attempt. On the member server, Windows receives an error message that resembles the following log excerpt:

```output
[SESSION] [3036] CONTOSO: NlDiscoverDc: Found DC \\CONTOSODC.CONTOSO.com
[SESSION] [3036] CONTOSO: NlSessionSetup: Denied access as we could not authenticate with Kerberos 0xC002002E
[CRITICAL] [3036] Assertion failed: ClientSession->CsState == CS_IDLE (Source File: onecore\ds\netapi\svcdlls\logonsrv\server\lsrvutil.c, line 3963)
[SESSION] [3036] CONTOSO: NlSessionSetup: Denied access as we could not authenticate with Kerberos (translated status) 0xC00000E5
[SESSION] [3036] CONTOSO: NlSetStatusClientSession: Set connection status to c00000e5
[SESSION] [3036] CONTOSO: NlSetStatusClientSession: Unbind from server \\CONTOSODC.CONTOSO.com (TCP) 0.
[MISC] [3036] Eventlog: 5719 (1) "CONTOSO" 0xc00000e5 3dc54378 84808124 847d677c e2aadc59   xC.=$...|g}.Y...
[SESSION] [3036] CONTOSO: NlSetStatusClientSession: Set connection status to c000005e
[SESSION] [3036] CONTOSO: NlSessionSetup: Session setup Failed[AC3]
```

Windows tries again to create the secure channel. This time, it works. Windows logs entries that resemble the following excerpt:

```output
[SESSION] [10664] CONTOSO: NlSessionSetup: Try Session setup
[SESSION] [10664] CONTOSO: NlDiscoverDc: Start Synchronous Discovery
[MISC] [10664] NetpDcInitializeContext: DSGETDC_VALID_FLAGS is c3fffff1
[MAILSLOT] [10664] NetpDcPingListIp: CONTOSO.COM.: Sending UDP ping to 10.32.51.12 ...
…
[MISC] [10664] NetpDcAllocateCacheEntry: new entry 0x0000020544B6E450 -> DC:CONTOSODC DnsDomName:CONTOSO.COM Flags:0x3f1fd
[MISC] [10664] NetpDcGetName: NetpDcGetNameIp for CONTOSO.COM. returned 0
```

Windows also records the Security-NetLogon Event ID 9005 in the Applications and Service Logs\Microsoft\Windows\Security-NetLogon\Operational event log. The log entry resembles the following excerpt:

```output
Source: Security-NetLogon
Event ID 9005
Task Category: Secure channel setup
Secure channel setup has failed with Kerberos: An internal error occurred.
Falling back to NetLogon.
```
