---
title: Troubleshoot authentication errors when you use RDP to connect to Azure VM
description: This article can help you troubleshoot authentication errors that occur when you use Remote Desktop Protocol (RDP) connection to connect to an Azure virtual machine (VM).
ms.date: 06/09/2023
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
---
# Troubleshoot authentication errors when you use RDP to connect to Azure VM

This article can help you troubleshoot authentication errors that occur when you use Remote Desktop Protocol (RDP) connection to connect to an Azure virtual machine (VM).

[!INCLUDE [Feedback](../../../includes/feedback.md)]

## Symptoms

You capture a screenshot of an Azure VM that shows the Welcome screen and indicates that the operating system is running. However, when you try to connect to the VM by using Remote Desktop Connection, you receive one of the following error messages:

- An authentication error has occurred. The Local Security Authority cannot be contacted.
- The remote computer that you are trying to connect to require Network Level Authentication (NLA), but your Windows domain controller cannot be contacted to perform NLA. If you are an administrator on the remote computer, you can disable NLA by using the options on the Remote tab of the System Properties dialog box.
- This computer can't connect to the remote computer. Try connecting again, if the problem continues, contact the owner of the remote computer or your network administrator.

## Cause

There are multiple reasons why NLA might block the RDP access to a VM:

- The VM cannot communicate with the domain controller (DC). This problem could prevent an RDP session from accessing a VM by using domain credentials. However, you would still be able to log on by using the Local Administrator credentials. This problem may occur in the following situations:
  - The Active Directory Security Channel between this VM and the DC is broken.
  - The VM has an old copy of the account password and the DC has a newer copy.
  - The DC that this VM is connecting to is unhealthy.
- The encryption level of the VM is higher than the one that's used by the client computer.
- The TLS 1.0, 1.1, or 1.2 (server) protocols are disabled on the VM. The VM was set up to disable logging on by using domain credentials, and the Local Security Authority (LSA) is set up incorrectly.
- The VM was set up to accept only Federal Information Processing Standard (FIPS)-compliant algorithm connections. This is usually done by using Active Directory policy. This is a rare configuration, but FIPS can be enforced for Remote Desktop connections only.

## Before you troubleshoot

### Create a backup snapshot

To create a backup snapshot, follow the steps in [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).

### Connect to the VM remotely

To connect to the VM remotely, use one of the methods in [How to use remote tools to troubleshoot Azure VM issues](remote-tools-troubleshoot-azure-vm-issues.md).

### Group policy client service

If this is a domain-joined VM, first stop the Group Policy Client service to prevent any Active Directory Policy from overwriting the changes. To do this, run the following command:

```cmd
REM Disable the member server to retrieve the latest GPO from the domain upon start
REG add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v Start /t REG_DWORD /d 4 /f
```

After the problem is fixed, restore the ability of this VM to contact the domain to retrieve the latest GPO from the domain. To do this, run the following commands:

```cmd
sc config gpsvc start= auto
sc start gpsvc

gpupdate /force
```

If the change is reverted, it means that an Active Directory policy is causing the problem.

### Workaround

As a workaround to connect to the VM and resolve the cause, you can temporarily disable NLA. To disable NLA please use the below commands, or use the `DisableNLA` script in [Run Command](/azure/virtual-machines/windows/run-command#azure-portal).

```cmd
REM Disable the Network Level Authentication
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0
```

Then, restart the VM, and proceed to the troubleshooting section.

Once you have resolved the issue re-enable NLA, by running the following commands, and then restarting the VM:

```cmd
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v disabledomaincreds /t REG_DWORD /d 0 /f
REG add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
```

## Troubleshooting

1. [Troubleshoot Domain-joined VMs.](#1)
2. [Troubleshoot standalone VMs.](#2)

### Troubleshoot Domain-joined VMs<a id="1"></a>

To troubleshoot this problem:

1. Check whether the VM can connect to a DC.
2. Check the health of the DC.

> [!NOTE]
> To test the DC health, you can use another VM that is in the same VNET, subnet, and uses the same logon server.

Connect to the VM that has the problem by using [Serial console, remote CMD, or remote PowerShell](/azure/virtual-machines/troubleshooting/remote-tools-troubleshoot-azure-vm-issues), according to the steps in the **Connect to the VM remotely** section.

1. Determine the DC that the VM is attempting to connect to. run the following command in the console:

   ```cmd
   set | find /i "LOGONSERVER"
   ```

2. Test the health of the secure channel between the VM and the DC. To do this, run the `Test-ComputerSecureChannel` command in an elevated PowerShell instance. This command returns True or False indicating whether the secure channel is alive:

   ```ps
   Test-ComputerSecureChannel -verbose
   ```

   If the channel is broken, run the following command to repair it:

   ```ps
   Test-ComputerSecureChannel -repair
   ```

3. Make sure that the computer account password in Active Directory is updated on the VM and the DC:

   ```ps
   Reset-ComputerMachinePassword -Server "<COMPUTERNAME>" -Credential <DOMAIN CREDENTIAL WITH DOMAIN ADMIN LEVEL>
   ```

If the communication between the DC and the VM is good, but the DC is not healthy enough to open an RDP session, you can try to restart the DC.

If the preceding commands did not fix the communication problem to the domain, you can rejoin this VM to the domain. To do this, follow these steps:

1. Create a script that's named Unjoin.ps1 by using the following content, and then deploy the script as a [Custom Script Extension](/azure/virtual-machines/extensions/custom-script-windows) on the Azure portal:

   ```cmd
   cmd /c "netdom remove <<MachineName>> /domain:<<DomainName>> /userD:<<DomainAdminhere>> /passwordD:<<PasswordHere>> /reboot:10 /Force"
   ```

   This script forcibly removes the VM from the domain and restarts the VM 10 seconds later. Then, you need to clean up the Computer object on the domain side.

2. After the cleanup is done, rejoin this VM to the domain. To do this, create a script that is named JoinDomain.ps1 by using the following content, and then deploy the script as a Custom Script Extension on the Azure portal:

   ```cmd
   cmd /c "netdom join <<MachineName>> /domain:<<DomainName>> /userD:<<DomainAdminhere>> /passwordD:<<PasswordHere>> /reboot:10"
   ```

> [!NOTE]
> This joins the VM on the domain by using the specified credentials.

If the Active Directory channel is healthy, the computer password is updated, and the domain controller is working as expected, try the following steps.

If the problem persists, check whether the domain credential is disabled. To do this, open an elevated Command Prompt window, and then run the following command to determine whether the VM is set up to disable domain accounts for logging on to the VM:

```cmd
REG query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v disabledomaincreds
```

If the key is set to 1, this means that the server was set up not to allow domain credentials. Change this key to 0.

### Troubleshoot standalone VMs<a id="2"></a>

#### Check MinEncryptionLevel

In a CMD instance, run the following command to query the **MinEncryptionLevel** registry value:

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel
```

Based on the registry value, follow these steps:

- 4 (FIPS): Check FIPs compliant algorithms connections.
- 3 (128-bit encryption): Set the severity to 2 by running the following command:

  ```cmd
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 2 /f
  ```

- 2 (Highest encryption possible, as dictated by the client): You can try to set the encryption to the minimum value of **1** by running the following command:

  ```cmd
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 1 /f
  ```

Restart the VM so that the changes to the registry take effect.

#### TLS version

Depending on the system, RDP uses the TLS 1.0, 1.1, or 1.2 (server) protocol. To query how these protocols are set up on the VM, open a CMD instance, and then run the following commands:

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled
```

If the returned values are not all **1**, this means that the protocol is disabled. To enable these protocols, run the following commands:

```cmd
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v Enabled /t REG_DWORD /d 1 /f
```

For other protocol versions, you can run the following commands:

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS x.x\Server" /v Enabled
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS x.x\Server" /v Enabled
```

> [!NOTE]
> Get the SSH/TLS version x.x from the Guest OS Logs on the SCHANNEL errors.

#### Check FIPs compliant algorithms connections

Remote desktop can be enforced to use only FIPs-compliant algorithm connections. This can be set by using a registry key. To do this, open an elevated Command Prompt window, and then query the following keys:

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy" /v Enabled
```

If the command returns **1**, change the registry value to **0**.

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy" /v Enabled /t REG_DWORD /d 0
```

Check which is the current **MinEncryptionLevel** on the VM:

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel
```

If the command returns **4**, change the registry value to **2**

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MinEncryptionLevel /t REG_DWORD /d 2
```

Restart the VM so that the changes to the registry take effect.

## Next steps

- [SetEncryptionLevel method of the Win32_TSGeneralSetting class](/windows/desktop/termserv/win32-tsgeneralsetting-setencryptionlevel)
- [Configure Server Authentication and Encryption Levels](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc770833(v=ws.11))
- [Win32_TSGeneralSetting class](/windows/desktop/termserv/win32-tsgeneralsetting)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
