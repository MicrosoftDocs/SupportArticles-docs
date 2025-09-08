---
title: 454 4.7.0 Temporary authentication failure
description: Describes an issue in which a 451 4.4.0 error message is returned and an Event ID 1035 is logged when some e-mail messages are stuck in a remote delivery queue in a Microsoft Exchange server environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Issues with Internal Mail Flow
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: scottlan, deedi, v-six
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# 454 4.7.0 Temporary authentication failure in Exchange Server

_Original KB number:_ &nbsp; 979174

## Symptoms

In an Exchange server environment, some e-mail messages are stuck in a remote delivery queue that should be transferred to another internal Exchange server in the Exchange organization.

If you open the **Queue Viewer** tool from the **Toolbox** node on the Exchange Management Console, the **Last Error** field displays an error message that resembles the following:

> 451 4.4.0 Primary target IP address responded with: "454 4.7.0 Temporary authentication failure." Attempted failover to alternate host, but that did not succeed. Either there are no alternate hosts, or delivery failed to all alternate hosts.

Additionally, you may find the following error message in the Application log file on the Exchange server that is receiving the e-mail message:

> Event Type: Error Event Source: MSExchangeTransport Event Category: SmtpReceive Event ID: 1035 Description: Inbound authentication failed with error IllegalMessage for Receive connector Default \<Server>. The authentication mechanism is ExchangeAuth. The source IP address of the client who tried to authenticate to Microsoft Exchange is [*SourceIPAddress*].

## Cause

This issue occurs if the Exchange server can't authenticate with the remote Exchange server. Exchange servers require authentication to route internal user messages between servers. The issue can occur for the following reasons:

- The Exchange server is experiencing Time synchronization issues.
- There's a replication issue between the domain controllers.
- The Exchange server is experiencing Service Principal Name (SPN) issues.
- The required TCP/UDP ports for the Kerberos protocol are blocked by the firewall.

## Resolution

To resolve this issue, follow these steps:

1. Check the clock on both servers and domain controllers that might be used to authenticate the servers. All clocks should be synchronized to within 5 minutes of one other.

1. [Force replication between domain controllers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816926(v=ws.10)) to see if there's a replication issue.

1. Verify that the Service Principal Name (SPN) for `SMTPSVC` is registered correctly on the target server.

   - Make sure that the `SMTP` and `SMTPSVC` entries are added correctly to the machine account by using the SetSPN tool. For example:

     SetSPN -L *\<ExchangeServerName>*  
     SMTP/ **\<ExchangeServerName>**  
     SMTP/ **\<ExchangeServerName>**.example.com  
     SMTPSVC/ **\<ExchangeServerName>**  
     SMTPSVC/ **\<ExchangeServerName>**.example.com

   - Check for duplicate SPNs by using the SetSPN tool. There should only be one entry of each:

     SetSPN -x  
     Processing entry 0  
     found 0 group of duplicate SPNs.

1. Verify that the ports required for Kerberos are enabled.

1. If the previous steps don't work, you can turn on logging for Kerberos on the Server that is registering the Event 1035 message, which may provide additional information. To do so, follow these steps:

    1. Select **Start**, select **Run**, type *Regedit*, and then select **OK**.
    2. Locate the registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`.
    3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
    4. In the details pane, input the new value *LogLevel*, and then press **Enter**.
    5. Right-click **LogLevel**, and then select **Modify**.
    6. In the **Edit DWORD Value** dialog box, under **Base**, select **Decimal**.
    7. In the **Value data** box, type the value **1**, and then select **OK**.
    8. Close Registry Editor.
    9. Again check the System Event log for any Kerberos errors.

1. In the destination Exchange Server, check the receive connectors that receive internal e-mail messages and make sure that they have Exchange Authentication enabled.
