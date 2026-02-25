---
title: How to Enable OpenSSH Verbose Logging
description: Explains how to enable verbose logging for the OpenSSH service.
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
# How to enable OpenSSH verbose logging

To enable verbose logging for the OpenSSH Server service, modify the sshd_config file, and restart the OpenSSH Server service. Follow these steps:

1. Use an administrator-level account to open a text editor, and then open **%ProgramData%\ssh\sshd_config**. The default text of the "Logging" section should resemble the following excerpt:

   ```output
   # Logging
   #SyslogFacility AUTH
   #LogLevel INFO
   ```

1. To enable verbose logging, edit the text to resemble the following excerpt:

   ```output
   # Logging
   SyslogFacility AUTH
   LogLevel VERBOSE
   ```

   > [!NOTE]  
   > By default, the OpenSSH Server service sends logs to Windows Event Viewer. To record a log file instead, use `SyslogFacility LOCAL0` instead of `SyslogFacility AUTH` in sshd_config. The OpenSSH service records log files in %ProgramData%\ssh\logs.

1. Save and close the sshd_config file.

1. To restart the OpenSSH Server service, open a Windows Command Prompt window, and then run the following command:

   ```console
   NET STOP "OpenSSH SSH Server" && NET START "OpenSSH SSH Server"
   ```

After the service restarts, it generates verbose log data.

For more information about how to configure OpenSSH, see the [Windows configurations in sshd_config](/windows-server/administration/OpenSSH/openssh-server-configuration#windows-configurations-in-sshd_config) section of "OpenSSH Server configuration for Windows Server and Windows."
