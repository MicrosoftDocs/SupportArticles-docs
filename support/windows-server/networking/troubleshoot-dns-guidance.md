---
title: Guidance for troubleshooting DNS
description: Introduces general guidance for troubleshooting scenarios related to DNS.
ms.date: 03/16/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
ms.technology: networking
---
# DNS troubleshooting guidance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806264" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common DNS issues.

This solution is designed to help you troubleshoot Domain Name System (DNS) scenarios. DNS troubleshooting can be broken down into server-side and client-side issues.

## Troubleshooting checklist

### Server-side issues

- IP configuration
- DNS server
- Authoritative data
- Recursion
- Zone Transfer

### Client-side issues

- IP configuration
- Network connectivity

## Common issues and solutions

### DNS records are missing in a DNS zone

This issue can be caused by one of the following causes:

#### DNS scavenging is misconfigured

If DNS records go missing from DNS zones, scavenging is the most common cause. Even Windows-based computers that have statically-assigned servers will register their records every 24 hours. Check whether the NoRefresh and Refresh intervals are too low. For example, if these values are both "less than 24 hours," you'll lose DNS records.

To troubleshoot this issue, see [Using DNS aging and scavenging](/previous-versions/windows/it-pro/windows-server-2003/cc757041%28v=ws.10%29).

#### Host "A" record is deleted when the IP address is changed

Sometimes, the host "A" record is deleted on the original DNS server after the host "A" record is registered on the newly configured DNS server IP address (Active Directory Integrated DNS). From a user perspective, anything that depends on name resolution is broken. When the DNS server IP address is changed on the client, the client sends an SOA update to delete its "A" record from the old DNS server. Then, it sends another update to register its "A" record to the new DNS server.

The trouble occurs in Active Directory-integrated zones. Issues occur when the DNS Server IP address is changed on the client. When the IP address changes, the client sends a registration request to the new server, and sends a deletion request to old server. Because both servers are already synced up, registration won't occur. However, the "A" record is deleted on the old server, and then it's deleted on both servers because of Active Directory.

#### DHCP clients that have option 81 configured unregister host "A" records during host "AAAA" registration

This problem occurs if Option 81 is defined and ISATAP or 6to4 interfaces are present. The DNS Dynamic Update Protocol update incorrectly sets TTL to **0**. This triggers record deletion for IPv6 record registration.

#### The DNS Dynamic Update Protocol update to existing records fails

The DNS Dynamic Update Protocol update to existing records fails and causes these records to be deleted by the scavenging process as aged records.

NETLOGON "event 577X" events are logged for record registration failures of SRV records by the NETLOGON service. Other events are logged for registration failures of host "A" and PTR records. Check the system logs for these failures. Such events may be logged by a client that registers these records. Or they may be logged by the DHCP servers that register the records on the client's behalf.

#### Converting an active dynamic lease to a reservation deletes the "A" and PTR records for that client

This behavior is by design. The DNS records ("A" or PTR) are automatically updated during the next DHCP renewal request from the client.

### Avoid registering unwanted network interface card in DNS

If the network interface card is configured to register the connection address in DNS, then the DHCP/DNS client service will register the record in DNS. Unwanted network cards should be configured not to register the connection address in DNS.

To prevent this issue, make sure that the unwanted network interface card address isn't registered in DNS. Follow these steps:

1. In **Network Connections**, open the properties for the unwanted network card, open TCP/IP properties, select **Advanced** > **DNS**, and then clear the **Register this connections Address in DNS** check box.
2. In the left pane, open the DNS server console, highlight the server, and then select **Action** > **Properties**. On the **Interfaces** tab, select **listen on only the following IP addresses**. Remove the unwanted IP address from the list.
3. On the **Zone** properties page, select the **Name server** tab. In addition to the FQDN of the domain controller, you'll see the IP address that's associated with the domain controller. Remove the unwanted IP address if it's listed.
4. After doing it, delete the existing unwanted host "A" record of the domain controller.

### DNS query response delays

A DNS query request may time out if the DNS server forwards the query to unreachable Forwarders or Root Hints. Follow these steps to troubleshoot this issue:

1. Open the DNS console on the DNS server, and check whether Forwarders or Conditional Forwarders are reachable. If some of the forwarders are unreachable, remove them.
2. If the DNS server does not have to use Forwarders and Root Hints, open the DNS console on the DNS server, open the server **Properties** window, select **Advanced**, and then turn on **Disable recursion**. (This also disables Forwarders.)

### Event ID 4004 and event ID 4013

Event message:  
> DNS server was unable to open Active Directory. This DNS server is configured to use directory service information and cannot operate without access to the directory. The DNS server will wait for the directory to start. If the DNS server is started but the appropriate event has not been logged, then the DNS server is still waiting for the directory to start.

To troubleshoot this issue, see [Troubleshoot AD DS and restart the DNS Server service](/troubleshoot/windows-server/networking/troubleshoot-dns-event-id-4013#resolution)

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSSv2 must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSSv2 won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSSv2, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSSv2 runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) on all nodes and unzip it in the *C:\\tss_tool* folder.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
3. Start the traces on the client and the server by using the following cmdlets:

    - Client:  

        ```powershell
        TSSv2.ps1 -Start -Scenario NET_DNScli
        ```

    - Server:  

        ```powershell
        TSSv2.ps1 -Start -Scenario NET_DNSsrv
        ```

4. Accept the EULA if the traces are run for the first time on the server or the client.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MSDATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Troubleshooting DNS clients](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-client)
- [Troubleshooting DNS Servers](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server)
- [DNS logging and diagnostics](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669%28v=ws.11%29)
- [Understanding Aging and Scavenging](/previous-versions/windows/it-pro/windows-server-2003/cc759204%28v%3dws.10%29)
- [Enable DNS dynamic updates for clients](/previous-versions/windows/it-pro/windows-server-2003/cc757445%28v%3dws.10%29)
- [DNS Policies overview](/windows-server/networking/dns/deploy/dns-policies-overview)
- [DNS Active Directory-Integrated Zones](/windows-server/identity/ad-ds/plan/active-directory-integrated-dns-zones)
- [DNS zone replication in Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc779655%28v%3dws.10%29)
- [Verify that SRV DNS records have been created](/troubleshoot/windows-server/networking/verify-srv-dns-records-have-been-created)
- [Configure DNS dynamic updates](/troubleshoot/windows-server/networking/configure-dns-dynamic-updates-windows-server-2003)
- [Reviewing DNS concepts](/windows-server/identity/ad-ds/plan/reviewing-dns-concepts)
