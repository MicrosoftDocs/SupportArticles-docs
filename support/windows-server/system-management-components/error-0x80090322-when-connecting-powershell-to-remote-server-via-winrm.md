---
title: Error 0x80090322 when connecting PowerShell to remote server via WinRM
description: Introduces how to solve the 0x80090322 error when you connect PowerShell to a remote server.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 05/11/2023
ms.reviewer: kaushika
ms.prod: windows-server
ms.technology: windows-server-system-management-components
ms.custom: sap:winrm, csstroubleshoot, ikb2lmc
---
# Error 0x80090322 when you connect PowerShell to remote server via WinRM

This article introduces how to solve the 0x80090322 error when you connect PowerShell to a remote server via \(Windows Remote Management\) WinRM.

_Applies to:_ Supported versions of Windows Server and Windows Client
_Original KB number:_ 4549715

## Symptoms

Assume that you try start a PowerShell session with a remote server. When you run the `Enter-PSSession -Computername <FQDN>` command, you receive the following error:

> "Enter-PSSession : Connecting to remote server \<FQDN\> failed with the following error message : WinRM cannot process the request. The following error with error code 0x80090322 occurred while using Kerberos authentication: An unknown security error occurred."

## Cause

By default, PowerShell uses HTTP Service principal name (SPN) in the format `HTTP/<FQDN>` to connect to the remote server. This issue occurs when the SPN is already registered to another service account in the forest or manually registered to a web service running on the computer.

## Resolution

First, we need to identifying the SPN. Run the command `setspn -q http/<FQDN>` to identify if this SPN is registered to a Service account.

Then, use one of these options to resolve this issue.

### Option 1

Validate if you still need the SPN registration on a Service account. Remove the SPN registration if not required.

### Option 2

Set up a dedicated SPN for WinRM by specifying the port number. To do this, run these commands to register the SPN:

```console
Setspn -s HTTP/servername:5985 <servername>
Setspn -s HTTP/FQDN:5985 <servername>
```

Example:

```console
Setspn -s HTTP/Mem1:5985 Mem1
Setspn -s HTTP/Mem1.contoso.com:5985 Mem1
```

Use the following Powershell command to specify a port for the `Enter-PSSession` command:

```PowerShell
Enter-PSSession -ComputerName <servername or FQDN> -SessionOption (New-PASessionOption -IncludePortInSPN)
```

Example:

```PowerShell
Enter-PSSession -Computername mem1.contoso.com -SessionOption (New-PSSessionOption -IncludePortInSPN)
```

### Option 3

Configure WinRM client to use Web Services-Management \(WSMAN\) SPN instead of HTTP SPN. To do this, create the following registry value:

Key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WSMAN\Client`  
Value name: spn_prefix  
Value type: REG_SZ (string)  
Value data: WSMAN

> [!NOTE]
> This operation must be done on the client machine.

:::image type="content" source="./media/error-0x80090322-when-connecting-powershell-to-remote-server-via-winrm/edited-registry.png" alt-text="The screenshot of the edited registry." border="true":::

The Kerberos request would look like the following example after making the registry change. In a Ticket Granting Server (TGS) request, the SPN is `WSMAN/mem1.contoso.com` instead of `HTTP/mem1.contoso.com`.

> Client.contoso.com	DC1.contoso.com	KerberosV5	KerberosV5:TGS Request Realm: CONTOSO.COM Sname: WSMAN/mem1.contoso.com

You can also use the `reg add` command to do this:

```console
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WSMAN\Client /v spn_prefix /t REG_SZ /d "HOST" /f
```

After that, add the following SPNs to the computer account:

```console
Setspn -s WSMAN/<servername> <servername>
Setspn -s WSMAN/<servername>.<domainname> <servername>
```

For example:

```console
Setspn -s WSMAN/mem1 mem1
Setspn -s WSMAN/mem1.contoso.com mem1
```
