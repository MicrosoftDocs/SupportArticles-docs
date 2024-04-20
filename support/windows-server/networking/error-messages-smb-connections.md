---
title: Error messages on SMB connections
description: Provides a solution to error messages that occur on SMB connections. Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joelch
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# System error 2148073478, extended error, or Invalid Signature error message on SMB connections in Windows Server 2012 or Windows 8

This article provides a solution to error messages that occur on Server Message Block (SMB) connections.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2686098

## Symptoms

After a Windows Server 2012-based or Windows 8-based computer fails to connect to a third-party file server that supports the SMBv2 file protocol, you receive one of the following error messages or a similar error message, depending on how you access the third-party file server:

- When you use a DIR command that has a UNC path:
    > Invalid Signature

- When you run a NET USE command:
    > System error 2148073478 has occurred

- When you try to browse to the UNC path:
    > An extended error has occurred

You may experience these errors in the following common scenarios:

- A live migration of Hyper-V servers (running either Hyper-V Server 2012 or Windows Server 2012 and Window 8) fails. This occurs because the storage is required to be hosted on an SMB share.
- You can't map network drives to a SAN in a Window 8-Windows Server 2012 environment.

## Cause

This problem is caused by the `Secure Negotiate` feature that was added to SMB 3.0 for Windows Server 2012 and Windows 8. This feature depends upon the correct signing of error responses by all SMBv2 servers, including servers that support only protocol versions 2.0 and 2.1. Some third-party file servers don't return a signed error response. So the connection fails.

## Resolution

To resolve this problem, contact the third-party file server vendor to request an update that enables the file server to support Windows Server 2012 and Windows 8 clients.

## Workaround

> [!WARNING]
> We don't recommend that you disable the requirement for secure negotiate, as this reduces computer security. Disable secure negotiate only as a temporary troubleshooting measure. Don't leave secure negotiate disabled; instead, contact the third-party file server vendor and request an update that allows their file server to support Windows Server 2012 and Windows 8 clients correctly.

The ability to disable secure negotiate functionality may be removed in future operating systems.

To work around this problem, use either of the following methods:

- Require signing on the third-party file server

    To require signing on the SMB client or the SMB server, turn on the `RequireSecuritySignature` setting. See your vendor's documentation for instructions to set the signing setting to **required** on the vendor's SMB server.

    You can enable signing by using PowerShell on a Windows Server 2012 or Windows 8 client. To do it, run the following command:

    ```powershell
    Set-SmbClientConfiguration -RequireSecuritySignature $true
    ```  

- Disable **Secure Negotiate** on the client

    You can disable the **Secure Negotiate** option by using PowerShell on a Windows Server 2012 or Windows 8 client. To do it, run the following command:

    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecureNegotiate -Value 0 -Force
    ```

    > [!NOTE]
    > This command may wrap to multiple lines in your web browser.

## References

For more information, see [New SMB 3.0 features in the Windows Server 2012 file server](../high-availability/smb-3-file-server-features.md)
