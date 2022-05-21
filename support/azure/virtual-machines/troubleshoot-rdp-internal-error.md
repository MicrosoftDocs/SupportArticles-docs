---
title: An internal error occurs when you make an RDP connection to Azure Virtual Machines | Microsoft Docs
description: Learn how to troubleshoot RDP internal errors in Microsoft Azure.| Microsoft Docs
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 02/23/2020
ms.author: genli
---

# An internal error occurs when you try to connect to an Azure VM through Remote Desktop

This article describes an error that you may experience when you try to connect to a virtual machine (VM) in Microsoft Azure.

## Symptoms

You can't connect to an Azure VM by using the remote desktop protocol (RDP). The connection gets stuck on the **Configuring Remote** section, or you receive the following error message:

- RDP internal error
- An internal error has occurred
- This computer can't be connected to the remote computer. Try connecting again. If the problem continues, contact the owner of the remote computer or your network administrator

## Cause

This issue might occur for the following reasons:

- The virtual machine might have been attacked.
- The local RSA encryption keys can't be accessed.
- TLS protocol is disabled.
- The certificate is corrupted or expired.

## Solution

To troubleshoot this issue, complete the steps in the following sections. Before you begin, take a snapshot of the OS disk of the affected VM as a backup. For more information, see [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).

### Check RDP security

First, check to see whether the network security group for RDP port 3389 is unsecured (open). If it's unsecured and it shows \* as the source IP address for inbound, restrict the RDP port to a specifc user's IP address, and then test RDP access. If this fails, complete the steps in the next section.

### Use Serial control

Use the Serial Console or [repair the VM offline](#repair-the-vm-offline) by attaching the OS disk of the VM to a recovery VM.

To begin, connect to the [Serial Console and open a PowerShell instance](./serial-console-windows.md#use-cmd-or-powershell-in-serial-console
). If the Serial Console is not enabled on your VM, go to the [repair the VM offline](#repair-the-vm-offline) section.

#### Step: 1 Check the RDP port

1. In a PowerShell instance, use the [NETSTAT](/windows-server/administration/windows-commands/netstat) to check whether port 3389 is used by other applications:

    ```powershell
    Netstat -anob |more
    ```

2. If Termservice.exe is using 3389 port, go to step 2. If another service or application other than Termservice.exe is using 3389 port, follow these steps:

    1. Stop the service for the application that is using the 3389 service:

        ```powershell
        Stop-Service -Name <ServiceName> -Force
        ```

    2. Start the terminal service:

        ```powershell
        Start-Service -Name Termservice
        ```

2. If the application cannot be stopped, or if this method does not apply to you, change the port for RDP:

    1. Change the port:

        ```powershell
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -name PortNumber -value <Hexportnumber>

        Stop-Service -Name Termservice -Force

        Start-Service -Name Termservice
        ```

    2. Set the firewall for the new port:

        ```powershell
        Set-NetFirewallRule -Name "RemoteDesktop-UserMode-In-TCP" -LocalPort <NEW PORT (decimal)>
        ```

    3. [Update the network security group for the new port](/azure/virtual-network/network-security-groups-overview) in the Azure portal RDP port.

#### Step 2: Set correct permissions on the RDP self-signed certificate

1. In a PowerShell instance, run the following commands one by one to renew the RDP self-signed certificate:

    ```powershell
    Import-Module PKI

    Set-Location Cert:\LocalMachine 

    $RdpCertThumbprint = 'Cert:\LocalMachine\Remote Desktop\'+((Get-ChildItem -Path 'Cert:\LocalMachine\Remote Desktop\').thumbprint) 

    Remove-Item -Path $RdpCertThumbprint

    Stop-Service -Name "SessionEnv"

    Start-Service -Name "SessionEnv"
    ```

2. If you cannot renew the certificate by using this method, try to renew the RDP self-signed certificate remotely:

    1. From a working VM that has connectivity to the VM that is experiencing problems, type **mmc** in the **Run** box to open Microsoft Management Console.
    2. On the **File** menu, select **Add/Remove Snap-in**, select **Certificates**, and then select **Add**.
    3. Select **Computer accounts**, select **Another Computer**, and then add the IP address of the problem VM.
    4. Go to the **Remote Desktop\Certificates** folder, right-click the certificate, and then and select **Delete**.
    5. In a PowerShell instance from the Serial Console, restart the Remote Desktop Configuration service:

        ```powershell
        Stop-Service -Name "SessionEnv"

        Start-Service -Name "SessionEnv"
        ```

3. Reset the permission for the MachineKeys folder.

    ```powershell
    remove-module psreadline 

    md c:\temp

    icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c > c:\temp\BeforeScript_permissions.txt 

    takeown /f "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys" /a /r

    icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "NT AUTHORITY\System:(F)"

    icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "NT AUTHORITY\NETWORK SERVICE:(R)"

    icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "BUILTIN\Administrators:(F)"

    icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c > c:\temp\AfterScript_permissions.txt 

    Restart-Service TermService -Force
    ```

4. Restart the VM, and then try Start a Remote Desktop connection to the VM. If the error still occurs, go to the next step.

#### Step 3: Enable all supported TLS versions

The RDP client uses TLS 1.0 as the default protocol. However, this can be changed to TLS 1.1, which has become the new standard. If TLS 1.1 is disabled on the VM, the connection will fail.

1. In a CMD instance, enable the TLS protocol:

    ```console
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 1 /f

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 1 /f

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f
    ```

2. To prevent the AD policy from overwriting the changes, stop the group policy update temporarily:

    ```console
    REG add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v Start /t REG_DWORD /d 4 /f
    ```

3. Restart the VM so that the changes take effect. If the issue is resolved, run the following command to re-enable the group policy:

    ```console
    sc config gpsvc start= auto sc start gpsvc

    gpupdate /force
    ```

    If the change is reverted, it means that there's an Active Directory policy in your company domain. You have to change that policy to avoid this problem from occurring again.

### Repair the VM Offline

#### Attach the OS disk to a recovery VM

1. [Attach the OS disk to a recovery VM](./troubleshoot-recovery-disks-portal-windows.md).
2. After the OS disk is attached to the recovery VM, make sure that the disk is flagged as **Online** in the Disk Management console. Note the drive letter that is assigned to the attached OS disk.
3. Start a Remote Desktop connection to the recovery VM.

#### Enable dump log and Serial Console

To enable dump log and Serial Console, run the following script.

1. Open an elevated command prompt session (**Run as administrator**).
2. Run the following script:

    In this script, we assume that the drive letter that is assigned to the attached OS disk is F. Replace this drive letter with the appropriate value for your VM.

    ```console
    reg load HKLM\BROKENSYSTEM F:\windows\system32\config\SYSTEM

    REM Enable Serial Console
    bcdedit /store F:\boot\bcd /set {bootmgr} displaybootmenu yes
    bcdedit /store F:\boot\bcd /set {bootmgr} timeout 5
    bcdedit /store F:\boot\bcd /set {bootmgr} bootems yes
    bcdedit /store F:\boot\bcd /ems {<BOOT LOADER IDENTIFIER>} ON
    bcdedit /store F:\boot\bcd /emssettings EMSPORT:1 EMSBAUDRATE:115200

    REM Suggested configuration to enable OS Dump
    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f
    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f
    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f
    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f
    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f

    reg unload HKLM\BROKENSYSTEM
    ```

#### Reset the permission for MachineKeys folder

1. Open an elevated command prompt session (**Run as administrator**).
2. Run the following script. In this script, we assume that the drive letter that is assigned to the attached OS disk is F. Replace this drive letter with the appropriate value for your VM.

    ```console
    Md F:\temp

    icacls F:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c > c:\temp\BeforeScript_permissions.txt

    takeown /f "F:\ProgramData\Microsoft\Crypto\RSA\MachineKeys" /a /r

    icacls F:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "NT AUTHORITY\System:(F)"

    icacls F:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "NT AUTHORITY\NETWORK SERVICE:(R)"

    icacls F:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c /grant "BUILTIN\Administrators:(F)"

    icacls F:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /t /c > c:\temp\AfterScript_permissions.txt
    ```

#### Enable all supported TLS versions

1. Open an elevated command prompt session (**Run as administrator**), and the run the following commands. The following script assumes that the driver letter is assigned to the attached OS disk is F. Replace this drive letter with the appropriate value for your VM.
2. Check which TLS is enabled:

    ```console
    reg load HKLM\BROKENSYSTEM F:\windows\system32\config\SYSTEM

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f
    ```

3. If the key doesn't exist, or its value is **0**, enable the protocol by running the following scripts:

    ```console
    REM Enable TLS 1.0, TLS 1.1 and TLS 1.2

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f
    ```

4. Enable NLA:

    ```console
    REM Enable NLA

    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f

    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
    
    reg unload HKLM\BROKENSYSTEM
    ```

5. [Detach the OS disk and recreate the VM](./troubleshoot-recovery-disks-portal-windows.md), and then check whether the issue is resolved.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
