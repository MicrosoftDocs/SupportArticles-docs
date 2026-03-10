---
title: OpenSSH Client Can't Connect To a Server via SSH
description: Addresses multiple common causes and solutions when encountering OpenSSH connection errors related to host key algorithm mismatches on Windows systems.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
---
# OpenSSH client can't connect to a server via SSH: "no matching host key type found" errors

This article addresses multiple common causes and solutions when encountering OpenSSH connection errors related to host key algorithm mismatches on Windows systems.

When you connect to a server via Secure Shell (SSH), you might encounter errors such as:

- > Unable to negotiate with \<server\>: no matching host key type found.
- > Host key algorithm: (no match)
- > Permission denied (publickey).
- > Server refused our key.

These errors typically indicate mismatches in supported algorithms, permissions issues, or security concerns.

## Cause 1: RSA algorithm disabled in updated OpenSSH versions

OpenSSH 8.8 and later versions disable the insecure `ssh-rsa` algorithm by default, causing legacy clients dependent on RSA keys to fail connection attempts.

### Resolution

1. Back up the existing configuration:

    ```powershell
    Copy-Item "C:\ProgramData\ssh\sshd_config" "C:\ProgramData\ssh\sshd_config.bak" 
    ```

2. Modify the **sshd_config** file:

    1. Open Notepad as administrator.
    2. Use the following command to open the **sshd_config** file:

        ```console
        notepad "C:\ProgramData\ssh\sshd_config"
        ```

    3. Add the following lines to the end of the file:

        ```output
        PubkeyAcceptedAlgorithms +ssh-rsa 
        HostKeyAlgorithms +ssh-rsa
        ```

3. Restart the OpenSSH service:

    ```powershell
    Restart-Service sshd
    ```

4. Verify the SSH connection:

    ```powershell
    ssh -v user@server.example.com 
    ```

## Cause 2: Missing or incorrect authorized_keys file or improper file permissions

Connection failures occur due to missing or incorrect **authorized_keys** file or improper file permissions, generating "Permission denied" errors.

### Resolution

1. Ensure the **authorized_keys** file exists:

    File path:
    **C:\ProgramData\\ssh\\administrators_authorized_keys**

    Place your public keys correctly in this file.
2. Correct file permissions:

    Ensure only administrators have write permissions to the file:

    ```console
    icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F"
    ```

3. Restart the OpenSSH service:

    ```console
    net stop sshd 
    net start sshd 
    ```

## Cause 3: Private keys stored in the registry persist across sessions causing security risks

Private keys stored by OpenSSH's ssh-agent service persist across sessions in the Windows registry, potentially causing security risks.

### Resolution

- Use strong encryption and passphrases when generating private keys.
- Limit registry access through user permissions.
- Regularly update OpenSSH from official sources (for example, GitHub).
- Regularly audit registry entries and clear sensitive keys when not needed.

### Optional registry adjustments

Manage RSA keys securely via registry policies:

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\SSH-Server' -Name AllowRSAKey -Value 1 -Type DWORD 
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\SSH-Server\Parameters' -Name AllowRSAKey -Value 1 -Type DWORD 
```

### Recommended general security practices

- Secure user accounts and maintain strict file permissions.
- Regularly update OpenSSH to include latest security patches.
- Use stronger algorithms such as ED25519 or ECDSA where possible.
- Educate users on secure key management practices.

## Troubleshooting logs and diagnostics

To gather detailed debugging logs during connection attempts, use the verbose SSH command:

```console
ssh -vvv user@hostname
```

Analyze logs collected from both working and nonworking environments to identify configuration differences.
  
## Next steps

- Identify and inventory legacy clients still requiring weaker algorithms like `ssh-rsa`.
- Implement a scheduled upgrade strategy to migrate these clients to stronger algorithms.
- After resolving compatibility issues, remove temporary algorithm overrides from **sshd_config**.
- Replace legacy RSA keys with stronger keys (minimum 3072-bit RSA or ED25519).
  
## References

- [Key-based authentication in OpenSSH for Windows](/windows-server/administration/openssh/openssh_keymanagement)
- [OpenSSH 8.8 Release Notes (RSA deprecation)](https://www.openssh.com/txt/release-8.8)
