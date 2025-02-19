---
title: Broken trust relationship between domain-joined device and its domain
description: Introduces how to troubleshoot secure channel issues that cause a broken trust relationship between a domain-joined device and its domain.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom: sap:Windows Security\Netlogon, secure channel, DC locator, csstroubleshoot
---
# Broken trust relationship between a domain-joined device and its domain due to secure channel issues

This article provides guidance on addressing common secure channel issues encountered on client machines or member servers within a domain during login attempts.

## Symptoms

When secure channel issues cause a broken trust relationship between a domain-joined device and its domain, you observe the following symptoms on the computer:

- You can't sign in to the computer by using Active Directory or domain credentials. The following error message occurs:
  
  > The trust relationship between this workstation and the primary domain failed.


  You can sign in using a local user or cached credentials.

- You see an Event 3210 from NETLOGON source on the System Event Viewer log:

  :::image type="content" source="media/broken-trust-relationship-between-domain-joined-device-and-its-domain-caused-by-secure-channel-issues/event-id-3210.png" alt-text="Screenshot of event ID 3210.":::  

  ```output
  Log name: System  
  Source: NETLOGON  
  Level: Error  
  Description: This computer could not authenticate with \\DCName.contoso.com, a Windows domain controller for domain CONTOSO, and therefore this computer might deny logon requests. This inability to authenticate might be caused by another computer on the same network using the same name or the password for this computer account is not recognized. If this message appears again, contact your system administrator.
  ```

- If Netlogon logging is enabled, you see something similar to this example:

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

- If you try to test the secure channel status, you receive an "Access denied" error:

  ```console
  C:\>nltest /sc_query:contoso.com

  Flags: 0
  Trusted DC Name
  Trusted DC Connection Status Status = 5 0x5 ERROR_ACCESS_DENIED
  The command completed successfully
  ```

## Common scenarios

Here are the most common scenarios and their causes:

- The client machine or member server has an older password than the Active Directory database.
- The Active Directory database has an older password than the client machine or member server. (Domain controller is restored to a previous state, or Active Directory replication issues.)

## Resolution

To troubleshoot the issue, follow these steps:

1. [Collect the data to determine the cause of the issue](data-collection-for-troubleshooting-secure-channel-issues.md).

2. Based on the scenario that you encounter, see the corresponding article for solutions:

    - [Active Directory has a newer password value than the client device](active-directory-has-newer-password-value-than-client-device.md)
    - [Client device has a newer password value than Active Directory](client-device-has-newer-password-value-than-active-directory.md)

## Other considerations

Make sure the following registry keys contain the actual name of the computer (not the fully qualified domain name (FQDN)):

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\ComputerName`
- `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters\hostname`

You can query those keys by running the following commands:

```console
Reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName
Reg query HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters /v hostname
```

> [!NOTE]
> Some IT technicians or administrators will rejoin the machine to the domain to solve the broken secure channel issue, which is a valid solution. However, if you need to find the cause of constant or repetitive issues, this article will help you find out the root cause in the environment.

## More information

- [PsExec](/sysinternals/downloads/psexec)
- [Nltest](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731935(v=ws.11))
- [Enable debug logging for Netlogon service](../../windows-client/windows-security/enable-debug-logging-netlogon-service.md)
- [Cached credentials and validation](/windows-server/security/windows-authentication/credentials-processes-in-windows-authentication#BKMK_CachedCredentialsAndValidation)

### Terminology

- **Local Security Authority (LSA) secret**: a special protected storage used by the Local Security Authority in Windows to store important data. In this series of articles, LSA secret refers to the computer password for a domain-joined device.
- **Cupdtime**: refers to the last update time for LSA secret, in this series of articles, the computer password. This information is stored in the Windows registry under `HKEY_LOCAL_MACHINE/Security/Policy/Secrets$MACHINE.ACC/cupdtime`.
- **pwdLastSet (PasswordLastSet)**: a computer object attribute stored in Active Directory.
