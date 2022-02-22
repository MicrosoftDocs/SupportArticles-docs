---
title: Guidance of troubleshooting DHCP
description: Introduces general guidance of troubleshooting scenarios related to DHCP.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
ms.technology: networking
---
# DHCP troubleshooting guidance

Devices must be assigned an IP address to be able to operate in a network. You can assign an IP address manually or automatically. The automatic assignment is handled by the Dynamic Host Configuration Protocol (DHCP) service (Microsoft or third-party server).

DHCP is a standard protocol that's defined by RFC 1541 (which is superseded by RFC 2131). DHCP enables a server to dynamically distribute IP addressing and configuration information to clients. Usually, the DHCP server provides at least the following basic information to the client:

- IP address
- Subnet mask
- Default gateway
- Other information, such as Domain Name Service (DNS) server addresses and Windows Internet Name Service (WINS) server addresses. The system administrator configures the DHCP server by using the options that are parsed out to the client.

For more information, see [DHCP Basics](/windows-server/troubleshoot/dynamic-host-configuration-protocol-basics).

## Troubleshoot DHCP clients

For DHCP clients, check the following devices and settings:

- Cables are connected and working.
- MAC filtering is enabled on the switches to which the client is connected.
- The network adapter is enabled.
- The correct network adapter driver is installed and updated.
- The DHCP Client service is started and running. To check this, run the net start command, and look for DHCP Client.
- There is no firewall blocking ports 67 and 68 UDP on the client computer.

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
