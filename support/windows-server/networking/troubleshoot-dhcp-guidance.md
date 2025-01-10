---
title: Guidance for troubleshooting DHCP
description: Introduces general guidance for troubleshooting scenarios related to DHCP.
ms.date: 03/06/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\Dynamic Host Configuration Protocol (DHCP), csstroubleshoot
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

## Troubleshooting checklist

Before you begin to troubleshoot, check the following items. These items can help you find the root cause of the problem.

- When did the problem start?
- Are there any error messages?
- Was the DHCP server working previously, or has it never worked? If it worked previously, did anything change before the problem started. For example, was an update installed? Was a change made to the infrastructure?
- Is the problem persistent or intermittent? If it is intermittent, when did it last occur?
- Are address lease failures occurring for all clients or for only specific clients, such as a single-scope subnet?
- Are there any clients on the same network subnet as the DHCP server?
- If clients reside on the same network subnet, can they obtain IP addresses?
- If clients are not on the same network subnet, are the routers or VLAN switches correctly configured to have DHCP relay agents (also known as IP Helpers)?
- Is the DHCP server standalone or is it configured for high availability, such as split-scope or DHCP Failover?
- Check the intermediate devices for features such as VRRP/HSRP, Dynamic ARP Inspection, or DHCP snooping that are known to cause problems.

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

## Using network trace to troubleshoot DHCP

Once you've confirmed the settings on both the DHCP client and server, you can use Wireshark to check whether the DHCP DORA process has completed successfully or if any packet drops are preventing DHCP clients from obtaining an IP address from the server.

### Steps to collect a network trace

To troubleshoot DHCP issues using network traces, follow these steps:

1. Install [Wireshark](https://www.wireshark.org/download.html) on both the affected DHCP client and the DHCP server.
2. Run Wireshark as administrator on both the client and server.
3. Choose the network interface used for DHCP on both devices by double-clicking them in Wireshark.
4. Start packet capture with Wireshark on both the client and server.
5. Reproduce the issue. Trigger the DHCP issue (for example, run `ipconfig /renew` on the client). Wait for the failure scenario to occur.
6. Stop the packet capture on both devices using the red button in Wireshark.

   :::image type="content" source="./media/troubleshoot-dhcp-guidance/stop-wireshark-capture.png" alt-text="Stop Wireshark capture.":::

7. Save the captured packets to a specified location by selecting **File** > **Save As**.
8. Apply a DHCP filter to view DHCP transactions:
   - On the client capture, apply a display filter for "dhcp".
   - On the server capture, use the filter "dhcp.id == \<Transaction ID\>" to track the specific client transaction. You can get the transaction ID from the client-side capture and apply it in the filter on the server-side capture.

     :::image type="content" source="./media/troubleshoot-dhcp-guidance/transaction-id-from-the-client-side-capture.png" alt-text="Transaction ID from the client-side capture.":::

9. Analyze DHCP transactions:
   - Check the client-side capture for all four DHCP packets (DISCOVER, OFFER, REQUEST, ACK). If all are present, the DORA process is likely successful.
   - If any packets are missing (for example, only DISCOVER packets are visible), it indicates a potential drop.

10. Identify network drops. Look for these indicators of network drops:
    - Client capture shows DISCOVER packets, but server capture does not.
    - Client capture shows DISCOVER packets and server shows OFFER sent, but no OFFER seen on client.
    - Client capture shows DISCOVER, OFFER, and REQUEST, but server only shows DISCOVER and OFFER.
    - Client capture shows DISCOVER, OFFER, and REQUEST, but server shows all four packets completed (DISCOVER, OFFER, REQUEST, ACK) with no ACK seen on client.

11. After drops are confirmed, involve the network team to investigate and resolve the drop issue.

These steps ensure thorough troubleshooting using Wireshark to pinpoint where DHCP communication breaks down, facilitating quicker resolution of DHCP configuration or network issues.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

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
