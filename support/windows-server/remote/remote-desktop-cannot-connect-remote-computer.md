---
title: Remote Desktop Can't Connect to the Remote Computer
description: Helps resolve the Remote Desktop can't connect to the remote computer related errors.
ms.date: 01/14/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, franciscoang, v-lianna
ms.custom: sap:Remote Desktop Services and Terminal Services\Session connectivity, csstroubleshoot
---
# Remote Desktop can't connect to the remote computer

This article helps troubleshoot errors when you connect to a remote machine.

When you use a direct Remote Desktop Protocol (RDP) connection to connect to a Windows machine, the connection fails with one of the following errors. The error occurs before or after entering credentials on the Remote Desktop connection application.

- > Remote Desktop can't connect to the remote computer for one of these reasons:
  >
  > 1\) Remote access to the server is not enabled  
  > 2\) The remote computer is turned off  
  > 3\) The remote computer is not available on the network
  >
  > Make sure the remote computer is turned on and connected to the network, and that remote access is enabled.

- > This computer can't connect to the remote computer.
  >
  > Try connecting again. If the problem continues, contact the owner of the remote computer or your network administrator.

There are several possible root causes, but the main ones are the RDP-TCP listener not working and incorrect network configurations.

## Verify if the error is related to the machine's state or performance

First, check if the machine is running. If it has console access (for example, Integrated Lights Out (iLO) for physical machines, or Hyper-V console for virtual machines), test connecting to the machine through it. If successful, proceed to [verify if the error is related to the RDP-TCP listener](#verify-if-the-error-is-related-to-the-rdp-tcp-listener).

Contact Microsoft Support for further assistance in the following scenarios:

- You can't put the machine in a running state.
- The machine is in a running state, but the web console access to the machine fails.

## Verify if the error is related to the RDP-TCP listener

Run the `qwinsta` command to verify if the RDP-TCP listener is working for RDP connections to function.

```console
C:\Windows\System32>qwinsta
 SESSIONNAME    USERNAME    ID    STATE    TYPE    DEVICE
 services                   0     Disc
>console                    1     Active
 rdp-tcp                    65536 Listen
```

If the output list includes the `rdp-tcp` line in the `Listen` state, the RDP-TCP listener is running. Proceed to [verify if the error is related to the network](#verify-if-the-error-is-related-to-network).

Otherwise, use the following methods to troubleshoot the issue.

### Check registry configurations

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Open Registry Editor and make sure these keys are set as follows:

- The DWORD value **fEnableWinStation** has the value data of **1**.
  
  Default path:
  `Computer\HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Winstations\RDP-Tcp`

- The DWORD value **fDenyTSConnections** has the value data of **0**.

  - Default path:
    `Computer\HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server`
  - Policy path (if the policy is configured):
    `Computer\HKEY\_LOCAL\_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services`

> [!NOTE]
> Policies override default configurations and should be configured with **gpedit.msc** (locally) or **gpmc.msc** (domain level).
>
> If both policy and default value are configured, make sure both **fDenyTSConnections** values are set to **0**, to avoid possible listener issues.

### Check services

Make sure the following services are running:

- Remote Desktop Services (TermService).
- Remote Desktop Services UserMode Port Redirector (UmRdpService).

Contact Microsoft Support for further assistance if any of the services fails to start.

### Check permissions

Add the Network service to the local administrator group on the affected machine, and run the following PowerShell cmdlet on an elevated session:

```powershell
Add-LocalGroupMember -Group Administrators -Member "Network Service"
```

After that, restart the Remote Desktop Services service (TermService).

### Check sysprep state

Make sure the machine isn't in Sysprep state by opening Registry Editor and checking the following keys:

`Computer\HKEY\_LOCAL\_MACHINE\SYSTEM\Setup`

Both the DWORD values **SystemSetupInProgress** and **OOBEInProgress** are set to **0.**

### Replace the RDP-TCP subkey

Export the following subkey on a functioning machine with the same Windows version:

`Computer\HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`

Back up the existing key on the affected machine. Then, delete it and replace it with the subkey exported from the functioning machine.

> [!NOTE]
> You can't access the machine via RDP with the `RDP-Tcp` subkey deleted.

### Contact Microsoft Support

If the preceding steps can't resolve the issue of RDP-TCP listener not working, contact Microsoft Support for further assistance.

## Verify if the error is related to network

If the RDP-TCP listener is working, use the following steps to check if you can connect to the server through a console session (for example, iLO for physical machines, or Hyper-V console for virtual machines):

1. Type **mstsc** in the **Run** box to open the **Remote Desktop Connection** application.
2. In the **Remote Desktop Connection** application, type **localhost** in the **Computer** box and select **Connect**.

If the error persists, the problem is with the server. Go to [verify machine's configurations and roles](#verify-machines-configurations-and-roles).

If the error no longer occurs, it's probably related to the network and might be troubleshot further with the following steps.

> [!NOTE]
> The preceding test is only possible on Windows Server machines and might not be available on all occasions (for example, Azure virtual machines).
>
> If it isn't available or possible, test connectivity with the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) cmdlet from a machine in the same network.

To confirm connectivity issues, run the following steps from a machine in the same network:

1. Open an elevated PowerShell window, and run the following cmdlet:

    ```PowerShell
    Test-NetConnection -ComputerName <www.contoso.com> -port 3389 -InformationLevel Detailed
    ```

2. In the output list, if `TcpTestSucceeded` is `True`, it indicates no connectivity issues. Go to [verify machine's configurations and roles](#verify-machines-configurations-and-roles).
3. If `TcpTestSucceeded` is `False`, it indicates connectivity issues. Go to the next step.

### Check the default RDP port

Open Registry Editor and make sure the following key is set as follows:

`Computer\HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Winstations\RDP-Tcp`

The DWORD value **PortNumber** has the value **0x00000d3d (3389)**.

If the value is different, **Remote Desktop Connection** connections should use *hostname*:*port* or *IPaddress*:*port* as the computer name.

### Check Domain Name System (DNS) resolution

If the connection fails when using the machine's hostname, try connecting using its IP address.

- If the connection works with the IP address, the issue is likely related to name resolution.
- If the connection also fails with the IP address, proceed to the next troubleshooting step.

### Check Firewall or Network Security Group configuration

Check if firewall rules allow RDP to the machine, or if the firewall is disabled.

Open **wf.msc**, select **Inbound Rules** and look for **Remote Desktop - User Mode (TCP-In)** and **Remote Desktop - User Mode (UDP-In)**. Make sure that they're enabled to all profiles.

You can get the same result with the following PowerShell cmdlet on an elevated session:

```powershell
Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Set-NetFirewallRule -Enabled True
```

To rule out the firewall, it can be disabled with the PowerShell cmdlet:

```powershell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
```

If other network elements are restricting traffic, they should be checked.

When using Azure Cloud, check if the Network Security Group (NSG) is configured to allow RDP to a subnet or network interface card (NIC). NSG is mandatory if you use [standard SKU for public IP addresses](/azure/virtual-network/ip-services/public-ip-addresses#sku).

### Check Anti-Virus (AV)

Anti-virus can negatively affect RDP connections to machines. If possible, disable the AV service and test the connections.

To completely rule out the AV as the root cause, uninstall it and restart the machine.

### Contact Microsoft Support

If the preceding steps can't resolve the issue, the RDP-TCP listener is working and the connectivity test result is `False`, contact Microsoft Support for further assistance.

## Verify machine's configurations and roles

If the RDP-TCP listener is working, and the connectivity test result to the machine is `True`, other scenarios related to machine's processes, roles or configurations should be checked.

### Check the concurrent process using the default RDP port

Run the following commands in an elevated command prompt or PowerShell window, and make sure the Process ID (PID) of `TermService` matches the one listening on port 3389:

- ```console
  tasklist /svc | findstr TermService
  ```

- ```console
  netstat -anob | findstr 3389
  ```

For example, `TermService` with PID 820 is listening on port 3389.

```console
C:\Windows\System32>tasklist /svc | findstr TermService
svchost.exe        820 TermService

C:\Windows\System32>netstat -anob | findstr 3389
  TCP    0.0.0.0:3389    0.0.0.0:0    LISTENING    820
  TCP    [::]:3389       [::]:0       LISTENING    820
  UDP    0.0.0.0:3389    *:*                       820
  UDP    [::]:3389       *:*                       820
```

If the PID doesn't match, find what process is listening on port 3389 and stop it. Then, restart the Remote Desktop Services service (TermService).

### Check Remote Desktop self-signed certificate

Check if you can re-create the Remote Desktop self-signed certificate by following these steps:

1. Open the Certificates Microsoft Management Console (MMC) snap-in. When you're prompted to select the certificate store to manage, select **Computer account**, and then select the affected computer.
2. In the **Certificates** folder under **Remote Desktop**, delete the RDP self-signed certificate.
3. Restart the Remote Desktop Services service on the affected computer.
4. Refresh the **Certificates** snap-in.
5. If the RDP self-signed certificate isn't re-created, go to [Remote Desktop self-signed certificate](internal-error-has-occurred-connecting-remote-machine.md#remote-desktop-self-signed-certificate).
6. If the RDP self-signed certificate is re-created, go to the next step.

### Check Remote Desktop Services (RDS) roles

Check if unnecessary RDS roles are installed, on **Server Manager** > **Manage** > **Remove Roles and Features** > **Server Roles** - **Remote Desktop Services**.

If unnecessary roles are installed, uncheck the corresponding box and proceed to remove them (for example, Remote Desktop Connection Broker role). Restart the machine in the end.

Machines with the Remote Desktop Connection Broker role in RDS deployments might still encounter the issue if the following conditions aren't met:

- Check if the Remote Desktop Connection Broker service (TSSDis) is running.
- In the Computer Management (**compmgmt.msc**) snap-in, **System Tools** > **Local Users and Groups** > **Groups** > **RDS Endpoint Servers** group must contain the **NT AUTHORITY\NETWORK SERVICE** account.

### **Contact Microsoft Support**

If the preceding steps can't resolve the issue, the RDP-TCP listener is working and the connectivity test result is `True`, contact Microsoft Support for further assistance.
