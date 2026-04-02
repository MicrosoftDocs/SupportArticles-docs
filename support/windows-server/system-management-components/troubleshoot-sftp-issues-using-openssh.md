---
title: Troubleshoot Common SFTP Issues
description: Explains how to resolve common SFTP issues when you use OpenSSH for Windows.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-appelgatet
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Troubleshoot common SFTP issues when using OpenSSH

OpenSSH on Windows provides secure file transfer protocol (SFTP) capabilities. This article describes how to resolve the most common issues that you might encounter when you use SFTP and OpenSSH to administer Windows Server and Windows Client.

## Best practices and additional resources

- Use the latest supported OpenSSH version.
- Avoid configuring OpenSSH to use a network share for the chroot directory.
- Every time that you change the OpenSSH Server configuration, validate the change by running `sshd -t`.
- When you start troubleshooting, check Event Viewer for relevant events.

For more information about how to configure OpenSSH on Windows and Windows Server, see the following articles:

- [Get started with OpenSSH for Windows](/windows-server/administration/openssh/openssh_install_firstuse)
- [OpenSSH Server configuration for Windows Server and Windows](/windows-server/administration/openssh/openssh-server-configuration)

### How to enable SFTP logging

To enable SFTP logging for the OpenSSH Server service, modify the sshd_config file, and then restart the OpenSSH Server service. Follow these steps:

1. Use an administrator-level account to open a text editor, and then open **%ProgramData%\ssh\sshd_config**. The default text of the "Logging" section should resemble the following excerpt:

   ```output
   # Logging
   #SyslogFacility AUTH
   #LogLevel INFO
   ```

1. To enable SFTP logging, edit the text to resemble the following excerpt:

   ```output
   # Logging
   SyslogFacility LOCAL0
   LogLevel DEBUG3
   ```

   Also, add (or modify) the following text:

   ```output
   Subsystem sftp sftp-server.exe -f LOCAL0 -l DEBUG3
   ```

1. Save and close the sshd_config file.

1. To restart the OpenSSH Server service, open a Windows Command Prompt window, and then run the following command:

   ```console
   NET STOP "OpenSSH SSH Server" && NET START "OpenSSH SSH Server"
   ```

After the service restarts, it generates SFTP log data in %ProgramData%\ssh\logs. For more information about OpenSSH logging, see [How to enable OpenSSH verbose logging](enable-openssh-verbose-logging.md).

## Common SFTP issues on Windows and Windows Server

### SFTP users land in the wrong directory or outside the chroot jail

When correctly configured, the chroot directory restricts (jails) users to a specific directory tree. This restriction prevents users from accessing the rest of the file system.

Check the following settings:

- In the sshd_config file, make sure that `ChrootDirectory` points to a local directory and doesn't use a UNC path.
- Make sure that SYSTEM/Administrators has owner permissions on the chroot directory.
- Make sure that each user has a writeable directory within the chroot directory, and that the directory has the correct permissions. Secure the /.ssh/authorized_keys files.

  > [!NOTE]  
  > To verify and fix NTFS permissions, use the [icacls](/windows-server/administration/windows-commands/icacls) command in an administrative Command Prompt window.

- In the sshd_config file, use`ForceCommand internal-sftp`, and use the `-d` switch together with the `Subsystem sftp sftp-server.exe` command to set an upload directory. You can use these settings in `Match` blocks to specify users.

### Specific users can't use SFTP or they receive "Access denied" errors

This behavior indicates ownership or permissions issues. Check the following settings:

- Make sure that SYSTEM/Administrators has owner permissions on the chroot directory.
- Make sure that each user has a writeable directory within the chroot directory, and that the directory has the correct permissions. Secure the /.ssh/authorized_keys files.

  > [!NOTE]  
  > To verify and fix NTFS permissions, use the [icacls](/windows-server/administration/windows-commands/icacls) command in an administrative Command Prompt window.

### Users can't sign in or they receive "Authentication failed" or "Server refused our key"

This behavior indicates public key or password issues. Check the following configurations:

- Use C:\ProgramData\ssh\administrators_authorized_keys to store keys, and use `icacles` to check the file and folder permissions.
- If the server refuses the key, add the following lines to sshd_config:

  ```console
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
  ```

  > [!NOTE]  
  > After you make these changes, restart the OpenSSH Server service.

### OpenSSH Server service doesn't start, or SFTP connections hang

To resolve these issues, try the following actions:

- To validate the sshd_config settings, run the `sshd -t` command.
- Review Event Viewer for any relevant events.
- To check and repair Access Control Lists (ACLs) on the chroot directory tree, run the `icacles` command.
- Review the sshd_config settings. Make sure that the entries don't have any trailing spaces, and make sure that the `Subsystem sftp sftp-server.exe` command is present.

If none of these actions resolve the issue, uninstall and reinstall OpenSSH Server.

### SFTP logs are missing or incomplete

Review the log settings in ssdh_config. SFTP log data is stored in %ProgramData%\ssh\logs.

To check and repair ACLs on the log folder, run the `icacles` command.

###  Users can't upload or download files

- In the sshd_config file, make sure that `ChrootDirectory` points to a local directory and doesn't use a UNC path.
- Make sure that SYSTEM/Administrators has owner permissions on the chroot directory.
- Make sure that each user has a writeable directory within the chroot directory, and that the directory has the correct permissions. To check and repair ACLs, run the `icacles` command.
- Make sure that users don't have writer permission on the chroot directory.
