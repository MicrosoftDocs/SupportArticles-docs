---
title: Cannot connect to 'HealthMonitor' worker role instance using RDP
description: Provides information about troubleshooting issues in which the 'HealthMonitor' worker role instance is not able to remote connect.
ms.date: 09/26/2022
ms.reviewer: 
author: genlin
ms.author: genli
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# Cannot connect to 'HealthMonitor' worker role instance using RDP

This article provides information about troubleshooting issues in which the 'HealthMonitor' worker role instance is not able to remote connect with error: This computer can't connect to the remote computer.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464850

> [!NOTE]
> Referring to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the sixth scenario of the lab. Please make sure you have followed the lab setup instructions for Super Convertor application as per [this](https://github.com/prchanda/superconvertor), to recreate the problem.

## Symptoms

You have enabled the RDP for all the cloud service roles, but for some reason Remote Desktop connection is failing only for 'HealthMonitor' worker role instance throwing the below error. Whereas RDP works as expected for the other cloud service role instances.

:::image type="content" source="media/scenario-6-connect-healthmonitor-worker-role-rdp/rdp-connection-error.png" alt-text="Screenshot of the Remote Desktop connection error message.":::

## Troubleshoot steps

Remote Desktop Protocol is encapsulated and encrypted within TCP. By default, server listens on TCP port 3389 for RDP connection. So first checking whether TCP port 3389 is open or not. You can use either [PsPing](/sysinternals/downloads/psping) or [telnet](/windows-server/administration/windows-commands/telnet) for checking the connectivity to the port 3389 for your cloud service hostname.

```console
psping.exe cloudservicelabs.cloudapp.net:3389

PsPing v2.01 - PsPing - ping, latency, bandwidth measurement utilityCopyright (C) 2012-2014 Mark RussinovichSysinternals - www.sysinternals.com

TCP connect to 40.124.28.4:3389:
5 iterations (warmup 1) connecting test:
Connecting to 40.124.28.4:3389 (warmup): 281.25ms
Connecting to 40.124.28.4:3389: 279.08ms
Connecting to 40.124.28.4:3389: 283.01ms
Connecting to 40.124.28.4:3389: 269.29ms
Connecting to 40.124.28.4:3389: 270.12ms

TCP connect statistics for 40.124.28.4:3389:Sent = 4, Received = 4, Lost = 0 (0% loss),Minimum = 269.29ms, Maximum = 283.01ms, Average = 275.37ms
```

As per the above statistics, definitely RDP port is open and server is responding as expected to TCP ping over port 3389. Here come three questions:

- Why the server is not responding to RDP connection request even if the port 3389 is open?
- Are there any [Access Control Lists](/archive/blogs/walterm/windows-azure-paas-acls-are-here)  defined for the cloud service?
- Is there any [windows firewall rule configured using startup task](/azure/cloud-services/cloud-services-startup-tasks-common#add-firewall-rules)?

If you checked the **ServiceDefinition.csdef** file but couldn't find any ACL configured and there were no startup tasks related to firewall configuration for this cloud service solution as well, the only thing that was left was to capture a [Network Monitor](/windows/client-management/troubleshoot-tcpip-netmon) trace and analyze the RDP traffic.

:::image type="content" source="media/scenario-6-connect-healthmonitor-worker-role-rdp/rdp-traffic.png" alt-text="Screenshot of network trace of the RDP traffic.":::

Let's split the above network trace screenshot into two halves for better understanding. Every TCP session is always established with the three-way handshake, which depicted by the first half of the screenshot.

:::image type="content" source="media/scenario-6-connect-healthmonitor-worker-role-rdp/split-network-trace.png" alt-text="Screenshot of split network trace.":::

The first three frames (90, 97 and 98) with the Syn, Syn/Ack, and Ack flags depicted as S, A..S, and A respectively is what is collectively referred to as the TCP three-way handshake, which is successful in this case. Moving on to the later half of the network trace you can see that client has initiated an RDP connection request depicted by X224: Connection Request but didn't receive any confirmation from the server side as per [RDP connection sequence](/openspecs/windows_protocols/ms-rdpbcgr/023f1e69-cfe8-4ee6-9ee0-7e759fb4e4ee?redirectedfrom=MSDN). The X.224 Connection Request PDU is an RDP Connection Sequence PDU sent from client to server during the Connection Initiation phase of the RDP Connection Sequence (section [1.3.1.1](/openspecs/windows_protocols/ms-rdpbcgr/023f1e69-cfe8-4ee6-9ee0-7e759fb4e4ee?redirectedfrom=MSDN) for an overview of the RDP Connection Sequence phases).

Instead server tore down the TCP session with a Fin flag (depicted as A...F in frame number 491). The client in turn acknowledges the server's packet and then proceeds to abruptly terminate the session with the Reset flag (depicted as A.R..) in the screenshot below, also acknowledging the receipt of the previous pact from the server (thus the A in A.R..).

:::image type="content" source="media/scenario-6-connect-healthmonitor-worker-role-rdp/another-network-trace.png" alt-text="Screenshot of another network trace.":::

This looks like a firewall issue as the server is gracefully terminating the RDP connection request after TCP handshake is complete. But where or how exactly firewall rules are configured?
Upon reviewing the WorkerRole.cs of 'HealthMonitor' role, You might find that firewall rules were programmatically added using [INetFwRules interface](/previous-versions/windows/desktop/api/netfw/nn-netfw-inetfwrules). So firewall rules can be added not only through startup tasks or ACL but also through application code.

```console
Type Policy2 = Type.GetTypeFromProgID("HNetCfg.FwPolicy2", false);
INetFwPolicy2 FwPolicy = (INetFwPolicy2)Activator.CreateInstance(Policy2);
INetFwRules rules = FwPolicy.Rules;
rules.Remove("Magic Rule");  
Type RuleType = Type.GetTypeFromProgID("HNetCfg.FWRule");
INetFwRule rule = (INetFwRule)Activator.CreateInstance(RuleType);
rule.Name = "Magic Rule";rule.Protocol = 6;
rule.LocalPorts = "3389";
rule.Action = NET_FW_ACTION_.NET_FW_ACTION_BLOCK;
rule.Direction = NET_FW_RULE_DIRECTION_.NET_FW_RULE_DIR_IN;
rule.Enabled = true;
rules.Add(rule);
```

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
