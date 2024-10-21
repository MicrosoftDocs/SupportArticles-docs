---
title: Broken trust relationship between domain joined device and its domain caused by secure channel issues
description: Introduces how to troubleshoot secure channel issues which cause broken trust relationship between domain joined device and its domain.
ms.date: 10/18/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom: sap:Windows Security\Netlogon, secure channel, DC locator, csstroubleshoot
---
# Broken trust relationship between domain joined device and its domain caused by secure channel issues

This article provides guidance on addressing common secure channel issues encountered on client machines or member servers within a domain during login attempts.

## Symptoms

When secure channel issues cause broken trust relationship between domain joined device and its domain, you observe the following symptoms on the computer:

- You can't sign into the computer by using Active Directory or domain credentials. The following error message is received:
  
  > The trust relationship between this workstation and the primary domain failed.

  :::image type="content" source="media/broken-trust-relationship-between-domain-joined-device-and-its-domain-caused-by-secure-channel-issues/screenshot-of-the-error-message-during-sign-in.png" alt-text="Screenshot of the error message during sign-in.":::

- You can log in using a local user or cached credentials.
- You see an Event 3210 from NETLOGON source on System Event Viewer log:

  :::image type="content" source="media/broken-trust-relationship-between-domain-joined-device-and-its-domain-caused-by-secure-channel-issues/screenshot-of-the-event-id-3210.png" alt-text="Screenshot of the event ID 3210.":::  

  > Log name: System  
  > Source: NETLOGON  
  > Level: Error  
  > Description: This computer could not authenticate with \\DCName.contoso.com, a Windows domain controller for domain CONTOSO, and therefore this computer might deny logon requests. This inability to authenticate might be caused by another computer on the same network using the same name or the password for this computer account is not recognized. If this message appears again, contact your system administrator.

- If Netlogon logging is enabled, you'll find something similar to this:

  ```output
  Date Time [CRITICAL] CORP: NlSessionSetup: Session setup: cannot I_NetServerAuthenticate 0xc0000022
  Date Time [CRITICAL] CORP: NlSessionSetup: new password is bad, try old one
  Date Time [CRITICAL] NlPrintRpcDebug: Couldn't get EEInfo for I_NetServerAuthenticate3: 1761 (may be legitimate for 0xc0000022)
  Date Time [SESSION] CORP: NlSessionSetup: Negotiated flags with server are 0x612fffff
  Date Time [CRITICAL] CORP: NlSessionSetup: Session setup: cannot I_NetServerAuthenticate 0xc0000022
  Date Time [MISC] Eventlog: 3210 (1) "CORP" "\\DCName.Contoso.com" 2f8270f1 5bc8d5e7 34c3e164 6665df64   .p./...[d..4d.ef
  Date Time [SESSION] CORP: NlSetStatusClientSession: Set connection status to c0000022
  Date Time [SESSION] CORP: NlSetStatusClientSession: Unbind from server \\DCName.Contoso.com (TCP) 0.
  Date Time [SESSION] CORP: NlSessionSetup: Session setup Failed
  ```

- If you try to test Secure Channel status, you will get an "Access denied" error:

  ```console
  C:\>nltest /sc_query:contoso.com

  Flags: 0
  Trusted DC Name
  Trusted DC Connection Status Status = 5 0x5 ERROR_ACCESS_DENIED
  The command completed successfully
  ```

## Common scenarios

The following are the most common scenarios and their causes for this issue to occur:

- Client machine or member server with older password compared to Active Directory database.
- Active Directory database with older password compared to client machine or member server. (Domain Controller restore to a previous state / Active Directory replication issues)

## Resolutions

To troubleshoot the issue, collect the data to determine the cause of the issue. see [Data collection for troubleshooting secure channel issues](data-collection-for-troubleshooting-secure-channel-issues.md).

Based on the scenario that you are encountering, see the corresponding article for solutions:

- [Active Directory having newer password value than client device](scenario-active-directory-having-newer-password-value-than-client-device.md)
- [Client device having a newer password value than Active Directory](scenario-client-device-having-a-newer-password-value-than-active-directory.md)

## Additional considerations

Make sure the following registry keys contain the actual name of the computer (not FQDN):

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\ComputerName`
- `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters\hostname`

You can query those keys by running:

```console
Reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName
Reg query HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters /v hostname
```

> [!NOTE]
> Some IT  technicians or administrator will just rejoin the machine to the domain to solve the broken Secure Channel issue, and it is a valid solution, but if you need to find a cause for constant or repetitive issues, this article will help you find out a root cause in the environment.

## More information

The following lists further information regarding the topics mentioned within this article.

- PsExec - [PsExec - Sysinternals | Microsoft Learn](/sysinternals/downloads/psexec)
- Nltest - [Nltest | Microsoft Learn](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731935(v=ws.11))
- Netlogon logging - [Enable debug logging for Netlogon service - Windows Client | Microsoft Learn](../../windows-client/windows-security/enable-debug-logging-netlogon-service.md)
- Cached credentials - [Credentials Processes in Windows Authentication | Microsoft Learn](/windows-server/security/windows-authentication/credentials-processes-in-windows-authentication#BKMK_CachedCredentialsAndValidation)

### Terminology

- **LSA Secret**: A special protected storage for important data used by the Local Security Authority in Windows. In this article, LSA Secret refers to the computer password for a domain-joined device.
- **Cupdtime**: refers to the last update time for LSA Secret, in this case the computer password. This information is stored in the Windows registry under the key HKEY_LOCAL_MACHINE/Security/Policy/Secrets$MACHINE.ACC/cupdtime.
- **pwdLastSet (PasswordLastSet)**: Computer object attribute, stored in Active Directory.
