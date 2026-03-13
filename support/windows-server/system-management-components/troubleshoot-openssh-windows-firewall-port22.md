---
title: Troubleshoot OpenSSH Communication Through Windows Firewall
description: Discusses how to troubleshoot issues that affect OpenSSH commands that pass through Windows Firewall.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
---
# Troubleshoot OpenSSH communication through Windows Firewall

## Summary

This article discusses how to troubleshoot issues that affect OpenSSH commands that pass through Windows Firewall.

By default, OpenSSH uses TCP port 22. If this port is blocked or not listening, SSH commands fail. By default, OpenSSH listens on both IPv4 (0.0.0.0:22) and IPv6 ([::]:22). Windows Firewall settings, service status, and network permissions all play a crucial role in making sure that port 22 is both listening and accessible. Many factors can block OpenSSH communication, such as the following issues:

- The OpenSSH service isn't running or is misconfigured.
- Port 22 isn't listening because of service or firewall problems.
- Windows Firewall blocks inbound SSH traffic.
- Conflicting applications or policies use port 22.
- Network connectivity problems, NAT appliances, or other firewall appliances block access to port 22.

## How to troubleshoot OpenSSH communication through Windows Firewall

### Step 1: Verify the basic functionality

1. To verify that OpenSSH installed correctly, open a Windows PowerShell Command Prompt window, and then run the following command:

   ```powershell
   Get-Service -Name sshd
   ```

   > [!IMPORTANT]  
   > Make sure that you install the latest OpenSSH version, and keep it updated.

1. To verify that OpenSSH is listening on port 22, run the following command at either a PowerShell command prompt or a Windows command prompt:

   ```powershell
   netstat -an | findstr :22
   ```

   The following example shows the response to this command when port 22 is listening for traffic:

   ```output
   TCP    0.0.0.0:22             0.0.0.0:0              LISTENING
   TCP    [::]:22                [::]:0                 LISTENING
   ```

### Step 2: Make sure that Windows Firewall allows OpenSSH to use port 22

> [!IMPORTANT]  
>
> - If possible, limit access to trusted IP addresses.
> - Avoid using port 22 for non-OpenSSH traffic.
> - Audit your firewall rules regularly.

1. To check for existing firewall rules, go to your OpenSSH client computer, and run the following cmdlet at a PowerShell command prompt:

   ```powershell
   Get-NetFirewallRule -DisplayName "*SSH*" | Get-NetFirewallPortFilter | Where-Object {$_.LocalPort -eq 22}
   ```

1. If you can't find an existing SSH rule, open an administrative PowerShell command prompt window. Then, run the following cmdlet:

   ```powershell
   New-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -DisplayName "OpenSSH Server (SSH)" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow
   ```

1. To verify that the rule is correctly configured, run `Get-NetFirewallRule` again.

### Step 3: Review the event logs for errors

In Event Viewer, review the entries in **Application and Services Logs** > **OpenSSH**.

### Step 4: If the port isn't listening, configure it

In the previous steps, if `netstat` didn't report port 22 as "Listening," and the firewall rule is correctly configured, follow these steps:

1. To check the service status, run the following command at a PowerShell command prompt:

   ```powershell
   Get-Service -Name sshd
   ```

1. To check the OpenSSH configuration, open the C:\ProgramData\ssh\ folder, and then use a text editor to open the sshd_config file.
1. Go to the `Port` section of the file. If the port information is commented out, uncomment it, and then make sure that the value is `22`.

   > [!IMPORTANT]  
   > If you use port forwarding, see the [sshd_config](https://man.openbsd.org/sshd_config) manual page for configuration information.

1. To test the settings, run the following cmdlet at a PowerShell command prompt:

   ```powershell
   sshd -t
   ```

1. To restart the OpenSSH server service, run the following cmdlet at a PowerShell command prompt:

   ```powershell
   Restart-Service sshd
   ```

### Step 5: Test for firewall issues

1. To create a temporary test rule, run the following cmdlet at a PowerShell command prompt:

   ```powershell
   New-NetFirewallRule -Name "SSH-Test" -DisplayName "SSH Test Rule" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow -Profile Any
   ```

   > [!NOTE]  
   > This cmdlet creates a temporary rule that's named "SSH Test Rule" to open port 22. By using this approach, you avoid having to disable the entire firewall.

1. Test some OpenSSH commands. If they work correctly, review and adjust your permanent firewall rules.

1. When you're finished, remove the test rule by running the following cmdlet at a PowerShell command prompt:

   ```powershell
   Remove-NetFirewallRule -Name "SSH-Test"
   ```

### Step 6: Test for other network and network address translation (NAT) issues

1. Make sure that external firewalls, routers, or NAT devices forward port 22 to your Windows host.

1. Use the actual host name or IP address to test-run OpenSSH commands from another client computer. Run commands that resemble the following example:

   ```bash
   ssh username@192.168.1.100
   # or
   ssh username@servername.domain.com
   ```

1. To further test port connectivity, run the following cmdlet at the PowerShell command prompt:

   ```powershell
   Test-NetConnection -ComputerName <hostname_or_IP> -Port 22
   ```

## Logging and diagnostics

For information about verbose logging for OpenSSH, see [How to enable OpenSSH verbose logging](enable-openssh-verbose-logging.md).

For information about connection attempts and errors, review the logs in %ProgramData%\ssh\logs.

## Example scenarios

**Scenario 1: SSH connection is refused**  
Cause: Firewall blocks port 22.  
Solution: Turn on or create an inbound rule for TCP port 22.

**Scenario 2: Port 22 isn't listening**  
Cause: OpenSSH service isn't running or is misconfigured.  
Solution: Start the service, fix the configuration, and then run `sshd -t` to verify the result. If you changed the configuration, restart the service.

**Scenario 3: Intermittent connectivity**  
Cause: Network device or NAT doesn't forward port 22.  
Solution: Check the router or firewall settings, and then test by using `Test-NetConnection`. For configuration information, see [sshd_config](https://man.openbsd.org/sshd_config).

## Related articles

- [OpenSSH Server configuration for Windows](/windows-server/administration/openssh/openssh_install_firstuse)
- [How to enable OpenSSH verbose logging](enable-openssh-verbose-logging.md)
- [OpenSSH Manual Pages](https://www.openssh.com/manual.html)
- [Windows Firewall with Advanced Security](/windows/security/threat-protection/windows-firewall/windows-firewall-with-advanced-security)
- [Troubleshooting OpenSSH in Windows](/windows-server/administration/openssh/openssh_server_configuration)
