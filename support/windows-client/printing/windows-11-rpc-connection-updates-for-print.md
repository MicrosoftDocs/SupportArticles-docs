---
title: Windows 11 RPC connection updates for print
description: Introduce the Windows 11 RPC connection updates for print and the recommended configurations.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 10/15/2022
ms.service: windows-client
ms.subservice: printing
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
---
# RPC connection updates for print in Windows 11

_Applies to:_ &nbsp; Windows 11, version 22H2 and later versions of Windows

Windows 11, version 22H2 introduces changes to print components that modify how Windows machines communicate with each other during printing or print related operations. 
For example, the changes come into effect when you print to a printer shared out by a print server or another computer on the network. These changes were made to further improve the overall security of printing in Windows.
The default configuration of the RPC connection settings enforces newer and more secure communication methods. Home users and enterprise administrators can also customize the settings for their environment.

## Update details

* For print related communications, by default, RPC over TCP is used for client – server communications.

  * Using RPC over Named Pipes for print related communication between computers is still available but is disabled by default.
  * Using RPC over TCP or RPC over Named Pipes for print related communication can be controlled by Group Policy or through the registry.

* By default, the client or server only listens for incoming connections via RPC over TCP.
  * The Spooler service can be configured to also listen for incoming connections via RPC over Named Pipes. This isn't the default configuration.
  * This behavior can be controlled by Group Policy or through the registry.
* When RPC over TCP is used, a specific port can be configured to use for communication instead of dynamic ports.
* Environments in which all computers are domain joined and support Kerberos can now enforce Kerberos authentication.

## Recommendations on configuring an environment

The following contains recommendations on how to properly configure the environment to avoid or resolve issues with communication between computers.

### Allow RPC over TCP communication

The most common issue is that firewall rules are preventing communication between the computers. To resolve issues with the firewall, follow these steps:

1. Ensure that the RPC Endpoint Mapper port (135) isn't blocked.
2. Open up the high range ephemeral ports (49152 – 65535) on the server or follow the guidance in the [Configuring RPC to use certain ports](#configuring-rpc-to-use-certain-ports) section below to specify a range of ports for RPC.

For more information on the different ports, and their usage by system services, see [Service overview and network port requirements for Windows](../../windows-server/networking/service-overview-and-network-port-requirements.md).

### Using RPC over Named Pipes

This configuration isn't recommended. However, it can be used if RPC over TCP isn't an option in the current environment.

* To enable a Windows 11, version 22H2 computer to use RPC over Named Pipes instead of RPC over TCP for communication, see the [Use RPC over Named Pipes for client - server communication](#use-rpc-over-named-pipes-for-client--server-communication) section.
* To enable a Windows 11, version 22H2 computer to listen for incoming connections via RPC over Named Pipes and RPC over TCP, see the [Enable listening for incoming connections on RPC over Named Pipes](#enable-listening-for-incoming-connections-on-rpc-over-named-pipes) section

The following additional configurations might also be needed to properly support RPC over Named Pipes in the environment.

* Set the **RpcAuthnLevelPrivacyEnabled** registry value to **0** on the server/host machine. See [Managing deployment of Printer RPC binding changes for CVE-2021-1678 (KB4599464) (microsoft.com)](https://support.microsoft.com/topic/managing-deployment-of-printer-rpc-binding-changes-for-cve-2021-1678-kb4599464-12a69652-30b9-3d61-d9f7-7201623a8b25)
* Some scenarios also require guest access in SMB2/SMB3, which is disabled by default. To enable it, see [Guest access in SMB2 and SMB3 disabled by default in Windows](../../windows-server/networking/guest-access-in-smb2-is-disabled-by-default.md)

## Configuring RPC to use certain ports

See [How to configure RPC to use certain ports and how to help secure those ports by using IPsec](https://support.microsoft.com/topic/how-to-configure-rpc-to-use-certain-ports-and-how-to-help-secure-those-ports-by-using-ipsec-2a94b798-063a-479a-8452-9cf07ac613d9).

* To set a dynamic/excluded port range, run the `netsh int` commands.
* To use IPSec with netsh, run the `netsh ipsec` commands.
* To use Windows Firewall to block a range of ports, run the `netsh advfirewall` commands.

All of the above are viable solutions. However, some solutions may be easier than the ones that require you to set the rule for each port (IPSec and AdvFirewall). For testing purpose, you may use the dynamic/excluded port range method since you can specify the range. For example:

To restrict dynamic port range, run these commands:

```console
netsh int ipv4 show dynamicport tcp
netsh int ipv4 show dynamicport udp
netsh int ipv4 set dynamicportrange tcp startport=50000 numberofports=255
netsh int ipv4 set dynamicportrange udp startport=50000 numberofports=255
netsh int ipv6 set dynamicportrange tcp startport=50000 numberofports=255
netsh int ipv6 set dynamicportrange udp startport=50000 numberofports=255
```

Then, restart the computer.

> [!NOTE]
> 255 is the minimum number of ports can set.

To further restrict port range, run these commands:

```console
netsh int ip show excludedportrange tcp
netsh int ip show excludedportrange udp
netsh int ipv4 add excludedportrange tcp startport=50000 numberofports=225
netsh int ipv4 add excludedportrange udp startport=50000 numberofports=225
netsh int ipv6 add excludedportrange tcp startport=50000 numberofports=225
netsh int ipv6 add excludedportrange udp startport=50000 numberofports=225
```

Then, restart the computer.

> [!NOTE]
> If you restrict the number of ports too much then services on the system will not be able to communicate effectively and can cause an issue with functionality.

## Configuring RPC communication for Windows Print components

The following settings can be configured through either Group Policy or directly through the registry to achieve the desired effect. Refer to the documentation in the Group Policy editor for specific details on each setting.

### Use RPC over Named Pipes for client – server communication

* Enable by using Group Policy:  
    Path: **Computer Configuration** > **Administrative Templates** > **Printers** > **Configure RPC connection Settings**  
    Enable and set to **RpcOverNamedPipes**.
* Enable the setting by using the registry:  
    Run `reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f`

### Enable listening for incoming connections on RPC over Named Pipes

* Enable via Group Policy:  
  Path: Computer Configuration > Administrative Templates > Printers > Configure RPC listener settings  
  Enable and set protocols allowed to be used to **RpcOverNamedPipesAndTcp**.
* Enable the setting via the registry:  
  Run `reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcProtocols /t REG_DWORD /d 0x7 /f`  

### Use a specific port for RPC over TCP communication

* Enable via Group Policy:  
  Path: **Computer Configuration** > **Administrative Templates** > **Printers** > **Configure RPC over TCP port**
  Enable and set the port number
* Enable the setting via the registry  
  Run `reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcTcpPort /t REG_DWORD /d <port number> /f`

Max port: 65535

### Enforce Kerberos authentication

* Enable via Group Policy:  
  Path: **Computer Configuration** > **Administrative Templates** > **Printers** > **Configure RPC listener settings**  
  Enable and set the authentication protocol allowed to be used to Kerberos.
* Enable the setting via the registry  
  Run `reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v ForceKerberosForRpc /t REG_DWORD /d 1 /f`
