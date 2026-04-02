---
title: Use "MaxStartups" and "MaxSessions" to Troubleshoot OpenSSH Connection Issues
description: This article explains how to troubleshoot OpenSSH connection issues by using the `MaxStartups` and `MaxSessions` parameters to limit client connections to the OpenSSH Server service.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: warrenw, kaushika, v-appelgatet
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# How to use "MaxStartups" and "MaxSessions" to troubleshoot OpenSSH connection issues

This guide explains how to use the `MaxStartups` and `MaxSessions` parameters to limit client connections to the OpenSSH Server service.
These settings help you troubleshoot connection issues and manage unauthenticated and authenticated SSH sessions, especially in high-load environments.

## Symptoms

You can use `MaxStartups` and `MaxSessions` to address the following types of symptoms.

- Symptom 1: Clients can't connect to the OpenSSH Server service and establish sessions. Additionally, you might receive the following error messages:

  - Connection reset by peer
  - Exceeded MaxStartups
  - Negotiation failed

- Symptom 2: In an environment that supports session multiplexing (multiple sessions per connection), clients connect and authenticate. However, the server drops the connection.

## Cause

Symptom 1 indicates that too many client applications are connecting to the OpenSSH Server service at the same time.

Symptom 2 is limited to multiplexing environments. It indicates that the OpenSSH Server service can't support the number of sessions per connection that the clients are using. This symptom can occur after you configure`MaxStartups`.

## How to use the parameters

`MaxStartups`and `MaxSessions` are parameters in the sshd_config file. The following sections explain how they function.

### MaxStartups

The `MaxStartups` parameter defines how many concurrent unauthenticated connections the OpenSSH Server service can manage. This setting is especially useful on servers that support multiple parallel SSH connections, including jump hosts and provisioning servers (such as servers that use Ansible). It's also useful in high-load environments or during brute-force attacks.

The value is a set of three integers that are separated by colons, in the format `Start:Rate:Full`. The integers represent the following values:

- **Start**: The number of unauthenticated connections that the OpenSSH Server service supports before it starts dropping connections.
- **Rate**: Probability that the OpenSSH Server service drops a connection. As long as the number of concurrent sessions is below the `Start` value, the service ignores `Rate`. However, when the number of concurrent connections surpasses `Start`, each additional connection has a `Rate` percent probability of being dropped.
- **Full**: When the number of concurrent connections surpasses `Full`, the service drops all additional connections.

For example, consider a system that's using the configuration, `MaxStartups 20:40:60`. The OpenSSH Server service manages connections as follows:

- The service maintains the first 20 concurrent unauthenticated connections. 
- Starting at the 21st connection attempt, there's a 40 percent probability that the server drops the new connection attempt.
- After the service reaches 60 concurrent unauthenticated connections, the server rejects all further connection attempts.

### MaxSessions

The `MaxSessions` parameter defines how many open shell, login, or subsystem (for example, sftp) sessions that the OpenSSH Server service permits for each network connection. Setting `MaxSessions` to `1` effectively disables session multiplexing. Setting it to `0` prevents all shell, login, and subsystem sessions,  but allows port forwarding. The default value is `10`.

### How to set the connection parameters

To modify the parameters for the Windows OpenSSH Server service, modify the sshd_config file, and then restart the OpenSSH Server service. To do this, follow these steps:

1. Using an Administrator-level account, open a text editor, and then open **%ProgramData%\ssh\sshd_config**. The default text for these settings should resemble the following excerpt:

   ```output
   #MaxStartups 10
   ```

   ```output
   #MaxSessions 10
   ```

   > [!NOTE]  
   > `MaxSessions` typically appears within the `# Authentication` section of the file. `MaxStartups` typically appears in a list of general options later in the file.

1. To enable `MaxStartup` or `MaxSessions` and to set values, edit the text to resemble the following excerpt:

   ```output

   MaxStartups 20:40:60
   ```

   ```output
   MaxSessions 15
   ```

   > [!NOTE]  
   > In this command, `20:40:60` and `15` are example values. Use values that are appropriate for your environment.

1. Save and close the sshd_config file.

1. To verify the configuration, open a Windows PowerShell Command Prompt window, and then run the following command:

   ```powershell
   sshd -t
      ```

1. To restart the OpenSSH Server service, open a Windows Command Prompt window, and then run the following command:

   ```console
   NET STOP "OpenSSH SSH Server" && NET START "OpenSSH SSH Server"
   ```

After the service restarts, it uses the new parameter values.

## More information

- [Windows configurations in sshd_config](/windows-server/administration/OpenSSH/openssh-server-configuration#windows-configurations-in-sshd_config) in "OpenSSH Server configuration for Windows Server and Windows"
- [sshd_config(5) - Linux manual page](https://man7.org/linux/man-pages/man5/sshd_config.5.html)
- [sshd_config - OpenSSH daemon configuration file](https://man.openbsd.org/sshd_config)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
