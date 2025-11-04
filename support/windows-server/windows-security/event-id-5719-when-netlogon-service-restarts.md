---
title: Event ID 5719 occurs when the NetLogon service restarts
description: Helps you diagnose and understand Event ID 5719 (NetLogon). Windows logs this event when you restart the NetLogon service on Windows Server systems. The event appears especially when Windows Server 2025 member servers interact with domain controllers that run earlier Windows Server versions.
ms.date: 11/04/2025
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
# Event ID 5719 occurs when the NetLogon service restarts

This article helps you diagnose and understand Event ID 5719 (NetLogon). Windows logs this event when you restart the NetLogon service on Windows Server systems. The event appears especially when Windows Server 2025 member servers interact with domain controllers that run earlier Windows Server versions.

## Symptoms

Each time the NetLogon service restarts on a Windows Server 2025 system, Windows logs Event ID 5719 in the System event log. The event text resembles the following excerpt:

> This computer was not able to set up a secure session with a domain controller in domain [domain name] due to the following: An internal error occurred.

The event text might include the `0xC00000E5 (STATUS_INTERNAL_ERROR)` code.

The event doesn't persist. Windows establishes the secure channel with the domain controller. Normal domain operations then resume.

The event occurs even though you haven't made any recent configuration, update, or software changes.

## Cause

When the NetLogon service restarts in mixed Windows Server environments (Windows Server 2025 vs. Windows Server 2022 or Windows Server 2019 domain controllers), Windows generates Event ID 5719. As long as the secure channel is established, this event is expected and harmless.

The error happens because of protocol differences in Kerberos authentication support. The error doesn't indicate a functional problem unless it keeps occurring in circumstances other than those that this article describes.

When a Windows Server 2025 member server tries to establish a secure channel with a domain controller that runs Windows Server 2022 or an earlier version, it starts the connection by using the new Kerberos authentication method. Older domain controllers don't support this new authentication Remote Procedure Call (RPC) call. Because of this lack of support, authentication fails and Windows logs Event ID 5719. The system automatically falls back to the legacy NetLogon method. This method succeeds in establishing the secure channel.

This sequence results in a single, harmless error event. You can ignore this event unless it's accompanied by ongoing authentication or connectivity problems.

## Resolution

If Event ID 5719 occurs only once when NetLogon restarts and the secure channel is established (domain operations proceed without issue), this event is harmless. You can safely ignore it.

Don't try remediation unless you see additional, persistent authentication or secure channel issues.

Microsoft recognizes this event as expected in mixed-version environments. Microsoft might suppress or clarify this event in future updates or documentation.

> [!IMPORTANT]  
> If the error recurs outside of NetLogon restarts or is accompanied by domain trust or authentication failures, investigate further. Collect the log data as described in [Collecting log data](#collecting-log-data), and then contact Microsoft Support.

### Workaround (optional)

As part of the transition to Windows Server 2025 or newer domain controllers that support Kerberos for secure channel setup, temporarily configure the following registry setting. Configure this setting on Kerberos-capable member computers that also run NetLogon.

This change suppresses the logging of NetLogon Event ID 5719. Once you deploy enough Windows Server 2025 or newer Kerberos-capable DCs in the domain to ensure reliable Kerberos-based secure channel establishment, remove the registry setting.

- **Registry subkey**: `HKLM\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters`

- **Registry entry details**:

  - Name: `UseKerberosForSecureChannels`
  - Type: `REG_DWORD`
  - Value: `0`

To use a Windows Command Line prompt to apply this change, run the following command:

```console
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters" /v UseKerberosForSecureChannels /t REG_DWORD /d 0 /f
```

To use a Windows PowerShell prompt to apply this fix, run the following command:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters" -Name "UseKerberosForSecureChannels" -Value 0 -Type DWord
```

Apply this configuration only temporarily. Monitor it for removal once the domain environment is adequately updated.

## Collecting log data

Collect the following logs:

- **System event logs**. Focus on entries for Event ID 5719 (Source: NetLogon).

- **NetLogon service logs**. If you need deeper analysis, turn NetLogon debugging on.

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

The event is specific to Windows Server 2025 member servers that authenticate by using domain controllers that run earlier versions of Windows. In the same scenario, Windows Server 2019 and Windows Server 2022 don't log Event ID 5719.

Windows Server 2025 systems that authenticate by using Windows Server 2025 domain controllers don't log Event ID 5719.

### Log entries in NetLogon.log that trace the secure channel process

When Windows first tries to establish the secure channel, it uses Kerberos:

```output
 [INIT] [10664]    UseKerberosForSecureChannels = TRUE
```

When Windows tries to connect to the domain controller the first time, it receives an error message that resembles the following log excerpt:

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

Windows tries to create the secure channel again. This time, it works. Windows logs entries that resemble the following excerpt:

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
