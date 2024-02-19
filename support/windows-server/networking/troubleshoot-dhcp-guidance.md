---
title: Guidance for troubleshooting DHCP
description: Introduces general guidance for troubleshooting scenarios related to DHCP.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# DHCP troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806271" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common DHCP issues.

Devices must be assigned an IP address to be able to operate in a network. You can assign an IP address manually or automatically. The automatic assignment is handled by the Dynamic Host Configuration Protocol (DHCP) service (Microsoft or third-party server).

DHCP is a standard protocol that's defined by RFC 1541 (which is superseded by RFC 2131). DHCP enables a server to dynamically distribute IP addressing and configuration information to clients. Usually, the DHCP server provides at least the following basic information to the client:

- IP address
- Subnet mask
- Default gateway
- Other information, such as Domain Name Service (DNS) server addresses and Windows Internet Name Service (WINS) server addresses. The system administrator configures the DHCP server by using the options that are parsed out to the client.

For more information, see [DHCP Basics](/windows-server/troubleshoot/dynamic-host-configuration-protocol-basics).

## Troubleshoot DHCP servers

For DHCP servers, check the following devices and settings:

- The DHCP server service is started and running. To check this setting, run the `net start` command, and look for **DHCP Server**.
- The DHCP server is authorized. See [Windows DHCP Server Authorization in Domain Joined Scenario](/openspecs/windows_protocols/ms-dhcpe/56f8870b-a7c1-4db1-8a86-f69079fe5077).
- Verify that IP address leases are available in the DHCP server scope for the subnet that the DHCP client is on. To do this, see the statistic for the appropriate scope in the DHCP server management console.
- Check whether any **BAD_ADDRESS** listings can be found in the **Address Leases** section.
- Check whether any devices on the network have static IP addresses that have not been excluded from the DHCP scope.
- Verify that the IP address to which DHCP server is bound is within the subnet of the scopes from which IP addresses must be leased out. This is in case no relay agent is available. To do this, run the `Get-DhcpServerv4Binding` or `Get-DhcpServerv6Binding` cmdlet.
- Verify that only the DHCP server is listening on UDP port 67 and 68. No other process or other services (such as WDS or PXE) should occupy these ports. To do this, run the `netstat -anb` command.
- If you are dealing with an IPsec-deployed environment, verify that the DHCP server IPsec exemption is added.
- Verify that the relay agent IP address can be pinged from the DHCP server.
- Enumerate and check configured DHCP policies and filters.

## Troubleshoot DHCP clients

For DHCP clients, check the following devices and settings:

- Cables are connected and working.
- MAC filtering is enabled on the switches to which the client is connected.
- The network adapter is enabled.
- The correct network adapter driver is installed and updated.
- The DHCP Client service is started and running. To check this, run the net start command, and look for DHCP Client.
- There is no firewall blocking ports 67 and 68 UDP on the client computer.

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the traces on the client and the server by using the following cmdlets:

    - Client:  

        ```powershell
        TSS.ps1 -Scenario NET_DHCPcli
        ```

    - Server:  

        ```powershell
        TSS.ps1 -Scenario NET_DHCPsrv
        ```

4. Accept the EULA if the traces are run for the first time on the server or the client.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Troubleshooting guide for DHCP](/windows-server/troubleshoot/troubleshoot-dhcp-issue)
- [Use automatic TCP/IP addressing without a DHCP server](/windows-server/troubleshoot/how-to-use-automatic-tcpip-addressing-without-a-dh)

### Event logs

Check the System and DHCP Server service event logs (**Applications and Services Logs** \> **Microsoft** \> **Windows** \> **DHCP-Server**) for reported issues that are related to the observed problem.

Depending on the kind of issue, an event is logged to one of the following event channels:

- [DHCP Server Operational Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668%28v=ws.11%29)
- [DHCP Server Administrative Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668%28v=ws.11%29)
- [DHCP Server System Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668%28v=ws.11%29)
- [DHCP Server Filter Notification Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668%28v=ws.11%29)
- [DHCP Server Audit Events](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800668%28v=ws.11%29)

### DHCP Server log

The DHCP Server service debug logs provide more information about the IP address lease assignment and the DNS dynamic updates that are done by the DHCP server. By default, these logs are located in *%windir%\\System32\\Dhcp*.

For more information, see [Analyze DHCP Server Log Files](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd183591%28v=ws.10%29).
