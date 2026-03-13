---
title: Upgrade in-box OpenSSH to the Latest OpenSSH Release
description: Discusses the difference between the in-box and GitHub versions of OpenSSH, how to back up your existing configuration, and how to upgrade safely while keeping your service settings intact.
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

# Upgrade in-box OpenSSH to the latest OpenSSH release

To provide secure remote management by using Secure Shell (SSH), Windows includes OpenSSH as a Feature on Demand. However, the built-in (in-box) version that ships as part of the Windows and Windows Server installation media, such as 7.7p1 or 8.1p1, often lags behind the latest Win32-OpenSSH releases that are available on GitHub. To use newer encryption algorithms, enhanced logging, and important security updates, upgrade OpenSSH to the GitHub version.

This article explains the difference between the in-box and GitHub versions, how to back up your existing configuration, and how to upgrade safely while keeping your service settings intact. It also includes instructions for using Windows Update to manually update OpenSSH.

## Prerequisites

- Use local Administrator credentials to sign in to the computer.
- Make sure that the OpenSSH Server service isn't handling active sessions.

  > [!NOTE]  
  > Upgrading temporarily stops the OpenSSH Server service and disconnects any active SSH sessions.

- In case the service restarts, have alternative access methods (such as RDP or console) available.
- Make sure that you have the correct permissions to modify C:\ProgramData\ssh and install MSI packages.
- Before you install a new release in a production environment, test it in a staging environment first.

## Understanding in-box versus GitHub OpenSSH

By default, you use Windows Update to install and maintain the in-box OpenSSH feature. Typically, the software resides in C:\Windows\System32\OpenSSH. The in-box version is Microsoft-supported and stable, but it updates only when Windows itself updates.

The GitHub version, known as Win32-OpenSSH, installs in C:\Program Files\OpenSSH, and has the newest features and fixes. However, you have to manually update it.

## Step 1: Back up the configuration and keys

Before you upgrade, back up all configuration and key files.

The following table lists the files and their default folder locations

| Folder and files | Description |
| --- | --- |
| C:\ProgramData\ssh\sshd_config | The server configuration file |
| C:\ProgramData\ssh\administrators_authorized_keys | Keys for administrator accounts |
| C:\\ProgramData\\ssh\\ssh_host\_\*\_key | Host identity keys |
| C:\\Users\\\<UserName>\\.ssh\\authorized_keys | Per-user keys |

To copy these files, open a Windows PowerShell command prompt, and run a cmdlet that resembles the following cmdlet:

```powershell
Copy-Item "C:\ProgramData\ssh" -Destination "C:\Backup\ssh_backup" -Recurse
```

> [!IMPORTANT]  
>
> - To avoid client trust warnings, don't change the host or user keys.
> - Don't change file permissions for either the source files and folders or the destination files and folders. Private keys must remain readable only by SYSTEM and Administrators. To verify the permissions, run a cmdlet that resembles the following cmdlet at a PowerShell command prompt:
>
>   ```powershell
>   Get-Acl "C:\ProgramData\ssh\ssh_host_ed25519_key" | Format-List
>   ```

## Step 2: Upgrade OpenSSH

To upgrade OpenSSH, select one of the following methods:

- [Option 1: Use an MSI installer to upgrade OpenSSH to the latest GitHub release](#option-1-use-an-msi-installer-to-upgrade-openssh-to-the-latest-github-release)
- [Option 2: Use a ZIP file to upgrade OpenSSH to the latest GitHub release](#option-2-use-a-zip-file-to-upgrade-openssh-to-the-latest-github-release)
- [Option 3: Upgrade OpenSSH to the latest Windows Update release instead of the GitHub release](#option-3-upgrade-openssh-to-the-latest-windows-update-release-instead-of-the-github-release)

### Option 1: Use an MSI installer to upgrade OpenSSH to the latest GitHub release

> [!NOTE]  
> Depending on your processor, OpenSSH installs in either C:\Program Files\OpenSSH or C:\Program Files\OpenSSH-Win64. The installer automatically registers the OpenSSH services and updates the PATH environment variable.

1. To download the MSI installer, go to [Win32-OpenSSH releases page on GitHub](https://github.com/PowerShell/Win32-OpenSSH/releases), and download the latest Win64 or Win32 OpenSSH .msi file.

1. To install all components of the new version, open an administrative PowerShell command prompt window and run a cmdlet that resembles the following cmdlet:

   ```powershell
   msiexec /i OpenSSH-Win64-v9.x.x.x.msi
   ```

1. To install only the client or server component, open an administrative PowerShell command prompt window, and run a cmdlet that resembles the one of the following cmdlets, as appropriate:

   ```powershell
   msiexec /i OpenSSH-Win64-v9.x.x.x.msi ADDLOCAL=Client
   msiexec /i OpenSSH-Win64-v9.x.x.x.msi ADDLOCAL=Server
   ```

1. To configure the OpenSSH Server service and then start it, run the following cmdlets on the computer where you installed the server component:

   ```powershell
   Start-Service sshd
   Set-Service sshd -StartupType Automatic
   ```

   If the service wasn't created, run the following command:

   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File "C:\Program Files\OpenSSH\install-sshd.ps1"
   ```

### Option 2: Use a .zip file to upgrade OpenSSH to the latest GitHub release

If you don't want to use the MSI package to install the upgrade, you can use a .zip archive file.

1. To download the latest .zip file, go to [Win32-OpenSSH releases page on GitHub](https://github.com/PowerShell/Win32-OpenSSH/releases), and download the appropriate file.

1. Extract the .zip file to C:\Program Files\OpenSSH.

1. Open an administrative PowerShell window, change to the C:\Program Files\OpenSSH folder, and then run the following command:

   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File .\install-sshd.ps1
   ```

1. To configure the OpenSSH Server service and then start it, run the following cmdlets.

   ```powershell
   Start-Service sshd
   Set-Service sshd -StartupType Automatic
   ```

### Option 3: Upgrade OpenSSH to the latest Windows Update release instead of the GitHub release

1. To check the current version of OpenSSH, run `ssh -V` at a PowerShell command prompt.

1. To uninstall the current version of OpenSSH, run the following cmdlets at a PowerShell command prompt:

   ```powershell
   Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
   Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
   ```

1. After the software is uninstalled, restart Windows.

1. To install the latest release from Windows Update, run the following cmdlets at a PowerShell command prompt:

   ```powershell
   Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
   Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
   ```

1. To configure the OpenSSH Server service and then start it, run the following cmdlets:

   ```powershell
   Start-Service sshd
   Set-Service sshd -StartupType Automatic
   ```

## Step 3: Create the firewall rule, if it's necessary

1. To check for existing firewall rules, go to your OpenSSH client computer, and run the following cmdlet at a PowerShell command prompt:

   ```powershell
   Get-NetFirewallRule -DisplayName "*SSH*" | Get-NetFirewallPortFilter | Where-Object {$_.LocalPort -eq 22}
   ```

1. If you can't find an existing SSH rule, open an administrative PowerShell command prompt window. Then, run the following cmdlet:

   ```powershell
   New-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -DisplayName "OpenSSH Server (SSH)" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow
   ```

1. To verify that the rule is correctly configured, run `Get-NetFirewallRule` again.

## Step 4: Verify the installation

1. Make sure that C:\ProgramData\ssh still has your previous configuration and keys. If it's necessary, restore this information from your backup.

1. To check the version, run `ssh -V` at the PowerShell command prompt.

1. To check the service status and connectivity, run the following cmdlets at a PowerShell command prompt:

   ```powershell
   Get-Service sshd
   ssh localhost
   ```

   > [!NOTE]  
   > The display name of the service is "OpenSSH SSH Server."

1. To verify that you're using the correct SSH binary, run the following cmdlets at a Windows PowerShell command prompt:

   ```powershell
   Get-Command ssh.exe | Select-Object Source
   ```

1. To check for errors, open Event Viewer, and then select **Applications and Services Logs** > **OpenSSH** > **Operational**.

1. Make sure that administrators and users can authenticate.

1. To avoid path conflicts, check for multiple OpenSSH folders (typically in the System32 folder). If multiple OpenSSH folders exist, keep the newest folder, and remove any older folders.

## Common issues quick reference

| **Symptom** | **Likely cause** | **Resolution** |
| --- | --- | --- |
| SSH service doesn't start | Missing or misconfigured host keys | Restore backed-up keys and restart the service |
| Authentication errors | Improper key file permissions | Make sure that only SYSTEM and Administrators can read or write key files |
| Old binaries still run | PATH still points to System32\OpenSSH | Remove or rename the outdated directory |
| Port 22 unreachable | Firewall rule is missing | Re-create the inbound rule for TCP port 22 |

## Related articles

- [Releases · PowerShell/Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/releases)
- [OpenSSH for Windows overview](/windows-server/administration/OpenSSH/openssh-overview)
- [Get started with OpenSSH Server for Windows](/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui&pivots=windows-server-2022)
- [OpenSSH Server configuration for Windows Server and Windows](/windows-server/administration/OpenSSH/openssh-server-configuration)
- [Key-Based Authentication in OpenSSH for Windows \| Microsoft Learn](/windows-server/administration/openssh/openssh_keymanagement)
- [Install Win32 OpenSSH · PowerShell/Win32-OpenSSH Wiki · GitHub](https://github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH)
- [OpenSSH: Manual Pages](https://www.openssh.com/manual.html)
- [OpenSSH: Release Notes](https://www.openssh.com/releasenotes.html?)
